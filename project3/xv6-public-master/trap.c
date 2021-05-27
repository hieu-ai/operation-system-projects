#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "x86.h"
#include "traps.h"
#include "spinlock.h"

// Interrupt descriptor table (shared by all CPUs).
struct gatedesc idt[256];
extern uint vectors[];  // in vectors.S: array of 256 entry pointers


extern uint time_slice[];
extern struct proc* q0[];
extern struct proc* q1[];
extern struct proc* q2[];
extern uint c0;
extern uint c1;
extern uint c2;

struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
	int i;

	for(i = 0; i < 256; i++)
		SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
	SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

	initlock(&tickslock, "time");
}

void
idtinit(void)
{
	lidt(idt, sizeof(idt));
}

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
	if(tf->trapno == T_SYSCALL){
		if(myproc()->killed)
			exit();
		myproc()->tf = tf;
		syscall();
		if(myproc()->killed)
			exit();
		return;
	}

	switch(tf->trapno){
	case T_IRQ0 + IRQ_TIMER:
		if(cpuid() == 0){
			acquire(&tickslock);
			ticks++;
			wakeup(&ticks);
			release(&tickslock);
		}
		lapiceoi();
		break;
	case T_IRQ0 + IRQ_IDE:
		ideintr();
		lapiceoi();
		break;
	case T_IRQ0 + IRQ_IDE+1:
		// Bochs generates spurious IDE1 interrupts.
		break;
	case T_IRQ0 + IRQ_KBD:
		kbdintr();
		lapiceoi();
		break;
	case T_IRQ0 + IRQ_COM1:
		uartintr();
		lapiceoi();
		break;
	case T_IRQ0 + 7:
	case T_IRQ0 + IRQ_SPURIOUS:
		cprintf("cpu%d: spurious interrupt at %x:%x\n",
						cpuid(), tf->cs, tf->eip);
		lapiceoi();
		break;

	//PAGEBREAK: 13
	default:
		if(myproc() == 0 || (tf->cs&3) == 0){
			// In kernel, it must be our mistake.
			cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
							tf->trapno, cpuid(), tf->eip, rcr2());
			panic("trap");
		}
		// In user space, assume process misbehaved.
		cprintf("pid %d %s: trap %d err %d on cpu %d "
						"eip 0x%x addr 0x%x--kill proc\n",
						myproc()->pid, myproc()->name, tf->trapno,
						tf->err, cpuid(), tf->eip, rcr2());
		myproc()->killed = 1;
	}

	// Force process exit if it has been killed and is in user space.
	// (If it is still executing in the kernel, let it keep running
	// until it gets to the regular system call return.)
	if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
		exit();

	// Force process to give up CPU on clock tick.
	// If interrupts were on while locks held, would need to check nlock.
	if(myproc() && myproc()->state == RUNNING &&
		 tf->trapno == T_IRQ0+IRQ_TIMER){

		 //BOOST: Increase wait time of all RUNNABLE processes in q2 according to last process' duration
			// this implementation will increase for every ticks
			for(int i = 0;i < c2; i++){
				struct proc *p = q2[i];
				if(p->state != RUNNABLE)
					continue;
				if(p->state == RUNNABLE){ 
					p->wait_time++;
				}
				// if any wait_time pass 50 -> put it to the end of q0
				if(p->wait_time >= 50){
					q0[c0] = p;
					c0++;
					p->priority = 0;
					p->wait_time = 0;
					// Delete from q2 and shift left
					for(int j = i;j < c2;j++){
						q2[j] = q2[j+1];
					}
					c2--;
					i--;
				}
			}
			if(myproc())
				myproc()->total_ticks = myproc()->total_ticks+1;
			if(myproc()->total_ticks == time_slice[myproc()->priority])      // HN ADD 
				yield();
	}

	// Check if the process has been killed since we yielded
	if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
		exit();
}
