
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc c0 b5 10 80       	mov    $0x8010b5c0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 60 2f 10 80       	mov    $0x80102f60,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb f4 b5 10 80       	mov    $0x8010b5f4,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 80 6f 10 80       	push   $0x80106f80
80100051:	68 c0 b5 10 80       	push   $0x8010b5c0
80100056:	e8 65 42 00 00       	call   801042c0 <initlock>
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 0c fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd0c
80100062:	fc 10 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 10 fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd10
8010006c:	fc 10 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba bc fc 10 80       	mov    $0x8010fcbc,%edx
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	8d 43 0c             	lea    0xc(%ebx),%eax
80100085:	83 ec 08             	sub    $0x8,%esp
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 87 6f 10 80       	push   $0x80106f87
80100097:	50                   	push   %eax
80100098:	e8 f3 40 00 00       	call   80104190 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    bcache.head.next = b;
801000b0:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d bc fc 10 80       	cmp    $0x8010fcbc,%eax
801000bb:	72 c3                	jb     80100080 <binit+0x40>
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 c0 b5 10 80       	push   $0x8010b5c0
801000e4:	e8 17 43 00 00       	call   80104400 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 10 fd 10 80    	mov    0x8010fd10,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 0c fd 10 80    	mov    0x8010fd0c,%ebx
80100126:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100139:	74 55                	je     80100190 <bread+0xc0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 c0 b5 10 80       	push   $0x8010b5c0
80100162:	e8 59 43 00 00       	call   801044c0 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 5e 40 00 00       	call   801041d0 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 5d 20 00 00       	call   801021e0 <iderw>
80100183:	83 c4 10             	add    $0x10,%esp
  }
  return b;
}
80100186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100189:	89 d8                	mov    %ebx,%eax
8010018b:	5b                   	pop    %ebx
8010018c:	5e                   	pop    %esi
8010018d:	5f                   	pop    %edi
8010018e:	5d                   	pop    %ebp
8010018f:	c3                   	ret    
  panic("bget: no buffers");
80100190:	83 ec 0c             	sub    $0xc,%esp
80100193:	68 8e 6f 10 80       	push   $0x80106f8e
80100198:	e8 f3 01 00 00       	call   80100390 <panic>
8010019d:	8d 76 00             	lea    0x0(%esi),%esi

801001a0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 10             	sub    $0x10,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	50                   	push   %eax
801001ae:	e8 bd 40 00 00       	call   80104270 <holdingsleep>
801001b3:	83 c4 10             	add    $0x10,%esp
801001b6:	85 c0                	test   %eax,%eax
801001b8:	74 0f                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ba:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c3:	c9                   	leave  
  iderw(b);
801001c4:	e9 17 20 00 00       	jmp    801021e0 <iderw>
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 9f 6f 10 80       	push   $0x80106f9f
801001d1:	e8 ba 01 00 00       	call   80100390 <panic>
801001d6:	8d 76 00             	lea    0x0(%esi),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001e8:	83 ec 0c             	sub    $0xc,%esp
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	56                   	push   %esi
801001ef:	e8 7c 40 00 00       	call   80104270 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 2c 40 00 00       	call   80104230 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
8010020b:	e8 f0 41 00 00       	call   80104400 <acquire>
  b->refcnt--;
80100210:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100213:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100216:	83 e8 01             	sub    $0x1,%eax
  if (b->refcnt == 0) {
80100219:	85 c0                	test   %eax,%eax
  b->refcnt--;
8010021b:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010021e:	75 2f                	jne    8010024f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100220:	8b 43 54             	mov    0x54(%ebx),%eax
80100223:	8b 53 50             	mov    0x50(%ebx),%edx
80100226:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100229:	8b 43 50             	mov    0x50(%ebx),%eax
8010022c:	8b 53 54             	mov    0x54(%ebx),%edx
8010022f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100232:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100241:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 c0 b5 10 80 	movl   $0x8010b5c0,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010025c:	e9 5f 42 00 00       	jmp    801044c0 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 a6 6f 10 80       	push   $0x80106fa6
80100269:	e8 22 01 00 00       	call   80100390 <panic>
8010026e:	66 90                	xchg   %ax,%ax

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 28             	sub    $0x28,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	57                   	push   %edi
80100280:	e8 9b 15 00 00       	call   80101820 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010028c:	e8 6f 41 00 00       	call   80104400 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e a1 00 00 00    	jle    80100342 <consoleread+0xd2>
    while(input.r == input.w){
801002a1:	8b 15 a0 ff 10 80    	mov    0x8010ffa0,%edx
801002a7:	39 15 a4 ff 10 80    	cmp    %edx,0x8010ffa4
801002ad:	74 2c                	je     801002db <consoleread+0x6b>
801002af:	eb 5f                	jmp    80100310 <consoleread+0xa0>
801002b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b8:	83 ec 08             	sub    $0x8,%esp
801002bb:	68 20 a5 10 80       	push   $0x8010a520
801002c0:	68 a0 ff 10 80       	push   $0x8010ffa0
801002c5:	e8 76 3b 00 00       	call   80103e40 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 a0 ff 10 80    	mov    0x8010ffa0,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 a4 ff 10 80    	cmp    0x8010ffa4,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 c0 35 00 00       	call   801038a0 <myproc>
801002e0:	8b 40 24             	mov    0x24(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 20 a5 10 80       	push   $0x8010a520
801002ef:	e8 cc 41 00 00       	call   801044c0 <release>
        ilock(ip);
801002f4:	89 3c 24             	mov    %edi,(%esp)
801002f7:	e8 44 14 00 00       	call   80101740 <ilock>
        return -1;
801002fc:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
80100302:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100307:	5b                   	pop    %ebx
80100308:	5e                   	pop    %esi
80100309:	5f                   	pop    %edi
8010030a:	5d                   	pop    %ebp
8010030b:	c3                   	ret    
8010030c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100310:	8d 42 01             	lea    0x1(%edx),%eax
80100313:	a3 a0 ff 10 80       	mov    %eax,0x8010ffa0
80100318:	89 d0                	mov    %edx,%eax
8010031a:	83 e0 7f             	and    $0x7f,%eax
8010031d:	0f be 80 20 ff 10 80 	movsbl -0x7fef00e0(%eax),%eax
    if(c == C('D')){  // EOF
80100324:	83 f8 04             	cmp    $0x4,%eax
80100327:	74 3f                	je     80100368 <consoleread+0xf8>
    *dst++ = c;
80100329:	83 c6 01             	add    $0x1,%esi
    --n;
8010032c:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
8010032f:	83 f8 0a             	cmp    $0xa,%eax
    *dst++ = c;
80100332:	88 46 ff             	mov    %al,-0x1(%esi)
    if(c == '\n')
80100335:	74 43                	je     8010037a <consoleread+0x10a>
  while(n > 0){
80100337:	85 db                	test   %ebx,%ebx
80100339:	0f 85 62 ff ff ff    	jne    801002a1 <consoleread+0x31>
8010033f:	8b 45 10             	mov    0x10(%ebp),%eax
  release(&cons.lock);
80100342:	83 ec 0c             	sub    $0xc,%esp
80100345:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100348:	68 20 a5 10 80       	push   $0x8010a520
8010034d:	e8 6e 41 00 00       	call   801044c0 <release>
  ilock(ip);
80100352:	89 3c 24             	mov    %edi,(%esp)
80100355:	e8 e6 13 00 00       	call   80101740 <ilock>
  return target - n;
8010035a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010035d:	83 c4 10             	add    $0x10,%esp
}
80100360:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100363:	5b                   	pop    %ebx
80100364:	5e                   	pop    %esi
80100365:	5f                   	pop    %edi
80100366:	5d                   	pop    %ebp
80100367:	c3                   	ret    
80100368:	8b 45 10             	mov    0x10(%ebp),%eax
8010036b:	29 d8                	sub    %ebx,%eax
      if(n < target){
8010036d:	3b 5d 10             	cmp    0x10(%ebp),%ebx
80100370:	73 d0                	jae    80100342 <consoleread+0xd2>
        input.r--;
80100372:	89 15 a0 ff 10 80    	mov    %edx,0x8010ffa0
80100378:	eb c8                	jmp    80100342 <consoleread+0xd2>
8010037a:	8b 45 10             	mov    0x10(%ebp),%eax
8010037d:	29 d8                	sub    %ebx,%eax
8010037f:	eb c1                	jmp    80100342 <consoleread+0xd2>
80100381:	eb 0d                	jmp    80100390 <panic>
80100383:	90                   	nop
80100384:	90                   	nop
80100385:	90                   	nop
80100386:	90                   	nop
80100387:	90                   	nop
80100388:	90                   	nop
80100389:	90                   	nop
8010038a:	90                   	nop
8010038b:	90                   	nop
8010038c:	90                   	nop
8010038d:	90                   	nop
8010038e:	90                   	nop
8010038f:	90                   	nop

80100390 <panic>:
{
80100390:	55                   	push   %ebp
80100391:	89 e5                	mov    %esp,%ebp
80100393:	56                   	push   %esi
80100394:	53                   	push   %ebx
80100395:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100398:	fa                   	cli    
  cons.locking = 0;
80100399:	c7 05 54 a5 10 80 00 	movl   $0x0,0x8010a554
801003a0:	00 00 00 
  getcallerpcs(&s, pcs);
801003a3:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003a6:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801003a9:	e8 42 24 00 00       	call   801027f0 <lapicid>
801003ae:	83 ec 08             	sub    $0x8,%esp
801003b1:	50                   	push   %eax
801003b2:	68 ad 6f 10 80       	push   $0x80106fad
801003b7:	e8 a4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 9b 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 f7 78 10 80 	movl   $0x801078f7,(%esp)
801003cc:	e8 8f 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	5a                   	pop    %edx
801003d2:	8d 45 08             	lea    0x8(%ebp),%eax
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 03 3f 00 00       	call   801042e0 <getcallerpcs>
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 c1 6f 10 80       	push   $0x80106fc1
801003ed:	e8 6e 02 00 00       	call   80100660 <cprintf>
  for(i=0; i<10; i++)
801003f2:	83 c4 10             	add    $0x10,%esp
801003f5:	39 f3                	cmp    %esi,%ebx
801003f7:	75 e7                	jne    801003e0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003f9:	c7 05 58 a5 10 80 01 	movl   $0x1,0x8010a558
80100400:	00 00 00 
80100403:	eb fe                	jmp    80100403 <panic+0x73>
80100405:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100410 <consputc>:
  if(panicked){
80100410:	8b 0d 58 a5 10 80    	mov    0x8010a558,%ecx
80100416:	85 c9                	test   %ecx,%ecx
80100418:	74 06                	je     80100420 <consputc+0x10>
8010041a:	fa                   	cli    
8010041b:	eb fe                	jmp    8010041b <consputc+0xb>
8010041d:	8d 76 00             	lea    0x0(%esi),%esi
{
80100420:	55                   	push   %ebp
80100421:	89 e5                	mov    %esp,%ebp
80100423:	57                   	push   %edi
80100424:	56                   	push   %esi
80100425:	53                   	push   %ebx
80100426:	89 c6                	mov    %eax,%esi
80100428:	83 ec 0c             	sub    $0xc,%esp
  if(c == BACKSPACE){
8010042b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100430:	0f 84 b1 00 00 00    	je     801004e7 <consputc+0xd7>
    uartputc(c);
80100436:	83 ec 0c             	sub    $0xc,%esp
80100439:	50                   	push   %eax
8010043a:	e8 41 57 00 00       	call   80105b80 <uartputc>
8010043f:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100442:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80100447:	b8 0e 00 00 00       	mov    $0xe,%eax
8010044c:	89 da                	mov    %ebx,%edx
8010044e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010044f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100454:	89 ca                	mov    %ecx,%edx
80100456:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100457:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010045a:	89 da                	mov    %ebx,%edx
8010045c:	c1 e0 08             	shl    $0x8,%eax
8010045f:	89 c7                	mov    %eax,%edi
80100461:	b8 0f 00 00 00       	mov    $0xf,%eax
80100466:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100467:	89 ca                	mov    %ecx,%edx
80100469:	ec                   	in     (%dx),%al
8010046a:	0f b6 d8             	movzbl %al,%ebx
  pos |= inb(CRTPORT+1);
8010046d:	09 fb                	or     %edi,%ebx
  if(c == '\n')
8010046f:	83 fe 0a             	cmp    $0xa,%esi
80100472:	0f 84 f3 00 00 00    	je     8010056b <consputc+0x15b>
  else if(c == BACKSPACE){
80100478:	81 fe 00 01 00 00    	cmp    $0x100,%esi
8010047e:	0f 84 d7 00 00 00    	je     8010055b <consputc+0x14b>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100484:	89 f0                	mov    %esi,%eax
80100486:	0f b6 c0             	movzbl %al,%eax
80100489:	80 cc 07             	or     $0x7,%ah
8010048c:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
80100493:	80 
80100494:	83 c3 01             	add    $0x1,%ebx
  if(pos < 0 || pos > 25*80)
80100497:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
8010049d:	0f 8f ab 00 00 00    	jg     8010054e <consputc+0x13e>
  if((pos/80) >= 24){  // Scroll up.
801004a3:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
801004a9:	7f 66                	jg     80100511 <consputc+0x101>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004ab:	be d4 03 00 00       	mov    $0x3d4,%esi
801004b0:	b8 0e 00 00 00       	mov    $0xe,%eax
801004b5:	89 f2                	mov    %esi,%edx
801004b7:	ee                   	out    %al,(%dx)
801004b8:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
  outb(CRTPORT+1, pos>>8);
801004bd:	89 d8                	mov    %ebx,%eax
801004bf:	c1 f8 08             	sar    $0x8,%eax
801004c2:	89 ca                	mov    %ecx,%edx
801004c4:	ee                   	out    %al,(%dx)
801004c5:	b8 0f 00 00 00       	mov    $0xf,%eax
801004ca:	89 f2                	mov    %esi,%edx
801004cc:	ee                   	out    %al,(%dx)
801004cd:	89 d8                	mov    %ebx,%eax
801004cf:	89 ca                	mov    %ecx,%edx
801004d1:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004d2:	b8 20 07 00 00       	mov    $0x720,%eax
801004d7:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
801004de:	80 
}
801004df:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004e2:	5b                   	pop    %ebx
801004e3:	5e                   	pop    %esi
801004e4:	5f                   	pop    %edi
801004e5:	5d                   	pop    %ebp
801004e6:	c3                   	ret    
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004e7:	83 ec 0c             	sub    $0xc,%esp
801004ea:	6a 08                	push   $0x8
801004ec:	e8 8f 56 00 00       	call   80105b80 <uartputc>
801004f1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f8:	e8 83 56 00 00       	call   80105b80 <uartputc>
801004fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100504:	e8 77 56 00 00       	call   80105b80 <uartputc>
80100509:	83 c4 10             	add    $0x10,%esp
8010050c:	e9 31 ff ff ff       	jmp    80100442 <consputc+0x32>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100511:	52                   	push   %edx
80100512:	68 60 0e 00 00       	push   $0xe60
    pos -= 80;
80100517:	83 eb 50             	sub    $0x50,%ebx
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010051a:	68 a0 80 0b 80       	push   $0x800b80a0
8010051f:	68 00 80 0b 80       	push   $0x800b8000
80100524:	e8 97 40 00 00       	call   801045c0 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100529:	b8 80 07 00 00       	mov    $0x780,%eax
8010052e:	83 c4 0c             	add    $0xc,%esp
80100531:	29 d8                	sub    %ebx,%eax
80100533:	01 c0                	add    %eax,%eax
80100535:	50                   	push   %eax
80100536:	8d 04 1b             	lea    (%ebx,%ebx,1),%eax
80100539:	6a 00                	push   $0x0
8010053b:	2d 00 80 f4 7f       	sub    $0x7ff48000,%eax
80100540:	50                   	push   %eax
80100541:	e8 ca 3f 00 00       	call   80104510 <memset>
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	e9 5d ff ff ff       	jmp    801004ab <consputc+0x9b>
    panic("pos under/overflow");
8010054e:	83 ec 0c             	sub    $0xc,%esp
80100551:	68 c5 6f 10 80       	push   $0x80106fc5
80100556:	e8 35 fe ff ff       	call   80100390 <panic>
    if(pos > 0) --pos;
8010055b:	85 db                	test   %ebx,%ebx
8010055d:	0f 84 48 ff ff ff    	je     801004ab <consputc+0x9b>
80100563:	83 eb 01             	sub    $0x1,%ebx
80100566:	e9 2c ff ff ff       	jmp    80100497 <consputc+0x87>
    pos += 80 - pos%80;
8010056b:	89 d8                	mov    %ebx,%eax
8010056d:	b9 50 00 00 00       	mov    $0x50,%ecx
80100572:	99                   	cltd   
80100573:	f7 f9                	idiv   %ecx
80100575:	29 d1                	sub    %edx,%ecx
80100577:	01 cb                	add    %ecx,%ebx
80100579:	e9 19 ff ff ff       	jmp    80100497 <consputc+0x87>
8010057e:	66 90                	xchg   %ax,%ax

80100580 <printint>:
{
80100580:	55                   	push   %ebp
80100581:	89 e5                	mov    %esp,%ebp
80100583:	57                   	push   %edi
80100584:	56                   	push   %esi
80100585:	53                   	push   %ebx
80100586:	89 d3                	mov    %edx,%ebx
80100588:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010058b:	85 c9                	test   %ecx,%ecx
{
8010058d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
80100590:	74 04                	je     80100596 <printint+0x16>
80100592:	85 c0                	test   %eax,%eax
80100594:	78 5a                	js     801005f0 <printint+0x70>
    x = xx;
80100596:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  i = 0;
8010059d:	31 c9                	xor    %ecx,%ecx
8010059f:	8d 75 d7             	lea    -0x29(%ebp),%esi
801005a2:	eb 06                	jmp    801005aa <printint+0x2a>
801005a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = digits[x % base];
801005a8:	89 f9                	mov    %edi,%ecx
801005aa:	31 d2                	xor    %edx,%edx
801005ac:	8d 79 01             	lea    0x1(%ecx),%edi
801005af:	f7 f3                	div    %ebx
801005b1:	0f b6 92 f0 6f 10 80 	movzbl -0x7fef9010(%edx),%edx
  }while((x /= base) != 0);
801005b8:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
801005ba:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
801005bd:	75 e9                	jne    801005a8 <printint+0x28>
  if(sign)
801005bf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801005c2:	85 c0                	test   %eax,%eax
801005c4:	74 08                	je     801005ce <printint+0x4e>
    buf[i++] = '-';
801005c6:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
801005cb:	8d 79 02             	lea    0x2(%ecx),%edi
801005ce:	8d 5c 3d d7          	lea    -0x29(%ebp,%edi,1),%ebx
801005d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    consputc(buf[i]);
801005d8:	0f be 03             	movsbl (%ebx),%eax
801005db:	83 eb 01             	sub    $0x1,%ebx
801005de:	e8 2d fe ff ff       	call   80100410 <consputc>
  while(--i >= 0)
801005e3:	39 f3                	cmp    %esi,%ebx
801005e5:	75 f1                	jne    801005d8 <printint+0x58>
}
801005e7:	83 c4 2c             	add    $0x2c,%esp
801005ea:	5b                   	pop    %ebx
801005eb:	5e                   	pop    %esi
801005ec:	5f                   	pop    %edi
801005ed:	5d                   	pop    %ebp
801005ee:	c3                   	ret    
801005ef:	90                   	nop
    x = -xx;
801005f0:	f7 d8                	neg    %eax
801005f2:	eb a9                	jmp    8010059d <printint+0x1d>
801005f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80100600 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 18             	sub    $0x18,%esp
80100609:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
8010060c:	ff 75 08             	pushl  0x8(%ebp)
8010060f:	e8 0c 12 00 00       	call   80101820 <iunlock>
  acquire(&cons.lock);
80100614:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010061b:	e8 e0 3d 00 00       	call   80104400 <acquire>
  for(i = 0; i < n; i++)
80100620:	83 c4 10             	add    $0x10,%esp
80100623:	85 f6                	test   %esi,%esi
80100625:	7e 18                	jle    8010063f <consolewrite+0x3f>
80100627:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010062a:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010062d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100630:	0f b6 07             	movzbl (%edi),%eax
80100633:	83 c7 01             	add    $0x1,%edi
80100636:	e8 d5 fd ff ff       	call   80100410 <consputc>
  for(i = 0; i < n; i++)
8010063b:	39 fb                	cmp    %edi,%ebx
8010063d:	75 f1                	jne    80100630 <consolewrite+0x30>
  release(&cons.lock);
8010063f:	83 ec 0c             	sub    $0xc,%esp
80100642:	68 20 a5 10 80       	push   $0x8010a520
80100647:	e8 74 3e 00 00       	call   801044c0 <release>
  ilock(ip);
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 eb 10 00 00       	call   80101740 <ilock>

  return n;
}
80100655:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100658:	89 f0                	mov    %esi,%eax
8010065a:	5b                   	pop    %ebx
8010065b:	5e                   	pop    %esi
8010065c:	5f                   	pop    %edi
8010065d:	5d                   	pop    %ebp
8010065e:	c3                   	ret    
8010065f:	90                   	nop

80100660 <cprintf>:
{
80100660:	55                   	push   %ebp
80100661:	89 e5                	mov    %esp,%ebp
80100663:	57                   	push   %edi
80100664:	56                   	push   %esi
80100665:	53                   	push   %ebx
80100666:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100669:	a1 54 a5 10 80       	mov    0x8010a554,%eax
  if(locking)
8010066e:	85 c0                	test   %eax,%eax
  locking = cons.locking;
80100670:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if(locking)
80100673:	0f 85 6f 01 00 00    	jne    801007e8 <cprintf+0x188>
  if (fmt == 0)
80100679:	8b 45 08             	mov    0x8(%ebp),%eax
8010067c:	85 c0                	test   %eax,%eax
8010067e:	89 c7                	mov    %eax,%edi
80100680:	0f 84 77 01 00 00    	je     801007fd <cprintf+0x19d>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100686:	0f b6 00             	movzbl (%eax),%eax
  argp = (uint*)(void*)(&fmt + 1);
80100689:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010068c:	31 db                	xor    %ebx,%ebx
  argp = (uint*)(void*)(&fmt + 1);
8010068e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100691:	85 c0                	test   %eax,%eax
80100693:	75 56                	jne    801006eb <cprintf+0x8b>
80100695:	eb 79                	jmp    80100710 <cprintf+0xb0>
80100697:	89 f6                	mov    %esi,%esi
80100699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[++i] & 0xff;
801006a0:	0f b6 16             	movzbl (%esi),%edx
    if(c == 0)
801006a3:	85 d2                	test   %edx,%edx
801006a5:	74 69                	je     80100710 <cprintf+0xb0>
801006a7:	83 c3 02             	add    $0x2,%ebx
    switch(c){
801006aa:	83 fa 70             	cmp    $0x70,%edx
801006ad:	8d 34 1f             	lea    (%edi,%ebx,1),%esi
801006b0:	0f 84 84 00 00 00    	je     8010073a <cprintf+0xda>
801006b6:	7f 78                	jg     80100730 <cprintf+0xd0>
801006b8:	83 fa 25             	cmp    $0x25,%edx
801006bb:	0f 84 ff 00 00 00    	je     801007c0 <cprintf+0x160>
801006c1:	83 fa 64             	cmp    $0x64,%edx
801006c4:	0f 85 8e 00 00 00    	jne    80100758 <cprintf+0xf8>
      printint(*argp++, 10, 1);
801006ca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801006cd:	ba 0a 00 00 00       	mov    $0xa,%edx
801006d2:	8d 48 04             	lea    0x4(%eax),%ecx
801006d5:	8b 00                	mov    (%eax),%eax
801006d7:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801006da:	b9 01 00 00 00       	mov    $0x1,%ecx
801006df:	e8 9c fe ff ff       	call   80100580 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006e4:	0f b6 06             	movzbl (%esi),%eax
801006e7:	85 c0                	test   %eax,%eax
801006e9:	74 25                	je     80100710 <cprintf+0xb0>
801006eb:	8d 53 01             	lea    0x1(%ebx),%edx
    if(c != '%'){
801006ee:	83 f8 25             	cmp    $0x25,%eax
801006f1:	8d 34 17             	lea    (%edi,%edx,1),%esi
801006f4:	74 aa                	je     801006a0 <cprintf+0x40>
801006f6:	89 55 e0             	mov    %edx,-0x20(%ebp)
      consputc(c);
801006f9:	e8 12 fd ff ff       	call   80100410 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006fe:	0f b6 06             	movzbl (%esi),%eax
      continue;
80100701:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100704:	89 d3                	mov    %edx,%ebx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100706:	85 c0                	test   %eax,%eax
80100708:	75 e1                	jne    801006eb <cprintf+0x8b>
8010070a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(locking)
80100710:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100713:	85 c0                	test   %eax,%eax
80100715:	74 10                	je     80100727 <cprintf+0xc7>
    release(&cons.lock);
80100717:	83 ec 0c             	sub    $0xc,%esp
8010071a:	68 20 a5 10 80       	push   $0x8010a520
8010071f:	e8 9c 3d 00 00       	call   801044c0 <release>
80100724:	83 c4 10             	add    $0x10,%esp
}
80100727:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010072a:	5b                   	pop    %ebx
8010072b:	5e                   	pop    %esi
8010072c:	5f                   	pop    %edi
8010072d:	5d                   	pop    %ebp
8010072e:	c3                   	ret    
8010072f:	90                   	nop
    switch(c){
80100730:	83 fa 73             	cmp    $0x73,%edx
80100733:	74 43                	je     80100778 <cprintf+0x118>
80100735:	83 fa 78             	cmp    $0x78,%edx
80100738:	75 1e                	jne    80100758 <cprintf+0xf8>
      printint(*argp++, 16, 0);
8010073a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010073d:	ba 10 00 00 00       	mov    $0x10,%edx
80100742:	8d 48 04             	lea    0x4(%eax),%ecx
80100745:	8b 00                	mov    (%eax),%eax
80100747:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010074a:	31 c9                	xor    %ecx,%ecx
8010074c:	e8 2f fe ff ff       	call   80100580 <printint>
      break;
80100751:	eb 91                	jmp    801006e4 <cprintf+0x84>
80100753:	90                   	nop
80100754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      consputc('%');
80100758:	b8 25 00 00 00       	mov    $0x25,%eax
8010075d:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100760:	e8 ab fc ff ff       	call   80100410 <consputc>
      consputc(c);
80100765:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100768:	89 d0                	mov    %edx,%eax
8010076a:	e8 a1 fc ff ff       	call   80100410 <consputc>
      break;
8010076f:	e9 70 ff ff ff       	jmp    801006e4 <cprintf+0x84>
80100774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if((s = (char*)*argp++) == 0)
80100778:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010077b:	8b 10                	mov    (%eax),%edx
8010077d:	8d 48 04             	lea    0x4(%eax),%ecx
80100780:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100783:	85 d2                	test   %edx,%edx
80100785:	74 49                	je     801007d0 <cprintf+0x170>
      for(; *s; s++)
80100787:	0f be 02             	movsbl (%edx),%eax
      if((s = (char*)*argp++) == 0)
8010078a:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
      for(; *s; s++)
8010078d:	84 c0                	test   %al,%al
8010078f:	0f 84 4f ff ff ff    	je     801006e4 <cprintf+0x84>
80100795:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80100798:	89 d3                	mov    %edx,%ebx
8010079a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801007a0:	83 c3 01             	add    $0x1,%ebx
        consputc(*s);
801007a3:	e8 68 fc ff ff       	call   80100410 <consputc>
      for(; *s; s++)
801007a8:	0f be 03             	movsbl (%ebx),%eax
801007ab:	84 c0                	test   %al,%al
801007ad:	75 f1                	jne    801007a0 <cprintf+0x140>
      if((s = (char*)*argp++) == 0)
801007af:	8b 45 e0             	mov    -0x20(%ebp),%eax
801007b2:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801007b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801007b8:	e9 27 ff ff ff       	jmp    801006e4 <cprintf+0x84>
801007bd:	8d 76 00             	lea    0x0(%esi),%esi
      consputc('%');
801007c0:	b8 25 00 00 00       	mov    $0x25,%eax
801007c5:	e8 46 fc ff ff       	call   80100410 <consputc>
      break;
801007ca:	e9 15 ff ff ff       	jmp    801006e4 <cprintf+0x84>
801007cf:	90                   	nop
        s = "(null)";
801007d0:	ba d8 6f 10 80       	mov    $0x80106fd8,%edx
      for(; *s; s++)
801007d5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801007d8:	b8 28 00 00 00       	mov    $0x28,%eax
801007dd:	89 d3                	mov    %edx,%ebx
801007df:	eb bf                	jmp    801007a0 <cprintf+0x140>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007e8:	83 ec 0c             	sub    $0xc,%esp
801007eb:	68 20 a5 10 80       	push   $0x8010a520
801007f0:	e8 0b 3c 00 00       	call   80104400 <acquire>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	e9 7c fe ff ff       	jmp    80100679 <cprintf+0x19>
    panic("null fmt");
801007fd:	83 ec 0c             	sub    $0xc,%esp
80100800:	68 df 6f 10 80       	push   $0x80106fdf
80100805:	e8 86 fb ff ff       	call   80100390 <panic>
8010080a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100810 <consoleintr>:
{
80100810:	55                   	push   %ebp
80100811:	89 e5                	mov    %esp,%ebp
80100813:	57                   	push   %edi
80100814:	56                   	push   %esi
80100815:	53                   	push   %ebx
  int c, doprocdump = 0;
80100816:	31 f6                	xor    %esi,%esi
{
80100818:	83 ec 18             	sub    $0x18,%esp
8010081b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
8010081e:	68 20 a5 10 80       	push   $0x8010a520
80100823:	e8 d8 3b 00 00       	call   80104400 <acquire>
  while((c = getc()) >= 0){
80100828:	83 c4 10             	add    $0x10,%esp
8010082b:	90                   	nop
8010082c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100830:	ff d3                	call   *%ebx
80100832:	85 c0                	test   %eax,%eax
80100834:	89 c7                	mov    %eax,%edi
80100836:	78 48                	js     80100880 <consoleintr+0x70>
    switch(c){
80100838:	83 ff 10             	cmp    $0x10,%edi
8010083b:	0f 84 e7 00 00 00    	je     80100928 <consoleintr+0x118>
80100841:	7e 5d                	jle    801008a0 <consoleintr+0x90>
80100843:	83 ff 15             	cmp    $0x15,%edi
80100846:	0f 84 ec 00 00 00    	je     80100938 <consoleintr+0x128>
8010084c:	83 ff 7f             	cmp    $0x7f,%edi
8010084f:	75 54                	jne    801008a5 <consoleintr+0x95>
      if(input.e != input.w){
80100851:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100856:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
8010085c:	74 d2                	je     80100830 <consoleintr+0x20>
        input.e--;
8010085e:	83 e8 01             	sub    $0x1,%eax
80100861:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
80100866:	b8 00 01 00 00       	mov    $0x100,%eax
8010086b:	e8 a0 fb ff ff       	call   80100410 <consputc>
  while((c = getc()) >= 0){
80100870:	ff d3                	call   *%ebx
80100872:	85 c0                	test   %eax,%eax
80100874:	89 c7                	mov    %eax,%edi
80100876:	79 c0                	jns    80100838 <consoleintr+0x28>
80100878:	90                   	nop
80100879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
80100880:	83 ec 0c             	sub    $0xc,%esp
80100883:	68 20 a5 10 80       	push   $0x8010a520
80100888:	e8 33 3c 00 00       	call   801044c0 <release>
  if(doprocdump) {
8010088d:	83 c4 10             	add    $0x10,%esp
80100890:	85 f6                	test   %esi,%esi
80100892:	0f 85 f8 00 00 00    	jne    80100990 <consoleintr+0x180>
}
80100898:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010089b:	5b                   	pop    %ebx
8010089c:	5e                   	pop    %esi
8010089d:	5f                   	pop    %edi
8010089e:	5d                   	pop    %ebp
8010089f:	c3                   	ret    
    switch(c){
801008a0:	83 ff 08             	cmp    $0x8,%edi
801008a3:	74 ac                	je     80100851 <consoleintr+0x41>
      if(c != 0 && input.e-input.r < INPUT_BUF){
801008a5:	85 ff                	test   %edi,%edi
801008a7:	74 87                	je     80100830 <consoleintr+0x20>
801008a9:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
801008ae:	89 c2                	mov    %eax,%edx
801008b0:	2b 15 a0 ff 10 80    	sub    0x8010ffa0,%edx
801008b6:	83 fa 7f             	cmp    $0x7f,%edx
801008b9:	0f 87 71 ff ff ff    	ja     80100830 <consoleintr+0x20>
801008bf:	8d 50 01             	lea    0x1(%eax),%edx
801008c2:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
801008c5:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
801008c8:	89 15 a8 ff 10 80    	mov    %edx,0x8010ffa8
        c = (c == '\r') ? '\n' : c;
801008ce:	0f 84 cc 00 00 00    	je     801009a0 <consoleintr+0x190>
        input.buf[input.e++ % INPUT_BUF] = c;
801008d4:	89 f9                	mov    %edi,%ecx
801008d6:	88 88 20 ff 10 80    	mov    %cl,-0x7fef00e0(%eax)
        consputc(c);
801008dc:	89 f8                	mov    %edi,%eax
801008de:	e8 2d fb ff ff       	call   80100410 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008e3:	83 ff 0a             	cmp    $0xa,%edi
801008e6:	0f 84 c5 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008ec:	83 ff 04             	cmp    $0x4,%edi
801008ef:	0f 84 bc 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008f5:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801008fa:	83 e8 80             	sub    $0xffffff80,%eax
801008fd:	39 05 a8 ff 10 80    	cmp    %eax,0x8010ffa8
80100903:	0f 85 27 ff ff ff    	jne    80100830 <consoleintr+0x20>
          wakeup(&input.r);
80100909:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
8010090c:	a3 a4 ff 10 80       	mov    %eax,0x8010ffa4
          wakeup(&input.r);
80100911:	68 a0 ff 10 80       	push   $0x8010ffa0
80100916:	e8 d5 36 00 00       	call   80103ff0 <wakeup>
8010091b:	83 c4 10             	add    $0x10,%esp
8010091e:	e9 0d ff ff ff       	jmp    80100830 <consoleintr+0x20>
80100923:	90                   	nop
80100924:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      doprocdump = 1;
80100928:	be 01 00 00 00       	mov    $0x1,%esi
8010092d:	e9 fe fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100932:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      while(input.e != input.w &&
80100938:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
8010093d:	39 05 a4 ff 10 80    	cmp    %eax,0x8010ffa4
80100943:	75 2b                	jne    80100970 <consoleintr+0x160>
80100945:	e9 e6 fe ff ff       	jmp    80100830 <consoleintr+0x20>
8010094a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
80100950:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
80100955:	b8 00 01 00 00       	mov    $0x100,%eax
8010095a:	e8 b1 fa ff ff       	call   80100410 <consputc>
      while(input.e != input.w &&
8010095f:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100964:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
8010096a:	0f 84 c0 fe ff ff    	je     80100830 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100970:	83 e8 01             	sub    $0x1,%eax
80100973:	89 c2                	mov    %eax,%edx
80100975:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100978:	80 ba 20 ff 10 80 0a 	cmpb   $0xa,-0x7fef00e0(%edx)
8010097f:	75 cf                	jne    80100950 <consoleintr+0x140>
80100981:	e9 aa fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100986:	8d 76 00             	lea    0x0(%esi),%esi
80100989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}
80100990:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100993:	5b                   	pop    %ebx
80100994:	5e                   	pop    %esi
80100995:	5f                   	pop    %edi
80100996:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100997:	e9 34 37 00 00       	jmp    801040d0 <procdump>
8010099c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        input.buf[input.e++ % INPUT_BUF] = c;
801009a0:	c6 80 20 ff 10 80 0a 	movb   $0xa,-0x7fef00e0(%eax)
        consputc(c);
801009a7:	b8 0a 00 00 00       	mov    $0xa,%eax
801009ac:	e8 5f fa ff ff       	call   80100410 <consputc>
801009b1:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
801009b6:	e9 4e ff ff ff       	jmp    80100909 <consoleintr+0xf9>
801009bb:	90                   	nop
801009bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801009c0 <consoleinit>:

void
consoleinit(void)
{
801009c0:	55                   	push   %ebp
801009c1:	89 e5                	mov    %esp,%ebp
801009c3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
801009c6:	68 e8 6f 10 80       	push   $0x80106fe8
801009cb:	68 20 a5 10 80       	push   $0x8010a520
801009d0:	e8 eb 38 00 00       	call   801042c0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
801009d5:	58                   	pop    %eax
801009d6:	5a                   	pop    %edx
801009d7:	6a 00                	push   $0x0
801009d9:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
801009db:	c7 05 6c 09 11 80 00 	movl   $0x80100600,0x8011096c
801009e2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
801009e5:	c7 05 68 09 11 80 70 	movl   $0x80100270,0x80110968
801009ec:	02 10 80 
  cons.locking = 1;
801009ef:	c7 05 54 a5 10 80 01 	movl   $0x1,0x8010a554
801009f6:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
801009f9:	e8 92 19 00 00       	call   80102390 <ioapicenable>
}
801009fe:	83 c4 10             	add    $0x10,%esp
80100a01:	c9                   	leave  
80100a02:	c3                   	ret    
80100a03:	66 90                	xchg   %ax,%ax
80100a05:	66 90                	xchg   %ax,%ax
80100a07:	66 90                	xchg   %ax,%ax
80100a09:	66 90                	xchg   %ax,%ax
80100a0b:	66 90                	xchg   %ax,%ax
80100a0d:	66 90                	xchg   %ax,%ax
80100a0f:	90                   	nop

80100a10 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100a10:	55                   	push   %ebp
80100a11:	89 e5                	mov    %esp,%ebp
80100a13:	57                   	push   %edi
80100a14:	56                   	push   %esi
80100a15:	53                   	push   %ebx
80100a16:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100a1c:	e8 7f 2e 00 00       	call   801038a0 <myproc>
80100a21:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
80100a27:	e8 34 22 00 00       	call   80102c60 <begin_op>

  if((ip = namei(path)) == 0){
80100a2c:	83 ec 0c             	sub    $0xc,%esp
80100a2f:	ff 75 08             	pushl  0x8(%ebp)
80100a32:	e8 69 15 00 00       	call   80101fa0 <namei>
80100a37:	83 c4 10             	add    $0x10,%esp
80100a3a:	85 c0                	test   %eax,%eax
80100a3c:	0f 84 91 01 00 00    	je     80100bd3 <exec+0x1c3>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100a42:	83 ec 0c             	sub    $0xc,%esp
80100a45:	89 c3                	mov    %eax,%ebx
80100a47:	50                   	push   %eax
80100a48:	e8 f3 0c 00 00       	call   80101740 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100a4d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a53:	6a 34                	push   $0x34
80100a55:	6a 00                	push   $0x0
80100a57:	50                   	push   %eax
80100a58:	53                   	push   %ebx
80100a59:	e8 c2 0f 00 00       	call   80101a20 <readi>
80100a5e:	83 c4 20             	add    $0x20,%esp
80100a61:	83 f8 34             	cmp    $0x34,%eax
80100a64:	74 22                	je     80100a88 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a66:	83 ec 0c             	sub    $0xc,%esp
80100a69:	53                   	push   %ebx
80100a6a:	e8 61 0f 00 00       	call   801019d0 <iunlockput>
    end_op();
80100a6f:	e8 5c 22 00 00       	call   80102cd0 <end_op>
80100a74:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100a77:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a7c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a7f:	5b                   	pop    %ebx
80100a80:	5e                   	pop    %esi
80100a81:	5f                   	pop    %edi
80100a82:	5d                   	pop    %ebp
80100a83:	c3                   	ret    
80100a84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80100a88:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a8f:	45 4c 46 
80100a92:	75 d2                	jne    80100a66 <exec+0x56>
  if((pgdir = setupkvm()) == 0)
80100a94:	e8 37 62 00 00       	call   80106cd0 <setupkvm>
80100a99:	85 c0                	test   %eax,%eax
80100a9b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100aa1:	74 c3                	je     80100a66 <exec+0x56>
  sz = 0;
80100aa3:	31 ff                	xor    %edi,%edi
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100aa5:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100aac:	00 
80100aad:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
80100ab3:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100ab9:	0f 84 8c 02 00 00    	je     80100d4b <exec+0x33b>
80100abf:	31 f6                	xor    %esi,%esi
80100ac1:	eb 7f                	jmp    80100b42 <exec+0x132>
80100ac3:	90                   	nop
80100ac4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ph.type != ELF_PROG_LOAD)
80100ac8:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100acf:	75 63                	jne    80100b34 <exec+0x124>
    if(ph.memsz < ph.filesz)
80100ad1:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100ad7:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100add:	0f 82 86 00 00 00    	jb     80100b69 <exec+0x159>
80100ae3:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100ae9:	72 7e                	jb     80100b69 <exec+0x159>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100aeb:	83 ec 04             	sub    $0x4,%esp
80100aee:	50                   	push   %eax
80100aef:	57                   	push   %edi
80100af0:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100af6:	e8 f5 5f 00 00       	call   80106af0 <allocuvm>
80100afb:	83 c4 10             	add    $0x10,%esp
80100afe:	85 c0                	test   %eax,%eax
80100b00:	89 c7                	mov    %eax,%edi
80100b02:	74 65                	je     80100b69 <exec+0x159>
    if(ph.vaddr % PGSIZE != 0)
80100b04:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b0a:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b0f:	75 58                	jne    80100b69 <exec+0x159>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b11:	83 ec 0c             	sub    $0xc,%esp
80100b14:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b1a:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100b20:	53                   	push   %ebx
80100b21:	50                   	push   %eax
80100b22:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b28:	e8 03 5f 00 00       	call   80106a30 <loaduvm>
80100b2d:	83 c4 20             	add    $0x20,%esp
80100b30:	85 c0                	test   %eax,%eax
80100b32:	78 35                	js     80100b69 <exec+0x159>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b34:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100b3b:	83 c6 01             	add    $0x1,%esi
80100b3e:	39 f0                	cmp    %esi,%eax
80100b40:	7e 3d                	jle    80100b7f <exec+0x16f>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100b42:	89 f0                	mov    %esi,%eax
80100b44:	6a 20                	push   $0x20
80100b46:	c1 e0 05             	shl    $0x5,%eax
80100b49:	03 85 ec fe ff ff    	add    -0x114(%ebp),%eax
80100b4f:	50                   	push   %eax
80100b50:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100b56:	50                   	push   %eax
80100b57:	53                   	push   %ebx
80100b58:	e8 c3 0e 00 00       	call   80101a20 <readi>
80100b5d:	83 c4 10             	add    $0x10,%esp
80100b60:	83 f8 20             	cmp    $0x20,%eax
80100b63:	0f 84 5f ff ff ff    	je     80100ac8 <exec+0xb8>
    freevm(pgdir);
80100b69:	83 ec 0c             	sub    $0xc,%esp
80100b6c:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b72:	e8 d9 60 00 00       	call   80106c50 <freevm>
80100b77:	83 c4 10             	add    $0x10,%esp
80100b7a:	e9 e7 fe ff ff       	jmp    80100a66 <exec+0x56>
80100b7f:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100b85:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80100b8b:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80100b91:	83 ec 0c             	sub    $0xc,%esp
80100b94:	53                   	push   %ebx
80100b95:	e8 36 0e 00 00       	call   801019d0 <iunlockput>
  end_op();
80100b9a:	e8 31 21 00 00       	call   80102cd0 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b9f:	83 c4 0c             	add    $0xc,%esp
80100ba2:	56                   	push   %esi
80100ba3:	57                   	push   %edi
80100ba4:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100baa:	e8 41 5f 00 00       	call   80106af0 <allocuvm>
80100baf:	83 c4 10             	add    $0x10,%esp
80100bb2:	85 c0                	test   %eax,%eax
80100bb4:	89 c6                	mov    %eax,%esi
80100bb6:	75 3a                	jne    80100bf2 <exec+0x1e2>
    freevm(pgdir);
80100bb8:	83 ec 0c             	sub    $0xc,%esp
80100bbb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100bc1:	e8 8a 60 00 00       	call   80106c50 <freevm>
80100bc6:	83 c4 10             	add    $0x10,%esp
  return -1;
80100bc9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bce:	e9 a9 fe ff ff       	jmp    80100a7c <exec+0x6c>
    end_op();
80100bd3:	e8 f8 20 00 00       	call   80102cd0 <end_op>
    cprintf("exec: fail\n");
80100bd8:	83 ec 0c             	sub    $0xc,%esp
80100bdb:	68 01 70 10 80       	push   $0x80107001
80100be0:	e8 7b fa ff ff       	call   80100660 <cprintf>
    return -1;
80100be5:	83 c4 10             	add    $0x10,%esp
80100be8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bed:	e9 8a fe ff ff       	jmp    80100a7c <exec+0x6c>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bf2:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100bf8:	83 ec 08             	sub    $0x8,%esp
  for(argc = 0; argv[argc]; argc++) {
80100bfb:	31 ff                	xor    %edi,%edi
80100bfd:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bff:	50                   	push   %eax
80100c00:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100c06:	e8 65 61 00 00       	call   80106d70 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100c0b:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c0e:	83 c4 10             	add    $0x10,%esp
80100c11:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c17:	8b 00                	mov    (%eax),%eax
80100c19:	85 c0                	test   %eax,%eax
80100c1b:	74 70                	je     80100c8d <exec+0x27d>
80100c1d:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100c23:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100c29:	eb 0a                	jmp    80100c35 <exec+0x225>
80100c2b:	90                   	nop
80100c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(argc >= MAXARG)
80100c30:	83 ff 20             	cmp    $0x20,%edi
80100c33:	74 83                	je     80100bb8 <exec+0x1a8>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c35:	83 ec 0c             	sub    $0xc,%esp
80100c38:	50                   	push   %eax
80100c39:	e8 f2 3a 00 00       	call   80104730 <strlen>
80100c3e:	f7 d0                	not    %eax
80100c40:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c42:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c45:	5a                   	pop    %edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c46:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c49:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c4c:	e8 df 3a 00 00       	call   80104730 <strlen>
80100c51:	83 c0 01             	add    $0x1,%eax
80100c54:	50                   	push   %eax
80100c55:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c58:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c5b:	53                   	push   %ebx
80100c5c:	56                   	push   %esi
80100c5d:	e8 6e 62 00 00       	call   80106ed0 <copyout>
80100c62:	83 c4 20             	add    $0x20,%esp
80100c65:	85 c0                	test   %eax,%eax
80100c67:	0f 88 4b ff ff ff    	js     80100bb8 <exec+0x1a8>
  for(argc = 0; argv[argc]; argc++) {
80100c6d:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100c70:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100c77:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100c7a:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100c80:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c83:	85 c0                	test   %eax,%eax
80100c85:	75 a9                	jne    80100c30 <exec+0x220>
80100c87:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c8d:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100c94:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100c96:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100c9d:	00 00 00 00 
  ustack[0] = 0xffffffff;  // fake return PC
80100ca1:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100ca8:	ff ff ff 
  ustack[1] = argc;
80100cab:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cb1:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100cb3:	83 c0 0c             	add    $0xc,%eax
80100cb6:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cb8:	50                   	push   %eax
80100cb9:	52                   	push   %edx
80100cba:	53                   	push   %ebx
80100cbb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cc1:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cc7:	e8 04 62 00 00       	call   80106ed0 <copyout>
80100ccc:	83 c4 10             	add    $0x10,%esp
80100ccf:	85 c0                	test   %eax,%eax
80100cd1:	0f 88 e1 fe ff ff    	js     80100bb8 <exec+0x1a8>
  for(last=s=path; *s; s++)
80100cd7:	8b 45 08             	mov    0x8(%ebp),%eax
80100cda:	0f b6 00             	movzbl (%eax),%eax
80100cdd:	84 c0                	test   %al,%al
80100cdf:	74 17                	je     80100cf8 <exec+0x2e8>
80100ce1:	8b 55 08             	mov    0x8(%ebp),%edx
80100ce4:	89 d1                	mov    %edx,%ecx
80100ce6:	83 c1 01             	add    $0x1,%ecx
80100ce9:	3c 2f                	cmp    $0x2f,%al
80100ceb:	0f b6 01             	movzbl (%ecx),%eax
80100cee:	0f 44 d1             	cmove  %ecx,%edx
80100cf1:	84 c0                	test   %al,%al
80100cf3:	75 f1                	jne    80100ce6 <exec+0x2d6>
80100cf5:	89 55 08             	mov    %edx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100cf8:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100cfe:	50                   	push   %eax
80100cff:	6a 10                	push   $0x10
80100d01:	ff 75 08             	pushl  0x8(%ebp)
80100d04:	89 f8                	mov    %edi,%eax
80100d06:	83 c0 6c             	add    $0x6c,%eax
80100d09:	50                   	push   %eax
80100d0a:	e8 e1 39 00 00       	call   801046f0 <safestrcpy>
  curproc->pgdir = pgdir;
80100d0f:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  oldpgdir = curproc->pgdir;
80100d15:	89 f9                	mov    %edi,%ecx
80100d17:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->tf->eip = elf.entry;  // main
80100d1a:	8b 41 18             	mov    0x18(%ecx),%eax
  curproc->sz = sz;
80100d1d:	89 31                	mov    %esi,(%ecx)
  curproc->pgdir = pgdir;
80100d1f:	89 51 04             	mov    %edx,0x4(%ecx)
  curproc->tf->eip = elf.entry;  // main
80100d22:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100d28:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100d2b:	8b 41 18             	mov    0x18(%ecx),%eax
80100d2e:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100d31:	89 0c 24             	mov    %ecx,(%esp)
80100d34:	e8 67 5b 00 00       	call   801068a0 <switchuvm>
  freevm(oldpgdir);
80100d39:	89 3c 24             	mov    %edi,(%esp)
80100d3c:	e8 0f 5f 00 00       	call   80106c50 <freevm>
  return 0;
80100d41:	83 c4 10             	add    $0x10,%esp
80100d44:	31 c0                	xor    %eax,%eax
80100d46:	e9 31 fd ff ff       	jmp    80100a7c <exec+0x6c>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100d4b:	be 00 20 00 00       	mov    $0x2000,%esi
80100d50:	e9 3c fe ff ff       	jmp    80100b91 <exec+0x181>
80100d55:	66 90                	xchg   %ax,%ax
80100d57:	66 90                	xchg   %ax,%ax
80100d59:	66 90                	xchg   %ax,%ax
80100d5b:	66 90                	xchg   %ax,%ax
80100d5d:	66 90                	xchg   %ax,%ax
80100d5f:	90                   	nop

80100d60 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100d60:	55                   	push   %ebp
80100d61:	89 e5                	mov    %esp,%ebp
80100d63:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100d66:	68 0d 70 10 80       	push   $0x8010700d
80100d6b:	68 c0 ff 10 80       	push   $0x8010ffc0
80100d70:	e8 4b 35 00 00       	call   801042c0 <initlock>
}
80100d75:	83 c4 10             	add    $0x10,%esp
80100d78:	c9                   	leave  
80100d79:	c3                   	ret    
80100d7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100d80 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d80:	55                   	push   %ebp
80100d81:	89 e5                	mov    %esp,%ebp
80100d83:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d84:	bb f4 ff 10 80       	mov    $0x8010fff4,%ebx
{
80100d89:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100d8c:	68 c0 ff 10 80       	push   $0x8010ffc0
80100d91:	e8 6a 36 00 00       	call   80104400 <acquire>
80100d96:	83 c4 10             	add    $0x10,%esp
80100d99:	eb 10                	jmp    80100dab <filealloc+0x2b>
80100d9b:	90                   	nop
80100d9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100da0:	83 c3 18             	add    $0x18,%ebx
80100da3:	81 fb 54 09 11 80    	cmp    $0x80110954,%ebx
80100da9:	73 25                	jae    80100dd0 <filealloc+0x50>
    if(f->ref == 0){
80100dab:	8b 43 04             	mov    0x4(%ebx),%eax
80100dae:	85 c0                	test   %eax,%eax
80100db0:	75 ee                	jne    80100da0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100db2:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100db5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100dbc:	68 c0 ff 10 80       	push   $0x8010ffc0
80100dc1:	e8 fa 36 00 00       	call   801044c0 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100dc6:	89 d8                	mov    %ebx,%eax
      return f;
80100dc8:	83 c4 10             	add    $0x10,%esp
}
80100dcb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100dce:	c9                   	leave  
80100dcf:	c3                   	ret    
  release(&ftable.lock);
80100dd0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100dd3:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100dd5:	68 c0 ff 10 80       	push   $0x8010ffc0
80100dda:	e8 e1 36 00 00       	call   801044c0 <release>
}
80100ddf:	89 d8                	mov    %ebx,%eax
  return 0;
80100de1:	83 c4 10             	add    $0x10,%esp
}
80100de4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100de7:	c9                   	leave  
80100de8:	c3                   	ret    
80100de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100df0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100df0:	55                   	push   %ebp
80100df1:	89 e5                	mov    %esp,%ebp
80100df3:	53                   	push   %ebx
80100df4:	83 ec 10             	sub    $0x10,%esp
80100df7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100dfa:	68 c0 ff 10 80       	push   $0x8010ffc0
80100dff:	e8 fc 35 00 00       	call   80104400 <acquire>
  if(f->ref < 1)
80100e04:	8b 43 04             	mov    0x4(%ebx),%eax
80100e07:	83 c4 10             	add    $0x10,%esp
80100e0a:	85 c0                	test   %eax,%eax
80100e0c:	7e 1a                	jle    80100e28 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100e0e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100e11:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100e14:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100e17:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e1c:	e8 9f 36 00 00       	call   801044c0 <release>
  return f;
}
80100e21:	89 d8                	mov    %ebx,%eax
80100e23:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e26:	c9                   	leave  
80100e27:	c3                   	ret    
    panic("filedup");
80100e28:	83 ec 0c             	sub    $0xc,%esp
80100e2b:	68 14 70 10 80       	push   $0x80107014
80100e30:	e8 5b f5 ff ff       	call   80100390 <panic>
80100e35:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e40 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e40:	55                   	push   %ebp
80100e41:	89 e5                	mov    %esp,%ebp
80100e43:	57                   	push   %edi
80100e44:	56                   	push   %esi
80100e45:	53                   	push   %ebx
80100e46:	83 ec 28             	sub    $0x28,%esp
80100e49:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100e4c:	68 c0 ff 10 80       	push   $0x8010ffc0
80100e51:	e8 aa 35 00 00       	call   80104400 <acquire>
  if(f->ref < 1)
80100e56:	8b 43 04             	mov    0x4(%ebx),%eax
80100e59:	83 c4 10             	add    $0x10,%esp
80100e5c:	85 c0                	test   %eax,%eax
80100e5e:	0f 8e 9b 00 00 00    	jle    80100eff <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100e64:	83 e8 01             	sub    $0x1,%eax
80100e67:	85 c0                	test   %eax,%eax
80100e69:	89 43 04             	mov    %eax,0x4(%ebx)
80100e6c:	74 1a                	je     80100e88 <fileclose+0x48>
    release(&ftable.lock);
80100e6e:	c7 45 08 c0 ff 10 80 	movl   $0x8010ffc0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e75:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e78:	5b                   	pop    %ebx
80100e79:	5e                   	pop    %esi
80100e7a:	5f                   	pop    %edi
80100e7b:	5d                   	pop    %ebp
    release(&ftable.lock);
80100e7c:	e9 3f 36 00 00       	jmp    801044c0 <release>
80100e81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ff = *f;
80100e88:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
80100e8c:	8b 3b                	mov    (%ebx),%edi
  release(&ftable.lock);
80100e8e:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100e91:	8b 73 0c             	mov    0xc(%ebx),%esi
  f->type = FD_NONE;
80100e94:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100e9a:	88 45 e7             	mov    %al,-0x19(%ebp)
80100e9d:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80100ea0:	68 c0 ff 10 80       	push   $0x8010ffc0
  ff = *f;
80100ea5:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100ea8:	e8 13 36 00 00       	call   801044c0 <release>
  if(ff.type == FD_PIPE)
80100ead:	83 c4 10             	add    $0x10,%esp
80100eb0:	83 ff 01             	cmp    $0x1,%edi
80100eb3:	74 13                	je     80100ec8 <fileclose+0x88>
  else if(ff.type == FD_INODE){
80100eb5:	83 ff 02             	cmp    $0x2,%edi
80100eb8:	74 26                	je     80100ee0 <fileclose+0xa0>
}
80100eba:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ebd:	5b                   	pop    %ebx
80100ebe:	5e                   	pop    %esi
80100ebf:	5f                   	pop    %edi
80100ec0:	5d                   	pop    %ebp
80100ec1:	c3                   	ret    
80100ec2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pipeclose(ff.pipe, ff.writable);
80100ec8:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100ecc:	83 ec 08             	sub    $0x8,%esp
80100ecf:	53                   	push   %ebx
80100ed0:	56                   	push   %esi
80100ed1:	e8 3a 25 00 00       	call   80103410 <pipeclose>
80100ed6:	83 c4 10             	add    $0x10,%esp
80100ed9:	eb df                	jmp    80100eba <fileclose+0x7a>
80100edb:	90                   	nop
80100edc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    begin_op();
80100ee0:	e8 7b 1d 00 00       	call   80102c60 <begin_op>
    iput(ff.ip);
80100ee5:	83 ec 0c             	sub    $0xc,%esp
80100ee8:	ff 75 e0             	pushl  -0x20(%ebp)
80100eeb:	e8 80 09 00 00       	call   80101870 <iput>
    end_op();
80100ef0:	83 c4 10             	add    $0x10,%esp
}
80100ef3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ef6:	5b                   	pop    %ebx
80100ef7:	5e                   	pop    %esi
80100ef8:	5f                   	pop    %edi
80100ef9:	5d                   	pop    %ebp
    end_op();
80100efa:	e9 d1 1d 00 00       	jmp    80102cd0 <end_op>
    panic("fileclose");
80100eff:	83 ec 0c             	sub    $0xc,%esp
80100f02:	68 1c 70 10 80       	push   $0x8010701c
80100f07:	e8 84 f4 ff ff       	call   80100390 <panic>
80100f0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f10 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100f10:	55                   	push   %ebp
80100f11:	89 e5                	mov    %esp,%ebp
80100f13:	53                   	push   %ebx
80100f14:	83 ec 04             	sub    $0x4,%esp
80100f17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100f1a:	83 3b 02             	cmpl   $0x2,(%ebx)
80100f1d:	75 31                	jne    80100f50 <filestat+0x40>
    ilock(f->ip);
80100f1f:	83 ec 0c             	sub    $0xc,%esp
80100f22:	ff 73 10             	pushl  0x10(%ebx)
80100f25:	e8 16 08 00 00       	call   80101740 <ilock>
    stati(f->ip, st);
80100f2a:	58                   	pop    %eax
80100f2b:	5a                   	pop    %edx
80100f2c:	ff 75 0c             	pushl  0xc(%ebp)
80100f2f:	ff 73 10             	pushl  0x10(%ebx)
80100f32:	e8 b9 0a 00 00       	call   801019f0 <stati>
    iunlock(f->ip);
80100f37:	59                   	pop    %ecx
80100f38:	ff 73 10             	pushl  0x10(%ebx)
80100f3b:	e8 e0 08 00 00       	call   80101820 <iunlock>
    return 0;
80100f40:	83 c4 10             	add    $0x10,%esp
80100f43:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100f45:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f48:	c9                   	leave  
80100f49:	c3                   	ret    
80100f4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return -1;
80100f50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100f55:	eb ee                	jmp    80100f45 <filestat+0x35>
80100f57:	89 f6                	mov    %esi,%esi
80100f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100f60 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100f60:	55                   	push   %ebp
80100f61:	89 e5                	mov    %esp,%ebp
80100f63:	57                   	push   %edi
80100f64:	56                   	push   %esi
80100f65:	53                   	push   %ebx
80100f66:	83 ec 0c             	sub    $0xc,%esp
80100f69:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f6c:	8b 75 0c             	mov    0xc(%ebp),%esi
80100f6f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100f72:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100f76:	74 60                	je     80100fd8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80100f78:	8b 03                	mov    (%ebx),%eax
80100f7a:	83 f8 01             	cmp    $0x1,%eax
80100f7d:	74 41                	je     80100fc0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100f7f:	83 f8 02             	cmp    $0x2,%eax
80100f82:	75 5b                	jne    80100fdf <fileread+0x7f>
    ilock(f->ip);
80100f84:	83 ec 0c             	sub    $0xc,%esp
80100f87:	ff 73 10             	pushl  0x10(%ebx)
80100f8a:	e8 b1 07 00 00       	call   80101740 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f8f:	57                   	push   %edi
80100f90:	ff 73 14             	pushl  0x14(%ebx)
80100f93:	56                   	push   %esi
80100f94:	ff 73 10             	pushl  0x10(%ebx)
80100f97:	e8 84 0a 00 00       	call   80101a20 <readi>
80100f9c:	83 c4 20             	add    $0x20,%esp
80100f9f:	85 c0                	test   %eax,%eax
80100fa1:	89 c6                	mov    %eax,%esi
80100fa3:	7e 03                	jle    80100fa8 <fileread+0x48>
      f->off += r;
80100fa5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100fa8:	83 ec 0c             	sub    $0xc,%esp
80100fab:	ff 73 10             	pushl  0x10(%ebx)
80100fae:	e8 6d 08 00 00       	call   80101820 <iunlock>
    return r;
80100fb3:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80100fb6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fb9:	89 f0                	mov    %esi,%eax
80100fbb:	5b                   	pop    %ebx
80100fbc:	5e                   	pop    %esi
80100fbd:	5f                   	pop    %edi
80100fbe:	5d                   	pop    %ebp
80100fbf:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80100fc0:	8b 43 0c             	mov    0xc(%ebx),%eax
80100fc3:	89 45 08             	mov    %eax,0x8(%ebp)
}
80100fc6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fc9:	5b                   	pop    %ebx
80100fca:	5e                   	pop    %esi
80100fcb:	5f                   	pop    %edi
80100fcc:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
80100fcd:	e9 ee 25 00 00       	jmp    801035c0 <piperead>
80100fd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80100fd8:	be ff ff ff ff       	mov    $0xffffffff,%esi
80100fdd:	eb d7                	jmp    80100fb6 <fileread+0x56>
  panic("fileread");
80100fdf:	83 ec 0c             	sub    $0xc,%esp
80100fe2:	68 26 70 10 80       	push   $0x80107026
80100fe7:	e8 a4 f3 ff ff       	call   80100390 <panic>
80100fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100ff0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100ff0:	55                   	push   %ebp
80100ff1:	89 e5                	mov    %esp,%ebp
80100ff3:	57                   	push   %edi
80100ff4:	56                   	push   %esi
80100ff5:	53                   	push   %ebx
80100ff6:	83 ec 1c             	sub    $0x1c,%esp
80100ff9:	8b 75 08             	mov    0x8(%ebp),%esi
80100ffc:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
80100fff:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
80101003:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101006:	8b 45 10             	mov    0x10(%ebp),%eax
80101009:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010100c:	0f 84 aa 00 00 00    	je     801010bc <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80101012:	8b 06                	mov    (%esi),%eax
80101014:	83 f8 01             	cmp    $0x1,%eax
80101017:	0f 84 c3 00 00 00    	je     801010e0 <filewrite+0xf0>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010101d:	83 f8 02             	cmp    $0x2,%eax
80101020:	0f 85 d9 00 00 00    	jne    801010ff <filewrite+0x10f>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101026:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101029:	31 ff                	xor    %edi,%edi
    while(i < n){
8010102b:	85 c0                	test   %eax,%eax
8010102d:	7f 34                	jg     80101063 <filewrite+0x73>
8010102f:	e9 9c 00 00 00       	jmp    801010d0 <filewrite+0xe0>
80101034:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101038:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010103b:	83 ec 0c             	sub    $0xc,%esp
8010103e:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
80101041:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101044:	e8 d7 07 00 00       	call   80101820 <iunlock>
      end_op();
80101049:	e8 82 1c 00 00       	call   80102cd0 <end_op>
8010104e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101051:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101054:	39 c3                	cmp    %eax,%ebx
80101056:	0f 85 96 00 00 00    	jne    801010f2 <filewrite+0x102>
        panic("short filewrite");
      i += r;
8010105c:	01 df                	add    %ebx,%edi
    while(i < n){
8010105e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101061:	7e 6d                	jle    801010d0 <filewrite+0xe0>
      int n1 = n - i;
80101063:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101066:	b8 00 06 00 00       	mov    $0x600,%eax
8010106b:	29 fb                	sub    %edi,%ebx
8010106d:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80101073:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
80101076:	e8 e5 1b 00 00       	call   80102c60 <begin_op>
      ilock(f->ip);
8010107b:	83 ec 0c             	sub    $0xc,%esp
8010107e:	ff 76 10             	pushl  0x10(%esi)
80101081:	e8 ba 06 00 00       	call   80101740 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101086:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101089:	53                   	push   %ebx
8010108a:	ff 76 14             	pushl  0x14(%esi)
8010108d:	01 f8                	add    %edi,%eax
8010108f:	50                   	push   %eax
80101090:	ff 76 10             	pushl  0x10(%esi)
80101093:	e8 88 0a 00 00       	call   80101b20 <writei>
80101098:	83 c4 20             	add    $0x20,%esp
8010109b:	85 c0                	test   %eax,%eax
8010109d:	7f 99                	jg     80101038 <filewrite+0x48>
      iunlock(f->ip);
8010109f:	83 ec 0c             	sub    $0xc,%esp
801010a2:	ff 76 10             	pushl  0x10(%esi)
801010a5:	89 45 e0             	mov    %eax,-0x20(%ebp)
801010a8:	e8 73 07 00 00       	call   80101820 <iunlock>
      end_op();
801010ad:	e8 1e 1c 00 00       	call   80102cd0 <end_op>
      if(r < 0)
801010b2:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010b5:	83 c4 10             	add    $0x10,%esp
801010b8:	85 c0                	test   %eax,%eax
801010ba:	74 98                	je     80101054 <filewrite+0x64>
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801010bf:	bf ff ff ff ff       	mov    $0xffffffff,%edi
}
801010c4:	89 f8                	mov    %edi,%eax
801010c6:	5b                   	pop    %ebx
801010c7:	5e                   	pop    %esi
801010c8:	5f                   	pop    %edi
801010c9:	5d                   	pop    %ebp
801010ca:	c3                   	ret    
801010cb:	90                   	nop
801010cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return i == n ? n : -1;
801010d0:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801010d3:	75 e7                	jne    801010bc <filewrite+0xcc>
}
801010d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010d8:	89 f8                	mov    %edi,%eax
801010da:	5b                   	pop    %ebx
801010db:	5e                   	pop    %esi
801010dc:	5f                   	pop    %edi
801010dd:	5d                   	pop    %ebp
801010de:	c3                   	ret    
801010df:	90                   	nop
    return pipewrite(f->pipe, addr, n);
801010e0:	8b 46 0c             	mov    0xc(%esi),%eax
801010e3:	89 45 08             	mov    %eax,0x8(%ebp)
}
801010e6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010e9:	5b                   	pop    %ebx
801010ea:	5e                   	pop    %esi
801010eb:	5f                   	pop    %edi
801010ec:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801010ed:	e9 be 23 00 00       	jmp    801034b0 <pipewrite>
        panic("short filewrite");
801010f2:	83 ec 0c             	sub    $0xc,%esp
801010f5:	68 2f 70 10 80       	push   $0x8010702f
801010fa:	e8 91 f2 ff ff       	call   80100390 <panic>
  panic("filewrite");
801010ff:	83 ec 0c             	sub    $0xc,%esp
80101102:	68 35 70 10 80       	push   $0x80107035
80101107:	e8 84 f2 ff ff       	call   80100390 <panic>
8010110c:	66 90                	xchg   %ax,%ax
8010110e:	66 90                	xchg   %ax,%ax

80101110 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101110:	55                   	push   %ebp
80101111:	89 e5                	mov    %esp,%ebp
80101113:	56                   	push   %esi
80101114:	53                   	push   %ebx
80101115:	89 d3                	mov    %edx,%ebx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
80101117:	c1 ea 0c             	shr    $0xc,%edx
8010111a:	03 15 d8 09 11 80    	add    0x801109d8,%edx
80101120:	83 ec 08             	sub    $0x8,%esp
80101123:	52                   	push   %edx
80101124:	50                   	push   %eax
80101125:	e8 a6 ef ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
8010112a:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010112c:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
8010112f:	ba 01 00 00 00       	mov    $0x1,%edx
80101134:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
80101137:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
8010113d:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
80101140:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101142:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101147:	85 d1                	test   %edx,%ecx
80101149:	74 25                	je     80101170 <bfree+0x60>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
8010114b:	f7 d2                	not    %edx
8010114d:	89 c6                	mov    %eax,%esi
  log_write(bp);
8010114f:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101152:	21 ca                	and    %ecx,%edx
80101154:	88 54 1e 5c          	mov    %dl,0x5c(%esi,%ebx,1)
  log_write(bp);
80101158:	56                   	push   %esi
80101159:	e8 d2 1c 00 00       	call   80102e30 <log_write>
  brelse(bp);
8010115e:	89 34 24             	mov    %esi,(%esp)
80101161:	e8 7a f0 ff ff       	call   801001e0 <brelse>
}
80101166:	83 c4 10             	add    $0x10,%esp
80101169:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010116c:	5b                   	pop    %ebx
8010116d:	5e                   	pop    %esi
8010116e:	5d                   	pop    %ebp
8010116f:	c3                   	ret    
    panic("freeing free block");
80101170:	83 ec 0c             	sub    $0xc,%esp
80101173:	68 3f 70 10 80       	push   $0x8010703f
80101178:	e8 13 f2 ff ff       	call   80100390 <panic>
8010117d:	8d 76 00             	lea    0x0(%esi),%esi

80101180 <balloc>:
{
80101180:	55                   	push   %ebp
80101181:	89 e5                	mov    %esp,%ebp
80101183:	57                   	push   %edi
80101184:	56                   	push   %esi
80101185:	53                   	push   %ebx
80101186:	83 ec 1c             	sub    $0x1c,%esp
  for(b = 0; b < sb.size; b += BPB){
80101189:	8b 0d c0 09 11 80    	mov    0x801109c0,%ecx
{
8010118f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101192:	85 c9                	test   %ecx,%ecx
80101194:	0f 84 87 00 00 00    	je     80101221 <balloc+0xa1>
8010119a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
801011a1:	8b 75 dc             	mov    -0x24(%ebp),%esi
801011a4:	83 ec 08             	sub    $0x8,%esp
801011a7:	89 f0                	mov    %esi,%eax
801011a9:	c1 f8 0c             	sar    $0xc,%eax
801011ac:	03 05 d8 09 11 80    	add    0x801109d8,%eax
801011b2:	50                   	push   %eax
801011b3:	ff 75 d8             	pushl  -0x28(%ebp)
801011b6:	e8 15 ef ff ff       	call   801000d0 <bread>
801011bb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801011be:	a1 c0 09 11 80       	mov    0x801109c0,%eax
801011c3:	83 c4 10             	add    $0x10,%esp
801011c6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801011c9:	31 c0                	xor    %eax,%eax
801011cb:	eb 2f                	jmp    801011fc <balloc+0x7c>
801011cd:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
801011d0:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011d2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
801011d5:	bb 01 00 00 00       	mov    $0x1,%ebx
801011da:	83 e1 07             	and    $0x7,%ecx
801011dd:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011df:	89 c1                	mov    %eax,%ecx
801011e1:	c1 f9 03             	sar    $0x3,%ecx
801011e4:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
801011e9:	85 df                	test   %ebx,%edi
801011eb:	89 fa                	mov    %edi,%edx
801011ed:	74 41                	je     80101230 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801011ef:	83 c0 01             	add    $0x1,%eax
801011f2:	83 c6 01             	add    $0x1,%esi
801011f5:	3d 00 10 00 00       	cmp    $0x1000,%eax
801011fa:	74 05                	je     80101201 <balloc+0x81>
801011fc:	39 75 e0             	cmp    %esi,-0x20(%ebp)
801011ff:	77 cf                	ja     801011d0 <balloc+0x50>
    brelse(bp);
80101201:	83 ec 0c             	sub    $0xc,%esp
80101204:	ff 75 e4             	pushl  -0x1c(%ebp)
80101207:	e8 d4 ef ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010120c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101213:	83 c4 10             	add    $0x10,%esp
80101216:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101219:	39 05 c0 09 11 80    	cmp    %eax,0x801109c0
8010121f:	77 80                	ja     801011a1 <balloc+0x21>
  panic("balloc: out of blocks");
80101221:	83 ec 0c             	sub    $0xc,%esp
80101224:	68 52 70 10 80       	push   $0x80107052
80101229:	e8 62 f1 ff ff       	call   80100390 <panic>
8010122e:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
80101230:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101233:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80101236:	09 da                	or     %ebx,%edx
80101238:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010123c:	57                   	push   %edi
8010123d:	e8 ee 1b 00 00       	call   80102e30 <log_write>
        brelse(bp);
80101242:	89 3c 24             	mov    %edi,(%esp)
80101245:	e8 96 ef ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
8010124a:	58                   	pop    %eax
8010124b:	5a                   	pop    %edx
8010124c:	56                   	push   %esi
8010124d:	ff 75 d8             	pushl  -0x28(%ebp)
80101250:	e8 7b ee ff ff       	call   801000d0 <bread>
80101255:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101257:	8d 40 5c             	lea    0x5c(%eax),%eax
8010125a:	83 c4 0c             	add    $0xc,%esp
8010125d:	68 00 02 00 00       	push   $0x200
80101262:	6a 00                	push   $0x0
80101264:	50                   	push   %eax
80101265:	e8 a6 32 00 00       	call   80104510 <memset>
  log_write(bp);
8010126a:	89 1c 24             	mov    %ebx,(%esp)
8010126d:	e8 be 1b 00 00       	call   80102e30 <log_write>
  brelse(bp);
80101272:	89 1c 24             	mov    %ebx,(%esp)
80101275:	e8 66 ef ff ff       	call   801001e0 <brelse>
}
8010127a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010127d:	89 f0                	mov    %esi,%eax
8010127f:	5b                   	pop    %ebx
80101280:	5e                   	pop    %esi
80101281:	5f                   	pop    %edi
80101282:	5d                   	pop    %ebp
80101283:	c3                   	ret    
80101284:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010128a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101290 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101290:	55                   	push   %ebp
80101291:	89 e5                	mov    %esp,%ebp
80101293:	57                   	push   %edi
80101294:	56                   	push   %esi
80101295:	53                   	push   %ebx
80101296:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101298:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010129a:	bb 14 0a 11 80       	mov    $0x80110a14,%ebx
{
8010129f:	83 ec 28             	sub    $0x28,%esp
801012a2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
801012a5:	68 e0 09 11 80       	push   $0x801109e0
801012aa:	e8 51 31 00 00       	call   80104400 <acquire>
801012af:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012b2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801012b5:	eb 17                	jmp    801012ce <iget+0x3e>
801012b7:	89 f6                	mov    %esi,%esi
801012b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801012c0:	81 c3 90 00 00 00    	add    $0x90,%ebx
801012c6:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
801012cc:	73 22                	jae    801012f0 <iget+0x60>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801012ce:	8b 4b 08             	mov    0x8(%ebx),%ecx
801012d1:	85 c9                	test   %ecx,%ecx
801012d3:	7e 04                	jle    801012d9 <iget+0x49>
801012d5:	39 3b                	cmp    %edi,(%ebx)
801012d7:	74 4f                	je     80101328 <iget+0x98>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801012d9:	85 f6                	test   %esi,%esi
801012db:	75 e3                	jne    801012c0 <iget+0x30>
801012dd:	85 c9                	test   %ecx,%ecx
801012df:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012e2:	81 c3 90 00 00 00    	add    $0x90,%ebx
801012e8:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
801012ee:	72 de                	jb     801012ce <iget+0x3e>
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801012f0:	85 f6                	test   %esi,%esi
801012f2:	74 5b                	je     8010134f <iget+0xbf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
801012f4:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
801012f7:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
801012f9:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
801012fc:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101303:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
8010130a:	68 e0 09 11 80       	push   $0x801109e0
8010130f:	e8 ac 31 00 00       	call   801044c0 <release>

  return ip;
80101314:	83 c4 10             	add    $0x10,%esp
}
80101317:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010131a:	89 f0                	mov    %esi,%eax
8010131c:	5b                   	pop    %ebx
8010131d:	5e                   	pop    %esi
8010131e:	5f                   	pop    %edi
8010131f:	5d                   	pop    %ebp
80101320:	c3                   	ret    
80101321:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101328:	39 53 04             	cmp    %edx,0x4(%ebx)
8010132b:	75 ac                	jne    801012d9 <iget+0x49>
      release(&icache.lock);
8010132d:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101330:	83 c1 01             	add    $0x1,%ecx
      return ip;
80101333:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
80101335:	68 e0 09 11 80       	push   $0x801109e0
      ip->ref++;
8010133a:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
8010133d:	e8 7e 31 00 00       	call   801044c0 <release>
      return ip;
80101342:	83 c4 10             	add    $0x10,%esp
}
80101345:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101348:	89 f0                	mov    %esi,%eax
8010134a:	5b                   	pop    %ebx
8010134b:	5e                   	pop    %esi
8010134c:	5f                   	pop    %edi
8010134d:	5d                   	pop    %ebp
8010134e:	c3                   	ret    
    panic("iget: no inodes");
8010134f:	83 ec 0c             	sub    $0xc,%esp
80101352:	68 68 70 10 80       	push   $0x80107068
80101357:	e8 34 f0 ff ff       	call   80100390 <panic>
8010135c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101360 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101360:	55                   	push   %ebp
80101361:	89 e5                	mov    %esp,%ebp
80101363:	57                   	push   %edi
80101364:	56                   	push   %esi
80101365:	53                   	push   %ebx
80101366:	89 c6                	mov    %eax,%esi
80101368:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010136b:	83 fa 0a             	cmp    $0xa,%edx
8010136e:	77 20                	ja     80101390 <bmap+0x30>
80101370:	8d 3c 90             	lea    (%eax,%edx,4),%edi
    if((addr = ip->addrs[bn]) == 0)
80101373:	8b 5f 5c             	mov    0x5c(%edi),%ebx
80101376:	85 db                	test   %ebx,%ebx
80101378:	0f 84 fa 00 00 00    	je     80101478 <bmap+0x118>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010137e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101381:	89 d8                	mov    %ebx,%eax
80101383:	5b                   	pop    %ebx
80101384:	5e                   	pop    %esi
80101385:	5f                   	pop    %edi
80101386:	5d                   	pop    %ebp
80101387:	c3                   	ret    
80101388:	90                   	nop
80101389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  bn -= NDIRECT;
80101390:	8d 5a f5             	lea    -0xb(%edx),%ebx
  if(bn < NINDIRECT){
80101393:	83 fb 7f             	cmp    $0x7f,%ebx
80101396:	0f 86 84 00 00 00    	jbe    80101420 <bmap+0xc0>
  bn -= NINDIRECT;
8010139c:	8d 9a 75 ff ff ff    	lea    -0x8b(%edx),%ebx
  if(bn < NDOUBLYINDIRECT){
801013a2:	81 fb ff 3f 00 00    	cmp    $0x3fff,%ebx
801013a8:	0f 87 3e 01 00 00    	ja     801014ec <bmap+0x18c>
    if((addr = ip->addrs[NDIRECT+1]) == 0) //check 13th block
801013ae:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
801013b4:	8b 00                	mov    (%eax),%eax
801013b6:	85 d2                	test   %edx,%edx
801013b8:	0f 84 1a 01 00 00    	je     801014d8 <bmap+0x178>
    bp = bread(ip->dev, addr);
801013be:	83 ec 08             	sub    $0x8,%esp
801013c1:	52                   	push   %edx
801013c2:	50                   	push   %eax
801013c3:	e8 08 ed ff ff       	call   801000d0 <bread>
801013c8:	89 c2                	mov    %eax,%edx
    int index = bn/NINDIRECT; //second level block
801013ca:	89 d8                	mov    %ebx,%eax
    if((addr = a[index]) == 0){
801013cc:	83 c4 10             	add    $0x10,%esp
    int index = bn/NINDIRECT; //second level block
801013cf:	c1 e8 07             	shr    $0x7,%eax
    if((addr = a[index]) == 0){
801013d2:	8d 4c 82 5c          	lea    0x5c(%edx,%eax,4),%ecx
801013d6:	8b 39                	mov    (%ecx),%edi
801013d8:	85 ff                	test   %edi,%edi
801013da:	0f 84 b0 00 00 00    	je     80101490 <bmap+0x130>
    brelse(bp);
801013e0:	83 ec 0c             	sub    $0xc,%esp
    if((addr = a[index]) == 0){
801013e3:	83 e3 7f             	and    $0x7f,%ebx
    brelse(bp);
801013e6:	52                   	push   %edx
801013e7:	e8 f4 ed ff ff       	call   801001e0 <brelse>
    bp = bread(ip->dev, addr);
801013ec:	58                   	pop    %eax
801013ed:	5a                   	pop    %edx
801013ee:	57                   	push   %edi
801013ef:	ff 36                	pushl  (%esi)
801013f1:	e8 da ec ff ff       	call   801000d0 <bread>
    if((addr = a[index]) == 0){
801013f6:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
801013fa:	83 c4 10             	add    $0x10,%esp
    bp = bread(ip->dev, addr);
801013fd:	89 c7                	mov    %eax,%edi
    if((addr = a[index]) == 0){
801013ff:	8b 1a                	mov    (%edx),%ebx
80101401:	85 db                	test   %ebx,%ebx
80101403:	74 44                	je     80101449 <bmap+0xe9>
    brelse(bp);
80101405:	83 ec 0c             	sub    $0xc,%esp
80101408:	57                   	push   %edi
80101409:	e8 d2 ed ff ff       	call   801001e0 <brelse>
8010140e:	83 c4 10             	add    $0x10,%esp
}
80101411:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101414:	89 d8                	mov    %ebx,%eax
80101416:	5b                   	pop    %ebx
80101417:	5e                   	pop    %esi
80101418:	5f                   	pop    %edi
80101419:	5d                   	pop    %ebp
8010141a:	c3                   	ret    
8010141b:	90                   	nop
8010141c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((addr = ip->addrs[NDIRECT]) == 0)
80101420:	8b 90 88 00 00 00    	mov    0x88(%eax),%edx
80101426:	8b 00                	mov    (%eax),%eax
80101428:	85 d2                	test   %edx,%edx
8010142a:	0f 84 90 00 00 00    	je     801014c0 <bmap+0x160>
    bp = bread(ip->dev, addr);
80101430:	83 ec 08             	sub    $0x8,%esp
80101433:	52                   	push   %edx
80101434:	50                   	push   %eax
80101435:	e8 96 ec ff ff       	call   801000d0 <bread>
    if((addr = a[bn]) == 0){
8010143a:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
8010143e:	83 c4 10             	add    $0x10,%esp
    bp = bread(ip->dev, addr);
80101441:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
80101443:	8b 1a                	mov    (%edx),%ebx
80101445:	85 db                	test   %ebx,%ebx
80101447:	75 bc                	jne    80101405 <bmap+0xa5>
      a[index] = addr = balloc(ip->dev);
80101449:	8b 06                	mov    (%esi),%eax
8010144b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010144e:	e8 2d fd ff ff       	call   80101180 <balloc>
80101453:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
80101456:	83 ec 0c             	sub    $0xc,%esp
      a[index] = addr = balloc(ip->dev);
80101459:	89 c3                	mov    %eax,%ebx
8010145b:	89 02                	mov    %eax,(%edx)
      log_write(bp);
8010145d:	57                   	push   %edi
8010145e:	e8 cd 19 00 00       	call   80102e30 <log_write>
80101463:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101466:	83 ec 0c             	sub    $0xc,%esp
80101469:	57                   	push   %edi
8010146a:	e8 71 ed ff ff       	call   801001e0 <brelse>
8010146f:	83 c4 10             	add    $0x10,%esp
80101472:	eb 9d                	jmp    80101411 <bmap+0xb1>
80101474:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[bn] = addr = balloc(ip->dev);
80101478:	8b 00                	mov    (%eax),%eax
8010147a:	e8 01 fd ff ff       	call   80101180 <balloc>
8010147f:	89 47 5c             	mov    %eax,0x5c(%edi)
}
80101482:	8d 65 f4             	lea    -0xc(%ebp),%esp
      ip->addrs[bn] = addr = balloc(ip->dev);
80101485:	89 c3                	mov    %eax,%ebx
}
80101487:	89 d8                	mov    %ebx,%eax
80101489:	5b                   	pop    %ebx
8010148a:	5e                   	pop    %esi
8010148b:	5f                   	pop    %edi
8010148c:	5d                   	pop    %ebp
8010148d:	c3                   	ret    
8010148e:	66 90                	xchg   %ax,%ax
      a[index] = addr = balloc(ip->dev);
80101490:	8b 06                	mov    (%esi),%eax
80101492:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101495:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101498:	e8 e3 fc ff ff       	call   80101180 <balloc>
      log_write(bp);
8010149d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      a[index] = addr = balloc(ip->dev);
801014a0:	8b 4d e0             	mov    -0x20(%ebp),%ecx
      log_write(bp);
801014a3:	83 ec 0c             	sub    $0xc,%esp
      a[index] = addr = balloc(ip->dev);
801014a6:	89 c7                	mov    %eax,%edi
801014a8:	89 01                	mov    %eax,(%ecx)
      log_write(bp);
801014aa:	52                   	push   %edx
801014ab:	e8 80 19 00 00       	call   80102e30 <log_write>
801014b0:	83 c4 10             	add    $0x10,%esp
801014b3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801014b6:	e9 25 ff ff ff       	jmp    801013e0 <bmap+0x80>
801014bb:	90                   	nop
801014bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801014c0:	e8 bb fc ff ff       	call   80101180 <balloc>
801014c5:	89 c2                	mov    %eax,%edx
801014c7:	89 86 88 00 00 00    	mov    %eax,0x88(%esi)
801014cd:	8b 06                	mov    (%esi),%eax
801014cf:	e9 5c ff ff ff       	jmp    80101430 <bmap+0xd0>
801014d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[NDIRECT+1] = addr = balloc(ip->dev);
801014d8:	e8 a3 fc ff ff       	call   80101180 <balloc>
801014dd:	89 c2                	mov    %eax,%edx
801014df:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
801014e5:	8b 06                	mov    (%esi),%eax
801014e7:	e9 d2 fe ff ff       	jmp    801013be <bmap+0x5e>
  panic("bmap: out of range");
801014ec:	83 ec 0c             	sub    $0xc,%esp
801014ef:	68 78 70 10 80       	push   $0x80107078
801014f4:	e8 97 ee ff ff       	call   80100390 <panic>
801014f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101500 <readsb>:
{
80101500:	55                   	push   %ebp
80101501:	89 e5                	mov    %esp,%ebp
80101503:	56                   	push   %esi
80101504:	53                   	push   %ebx
80101505:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101508:	83 ec 08             	sub    $0x8,%esp
8010150b:	6a 01                	push   $0x1
8010150d:	ff 75 08             	pushl  0x8(%ebp)
80101510:	e8 bb eb ff ff       	call   801000d0 <bread>
80101515:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101517:	8d 40 5c             	lea    0x5c(%eax),%eax
8010151a:	83 c4 0c             	add    $0xc,%esp
8010151d:	6a 1c                	push   $0x1c
8010151f:	50                   	push   %eax
80101520:	56                   	push   %esi
80101521:	e8 9a 30 00 00       	call   801045c0 <memmove>
  brelse(bp);
80101526:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101529:	83 c4 10             	add    $0x10,%esp
}
8010152c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010152f:	5b                   	pop    %ebx
80101530:	5e                   	pop    %esi
80101531:	5d                   	pop    %ebp
  brelse(bp);
80101532:	e9 a9 ec ff ff       	jmp    801001e0 <brelse>
80101537:	89 f6                	mov    %esi,%esi
80101539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101540 <iinit>:
{
80101540:	55                   	push   %ebp
80101541:	89 e5                	mov    %esp,%ebp
80101543:	53                   	push   %ebx
80101544:	bb 20 0a 11 80       	mov    $0x80110a20,%ebx
80101549:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010154c:	68 8b 70 10 80       	push   $0x8010708b
80101551:	68 e0 09 11 80       	push   $0x801109e0
80101556:	e8 65 2d 00 00       	call   801042c0 <initlock>
8010155b:	83 c4 10             	add    $0x10,%esp
8010155e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80101560:	83 ec 08             	sub    $0x8,%esp
80101563:	68 92 70 10 80       	push   $0x80107092
80101568:	53                   	push   %ebx
80101569:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010156f:	e8 1c 2c 00 00       	call   80104190 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101574:	83 c4 10             	add    $0x10,%esp
80101577:	81 fb 40 26 11 80    	cmp    $0x80112640,%ebx
8010157d:	75 e1                	jne    80101560 <iinit+0x20>
  readsb(dev, &sb);
8010157f:	83 ec 08             	sub    $0x8,%esp
80101582:	68 c0 09 11 80       	push   $0x801109c0
80101587:	ff 75 08             	pushl  0x8(%ebp)
8010158a:	e8 71 ff ff ff       	call   80101500 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
8010158f:	ff 35 d8 09 11 80    	pushl  0x801109d8
80101595:	ff 35 d4 09 11 80    	pushl  0x801109d4
8010159b:	ff 35 d0 09 11 80    	pushl  0x801109d0
801015a1:	ff 35 cc 09 11 80    	pushl  0x801109cc
801015a7:	ff 35 c8 09 11 80    	pushl  0x801109c8
801015ad:	ff 35 c4 09 11 80    	pushl  0x801109c4
801015b3:	ff 35 c0 09 11 80    	pushl  0x801109c0
801015b9:	68 f8 70 10 80       	push   $0x801070f8
801015be:	e8 9d f0 ff ff       	call   80100660 <cprintf>
}
801015c3:	83 c4 30             	add    $0x30,%esp
801015c6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801015c9:	c9                   	leave  
801015ca:	c3                   	ret    
801015cb:	90                   	nop
801015cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801015d0 <ialloc>:
{
801015d0:	55                   	push   %ebp
801015d1:	89 e5                	mov    %esp,%ebp
801015d3:	57                   	push   %edi
801015d4:	56                   	push   %esi
801015d5:	53                   	push   %ebx
801015d6:	83 ec 1c             	sub    $0x1c,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
801015d9:	83 3d c8 09 11 80 01 	cmpl   $0x1,0x801109c8
{
801015e0:	8b 45 0c             	mov    0xc(%ebp),%eax
801015e3:	8b 75 08             	mov    0x8(%ebp),%esi
801015e6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
801015e9:	0f 86 91 00 00 00    	jbe    80101680 <ialloc+0xb0>
801015ef:	bb 01 00 00 00       	mov    $0x1,%ebx
801015f4:	eb 21                	jmp    80101617 <ialloc+0x47>
801015f6:	8d 76 00             	lea    0x0(%esi),%esi
801015f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    brelse(bp);
80101600:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101603:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
80101606:	57                   	push   %edi
80101607:	e8 d4 eb ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010160c:	83 c4 10             	add    $0x10,%esp
8010160f:	39 1d c8 09 11 80    	cmp    %ebx,0x801109c8
80101615:	76 69                	jbe    80101680 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101617:	89 d8                	mov    %ebx,%eax
80101619:	83 ec 08             	sub    $0x8,%esp
8010161c:	c1 e8 03             	shr    $0x3,%eax
8010161f:	03 05 d4 09 11 80    	add    0x801109d4,%eax
80101625:	50                   	push   %eax
80101626:	56                   	push   %esi
80101627:	e8 a4 ea ff ff       	call   801000d0 <bread>
8010162c:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
8010162e:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
80101630:	83 c4 10             	add    $0x10,%esp
    dip = (struct dinode*)bp->data + inum%IPB;
80101633:	83 e0 07             	and    $0x7,%eax
80101636:	c1 e0 06             	shl    $0x6,%eax
80101639:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010163d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101641:	75 bd                	jne    80101600 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101643:	83 ec 04             	sub    $0x4,%esp
80101646:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101649:	6a 40                	push   $0x40
8010164b:	6a 00                	push   $0x0
8010164d:	51                   	push   %ecx
8010164e:	e8 bd 2e 00 00       	call   80104510 <memset>
      dip->type = type;
80101653:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101657:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010165a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010165d:	89 3c 24             	mov    %edi,(%esp)
80101660:	e8 cb 17 00 00       	call   80102e30 <log_write>
      brelse(bp);
80101665:	89 3c 24             	mov    %edi,(%esp)
80101668:	e8 73 eb ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
8010166d:	83 c4 10             	add    $0x10,%esp
}
80101670:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80101673:	89 da                	mov    %ebx,%edx
80101675:	89 f0                	mov    %esi,%eax
}
80101677:	5b                   	pop    %ebx
80101678:	5e                   	pop    %esi
80101679:	5f                   	pop    %edi
8010167a:	5d                   	pop    %ebp
      return iget(dev, inum);
8010167b:	e9 10 fc ff ff       	jmp    80101290 <iget>
  panic("ialloc: no inodes");
80101680:	83 ec 0c             	sub    $0xc,%esp
80101683:	68 98 70 10 80       	push   $0x80107098
80101688:	e8 03 ed ff ff       	call   80100390 <panic>
8010168d:	8d 76 00             	lea    0x0(%esi),%esi

80101690 <iupdate>:
{
80101690:	55                   	push   %ebp
80101691:	89 e5                	mov    %esp,%ebp
80101693:	56                   	push   %esi
80101694:	53                   	push   %ebx
80101695:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101698:	83 ec 08             	sub    $0x8,%esp
8010169b:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010169e:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016a1:	c1 e8 03             	shr    $0x3,%eax
801016a4:	03 05 d4 09 11 80    	add    0x801109d4,%eax
801016aa:	50                   	push   %eax
801016ab:	ff 73 a4             	pushl  -0x5c(%ebx)
801016ae:	e8 1d ea ff ff       	call   801000d0 <bread>
801016b3:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801016b5:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
801016b8:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016bc:	83 c4 0c             	add    $0xc,%esp
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801016bf:	83 e0 07             	and    $0x7,%eax
801016c2:	c1 e0 06             	shl    $0x6,%eax
801016c5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
801016c9:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
801016cc:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016d0:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
801016d3:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
801016d7:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
801016db:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
801016df:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
801016e3:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
801016e7:	8b 53 fc             	mov    -0x4(%ebx),%edx
801016ea:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016ed:	6a 34                	push   $0x34
801016ef:	53                   	push   %ebx
801016f0:	50                   	push   %eax
801016f1:	e8 ca 2e 00 00       	call   801045c0 <memmove>
  log_write(bp);
801016f6:	89 34 24             	mov    %esi,(%esp)
801016f9:	e8 32 17 00 00       	call   80102e30 <log_write>
  brelse(bp);
801016fe:	89 75 08             	mov    %esi,0x8(%ebp)
80101701:	83 c4 10             	add    $0x10,%esp
}
80101704:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101707:	5b                   	pop    %ebx
80101708:	5e                   	pop    %esi
80101709:	5d                   	pop    %ebp
  brelse(bp);
8010170a:	e9 d1 ea ff ff       	jmp    801001e0 <brelse>
8010170f:	90                   	nop

80101710 <idup>:
{
80101710:	55                   	push   %ebp
80101711:	89 e5                	mov    %esp,%ebp
80101713:	53                   	push   %ebx
80101714:	83 ec 10             	sub    $0x10,%esp
80101717:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010171a:	68 e0 09 11 80       	push   $0x801109e0
8010171f:	e8 dc 2c 00 00       	call   80104400 <acquire>
  ip->ref++;
80101724:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101728:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010172f:	e8 8c 2d 00 00       	call   801044c0 <release>
}
80101734:	89 d8                	mov    %ebx,%eax
80101736:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101739:	c9                   	leave  
8010173a:	c3                   	ret    
8010173b:	90                   	nop
8010173c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101740 <ilock>:
{
80101740:	55                   	push   %ebp
80101741:	89 e5                	mov    %esp,%ebp
80101743:	56                   	push   %esi
80101744:	53                   	push   %ebx
80101745:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101748:	85 db                	test   %ebx,%ebx
8010174a:	0f 84 b7 00 00 00    	je     80101807 <ilock+0xc7>
80101750:	8b 53 08             	mov    0x8(%ebx),%edx
80101753:	85 d2                	test   %edx,%edx
80101755:	0f 8e ac 00 00 00    	jle    80101807 <ilock+0xc7>
  acquiresleep(&ip->lock);
8010175b:	8d 43 0c             	lea    0xc(%ebx),%eax
8010175e:	83 ec 0c             	sub    $0xc,%esp
80101761:	50                   	push   %eax
80101762:	e8 69 2a 00 00       	call   801041d0 <acquiresleep>
  if(ip->valid == 0){
80101767:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010176a:	83 c4 10             	add    $0x10,%esp
8010176d:	85 c0                	test   %eax,%eax
8010176f:	74 0f                	je     80101780 <ilock+0x40>
}
80101771:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101774:	5b                   	pop    %ebx
80101775:	5e                   	pop    %esi
80101776:	5d                   	pop    %ebp
80101777:	c3                   	ret    
80101778:	90                   	nop
80101779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101780:	8b 43 04             	mov    0x4(%ebx),%eax
80101783:	83 ec 08             	sub    $0x8,%esp
80101786:	c1 e8 03             	shr    $0x3,%eax
80101789:	03 05 d4 09 11 80    	add    0x801109d4,%eax
8010178f:	50                   	push   %eax
80101790:	ff 33                	pushl  (%ebx)
80101792:	e8 39 e9 ff ff       	call   801000d0 <bread>
80101797:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101799:	8b 43 04             	mov    0x4(%ebx),%eax
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010179c:	83 c4 0c             	add    $0xc,%esp
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010179f:	83 e0 07             	and    $0x7,%eax
801017a2:	c1 e0 06             	shl    $0x6,%eax
801017a5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801017a9:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801017ac:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
801017af:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
801017b3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
801017b7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
801017bb:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
801017bf:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
801017c3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
801017c7:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
801017cb:	8b 50 fc             	mov    -0x4(%eax),%edx
801017ce:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801017d1:	6a 34                	push   $0x34
801017d3:	50                   	push   %eax
801017d4:	8d 43 5c             	lea    0x5c(%ebx),%eax
801017d7:	50                   	push   %eax
801017d8:	e8 e3 2d 00 00       	call   801045c0 <memmove>
    brelse(bp);
801017dd:	89 34 24             	mov    %esi,(%esp)
801017e0:	e8 fb e9 ff ff       	call   801001e0 <brelse>
    if(ip->type == 0)
801017e5:	83 c4 10             	add    $0x10,%esp
801017e8:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
801017ed:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
801017f4:	0f 85 77 ff ff ff    	jne    80101771 <ilock+0x31>
      panic("ilock: no type");
801017fa:	83 ec 0c             	sub    $0xc,%esp
801017fd:	68 b0 70 10 80       	push   $0x801070b0
80101802:	e8 89 eb ff ff       	call   80100390 <panic>
    panic("ilock");
80101807:	83 ec 0c             	sub    $0xc,%esp
8010180a:	68 aa 70 10 80       	push   $0x801070aa
8010180f:	e8 7c eb ff ff       	call   80100390 <panic>
80101814:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010181a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101820 <iunlock>:
{
80101820:	55                   	push   %ebp
80101821:	89 e5                	mov    %esp,%ebp
80101823:	56                   	push   %esi
80101824:	53                   	push   %ebx
80101825:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101828:	85 db                	test   %ebx,%ebx
8010182a:	74 28                	je     80101854 <iunlock+0x34>
8010182c:	8d 73 0c             	lea    0xc(%ebx),%esi
8010182f:	83 ec 0c             	sub    $0xc,%esp
80101832:	56                   	push   %esi
80101833:	e8 38 2a 00 00       	call   80104270 <holdingsleep>
80101838:	83 c4 10             	add    $0x10,%esp
8010183b:	85 c0                	test   %eax,%eax
8010183d:	74 15                	je     80101854 <iunlock+0x34>
8010183f:	8b 43 08             	mov    0x8(%ebx),%eax
80101842:	85 c0                	test   %eax,%eax
80101844:	7e 0e                	jle    80101854 <iunlock+0x34>
  releasesleep(&ip->lock);
80101846:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101849:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010184c:	5b                   	pop    %ebx
8010184d:	5e                   	pop    %esi
8010184e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
8010184f:	e9 dc 29 00 00       	jmp    80104230 <releasesleep>
    panic("iunlock");
80101854:	83 ec 0c             	sub    $0xc,%esp
80101857:	68 bf 70 10 80       	push   $0x801070bf
8010185c:	e8 2f eb ff ff       	call   80100390 <panic>
80101861:	eb 0d                	jmp    80101870 <iput>
80101863:	90                   	nop
80101864:	90                   	nop
80101865:	90                   	nop
80101866:	90                   	nop
80101867:	90                   	nop
80101868:	90                   	nop
80101869:	90                   	nop
8010186a:	90                   	nop
8010186b:	90                   	nop
8010186c:	90                   	nop
8010186d:	90                   	nop
8010186e:	90                   	nop
8010186f:	90                   	nop

80101870 <iput>:
{
80101870:	55                   	push   %ebp
80101871:	89 e5                	mov    %esp,%ebp
80101873:	57                   	push   %edi
80101874:	56                   	push   %esi
80101875:	53                   	push   %ebx
80101876:	83 ec 28             	sub    $0x28,%esp
80101879:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
8010187c:	8d 7b 0c             	lea    0xc(%ebx),%edi
8010187f:	57                   	push   %edi
80101880:	e8 4b 29 00 00       	call   801041d0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101885:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101888:	83 c4 10             	add    $0x10,%esp
8010188b:	85 d2                	test   %edx,%edx
8010188d:	74 07                	je     80101896 <iput+0x26>
8010188f:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101894:	74 32                	je     801018c8 <iput+0x58>
  releasesleep(&ip->lock);
80101896:	83 ec 0c             	sub    $0xc,%esp
80101899:	57                   	push   %edi
8010189a:	e8 91 29 00 00       	call   80104230 <releasesleep>
  acquire(&icache.lock);
8010189f:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
801018a6:	e8 55 2b 00 00       	call   80104400 <acquire>
  ip->ref--;
801018ab:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
801018af:	83 c4 10             	add    $0x10,%esp
801018b2:	c7 45 08 e0 09 11 80 	movl   $0x801109e0,0x8(%ebp)
}
801018b9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801018bc:	5b                   	pop    %ebx
801018bd:	5e                   	pop    %esi
801018be:	5f                   	pop    %edi
801018bf:	5d                   	pop    %ebp
  release(&icache.lock);
801018c0:	e9 fb 2b 00 00       	jmp    801044c0 <release>
801018c5:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
801018c8:	83 ec 0c             	sub    $0xc,%esp
801018cb:	68 e0 09 11 80       	push   $0x801109e0
801018d0:	e8 2b 2b 00 00       	call   80104400 <acquire>
    int r = ip->ref;
801018d5:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
801018d8:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
801018df:	e8 dc 2b 00 00       	call   801044c0 <release>
    if(r == 1){
801018e4:	83 c4 10             	add    $0x10,%esp
801018e7:	83 fe 01             	cmp    $0x1,%esi
801018ea:	75 aa                	jne    80101896 <iput+0x26>
801018ec:	8d 8b 88 00 00 00    	lea    0x88(%ebx),%ecx
801018f2:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801018f5:	8d 73 5c             	lea    0x5c(%ebx),%esi
801018f8:	89 cf                	mov    %ecx,%edi
801018fa:	eb 0b                	jmp    80101907 <iput+0x97>
801018fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101900:	83 c6 04             	add    $0x4,%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101903:	39 fe                	cmp    %edi,%esi
80101905:	74 19                	je     80101920 <iput+0xb0>
    if(ip->addrs[i]){
80101907:	8b 16                	mov    (%esi),%edx
80101909:	85 d2                	test   %edx,%edx
8010190b:	74 f3                	je     80101900 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010190d:	8b 03                	mov    (%ebx),%eax
8010190f:	e8 fc f7 ff ff       	call   80101110 <bfree>
      ip->addrs[i] = 0;
80101914:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010191a:	eb e4                	jmp    80101900 <iput+0x90>
8010191c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101920:	8b 83 88 00 00 00    	mov    0x88(%ebx),%eax
80101926:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101929:	85 c0                	test   %eax,%eax
8010192b:	75 33                	jne    80101960 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010192d:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101930:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101937:	53                   	push   %ebx
80101938:	e8 53 fd ff ff       	call   80101690 <iupdate>
      ip->type = 0;
8010193d:	31 c0                	xor    %eax,%eax
8010193f:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101943:	89 1c 24             	mov    %ebx,(%esp)
80101946:	e8 45 fd ff ff       	call   80101690 <iupdate>
      ip->valid = 0;
8010194b:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101952:	83 c4 10             	add    $0x10,%esp
80101955:	e9 3c ff ff ff       	jmp    80101896 <iput+0x26>
8010195a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101960:	83 ec 08             	sub    $0x8,%esp
80101963:	50                   	push   %eax
80101964:	ff 33                	pushl  (%ebx)
80101966:	e8 65 e7 ff ff       	call   801000d0 <bread>
8010196b:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101971:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101974:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
80101977:	8d 70 5c             	lea    0x5c(%eax),%esi
8010197a:	83 c4 10             	add    $0x10,%esp
8010197d:	89 cf                	mov    %ecx,%edi
8010197f:	eb 0e                	jmp    8010198f <iput+0x11f>
80101981:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101988:	83 c6 04             	add    $0x4,%esi
    for(j = 0; j < NINDIRECT; j++){
8010198b:	39 fe                	cmp    %edi,%esi
8010198d:	74 0f                	je     8010199e <iput+0x12e>
      if(a[j])
8010198f:	8b 16                	mov    (%esi),%edx
80101991:	85 d2                	test   %edx,%edx
80101993:	74 f3                	je     80101988 <iput+0x118>
        bfree(ip->dev, a[j]);
80101995:	8b 03                	mov    (%ebx),%eax
80101997:	e8 74 f7 ff ff       	call   80101110 <bfree>
8010199c:	eb ea                	jmp    80101988 <iput+0x118>
    brelse(bp);
8010199e:	83 ec 0c             	sub    $0xc,%esp
801019a1:	ff 75 e4             	pushl  -0x1c(%ebp)
801019a4:	8b 7d e0             	mov    -0x20(%ebp),%edi
801019a7:	e8 34 e8 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801019ac:	8b 93 88 00 00 00    	mov    0x88(%ebx),%edx
801019b2:	8b 03                	mov    (%ebx),%eax
801019b4:	e8 57 f7 ff ff       	call   80101110 <bfree>
    ip->addrs[NDIRECT] = 0;
801019b9:	c7 83 88 00 00 00 00 	movl   $0x0,0x88(%ebx)
801019c0:	00 00 00 
801019c3:	83 c4 10             	add    $0x10,%esp
801019c6:	e9 62 ff ff ff       	jmp    8010192d <iput+0xbd>
801019cb:	90                   	nop
801019cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801019d0 <iunlockput>:
{
801019d0:	55                   	push   %ebp
801019d1:	89 e5                	mov    %esp,%ebp
801019d3:	53                   	push   %ebx
801019d4:	83 ec 10             	sub    $0x10,%esp
801019d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
801019da:	53                   	push   %ebx
801019db:	e8 40 fe ff ff       	call   80101820 <iunlock>
  iput(ip);
801019e0:	89 5d 08             	mov    %ebx,0x8(%ebp)
801019e3:	83 c4 10             	add    $0x10,%esp
}
801019e6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801019e9:	c9                   	leave  
  iput(ip);
801019ea:	e9 81 fe ff ff       	jmp    80101870 <iput>
801019ef:	90                   	nop

801019f0 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
801019f0:	55                   	push   %ebp
801019f1:	89 e5                	mov    %esp,%ebp
801019f3:	8b 55 08             	mov    0x8(%ebp),%edx
801019f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
801019f9:	8b 0a                	mov    (%edx),%ecx
801019fb:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
801019fe:	8b 4a 04             	mov    0x4(%edx),%ecx
80101a01:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101a04:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101a08:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101a0b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101a0f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101a13:	8b 52 58             	mov    0x58(%edx),%edx
80101a16:	89 50 10             	mov    %edx,0x10(%eax)
}
80101a19:	5d                   	pop    %ebp
80101a1a:	c3                   	ret    
80101a1b:	90                   	nop
80101a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101a20 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101a20:	55                   	push   %ebp
80101a21:	89 e5                	mov    %esp,%ebp
80101a23:	57                   	push   %edi
80101a24:	56                   	push   %esi
80101a25:	53                   	push   %ebx
80101a26:	83 ec 1c             	sub    $0x1c,%esp
80101a29:	8b 45 08             	mov    0x8(%ebp),%eax
80101a2c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101a2f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a32:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101a37:	89 75 e0             	mov    %esi,-0x20(%ebp)
80101a3a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101a3d:	8b 75 10             	mov    0x10(%ebp),%esi
80101a40:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101a43:	0f 84 a7 00 00 00    	je     80101af0 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101a49:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a4c:	8b 40 58             	mov    0x58(%eax),%eax
80101a4f:	39 c6                	cmp    %eax,%esi
80101a51:	0f 87 ba 00 00 00    	ja     80101b11 <readi+0xf1>
80101a57:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101a5a:	89 f9                	mov    %edi,%ecx
80101a5c:	01 f1                	add    %esi,%ecx
80101a5e:	0f 82 ad 00 00 00    	jb     80101b11 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101a64:	89 c2                	mov    %eax,%edx
80101a66:	29 f2                	sub    %esi,%edx
80101a68:	39 c8                	cmp    %ecx,%eax
80101a6a:	0f 43 d7             	cmovae %edi,%edx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a6d:	31 ff                	xor    %edi,%edi
80101a6f:	85 d2                	test   %edx,%edx
    n = ip->size - off;
80101a71:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a74:	74 6c                	je     80101ae2 <readi+0xc2>
80101a76:	8d 76 00             	lea    0x0(%esi),%esi
80101a79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a80:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101a83:	89 f2                	mov    %esi,%edx
80101a85:	c1 ea 09             	shr    $0x9,%edx
80101a88:	89 d8                	mov    %ebx,%eax
80101a8a:	e8 d1 f8 ff ff       	call   80101360 <bmap>
80101a8f:	83 ec 08             	sub    $0x8,%esp
80101a92:	50                   	push   %eax
80101a93:	ff 33                	pushl  (%ebx)
80101a95:	e8 36 e6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101a9a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a9d:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101a9f:	89 f0                	mov    %esi,%eax
80101aa1:	25 ff 01 00 00       	and    $0x1ff,%eax
80101aa6:	b9 00 02 00 00       	mov    $0x200,%ecx
80101aab:	83 c4 0c             	add    $0xc,%esp
80101aae:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101ab0:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
80101ab4:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101ab7:	29 fb                	sub    %edi,%ebx
80101ab9:	39 d9                	cmp    %ebx,%ecx
80101abb:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101abe:	53                   	push   %ebx
80101abf:	50                   	push   %eax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101ac0:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101ac2:	ff 75 e0             	pushl  -0x20(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101ac5:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101ac7:	e8 f4 2a 00 00       	call   801045c0 <memmove>
    brelse(bp);
80101acc:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101acf:	89 14 24             	mov    %edx,(%esp)
80101ad2:	e8 09 e7 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101ad7:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101ada:	83 c4 10             	add    $0x10,%esp
80101add:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101ae0:	77 9e                	ja     80101a80 <readi+0x60>
  }
  return n;
80101ae2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101ae5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ae8:	5b                   	pop    %ebx
80101ae9:	5e                   	pop    %esi
80101aea:	5f                   	pop    %edi
80101aeb:	5d                   	pop    %ebp
80101aec:	c3                   	ret    
80101aed:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101af0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101af4:	66 83 f8 09          	cmp    $0x9,%ax
80101af8:	77 17                	ja     80101b11 <readi+0xf1>
80101afa:	8b 04 c5 60 09 11 80 	mov    -0x7feef6a0(,%eax,8),%eax
80101b01:	85 c0                	test   %eax,%eax
80101b03:	74 0c                	je     80101b11 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101b05:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101b08:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b0b:	5b                   	pop    %ebx
80101b0c:	5e                   	pop    %esi
80101b0d:	5f                   	pop    %edi
80101b0e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101b0f:	ff e0                	jmp    *%eax
      return -1;
80101b11:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b16:	eb cd                	jmp    80101ae5 <readi+0xc5>
80101b18:	90                   	nop
80101b19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101b20 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101b20:	55                   	push   %ebp
80101b21:	89 e5                	mov    %esp,%ebp
80101b23:	57                   	push   %edi
80101b24:	56                   	push   %esi
80101b25:	53                   	push   %ebx
80101b26:	83 ec 1c             	sub    $0x1c,%esp
80101b29:	8b 45 08             	mov    0x8(%ebp),%eax
80101b2c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101b2f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101b32:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101b37:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101b3a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101b3d:	8b 75 10             	mov    0x10(%ebp),%esi
80101b40:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80101b43:	0f 84 b7 00 00 00    	je     80101c00 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101b49:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b4c:	39 70 58             	cmp    %esi,0x58(%eax)
80101b4f:	0f 82 eb 00 00 00    	jb     80101c40 <writei+0x120>
80101b55:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101b58:	31 d2                	xor    %edx,%edx
80101b5a:	89 f8                	mov    %edi,%eax
80101b5c:	01 f0                	add    %esi,%eax
80101b5e:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101b61:	3d 00 16 81 00       	cmp    $0x811600,%eax
80101b66:	0f 87 d4 00 00 00    	ja     80101c40 <writei+0x120>
80101b6c:	85 d2                	test   %edx,%edx
80101b6e:	0f 85 cc 00 00 00    	jne    80101c40 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b74:	85 ff                	test   %edi,%edi
80101b76:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101b7d:	74 72                	je     80101bf1 <writei+0xd1>
80101b7f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b80:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101b83:	89 f2                	mov    %esi,%edx
80101b85:	c1 ea 09             	shr    $0x9,%edx
80101b88:	89 f8                	mov    %edi,%eax
80101b8a:	e8 d1 f7 ff ff       	call   80101360 <bmap>
80101b8f:	83 ec 08             	sub    $0x8,%esp
80101b92:	50                   	push   %eax
80101b93:	ff 37                	pushl  (%edi)
80101b95:	e8 36 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101b9a:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101b9d:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ba0:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101ba2:	89 f0                	mov    %esi,%eax
80101ba4:	b9 00 02 00 00       	mov    $0x200,%ecx
80101ba9:	83 c4 0c             	add    $0xc,%esp
80101bac:	25 ff 01 00 00       	and    $0x1ff,%eax
80101bb1:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101bb3:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101bb7:	39 d9                	cmp    %ebx,%ecx
80101bb9:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101bbc:	53                   	push   %ebx
80101bbd:	ff 75 dc             	pushl  -0x24(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101bc0:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101bc2:	50                   	push   %eax
80101bc3:	e8 f8 29 00 00       	call   801045c0 <memmove>
    log_write(bp);
80101bc8:	89 3c 24             	mov    %edi,(%esp)
80101bcb:	e8 60 12 00 00       	call   80102e30 <log_write>
    brelse(bp);
80101bd0:	89 3c 24             	mov    %edi,(%esp)
80101bd3:	e8 08 e6 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101bd8:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101bdb:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101bde:	83 c4 10             	add    $0x10,%esp
80101be1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101be4:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101be7:	77 97                	ja     80101b80 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101be9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101bec:	3b 70 58             	cmp    0x58(%eax),%esi
80101bef:	77 37                	ja     80101c28 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101bf1:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101bf4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101bf7:	5b                   	pop    %ebx
80101bf8:	5e                   	pop    %esi
80101bf9:	5f                   	pop    %edi
80101bfa:	5d                   	pop    %ebp
80101bfb:	c3                   	ret    
80101bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101c00:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101c04:	66 83 f8 09          	cmp    $0x9,%ax
80101c08:	77 36                	ja     80101c40 <writei+0x120>
80101c0a:	8b 04 c5 64 09 11 80 	mov    -0x7feef69c(,%eax,8),%eax
80101c11:	85 c0                	test   %eax,%eax
80101c13:	74 2b                	je     80101c40 <writei+0x120>
    return devsw[ip->major].write(ip, src, n);
80101c15:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101c18:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c1b:	5b                   	pop    %ebx
80101c1c:	5e                   	pop    %esi
80101c1d:	5f                   	pop    %edi
80101c1e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101c1f:	ff e0                	jmp    *%eax
80101c21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101c28:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101c2b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101c2e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101c31:	50                   	push   %eax
80101c32:	e8 59 fa ff ff       	call   80101690 <iupdate>
80101c37:	83 c4 10             	add    $0x10,%esp
80101c3a:	eb b5                	jmp    80101bf1 <writei+0xd1>
80101c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80101c40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101c45:	eb ad                	jmp    80101bf4 <writei+0xd4>
80101c47:	89 f6                	mov    %esi,%esi
80101c49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101c50 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101c50:	55                   	push   %ebp
80101c51:	89 e5                	mov    %esp,%ebp
80101c53:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101c56:	6a 0e                	push   $0xe
80101c58:	ff 75 0c             	pushl  0xc(%ebp)
80101c5b:	ff 75 08             	pushl  0x8(%ebp)
80101c5e:	e8 cd 29 00 00       	call   80104630 <strncmp>
}
80101c63:	c9                   	leave  
80101c64:	c3                   	ret    
80101c65:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101c70 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101c70:	55                   	push   %ebp
80101c71:	89 e5                	mov    %esp,%ebp
80101c73:	57                   	push   %edi
80101c74:	56                   	push   %esi
80101c75:	53                   	push   %ebx
80101c76:	83 ec 1c             	sub    $0x1c,%esp
80101c79:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101c7c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101c81:	0f 85 85 00 00 00    	jne    80101d0c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101c87:	8b 53 58             	mov    0x58(%ebx),%edx
80101c8a:	31 ff                	xor    %edi,%edi
80101c8c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101c8f:	85 d2                	test   %edx,%edx
80101c91:	74 3e                	je     80101cd1 <dirlookup+0x61>
80101c93:	90                   	nop
80101c94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101c98:	6a 10                	push   $0x10
80101c9a:	57                   	push   %edi
80101c9b:	56                   	push   %esi
80101c9c:	53                   	push   %ebx
80101c9d:	e8 7e fd ff ff       	call   80101a20 <readi>
80101ca2:	83 c4 10             	add    $0x10,%esp
80101ca5:	83 f8 10             	cmp    $0x10,%eax
80101ca8:	75 55                	jne    80101cff <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101caa:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101caf:	74 18                	je     80101cc9 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101cb1:	8d 45 da             	lea    -0x26(%ebp),%eax
80101cb4:	83 ec 04             	sub    $0x4,%esp
80101cb7:	6a 0e                	push   $0xe
80101cb9:	50                   	push   %eax
80101cba:	ff 75 0c             	pushl  0xc(%ebp)
80101cbd:	e8 6e 29 00 00       	call   80104630 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101cc2:	83 c4 10             	add    $0x10,%esp
80101cc5:	85 c0                	test   %eax,%eax
80101cc7:	74 17                	je     80101ce0 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101cc9:	83 c7 10             	add    $0x10,%edi
80101ccc:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101ccf:	72 c7                	jb     80101c98 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101cd1:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101cd4:	31 c0                	xor    %eax,%eax
}
80101cd6:	5b                   	pop    %ebx
80101cd7:	5e                   	pop    %esi
80101cd8:	5f                   	pop    %edi
80101cd9:	5d                   	pop    %ebp
80101cda:	c3                   	ret    
80101cdb:	90                   	nop
80101cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(poff)
80101ce0:	8b 45 10             	mov    0x10(%ebp),%eax
80101ce3:	85 c0                	test   %eax,%eax
80101ce5:	74 05                	je     80101cec <dirlookup+0x7c>
        *poff = off;
80101ce7:	8b 45 10             	mov    0x10(%ebp),%eax
80101cea:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101cec:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101cf0:	8b 03                	mov    (%ebx),%eax
80101cf2:	e8 99 f5 ff ff       	call   80101290 <iget>
}
80101cf7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101cfa:	5b                   	pop    %ebx
80101cfb:	5e                   	pop    %esi
80101cfc:	5f                   	pop    %edi
80101cfd:	5d                   	pop    %ebp
80101cfe:	c3                   	ret    
      panic("dirlookup read");
80101cff:	83 ec 0c             	sub    $0xc,%esp
80101d02:	68 d9 70 10 80       	push   $0x801070d9
80101d07:	e8 84 e6 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101d0c:	83 ec 0c             	sub    $0xc,%esp
80101d0f:	68 c7 70 10 80       	push   $0x801070c7
80101d14:	e8 77 e6 ff ff       	call   80100390 <panic>
80101d19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101d20 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101d20:	55                   	push   %ebp
80101d21:	89 e5                	mov    %esp,%ebp
80101d23:	57                   	push   %edi
80101d24:	56                   	push   %esi
80101d25:	53                   	push   %ebx
80101d26:	89 cf                	mov    %ecx,%edi
80101d28:	89 c3                	mov    %eax,%ebx
80101d2a:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101d2d:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101d30:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80101d33:	0f 84 67 01 00 00    	je     80101ea0 <namex+0x180>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101d39:	e8 62 1b 00 00       	call   801038a0 <myproc>
  acquire(&icache.lock);
80101d3e:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101d41:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101d44:	68 e0 09 11 80       	push   $0x801109e0
80101d49:	e8 b2 26 00 00       	call   80104400 <acquire>
  ip->ref++;
80101d4e:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101d52:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101d59:	e8 62 27 00 00       	call   801044c0 <release>
80101d5e:	83 c4 10             	add    $0x10,%esp
80101d61:	eb 08                	jmp    80101d6b <namex+0x4b>
80101d63:	90                   	nop
80101d64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101d68:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101d6b:	0f b6 03             	movzbl (%ebx),%eax
80101d6e:	3c 2f                	cmp    $0x2f,%al
80101d70:	74 f6                	je     80101d68 <namex+0x48>
  if(*path == 0)
80101d72:	84 c0                	test   %al,%al
80101d74:	0f 84 ee 00 00 00    	je     80101e68 <namex+0x148>
  while(*path != '/' && *path != 0)
80101d7a:	0f b6 03             	movzbl (%ebx),%eax
80101d7d:	3c 2f                	cmp    $0x2f,%al
80101d7f:	0f 84 b3 00 00 00    	je     80101e38 <namex+0x118>
80101d85:	84 c0                	test   %al,%al
80101d87:	89 da                	mov    %ebx,%edx
80101d89:	75 09                	jne    80101d94 <namex+0x74>
80101d8b:	e9 a8 00 00 00       	jmp    80101e38 <namex+0x118>
80101d90:	84 c0                	test   %al,%al
80101d92:	74 0a                	je     80101d9e <namex+0x7e>
    path++;
80101d94:	83 c2 01             	add    $0x1,%edx
  while(*path != '/' && *path != 0)
80101d97:	0f b6 02             	movzbl (%edx),%eax
80101d9a:	3c 2f                	cmp    $0x2f,%al
80101d9c:	75 f2                	jne    80101d90 <namex+0x70>
80101d9e:	89 d1                	mov    %edx,%ecx
80101da0:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80101da2:	83 f9 0d             	cmp    $0xd,%ecx
80101da5:	0f 8e 91 00 00 00    	jle    80101e3c <namex+0x11c>
    memmove(name, s, DIRSIZ);
80101dab:	83 ec 04             	sub    $0x4,%esp
80101dae:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101db1:	6a 0e                	push   $0xe
80101db3:	53                   	push   %ebx
80101db4:	57                   	push   %edi
80101db5:	e8 06 28 00 00       	call   801045c0 <memmove>
    path++;
80101dba:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    memmove(name, s, DIRSIZ);
80101dbd:	83 c4 10             	add    $0x10,%esp
    path++;
80101dc0:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80101dc2:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101dc5:	75 11                	jne    80101dd8 <namex+0xb8>
80101dc7:	89 f6                	mov    %esi,%esi
80101dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101dd0:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101dd3:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101dd6:	74 f8                	je     80101dd0 <namex+0xb0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101dd8:	83 ec 0c             	sub    $0xc,%esp
80101ddb:	56                   	push   %esi
80101ddc:	e8 5f f9 ff ff       	call   80101740 <ilock>
    if(ip->type != T_DIR){
80101de1:	83 c4 10             	add    $0x10,%esp
80101de4:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101de9:	0f 85 91 00 00 00    	jne    80101e80 <namex+0x160>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101def:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101df2:	85 d2                	test   %edx,%edx
80101df4:	74 09                	je     80101dff <namex+0xdf>
80101df6:	80 3b 00             	cmpb   $0x0,(%ebx)
80101df9:	0f 84 b7 00 00 00    	je     80101eb6 <namex+0x196>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101dff:	83 ec 04             	sub    $0x4,%esp
80101e02:	6a 00                	push   $0x0
80101e04:	57                   	push   %edi
80101e05:	56                   	push   %esi
80101e06:	e8 65 fe ff ff       	call   80101c70 <dirlookup>
80101e0b:	83 c4 10             	add    $0x10,%esp
80101e0e:	85 c0                	test   %eax,%eax
80101e10:	74 6e                	je     80101e80 <namex+0x160>
  iunlock(ip);
80101e12:	83 ec 0c             	sub    $0xc,%esp
80101e15:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101e18:	56                   	push   %esi
80101e19:	e8 02 fa ff ff       	call   80101820 <iunlock>
  iput(ip);
80101e1e:	89 34 24             	mov    %esi,(%esp)
80101e21:	e8 4a fa ff ff       	call   80101870 <iput>
80101e26:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101e29:	83 c4 10             	add    $0x10,%esp
80101e2c:	89 c6                	mov    %eax,%esi
80101e2e:	e9 38 ff ff ff       	jmp    80101d6b <namex+0x4b>
80101e33:	90                   	nop
80101e34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path != '/' && *path != 0)
80101e38:	89 da                	mov    %ebx,%edx
80101e3a:	31 c9                	xor    %ecx,%ecx
    memmove(name, s, len);
80101e3c:	83 ec 04             	sub    $0x4,%esp
80101e3f:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101e42:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101e45:	51                   	push   %ecx
80101e46:	53                   	push   %ebx
80101e47:	57                   	push   %edi
80101e48:	e8 73 27 00 00       	call   801045c0 <memmove>
    name[len] = 0;
80101e4d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101e50:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101e53:	83 c4 10             	add    $0x10,%esp
80101e56:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101e5a:	89 d3                	mov    %edx,%ebx
80101e5c:	e9 61 ff ff ff       	jmp    80101dc2 <namex+0xa2>
80101e61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101e68:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101e6b:	85 c0                	test   %eax,%eax
80101e6d:	75 5d                	jne    80101ecc <namex+0x1ac>
    iput(ip);
    return 0;
  }
  return ip;
}
80101e6f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e72:	89 f0                	mov    %esi,%eax
80101e74:	5b                   	pop    %ebx
80101e75:	5e                   	pop    %esi
80101e76:	5f                   	pop    %edi
80101e77:	5d                   	pop    %ebp
80101e78:	c3                   	ret    
80101e79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80101e80:	83 ec 0c             	sub    $0xc,%esp
80101e83:	56                   	push   %esi
80101e84:	e8 97 f9 ff ff       	call   80101820 <iunlock>
  iput(ip);
80101e89:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101e8c:	31 f6                	xor    %esi,%esi
  iput(ip);
80101e8e:	e8 dd f9 ff ff       	call   80101870 <iput>
      return 0;
80101e93:	83 c4 10             	add    $0x10,%esp
}
80101e96:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e99:	89 f0                	mov    %esi,%eax
80101e9b:	5b                   	pop    %ebx
80101e9c:	5e                   	pop    %esi
80101e9d:	5f                   	pop    %edi
80101e9e:	5d                   	pop    %ebp
80101e9f:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
80101ea0:	ba 01 00 00 00       	mov    $0x1,%edx
80101ea5:	b8 01 00 00 00       	mov    $0x1,%eax
80101eaa:	e8 e1 f3 ff ff       	call   80101290 <iget>
80101eaf:	89 c6                	mov    %eax,%esi
80101eb1:	e9 b5 fe ff ff       	jmp    80101d6b <namex+0x4b>
      iunlock(ip);
80101eb6:	83 ec 0c             	sub    $0xc,%esp
80101eb9:	56                   	push   %esi
80101eba:	e8 61 f9 ff ff       	call   80101820 <iunlock>
      return ip;
80101ebf:	83 c4 10             	add    $0x10,%esp
}
80101ec2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ec5:	89 f0                	mov    %esi,%eax
80101ec7:	5b                   	pop    %ebx
80101ec8:	5e                   	pop    %esi
80101ec9:	5f                   	pop    %edi
80101eca:	5d                   	pop    %ebp
80101ecb:	c3                   	ret    
    iput(ip);
80101ecc:	83 ec 0c             	sub    $0xc,%esp
80101ecf:	56                   	push   %esi
    return 0;
80101ed0:	31 f6                	xor    %esi,%esi
    iput(ip);
80101ed2:	e8 99 f9 ff ff       	call   80101870 <iput>
    return 0;
80101ed7:	83 c4 10             	add    $0x10,%esp
80101eda:	eb 93                	jmp    80101e6f <namex+0x14f>
80101edc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101ee0 <dirlink>:
{
80101ee0:	55                   	push   %ebp
80101ee1:	89 e5                	mov    %esp,%ebp
80101ee3:	57                   	push   %edi
80101ee4:	56                   	push   %esi
80101ee5:	53                   	push   %ebx
80101ee6:	83 ec 20             	sub    $0x20,%esp
80101ee9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101eec:	6a 00                	push   $0x0
80101eee:	ff 75 0c             	pushl  0xc(%ebp)
80101ef1:	53                   	push   %ebx
80101ef2:	e8 79 fd ff ff       	call   80101c70 <dirlookup>
80101ef7:	83 c4 10             	add    $0x10,%esp
80101efa:	85 c0                	test   %eax,%eax
80101efc:	75 67                	jne    80101f65 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101efe:	8b 7b 58             	mov    0x58(%ebx),%edi
80101f01:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101f04:	85 ff                	test   %edi,%edi
80101f06:	74 29                	je     80101f31 <dirlink+0x51>
80101f08:	31 ff                	xor    %edi,%edi
80101f0a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101f0d:	eb 09                	jmp    80101f18 <dirlink+0x38>
80101f0f:	90                   	nop
80101f10:	83 c7 10             	add    $0x10,%edi
80101f13:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101f16:	73 19                	jae    80101f31 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f18:	6a 10                	push   $0x10
80101f1a:	57                   	push   %edi
80101f1b:	56                   	push   %esi
80101f1c:	53                   	push   %ebx
80101f1d:	e8 fe fa ff ff       	call   80101a20 <readi>
80101f22:	83 c4 10             	add    $0x10,%esp
80101f25:	83 f8 10             	cmp    $0x10,%eax
80101f28:	75 4e                	jne    80101f78 <dirlink+0x98>
    if(de.inum == 0)
80101f2a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101f2f:	75 df                	jne    80101f10 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80101f31:	8d 45 da             	lea    -0x26(%ebp),%eax
80101f34:	83 ec 04             	sub    $0x4,%esp
80101f37:	6a 0e                	push   $0xe
80101f39:	ff 75 0c             	pushl  0xc(%ebp)
80101f3c:	50                   	push   %eax
80101f3d:	e8 4e 27 00 00       	call   80104690 <strncpy>
  de.inum = inum;
80101f42:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f45:	6a 10                	push   $0x10
80101f47:	57                   	push   %edi
80101f48:	56                   	push   %esi
80101f49:	53                   	push   %ebx
  de.inum = inum;
80101f4a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f4e:	e8 cd fb ff ff       	call   80101b20 <writei>
80101f53:	83 c4 20             	add    $0x20,%esp
80101f56:	83 f8 10             	cmp    $0x10,%eax
80101f59:	75 2a                	jne    80101f85 <dirlink+0xa5>
  return 0;
80101f5b:	31 c0                	xor    %eax,%eax
}
80101f5d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f60:	5b                   	pop    %ebx
80101f61:	5e                   	pop    %esi
80101f62:	5f                   	pop    %edi
80101f63:	5d                   	pop    %ebp
80101f64:	c3                   	ret    
    iput(ip);
80101f65:	83 ec 0c             	sub    $0xc,%esp
80101f68:	50                   	push   %eax
80101f69:	e8 02 f9 ff ff       	call   80101870 <iput>
    return -1;
80101f6e:	83 c4 10             	add    $0x10,%esp
80101f71:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f76:	eb e5                	jmp    80101f5d <dirlink+0x7d>
      panic("dirlink read");
80101f78:	83 ec 0c             	sub    $0xc,%esp
80101f7b:	68 e8 70 10 80       	push   $0x801070e8
80101f80:	e8 0b e4 ff ff       	call   80100390 <panic>
    panic("dirlink");
80101f85:	83 ec 0c             	sub    $0xc,%esp
80101f88:	68 de 76 10 80       	push   $0x801076de
80101f8d:	e8 fe e3 ff ff       	call   80100390 <panic>
80101f92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101fa0 <namei>:

struct inode*
namei(char *path)
{
80101fa0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101fa1:	31 d2                	xor    %edx,%edx
{
80101fa3:	89 e5                	mov    %esp,%ebp
80101fa5:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80101fa8:	8b 45 08             	mov    0x8(%ebp),%eax
80101fab:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101fae:	e8 6d fd ff ff       	call   80101d20 <namex>
}
80101fb3:	c9                   	leave  
80101fb4:	c3                   	ret    
80101fb5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101fb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101fc0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101fc0:	55                   	push   %ebp
  return namex(path, 1, name);
80101fc1:	ba 01 00 00 00       	mov    $0x1,%edx
{
80101fc6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101fc8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101fcb:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101fce:	5d                   	pop    %ebp
  return namex(path, 1, name);
80101fcf:	e9 4c fd ff ff       	jmp    80101d20 <namex>
80101fd4:	66 90                	xchg   %ax,%ax
80101fd6:	66 90                	xchg   %ax,%ax
80101fd8:	66 90                	xchg   %ax,%ax
80101fda:	66 90                	xchg   %ax,%ax
80101fdc:	66 90                	xchg   %ax,%ax
80101fde:	66 90                	xchg   %ax,%ax

80101fe0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101fe0:	55                   	push   %ebp
80101fe1:	89 e5                	mov    %esp,%ebp
80101fe3:	57                   	push   %edi
80101fe4:	56                   	push   %esi
80101fe5:	53                   	push   %ebx
80101fe6:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80101fe9:	85 c0                	test   %eax,%eax
80101feb:	0f 84 b4 00 00 00    	je     801020a5 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101ff1:	8b 58 08             	mov    0x8(%eax),%ebx
80101ff4:	89 c6                	mov    %eax,%esi
80101ff6:	81 fb 1f 4e 00 00    	cmp    $0x4e1f,%ebx
80101ffc:	0f 87 96 00 00 00    	ja     80102098 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102002:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102007:	89 f6                	mov    %esi,%esi
80102009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80102010:	89 ca                	mov    %ecx,%edx
80102012:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102013:	83 e0 c0             	and    $0xffffffc0,%eax
80102016:	3c 40                	cmp    $0x40,%al
80102018:	75 f6                	jne    80102010 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010201a:	31 ff                	xor    %edi,%edi
8010201c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102021:	89 f8                	mov    %edi,%eax
80102023:	ee                   	out    %al,(%dx)
80102024:	b8 01 00 00 00       	mov    $0x1,%eax
80102029:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010202e:	ee                   	out    %al,(%dx)
8010202f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102034:	89 d8                	mov    %ebx,%eax
80102036:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102037:	89 d8                	mov    %ebx,%eax
80102039:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010203e:	c1 f8 08             	sar    $0x8,%eax
80102041:	ee                   	out    %al,(%dx)
80102042:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102047:	89 f8                	mov    %edi,%eax
80102049:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
8010204a:	0f b6 46 04          	movzbl 0x4(%esi),%eax
8010204e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102053:	c1 e0 04             	shl    $0x4,%eax
80102056:	83 e0 10             	and    $0x10,%eax
80102059:	83 c8 e0             	or     $0xffffffe0,%eax
8010205c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010205d:	f6 06 04             	testb  $0x4,(%esi)
80102060:	75 16                	jne    80102078 <idestart+0x98>
80102062:	b8 20 00 00 00       	mov    $0x20,%eax
80102067:	89 ca                	mov    %ecx,%edx
80102069:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010206a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010206d:	5b                   	pop    %ebx
8010206e:	5e                   	pop    %esi
8010206f:	5f                   	pop    %edi
80102070:	5d                   	pop    %ebp
80102071:	c3                   	ret    
80102072:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102078:	b8 30 00 00 00       	mov    $0x30,%eax
8010207d:	89 ca                	mov    %ecx,%edx
8010207f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102080:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102085:	83 c6 5c             	add    $0x5c,%esi
80102088:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010208d:	fc                   	cld    
8010208e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102090:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102093:	5b                   	pop    %ebx
80102094:	5e                   	pop    %esi
80102095:	5f                   	pop    %edi
80102096:	5d                   	pop    %ebp
80102097:	c3                   	ret    
    panic("incorrect blockno");
80102098:	83 ec 0c             	sub    $0xc,%esp
8010209b:	68 54 71 10 80       	push   $0x80107154
801020a0:	e8 eb e2 ff ff       	call   80100390 <panic>
    panic("idestart");
801020a5:	83 ec 0c             	sub    $0xc,%esp
801020a8:	68 4b 71 10 80       	push   $0x8010714b
801020ad:	e8 de e2 ff ff       	call   80100390 <panic>
801020b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801020b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801020c0 <ideinit>:
{
801020c0:	55                   	push   %ebp
801020c1:	89 e5                	mov    %esp,%ebp
801020c3:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
801020c6:	68 66 71 10 80       	push   $0x80107166
801020cb:	68 80 a5 10 80       	push   $0x8010a580
801020d0:	e8 eb 21 00 00       	call   801042c0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801020d5:	58                   	pop    %eax
801020d6:	a1 00 2d 11 80       	mov    0x80112d00,%eax
801020db:	5a                   	pop    %edx
801020dc:	83 e8 01             	sub    $0x1,%eax
801020df:	50                   	push   %eax
801020e0:	6a 0e                	push   $0xe
801020e2:	e8 a9 02 00 00       	call   80102390 <ioapicenable>
801020e7:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020ea:	ba f7 01 00 00       	mov    $0x1f7,%edx
801020ef:	90                   	nop
801020f0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801020f1:	83 e0 c0             	and    $0xffffffc0,%eax
801020f4:	3c 40                	cmp    $0x40,%al
801020f6:	75 f8                	jne    801020f0 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801020f8:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
801020fd:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102102:	ee                   	out    %al,(%dx)
80102103:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102108:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010210d:	eb 06                	jmp    80102115 <ideinit+0x55>
8010210f:	90                   	nop
  for(i=0; i<1000; i++){
80102110:	83 e9 01             	sub    $0x1,%ecx
80102113:	74 0f                	je     80102124 <ideinit+0x64>
80102115:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102116:	84 c0                	test   %al,%al
80102118:	74 f6                	je     80102110 <ideinit+0x50>
      havedisk1 = 1;
8010211a:	c7 05 60 a5 10 80 01 	movl   $0x1,0x8010a560
80102121:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102124:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102129:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010212e:	ee                   	out    %al,(%dx)
}
8010212f:	c9                   	leave  
80102130:	c3                   	ret    
80102131:	eb 0d                	jmp    80102140 <ideintr>
80102133:	90                   	nop
80102134:	90                   	nop
80102135:	90                   	nop
80102136:	90                   	nop
80102137:	90                   	nop
80102138:	90                   	nop
80102139:	90                   	nop
8010213a:	90                   	nop
8010213b:	90                   	nop
8010213c:	90                   	nop
8010213d:	90                   	nop
8010213e:	90                   	nop
8010213f:	90                   	nop

80102140 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102140:	55                   	push   %ebp
80102141:	89 e5                	mov    %esp,%ebp
80102143:	57                   	push   %edi
80102144:	56                   	push   %esi
80102145:	53                   	push   %ebx
80102146:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102149:	68 80 a5 10 80       	push   $0x8010a580
8010214e:	e8 ad 22 00 00       	call   80104400 <acquire>

  if((b = idequeue) == 0){
80102153:	8b 1d 64 a5 10 80    	mov    0x8010a564,%ebx
80102159:	83 c4 10             	add    $0x10,%esp
8010215c:	85 db                	test   %ebx,%ebx
8010215e:	74 67                	je     801021c7 <ideintr+0x87>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102160:	8b 43 58             	mov    0x58(%ebx),%eax
80102163:	a3 64 a5 10 80       	mov    %eax,0x8010a564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102168:	8b 3b                	mov    (%ebx),%edi
8010216a:	f7 c7 04 00 00 00    	test   $0x4,%edi
80102170:	75 31                	jne    801021a3 <ideintr+0x63>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102172:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102177:	89 f6                	mov    %esi,%esi
80102179:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80102180:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102181:	89 c6                	mov    %eax,%esi
80102183:	83 e6 c0             	and    $0xffffffc0,%esi
80102186:	89 f1                	mov    %esi,%ecx
80102188:	80 f9 40             	cmp    $0x40,%cl
8010218b:	75 f3                	jne    80102180 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010218d:	a8 21                	test   $0x21,%al
8010218f:	75 12                	jne    801021a3 <ideintr+0x63>
    insl(0x1f0, b->data, BSIZE/4);
80102191:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102194:	b9 80 00 00 00       	mov    $0x80,%ecx
80102199:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010219e:	fc                   	cld    
8010219f:	f3 6d                	rep insl (%dx),%es:(%edi)
801021a1:	8b 3b                	mov    (%ebx),%edi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801021a3:	83 e7 fb             	and    $0xfffffffb,%edi
  wakeup(b);
801021a6:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
801021a9:	89 f9                	mov    %edi,%ecx
801021ab:	83 c9 02             	or     $0x2,%ecx
801021ae:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
801021b0:	53                   	push   %ebx
801021b1:	e8 3a 1e 00 00       	call   80103ff0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801021b6:	a1 64 a5 10 80       	mov    0x8010a564,%eax
801021bb:	83 c4 10             	add    $0x10,%esp
801021be:	85 c0                	test   %eax,%eax
801021c0:	74 05                	je     801021c7 <ideintr+0x87>
    idestart(idequeue);
801021c2:	e8 19 fe ff ff       	call   80101fe0 <idestart>
    release(&idelock);
801021c7:	83 ec 0c             	sub    $0xc,%esp
801021ca:	68 80 a5 10 80       	push   $0x8010a580
801021cf:	e8 ec 22 00 00       	call   801044c0 <release>

  release(&idelock);
}
801021d4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801021d7:	5b                   	pop    %ebx
801021d8:	5e                   	pop    %esi
801021d9:	5f                   	pop    %edi
801021da:	5d                   	pop    %ebp
801021db:	c3                   	ret    
801021dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801021e0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801021e0:	55                   	push   %ebp
801021e1:	89 e5                	mov    %esp,%ebp
801021e3:	53                   	push   %ebx
801021e4:	83 ec 10             	sub    $0x10,%esp
801021e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801021ea:	8d 43 0c             	lea    0xc(%ebx),%eax
801021ed:	50                   	push   %eax
801021ee:	e8 7d 20 00 00       	call   80104270 <holdingsleep>
801021f3:	83 c4 10             	add    $0x10,%esp
801021f6:	85 c0                	test   %eax,%eax
801021f8:	0f 84 c6 00 00 00    	je     801022c4 <iderw+0xe4>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801021fe:	8b 03                	mov    (%ebx),%eax
80102200:	83 e0 06             	and    $0x6,%eax
80102203:	83 f8 02             	cmp    $0x2,%eax
80102206:	0f 84 ab 00 00 00    	je     801022b7 <iderw+0xd7>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010220c:	8b 53 04             	mov    0x4(%ebx),%edx
8010220f:	85 d2                	test   %edx,%edx
80102211:	74 0d                	je     80102220 <iderw+0x40>
80102213:	a1 60 a5 10 80       	mov    0x8010a560,%eax
80102218:	85 c0                	test   %eax,%eax
8010221a:	0f 84 b1 00 00 00    	je     801022d1 <iderw+0xf1>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102220:	83 ec 0c             	sub    $0xc,%esp
80102223:	68 80 a5 10 80       	push   $0x8010a580
80102228:	e8 d3 21 00 00       	call   80104400 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010222d:	8b 15 64 a5 10 80    	mov    0x8010a564,%edx
80102233:	83 c4 10             	add    $0x10,%esp
  b->qnext = 0;
80102236:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010223d:	85 d2                	test   %edx,%edx
8010223f:	75 09                	jne    8010224a <iderw+0x6a>
80102241:	eb 6d                	jmp    801022b0 <iderw+0xd0>
80102243:	90                   	nop
80102244:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102248:	89 c2                	mov    %eax,%edx
8010224a:	8b 42 58             	mov    0x58(%edx),%eax
8010224d:	85 c0                	test   %eax,%eax
8010224f:	75 f7                	jne    80102248 <iderw+0x68>
80102251:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102254:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102256:	39 1d 64 a5 10 80    	cmp    %ebx,0x8010a564
8010225c:	74 42                	je     801022a0 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010225e:	8b 03                	mov    (%ebx),%eax
80102260:	83 e0 06             	and    $0x6,%eax
80102263:	83 f8 02             	cmp    $0x2,%eax
80102266:	74 23                	je     8010228b <iderw+0xab>
80102268:	90                   	nop
80102269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
80102270:	83 ec 08             	sub    $0x8,%esp
80102273:	68 80 a5 10 80       	push   $0x8010a580
80102278:	53                   	push   %ebx
80102279:	e8 c2 1b 00 00       	call   80103e40 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010227e:	8b 03                	mov    (%ebx),%eax
80102280:	83 c4 10             	add    $0x10,%esp
80102283:	83 e0 06             	and    $0x6,%eax
80102286:	83 f8 02             	cmp    $0x2,%eax
80102289:	75 e5                	jne    80102270 <iderw+0x90>
  }


  release(&idelock);
8010228b:	c7 45 08 80 a5 10 80 	movl   $0x8010a580,0x8(%ebp)
}
80102292:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102295:	c9                   	leave  
  release(&idelock);
80102296:	e9 25 22 00 00       	jmp    801044c0 <release>
8010229b:	90                   	nop
8010229c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
801022a0:	89 d8                	mov    %ebx,%eax
801022a2:	e8 39 fd ff ff       	call   80101fe0 <idestart>
801022a7:	eb b5                	jmp    8010225e <iderw+0x7e>
801022a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801022b0:	ba 64 a5 10 80       	mov    $0x8010a564,%edx
801022b5:	eb 9d                	jmp    80102254 <iderw+0x74>
    panic("iderw: nothing to do");
801022b7:	83 ec 0c             	sub    $0xc,%esp
801022ba:	68 80 71 10 80       	push   $0x80107180
801022bf:	e8 cc e0 ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
801022c4:	83 ec 0c             	sub    $0xc,%esp
801022c7:	68 6a 71 10 80       	push   $0x8010716a
801022cc:	e8 bf e0 ff ff       	call   80100390 <panic>
    panic("iderw: ide disk 1 not present");
801022d1:	83 ec 0c             	sub    $0xc,%esp
801022d4:	68 95 71 10 80       	push   $0x80107195
801022d9:	e8 b2 e0 ff ff       	call   80100390 <panic>
801022de:	66 90                	xchg   %ax,%ax

801022e0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801022e0:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801022e1:	c7 05 34 26 11 80 00 	movl   $0xfec00000,0x80112634
801022e8:	00 c0 fe 
{
801022eb:	89 e5                	mov    %esp,%ebp
801022ed:	56                   	push   %esi
801022ee:	53                   	push   %ebx
  ioapic->reg = reg;
801022ef:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801022f6:	00 00 00 
  return ioapic->data;
801022f9:	a1 34 26 11 80       	mov    0x80112634,%eax
801022fe:	8b 58 10             	mov    0x10(%eax),%ebx
  ioapic->reg = reg;
80102301:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return ioapic->data;
80102307:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010230d:	0f b6 15 60 27 11 80 	movzbl 0x80112760,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102314:	c1 eb 10             	shr    $0x10,%ebx
  return ioapic->data;
80102317:	8b 41 10             	mov    0x10(%ecx),%eax
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
8010231a:	0f b6 db             	movzbl %bl,%ebx
  id = ioapicread(REG_ID) >> 24;
8010231d:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102320:	39 c2                	cmp    %eax,%edx
80102322:	74 16                	je     8010233a <ioapicinit+0x5a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102324:	83 ec 0c             	sub    $0xc,%esp
80102327:	68 b4 71 10 80       	push   $0x801071b4
8010232c:	e8 2f e3 ff ff       	call   80100660 <cprintf>
80102331:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
80102337:	83 c4 10             	add    $0x10,%esp
8010233a:	83 c3 21             	add    $0x21,%ebx
{
8010233d:	ba 10 00 00 00       	mov    $0x10,%edx
80102342:	b8 20 00 00 00       	mov    $0x20,%eax
80102347:	89 f6                	mov    %esi,%esi
80102349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ioapic->reg = reg;
80102350:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
80102352:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102358:	89 c6                	mov    %eax,%esi
8010235a:	81 ce 00 00 01 00    	or     $0x10000,%esi
80102360:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
80102363:	89 71 10             	mov    %esi,0x10(%ecx)
80102366:	8d 72 01             	lea    0x1(%edx),%esi
80102369:	83 c2 02             	add    $0x2,%edx
  for(i = 0; i <= maxintr; i++){
8010236c:	39 d8                	cmp    %ebx,%eax
  ioapic->reg = reg;
8010236e:	89 31                	mov    %esi,(%ecx)
  ioapic->data = data;
80102370:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
80102376:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
8010237d:	75 d1                	jne    80102350 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010237f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102382:	5b                   	pop    %ebx
80102383:	5e                   	pop    %esi
80102384:	5d                   	pop    %ebp
80102385:	c3                   	ret    
80102386:	8d 76 00             	lea    0x0(%esi),%esi
80102389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102390 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102390:	55                   	push   %ebp
  ioapic->reg = reg;
80102391:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
{
80102397:	89 e5                	mov    %esp,%ebp
80102399:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010239c:	8d 50 20             	lea    0x20(%eax),%edx
8010239f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
801023a3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801023a5:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023ab:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801023ae:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023b1:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
801023b4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801023b6:	a1 34 26 11 80       	mov    0x80112634,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023bb:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
801023be:	89 50 10             	mov    %edx,0x10(%eax)
}
801023c1:	5d                   	pop    %ebp
801023c2:	c3                   	ret    
801023c3:	66 90                	xchg   %ax,%ax
801023c5:	66 90                	xchg   %ax,%ax
801023c7:	66 90                	xchg   %ax,%ax
801023c9:	66 90                	xchg   %ax,%ax
801023cb:	66 90                	xchg   %ax,%ax
801023cd:	66 90                	xchg   %ax,%ax
801023cf:	90                   	nop

801023d0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801023d0:	55                   	push   %ebp
801023d1:	89 e5                	mov    %esp,%ebp
801023d3:	53                   	push   %ebx
801023d4:	83 ec 04             	sub    $0x4,%esp
801023d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801023da:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801023e0:	75 70                	jne    80102452 <kfree+0x82>
801023e2:	81 fb a8 54 11 80    	cmp    $0x801154a8,%ebx
801023e8:	72 68                	jb     80102452 <kfree+0x82>
801023ea:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801023f0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801023f5:	77 5b                	ja     80102452 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801023f7:	83 ec 04             	sub    $0x4,%esp
801023fa:	68 00 10 00 00       	push   $0x1000
801023ff:	6a 01                	push   $0x1
80102401:	53                   	push   %ebx
80102402:	e8 09 21 00 00       	call   80104510 <memset>

  if(kmem.use_lock)
80102407:	8b 15 74 26 11 80    	mov    0x80112674,%edx
8010240d:	83 c4 10             	add    $0x10,%esp
80102410:	85 d2                	test   %edx,%edx
80102412:	75 2c                	jne    80102440 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102414:	a1 78 26 11 80       	mov    0x80112678,%eax
80102419:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010241b:	a1 74 26 11 80       	mov    0x80112674,%eax
  kmem.freelist = r;
80102420:	89 1d 78 26 11 80    	mov    %ebx,0x80112678
  if(kmem.use_lock)
80102426:	85 c0                	test   %eax,%eax
80102428:	75 06                	jne    80102430 <kfree+0x60>
    release(&kmem.lock);
}
8010242a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010242d:	c9                   	leave  
8010242e:	c3                   	ret    
8010242f:	90                   	nop
    release(&kmem.lock);
80102430:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
}
80102437:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010243a:	c9                   	leave  
    release(&kmem.lock);
8010243b:	e9 80 20 00 00       	jmp    801044c0 <release>
    acquire(&kmem.lock);
80102440:	83 ec 0c             	sub    $0xc,%esp
80102443:	68 40 26 11 80       	push   $0x80112640
80102448:	e8 b3 1f 00 00       	call   80104400 <acquire>
8010244d:	83 c4 10             	add    $0x10,%esp
80102450:	eb c2                	jmp    80102414 <kfree+0x44>
    panic("kfree");
80102452:	83 ec 0c             	sub    $0xc,%esp
80102455:	68 e6 71 10 80       	push   $0x801071e6
8010245a:	e8 31 df ff ff       	call   80100390 <panic>
8010245f:	90                   	nop

80102460 <freerange>:
{
80102460:	55                   	push   %ebp
80102461:	89 e5                	mov    %esp,%ebp
80102463:	56                   	push   %esi
80102464:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102465:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102468:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010246b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102471:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102477:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010247d:	39 de                	cmp    %ebx,%esi
8010247f:	72 23                	jb     801024a4 <freerange+0x44>
80102481:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102488:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010248e:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102491:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102497:	50                   	push   %eax
80102498:	e8 33 ff ff ff       	call   801023d0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010249d:	83 c4 10             	add    $0x10,%esp
801024a0:	39 f3                	cmp    %esi,%ebx
801024a2:	76 e4                	jbe    80102488 <freerange+0x28>
}
801024a4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801024a7:	5b                   	pop    %ebx
801024a8:	5e                   	pop    %esi
801024a9:	5d                   	pop    %ebp
801024aa:	c3                   	ret    
801024ab:	90                   	nop
801024ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801024b0 <kinit1>:
{
801024b0:	55                   	push   %ebp
801024b1:	89 e5                	mov    %esp,%ebp
801024b3:	56                   	push   %esi
801024b4:	53                   	push   %ebx
801024b5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801024b8:	83 ec 08             	sub    $0x8,%esp
801024bb:	68 ec 71 10 80       	push   $0x801071ec
801024c0:	68 40 26 11 80       	push   $0x80112640
801024c5:	e8 f6 1d 00 00       	call   801042c0 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
801024ca:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024cd:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
801024d0:	c7 05 74 26 11 80 00 	movl   $0x0,0x80112674
801024d7:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
801024da:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801024e0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024e6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801024ec:	39 de                	cmp    %ebx,%esi
801024ee:	72 1c                	jb     8010250c <kinit1+0x5c>
    kfree(p);
801024f0:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801024f6:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024f9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801024ff:	50                   	push   %eax
80102500:	e8 cb fe ff ff       	call   801023d0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102505:	83 c4 10             	add    $0x10,%esp
80102508:	39 de                	cmp    %ebx,%esi
8010250a:	73 e4                	jae    801024f0 <kinit1+0x40>
}
8010250c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010250f:	5b                   	pop    %ebx
80102510:	5e                   	pop    %esi
80102511:	5d                   	pop    %ebp
80102512:	c3                   	ret    
80102513:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102520 <kinit2>:
{
80102520:	55                   	push   %ebp
80102521:	89 e5                	mov    %esp,%ebp
80102523:	56                   	push   %esi
80102524:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102525:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102528:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010252b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102531:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102537:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010253d:	39 de                	cmp    %ebx,%esi
8010253f:	72 23                	jb     80102564 <kinit2+0x44>
80102541:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102548:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010254e:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102551:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102557:	50                   	push   %eax
80102558:	e8 73 fe ff ff       	call   801023d0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010255d:	83 c4 10             	add    $0x10,%esp
80102560:	39 de                	cmp    %ebx,%esi
80102562:	73 e4                	jae    80102548 <kinit2+0x28>
  kmem.use_lock = 1;
80102564:	c7 05 74 26 11 80 01 	movl   $0x1,0x80112674
8010256b:	00 00 00 
}
8010256e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102571:	5b                   	pop    %ebx
80102572:	5e                   	pop    %esi
80102573:	5d                   	pop    %ebp
80102574:	c3                   	ret    
80102575:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102579:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102580 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
80102580:	a1 74 26 11 80       	mov    0x80112674,%eax
80102585:	85 c0                	test   %eax,%eax
80102587:	75 1f                	jne    801025a8 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102589:	a1 78 26 11 80       	mov    0x80112678,%eax
  if(r)
8010258e:	85 c0                	test   %eax,%eax
80102590:	74 0e                	je     801025a0 <kalloc+0x20>
    kmem.freelist = r->next;
80102592:	8b 10                	mov    (%eax),%edx
80102594:	89 15 78 26 11 80    	mov    %edx,0x80112678
8010259a:	c3                   	ret    
8010259b:	90                   	nop
8010259c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
801025a0:	f3 c3                	repz ret 
801025a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
801025a8:	55                   	push   %ebp
801025a9:	89 e5                	mov    %esp,%ebp
801025ab:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
801025ae:	68 40 26 11 80       	push   $0x80112640
801025b3:	e8 48 1e 00 00       	call   80104400 <acquire>
  r = kmem.freelist;
801025b8:	a1 78 26 11 80       	mov    0x80112678,%eax
  if(r)
801025bd:	83 c4 10             	add    $0x10,%esp
801025c0:	8b 15 74 26 11 80    	mov    0x80112674,%edx
801025c6:	85 c0                	test   %eax,%eax
801025c8:	74 08                	je     801025d2 <kalloc+0x52>
    kmem.freelist = r->next;
801025ca:	8b 08                	mov    (%eax),%ecx
801025cc:	89 0d 78 26 11 80    	mov    %ecx,0x80112678
  if(kmem.use_lock)
801025d2:	85 d2                	test   %edx,%edx
801025d4:	74 16                	je     801025ec <kalloc+0x6c>
    release(&kmem.lock);
801025d6:	83 ec 0c             	sub    $0xc,%esp
801025d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
801025dc:	68 40 26 11 80       	push   $0x80112640
801025e1:	e8 da 1e 00 00       	call   801044c0 <release>
  return (char*)r;
801025e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
801025e9:	83 c4 10             	add    $0x10,%esp
}
801025ec:	c9                   	leave  
801025ed:	c3                   	ret    
801025ee:	66 90                	xchg   %ax,%ax

801025f0 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801025f0:	ba 64 00 00 00       	mov    $0x64,%edx
801025f5:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801025f6:	a8 01                	test   $0x1,%al
801025f8:	0f 84 c2 00 00 00    	je     801026c0 <kbdgetc+0xd0>
801025fe:	ba 60 00 00 00       	mov    $0x60,%edx
80102603:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102604:	0f b6 d0             	movzbl %al,%edx
80102607:	8b 0d b4 a5 10 80    	mov    0x8010a5b4,%ecx

  if(data == 0xE0){
8010260d:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102613:	0f 84 7f 00 00 00    	je     80102698 <kbdgetc+0xa8>
{
80102619:	55                   	push   %ebp
8010261a:	89 e5                	mov    %esp,%ebp
8010261c:	53                   	push   %ebx
8010261d:	89 cb                	mov    %ecx,%ebx
8010261f:	83 e3 40             	and    $0x40,%ebx
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102622:	84 c0                	test   %al,%al
80102624:	78 4a                	js     80102670 <kbdgetc+0x80>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102626:	85 db                	test   %ebx,%ebx
80102628:	74 09                	je     80102633 <kbdgetc+0x43>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010262a:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
8010262d:	83 e1 bf             	and    $0xffffffbf,%ecx
    data |= 0x80;
80102630:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
80102633:	0f b6 82 20 73 10 80 	movzbl -0x7fef8ce0(%edx),%eax
8010263a:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
8010263c:	0f b6 82 20 72 10 80 	movzbl -0x7fef8de0(%edx),%eax
80102643:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102645:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
80102647:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
  c = charcode[shift & (CTL | SHIFT)][data];
8010264d:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102650:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102653:	8b 04 85 00 72 10 80 	mov    -0x7fef8e00(,%eax,4),%eax
8010265a:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
8010265e:	74 31                	je     80102691 <kbdgetc+0xa1>
    if('a' <= c && c <= 'z')
80102660:	8d 50 9f             	lea    -0x61(%eax),%edx
80102663:	83 fa 19             	cmp    $0x19,%edx
80102666:	77 40                	ja     801026a8 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102668:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
8010266b:	5b                   	pop    %ebx
8010266c:	5d                   	pop    %ebp
8010266d:	c3                   	ret    
8010266e:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
80102670:	83 e0 7f             	and    $0x7f,%eax
80102673:	85 db                	test   %ebx,%ebx
80102675:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
80102678:	0f b6 82 20 73 10 80 	movzbl -0x7fef8ce0(%edx),%eax
8010267f:	83 c8 40             	or     $0x40,%eax
80102682:	0f b6 c0             	movzbl %al,%eax
80102685:	f7 d0                	not    %eax
80102687:	21 c1                	and    %eax,%ecx
    return 0;
80102689:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
8010268b:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
}
80102691:	5b                   	pop    %ebx
80102692:	5d                   	pop    %ebp
80102693:	c3                   	ret    
80102694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
80102698:	83 c9 40             	or     $0x40,%ecx
    return 0;
8010269b:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
8010269d:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
    return 0;
801026a3:	c3                   	ret    
801026a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
801026a8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801026ab:	8d 50 20             	lea    0x20(%eax),%edx
}
801026ae:	5b                   	pop    %ebx
      c += 'a' - 'A';
801026af:	83 f9 1a             	cmp    $0x1a,%ecx
801026b2:	0f 42 c2             	cmovb  %edx,%eax
}
801026b5:	5d                   	pop    %ebp
801026b6:	c3                   	ret    
801026b7:	89 f6                	mov    %esi,%esi
801026b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801026c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801026c5:	c3                   	ret    
801026c6:	8d 76 00             	lea    0x0(%esi),%esi
801026c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801026d0 <kbdintr>:

void
kbdintr(void)
{
801026d0:	55                   	push   %ebp
801026d1:	89 e5                	mov    %esp,%ebp
801026d3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801026d6:	68 f0 25 10 80       	push   $0x801025f0
801026db:	e8 30 e1 ff ff       	call   80100810 <consoleintr>
}
801026e0:	83 c4 10             	add    $0x10,%esp
801026e3:	c9                   	leave  
801026e4:	c3                   	ret    
801026e5:	66 90                	xchg   %ax,%ax
801026e7:	66 90                	xchg   %ax,%ax
801026e9:	66 90                	xchg   %ax,%ax
801026eb:	66 90                	xchg   %ax,%ax
801026ed:	66 90                	xchg   %ax,%ax
801026ef:	90                   	nop

801026f0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
801026f0:	a1 7c 26 11 80       	mov    0x8011267c,%eax
{
801026f5:	55                   	push   %ebp
801026f6:	89 e5                	mov    %esp,%ebp
  if(!lapic)
801026f8:	85 c0                	test   %eax,%eax
801026fa:	0f 84 c8 00 00 00    	je     801027c8 <lapicinit+0xd8>
  lapic[index] = value;
80102700:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102707:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010270a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010270d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102714:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102717:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010271a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102721:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102724:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102727:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010272e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102731:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102734:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010273b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010273e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102741:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102748:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010274b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010274e:	8b 50 30             	mov    0x30(%eax),%edx
80102751:	c1 ea 10             	shr    $0x10,%edx
80102754:	80 fa 03             	cmp    $0x3,%dl
80102757:	77 77                	ja     801027d0 <lapicinit+0xe0>
  lapic[index] = value;
80102759:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102760:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102763:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102766:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010276d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102770:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102773:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010277a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010277d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102780:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102787:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010278a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010278d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102794:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102797:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010279a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801027a1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801027a4:	8b 50 20             	mov    0x20(%eax),%edx
801027a7:	89 f6                	mov    %esi,%esi
801027a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801027b0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801027b6:	80 e6 10             	and    $0x10,%dh
801027b9:	75 f5                	jne    801027b0 <lapicinit+0xc0>
  lapic[index] = value;
801027bb:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801027c2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027c5:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801027c8:	5d                   	pop    %ebp
801027c9:	c3                   	ret    
801027ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
801027d0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801027d7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801027da:	8b 50 20             	mov    0x20(%eax),%edx
801027dd:	e9 77 ff ff ff       	jmp    80102759 <lapicinit+0x69>
801027e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801027e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801027f0 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
801027f0:	8b 15 7c 26 11 80    	mov    0x8011267c,%edx
{
801027f6:	55                   	push   %ebp
801027f7:	31 c0                	xor    %eax,%eax
801027f9:	89 e5                	mov    %esp,%ebp
  if (!lapic)
801027fb:	85 d2                	test   %edx,%edx
801027fd:	74 06                	je     80102805 <lapicid+0x15>
    return 0;
  return lapic[ID] >> 24;
801027ff:	8b 42 20             	mov    0x20(%edx),%eax
80102802:	c1 e8 18             	shr    $0x18,%eax
}
80102805:	5d                   	pop    %ebp
80102806:	c3                   	ret    
80102807:	89 f6                	mov    %esi,%esi
80102809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102810 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102810:	a1 7c 26 11 80       	mov    0x8011267c,%eax
{
80102815:	55                   	push   %ebp
80102816:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102818:	85 c0                	test   %eax,%eax
8010281a:	74 0d                	je     80102829 <lapiceoi+0x19>
  lapic[index] = value;
8010281c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102823:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102826:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102829:	5d                   	pop    %ebp
8010282a:	c3                   	ret    
8010282b:	90                   	nop
8010282c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102830 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102830:	55                   	push   %ebp
80102831:	89 e5                	mov    %esp,%ebp
}
80102833:	5d                   	pop    %ebp
80102834:	c3                   	ret    
80102835:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102840 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102840:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102841:	b8 0f 00 00 00       	mov    $0xf,%eax
80102846:	ba 70 00 00 00       	mov    $0x70,%edx
8010284b:	89 e5                	mov    %esp,%ebp
8010284d:	53                   	push   %ebx
8010284e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102851:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102854:	ee                   	out    %al,(%dx)
80102855:	b8 0a 00 00 00       	mov    $0xa,%eax
8010285a:	ba 71 00 00 00       	mov    $0x71,%edx
8010285f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102860:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102862:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102865:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010286b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010286d:	c1 e9 0c             	shr    $0xc,%ecx
  wrv[1] = addr >> 4;
80102870:	c1 e8 04             	shr    $0x4,%eax
  lapicw(ICRHI, apicid<<24);
80102873:	89 da                	mov    %ebx,%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
80102875:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102878:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
8010287e:	a1 7c 26 11 80       	mov    0x8011267c,%eax
80102883:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102889:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010288c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102893:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102896:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102899:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801028a0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028a3:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028a6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028ac:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028af:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028b5:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028b8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028be:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028c1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028c7:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
801028ca:	5b                   	pop    %ebx
801028cb:	5d                   	pop    %ebp
801028cc:	c3                   	ret    
801028cd:	8d 76 00             	lea    0x0(%esi),%esi

801028d0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
801028d0:	55                   	push   %ebp
801028d1:	b8 0b 00 00 00       	mov    $0xb,%eax
801028d6:	ba 70 00 00 00       	mov    $0x70,%edx
801028db:	89 e5                	mov    %esp,%ebp
801028dd:	57                   	push   %edi
801028de:	56                   	push   %esi
801028df:	53                   	push   %ebx
801028e0:	83 ec 4c             	sub    $0x4c,%esp
801028e3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028e4:	ba 71 00 00 00       	mov    $0x71,%edx
801028e9:	ec                   	in     (%dx),%al
801028ea:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028ed:	bb 70 00 00 00       	mov    $0x70,%ebx
801028f2:	88 45 b3             	mov    %al,-0x4d(%ebp)
801028f5:	8d 76 00             	lea    0x0(%esi),%esi
801028f8:	31 c0                	xor    %eax,%eax
801028fa:	89 da                	mov    %ebx,%edx
801028fc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028fd:	b9 71 00 00 00       	mov    $0x71,%ecx
80102902:	89 ca                	mov    %ecx,%edx
80102904:	ec                   	in     (%dx),%al
80102905:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102908:	89 da                	mov    %ebx,%edx
8010290a:	b8 02 00 00 00       	mov    $0x2,%eax
8010290f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102910:	89 ca                	mov    %ecx,%edx
80102912:	ec                   	in     (%dx),%al
80102913:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102916:	89 da                	mov    %ebx,%edx
80102918:	b8 04 00 00 00       	mov    $0x4,%eax
8010291d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010291e:	89 ca                	mov    %ecx,%edx
80102920:	ec                   	in     (%dx),%al
80102921:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102924:	89 da                	mov    %ebx,%edx
80102926:	b8 07 00 00 00       	mov    $0x7,%eax
8010292b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010292c:	89 ca                	mov    %ecx,%edx
8010292e:	ec                   	in     (%dx),%al
8010292f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102932:	89 da                	mov    %ebx,%edx
80102934:	b8 08 00 00 00       	mov    $0x8,%eax
80102939:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010293a:	89 ca                	mov    %ecx,%edx
8010293c:	ec                   	in     (%dx),%al
8010293d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010293f:	89 da                	mov    %ebx,%edx
80102941:	b8 09 00 00 00       	mov    $0x9,%eax
80102946:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102947:	89 ca                	mov    %ecx,%edx
80102949:	ec                   	in     (%dx),%al
8010294a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010294c:	89 da                	mov    %ebx,%edx
8010294e:	b8 0a 00 00 00       	mov    $0xa,%eax
80102953:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102954:	89 ca                	mov    %ecx,%edx
80102956:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102957:	84 c0                	test   %al,%al
80102959:	78 9d                	js     801028f8 <cmostime+0x28>
  return inb(CMOS_RETURN);
8010295b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
8010295f:	89 fa                	mov    %edi,%edx
80102961:	0f b6 fa             	movzbl %dl,%edi
80102964:	89 f2                	mov    %esi,%edx
80102966:	0f b6 f2             	movzbl %dl,%esi
80102969:	89 7d c8             	mov    %edi,-0x38(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010296c:	89 da                	mov    %ebx,%edx
8010296e:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102971:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102974:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102978:	89 45 bc             	mov    %eax,-0x44(%ebp)
8010297b:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
8010297f:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102982:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102986:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102989:	31 c0                	xor    %eax,%eax
8010298b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010298c:	89 ca                	mov    %ecx,%edx
8010298e:	ec                   	in     (%dx),%al
8010298f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102992:	89 da                	mov    %ebx,%edx
80102994:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102997:	b8 02 00 00 00       	mov    $0x2,%eax
8010299c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010299d:	89 ca                	mov    %ecx,%edx
8010299f:	ec                   	in     (%dx),%al
801029a0:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029a3:	89 da                	mov    %ebx,%edx
801029a5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801029a8:	b8 04 00 00 00       	mov    $0x4,%eax
801029ad:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029ae:	89 ca                	mov    %ecx,%edx
801029b0:	ec                   	in     (%dx),%al
801029b1:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029b4:	89 da                	mov    %ebx,%edx
801029b6:	89 45 d8             	mov    %eax,-0x28(%ebp)
801029b9:	b8 07 00 00 00       	mov    $0x7,%eax
801029be:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029bf:	89 ca                	mov    %ecx,%edx
801029c1:	ec                   	in     (%dx),%al
801029c2:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029c5:	89 da                	mov    %ebx,%edx
801029c7:	89 45 dc             	mov    %eax,-0x24(%ebp)
801029ca:	b8 08 00 00 00       	mov    $0x8,%eax
801029cf:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029d0:	89 ca                	mov    %ecx,%edx
801029d2:	ec                   	in     (%dx),%al
801029d3:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029d6:	89 da                	mov    %ebx,%edx
801029d8:	89 45 e0             	mov    %eax,-0x20(%ebp)
801029db:	b8 09 00 00 00       	mov    $0x9,%eax
801029e0:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029e1:	89 ca                	mov    %ecx,%edx
801029e3:	ec                   	in     (%dx),%al
801029e4:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801029e7:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
801029ea:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801029ed:	8d 45 d0             	lea    -0x30(%ebp),%eax
801029f0:	6a 18                	push   $0x18
801029f2:	50                   	push   %eax
801029f3:	8d 45 b8             	lea    -0x48(%ebp),%eax
801029f6:	50                   	push   %eax
801029f7:	e8 64 1b 00 00       	call   80104560 <memcmp>
801029fc:	83 c4 10             	add    $0x10,%esp
801029ff:	85 c0                	test   %eax,%eax
80102a01:	0f 85 f1 fe ff ff    	jne    801028f8 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102a07:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102a0b:	75 78                	jne    80102a85 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102a0d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102a10:	89 c2                	mov    %eax,%edx
80102a12:	83 e0 0f             	and    $0xf,%eax
80102a15:	c1 ea 04             	shr    $0x4,%edx
80102a18:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a1b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a1e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102a21:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102a24:	89 c2                	mov    %eax,%edx
80102a26:	83 e0 0f             	and    $0xf,%eax
80102a29:	c1 ea 04             	shr    $0x4,%edx
80102a2c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a2f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a32:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102a35:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102a38:	89 c2                	mov    %eax,%edx
80102a3a:	83 e0 0f             	and    $0xf,%eax
80102a3d:	c1 ea 04             	shr    $0x4,%edx
80102a40:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a43:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a46:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102a49:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102a4c:	89 c2                	mov    %eax,%edx
80102a4e:	83 e0 0f             	and    $0xf,%eax
80102a51:	c1 ea 04             	shr    $0x4,%edx
80102a54:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a57:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a5a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102a5d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102a60:	89 c2                	mov    %eax,%edx
80102a62:	83 e0 0f             	and    $0xf,%eax
80102a65:	c1 ea 04             	shr    $0x4,%edx
80102a68:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a6b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a6e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102a71:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102a74:	89 c2                	mov    %eax,%edx
80102a76:	83 e0 0f             	and    $0xf,%eax
80102a79:	c1 ea 04             	shr    $0x4,%edx
80102a7c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a7f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a82:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102a85:	8b 75 08             	mov    0x8(%ebp),%esi
80102a88:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102a8b:	89 06                	mov    %eax,(%esi)
80102a8d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102a90:	89 46 04             	mov    %eax,0x4(%esi)
80102a93:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102a96:	89 46 08             	mov    %eax,0x8(%esi)
80102a99:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102a9c:	89 46 0c             	mov    %eax,0xc(%esi)
80102a9f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102aa2:	89 46 10             	mov    %eax,0x10(%esi)
80102aa5:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102aa8:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102aab:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102ab2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102ab5:	5b                   	pop    %ebx
80102ab6:	5e                   	pop    %esi
80102ab7:	5f                   	pop    %edi
80102ab8:	5d                   	pop    %ebp
80102ab9:	c3                   	ret    
80102aba:	66 90                	xchg   %ax,%ax
80102abc:	66 90                	xchg   %ax,%ax
80102abe:	66 90                	xchg   %ax,%ax

80102ac0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102ac0:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102ac6:	85 c9                	test   %ecx,%ecx
80102ac8:	0f 8e 8a 00 00 00    	jle    80102b58 <install_trans+0x98>
{
80102ace:	55                   	push   %ebp
80102acf:	89 e5                	mov    %esp,%ebp
80102ad1:	57                   	push   %edi
80102ad2:	56                   	push   %esi
80102ad3:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
80102ad4:	31 db                	xor    %ebx,%ebx
{
80102ad6:	83 ec 0c             	sub    $0xc,%esp
80102ad9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102ae0:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102ae5:	83 ec 08             	sub    $0x8,%esp
80102ae8:	01 d8                	add    %ebx,%eax
80102aea:	83 c0 01             	add    $0x1,%eax
80102aed:	50                   	push   %eax
80102aee:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102af4:	e8 d7 d5 ff ff       	call   801000d0 <bread>
80102af9:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102afb:	58                   	pop    %eax
80102afc:	5a                   	pop    %edx
80102afd:	ff 34 9d cc 26 11 80 	pushl  -0x7feed934(,%ebx,4)
80102b04:	ff 35 c4 26 11 80    	pushl  0x801126c4
  for (tail = 0; tail < log.lh.n; tail++) {
80102b0a:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102b0d:	e8 be d5 ff ff       	call   801000d0 <bread>
80102b12:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102b14:	8d 47 5c             	lea    0x5c(%edi),%eax
80102b17:	83 c4 0c             	add    $0xc,%esp
80102b1a:	68 00 02 00 00       	push   $0x200
80102b1f:	50                   	push   %eax
80102b20:	8d 46 5c             	lea    0x5c(%esi),%eax
80102b23:	50                   	push   %eax
80102b24:	e8 97 1a 00 00       	call   801045c0 <memmove>
    bwrite(dbuf);  // write dst to disk
80102b29:	89 34 24             	mov    %esi,(%esp)
80102b2c:	e8 6f d6 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102b31:	89 3c 24             	mov    %edi,(%esp)
80102b34:	e8 a7 d6 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102b39:	89 34 24             	mov    %esi,(%esp)
80102b3c:	e8 9f d6 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102b41:	83 c4 10             	add    $0x10,%esp
80102b44:	39 1d c8 26 11 80    	cmp    %ebx,0x801126c8
80102b4a:	7f 94                	jg     80102ae0 <install_trans+0x20>
  }
}
80102b4c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b4f:	5b                   	pop    %ebx
80102b50:	5e                   	pop    %esi
80102b51:	5f                   	pop    %edi
80102b52:	5d                   	pop    %ebp
80102b53:	c3                   	ret    
80102b54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102b58:	f3 c3                	repz ret 
80102b5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102b60 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102b60:	55                   	push   %ebp
80102b61:	89 e5                	mov    %esp,%ebp
80102b63:	56                   	push   %esi
80102b64:	53                   	push   %ebx
  struct buf *buf = bread(log.dev, log.start);
80102b65:	83 ec 08             	sub    $0x8,%esp
80102b68:	ff 35 b4 26 11 80    	pushl  0x801126b4
80102b6e:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102b74:	e8 57 d5 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102b79:	8b 1d c8 26 11 80    	mov    0x801126c8,%ebx
  for (i = 0; i < log.lh.n; i++) {
80102b7f:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102b82:	89 c6                	mov    %eax,%esi
  for (i = 0; i < log.lh.n; i++) {
80102b84:	85 db                	test   %ebx,%ebx
  hb->n = log.lh.n;
80102b86:	89 58 5c             	mov    %ebx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102b89:	7e 16                	jle    80102ba1 <write_head+0x41>
80102b8b:	c1 e3 02             	shl    $0x2,%ebx
80102b8e:	31 d2                	xor    %edx,%edx
    hb->block[i] = log.lh.block[i];
80102b90:	8b 8a cc 26 11 80    	mov    -0x7feed934(%edx),%ecx
80102b96:	89 4c 16 60          	mov    %ecx,0x60(%esi,%edx,1)
80102b9a:	83 c2 04             	add    $0x4,%edx
  for (i = 0; i < log.lh.n; i++) {
80102b9d:	39 da                	cmp    %ebx,%edx
80102b9f:	75 ef                	jne    80102b90 <write_head+0x30>
  }
  bwrite(buf);
80102ba1:	83 ec 0c             	sub    $0xc,%esp
80102ba4:	56                   	push   %esi
80102ba5:	e8 f6 d5 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102baa:	89 34 24             	mov    %esi,(%esp)
80102bad:	e8 2e d6 ff ff       	call   801001e0 <brelse>
}
80102bb2:	83 c4 10             	add    $0x10,%esp
80102bb5:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102bb8:	5b                   	pop    %ebx
80102bb9:	5e                   	pop    %esi
80102bba:	5d                   	pop    %ebp
80102bbb:	c3                   	ret    
80102bbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102bc0 <initlog>:
{
80102bc0:	55                   	push   %ebp
80102bc1:	89 e5                	mov    %esp,%ebp
80102bc3:	53                   	push   %ebx
80102bc4:	83 ec 2c             	sub    $0x2c,%esp
80102bc7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102bca:	68 20 74 10 80       	push   $0x80107420
80102bcf:	68 80 26 11 80       	push   $0x80112680
80102bd4:	e8 e7 16 00 00       	call   801042c0 <initlock>
  readsb(dev, &sb);
80102bd9:	58                   	pop    %eax
80102bda:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102bdd:	5a                   	pop    %edx
80102bde:	50                   	push   %eax
80102bdf:	53                   	push   %ebx
80102be0:	e8 1b e9 ff ff       	call   80101500 <readsb>
  log.size = sb.nlog;
80102be5:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102be8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102beb:	59                   	pop    %ecx
  log.dev = dev;
80102bec:	89 1d c4 26 11 80    	mov    %ebx,0x801126c4
  log.size = sb.nlog;
80102bf2:	89 15 b8 26 11 80    	mov    %edx,0x801126b8
  log.start = sb.logstart;
80102bf8:	a3 b4 26 11 80       	mov    %eax,0x801126b4
  struct buf *buf = bread(log.dev, log.start);
80102bfd:	5a                   	pop    %edx
80102bfe:	50                   	push   %eax
80102bff:	53                   	push   %ebx
80102c00:	e8 cb d4 ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80102c05:	8b 58 5c             	mov    0x5c(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
80102c08:	83 c4 10             	add    $0x10,%esp
80102c0b:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
80102c0d:	89 1d c8 26 11 80    	mov    %ebx,0x801126c8
  for (i = 0; i < log.lh.n; i++) {
80102c13:	7e 1c                	jle    80102c31 <initlog+0x71>
80102c15:	c1 e3 02             	shl    $0x2,%ebx
80102c18:	31 d2                	xor    %edx,%edx
80102c1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    log.lh.block[i] = lh->block[i];
80102c20:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102c24:	83 c2 04             	add    $0x4,%edx
80102c27:	89 8a c8 26 11 80    	mov    %ecx,-0x7feed938(%edx)
  for (i = 0; i < log.lh.n; i++) {
80102c2d:	39 d3                	cmp    %edx,%ebx
80102c2f:	75 ef                	jne    80102c20 <initlog+0x60>
  brelse(buf);
80102c31:	83 ec 0c             	sub    $0xc,%esp
80102c34:	50                   	push   %eax
80102c35:	e8 a6 d5 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102c3a:	e8 81 fe ff ff       	call   80102ac0 <install_trans>
  log.lh.n = 0;
80102c3f:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102c46:	00 00 00 
  write_head(); // clear the log
80102c49:	e8 12 ff ff ff       	call   80102b60 <write_head>
}
80102c4e:	83 c4 10             	add    $0x10,%esp
80102c51:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102c54:	c9                   	leave  
80102c55:	c3                   	ret    
80102c56:	8d 76 00             	lea    0x0(%esi),%esi
80102c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c60 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102c60:	55                   	push   %ebp
80102c61:	89 e5                	mov    %esp,%ebp
80102c63:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102c66:	68 80 26 11 80       	push   $0x80112680
80102c6b:	e8 90 17 00 00       	call   80104400 <acquire>
80102c70:	83 c4 10             	add    $0x10,%esp
80102c73:	eb 18                	jmp    80102c8d <begin_op+0x2d>
80102c75:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102c78:	83 ec 08             	sub    $0x8,%esp
80102c7b:	68 80 26 11 80       	push   $0x80112680
80102c80:	68 80 26 11 80       	push   $0x80112680
80102c85:	e8 b6 11 00 00       	call   80103e40 <sleep>
80102c8a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102c8d:	a1 c0 26 11 80       	mov    0x801126c0,%eax
80102c92:	85 c0                	test   %eax,%eax
80102c94:	75 e2                	jne    80102c78 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102c96:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102c9b:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
80102ca1:	83 c0 01             	add    $0x1,%eax
80102ca4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102ca7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102caa:	83 fa 1e             	cmp    $0x1e,%edx
80102cad:	7f c9                	jg     80102c78 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102caf:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102cb2:	a3 bc 26 11 80       	mov    %eax,0x801126bc
      release(&log.lock);
80102cb7:	68 80 26 11 80       	push   $0x80112680
80102cbc:	e8 ff 17 00 00       	call   801044c0 <release>
      break;
    }
  }
}
80102cc1:	83 c4 10             	add    $0x10,%esp
80102cc4:	c9                   	leave  
80102cc5:	c3                   	ret    
80102cc6:	8d 76 00             	lea    0x0(%esi),%esi
80102cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102cd0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102cd0:	55                   	push   %ebp
80102cd1:	89 e5                	mov    %esp,%ebp
80102cd3:	57                   	push   %edi
80102cd4:	56                   	push   %esi
80102cd5:	53                   	push   %ebx
80102cd6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102cd9:	68 80 26 11 80       	push   $0x80112680
80102cde:	e8 1d 17 00 00       	call   80104400 <acquire>
  log.outstanding -= 1;
80102ce3:	a1 bc 26 11 80       	mov    0x801126bc,%eax
  if(log.committing)
80102ce8:	8b 35 c0 26 11 80    	mov    0x801126c0,%esi
80102cee:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102cf1:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80102cf4:	85 f6                	test   %esi,%esi
  log.outstanding -= 1;
80102cf6:	89 1d bc 26 11 80    	mov    %ebx,0x801126bc
  if(log.committing)
80102cfc:	0f 85 1a 01 00 00    	jne    80102e1c <end_op+0x14c>
    panic("log.committing");
  if(log.outstanding == 0){
80102d02:	85 db                	test   %ebx,%ebx
80102d04:	0f 85 ee 00 00 00    	jne    80102df8 <end_op+0x128>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102d0a:	83 ec 0c             	sub    $0xc,%esp
    log.committing = 1;
80102d0d:	c7 05 c0 26 11 80 01 	movl   $0x1,0x801126c0
80102d14:	00 00 00 
  release(&log.lock);
80102d17:	68 80 26 11 80       	push   $0x80112680
80102d1c:	e8 9f 17 00 00       	call   801044c0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102d21:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102d27:	83 c4 10             	add    $0x10,%esp
80102d2a:	85 c9                	test   %ecx,%ecx
80102d2c:	0f 8e 85 00 00 00    	jle    80102db7 <end_op+0xe7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102d32:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102d37:	83 ec 08             	sub    $0x8,%esp
80102d3a:	01 d8                	add    %ebx,%eax
80102d3c:	83 c0 01             	add    $0x1,%eax
80102d3f:	50                   	push   %eax
80102d40:	ff 35 c4 26 11 80    	pushl  0x801126c4
80102d46:	e8 85 d3 ff ff       	call   801000d0 <bread>
80102d4b:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d4d:	58                   	pop    %eax
80102d4e:	5a                   	pop    %edx
80102d4f:	ff 34 9d cc 26 11 80 	pushl  -0x7feed934(,%ebx,4)
80102d56:	ff 35 c4 26 11 80    	pushl  0x801126c4
  for (tail = 0; tail < log.lh.n; tail++) {
80102d5c:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d5f:	e8 6c d3 ff ff       	call   801000d0 <bread>
80102d64:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102d66:	8d 40 5c             	lea    0x5c(%eax),%eax
80102d69:	83 c4 0c             	add    $0xc,%esp
80102d6c:	68 00 02 00 00       	push   $0x200
80102d71:	50                   	push   %eax
80102d72:	8d 46 5c             	lea    0x5c(%esi),%eax
80102d75:	50                   	push   %eax
80102d76:	e8 45 18 00 00       	call   801045c0 <memmove>
    bwrite(to);  // write the log
80102d7b:	89 34 24             	mov    %esi,(%esp)
80102d7e:	e8 1d d4 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102d83:	89 3c 24             	mov    %edi,(%esp)
80102d86:	e8 55 d4 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102d8b:	89 34 24             	mov    %esi,(%esp)
80102d8e:	e8 4d d4 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102d93:	83 c4 10             	add    $0x10,%esp
80102d96:	3b 1d c8 26 11 80    	cmp    0x801126c8,%ebx
80102d9c:	7c 94                	jl     80102d32 <end_op+0x62>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102d9e:	e8 bd fd ff ff       	call   80102b60 <write_head>
    install_trans(); // Now install writes to home locations
80102da3:	e8 18 fd ff ff       	call   80102ac0 <install_trans>
    log.lh.n = 0;
80102da8:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102daf:	00 00 00 
    write_head();    // Erase the transaction from the log
80102db2:	e8 a9 fd ff ff       	call   80102b60 <write_head>
    acquire(&log.lock);
80102db7:	83 ec 0c             	sub    $0xc,%esp
80102dba:	68 80 26 11 80       	push   $0x80112680
80102dbf:	e8 3c 16 00 00       	call   80104400 <acquire>
    wakeup(&log);
80102dc4:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
    log.committing = 0;
80102dcb:	c7 05 c0 26 11 80 00 	movl   $0x0,0x801126c0
80102dd2:	00 00 00 
    wakeup(&log);
80102dd5:	e8 16 12 00 00       	call   80103ff0 <wakeup>
    release(&log.lock);
80102dda:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102de1:	e8 da 16 00 00       	call   801044c0 <release>
80102de6:	83 c4 10             	add    $0x10,%esp
}
80102de9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102dec:	5b                   	pop    %ebx
80102ded:	5e                   	pop    %esi
80102dee:	5f                   	pop    %edi
80102def:	5d                   	pop    %ebp
80102df0:	c3                   	ret    
80102df1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&log);
80102df8:	83 ec 0c             	sub    $0xc,%esp
80102dfb:	68 80 26 11 80       	push   $0x80112680
80102e00:	e8 eb 11 00 00       	call   80103ff0 <wakeup>
  release(&log.lock);
80102e05:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102e0c:	e8 af 16 00 00       	call   801044c0 <release>
80102e11:	83 c4 10             	add    $0x10,%esp
}
80102e14:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e17:	5b                   	pop    %ebx
80102e18:	5e                   	pop    %esi
80102e19:	5f                   	pop    %edi
80102e1a:	5d                   	pop    %ebp
80102e1b:	c3                   	ret    
    panic("log.committing");
80102e1c:	83 ec 0c             	sub    $0xc,%esp
80102e1f:	68 24 74 10 80       	push   $0x80107424
80102e24:	e8 67 d5 ff ff       	call   80100390 <panic>
80102e29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102e30 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102e30:	55                   	push   %ebp
80102e31:	89 e5                	mov    %esp,%ebp
80102e33:	53                   	push   %ebx
80102e34:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102e37:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
{
80102e3d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102e40:	83 fa 1d             	cmp    $0x1d,%edx
80102e43:	0f 8f 9d 00 00 00    	jg     80102ee6 <log_write+0xb6>
80102e49:	a1 b8 26 11 80       	mov    0x801126b8,%eax
80102e4e:	83 e8 01             	sub    $0x1,%eax
80102e51:	39 c2                	cmp    %eax,%edx
80102e53:	0f 8d 8d 00 00 00    	jge    80102ee6 <log_write+0xb6>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102e59:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102e5e:	85 c0                	test   %eax,%eax
80102e60:	0f 8e 8d 00 00 00    	jle    80102ef3 <log_write+0xc3>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102e66:	83 ec 0c             	sub    $0xc,%esp
80102e69:	68 80 26 11 80       	push   $0x80112680
80102e6e:	e8 8d 15 00 00       	call   80104400 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102e73:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102e79:	83 c4 10             	add    $0x10,%esp
80102e7c:	83 f9 00             	cmp    $0x0,%ecx
80102e7f:	7e 57                	jle    80102ed8 <log_write+0xa8>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102e81:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
80102e84:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102e86:	3b 15 cc 26 11 80    	cmp    0x801126cc,%edx
80102e8c:	75 0b                	jne    80102e99 <log_write+0x69>
80102e8e:	eb 38                	jmp    80102ec8 <log_write+0x98>
80102e90:	39 14 85 cc 26 11 80 	cmp    %edx,-0x7feed934(,%eax,4)
80102e97:	74 2f                	je     80102ec8 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
80102e99:	83 c0 01             	add    $0x1,%eax
80102e9c:	39 c1                	cmp    %eax,%ecx
80102e9e:	75 f0                	jne    80102e90 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80102ea0:	89 14 85 cc 26 11 80 	mov    %edx,-0x7feed934(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
80102ea7:	83 c0 01             	add    $0x1,%eax
80102eaa:	a3 c8 26 11 80       	mov    %eax,0x801126c8
  b->flags |= B_DIRTY; // prevent eviction
80102eaf:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102eb2:	c7 45 08 80 26 11 80 	movl   $0x80112680,0x8(%ebp)
}
80102eb9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102ebc:	c9                   	leave  
  release(&log.lock);
80102ebd:	e9 fe 15 00 00       	jmp    801044c0 <release>
80102ec2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80102ec8:	89 14 85 cc 26 11 80 	mov    %edx,-0x7feed934(,%eax,4)
80102ecf:	eb de                	jmp    80102eaf <log_write+0x7f>
80102ed1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ed8:	8b 43 08             	mov    0x8(%ebx),%eax
80102edb:	a3 cc 26 11 80       	mov    %eax,0x801126cc
  if (i == log.lh.n)
80102ee0:	75 cd                	jne    80102eaf <log_write+0x7f>
80102ee2:	31 c0                	xor    %eax,%eax
80102ee4:	eb c1                	jmp    80102ea7 <log_write+0x77>
    panic("too big a transaction");
80102ee6:	83 ec 0c             	sub    $0xc,%esp
80102ee9:	68 33 74 10 80       	push   $0x80107433
80102eee:	e8 9d d4 ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
80102ef3:	83 ec 0c             	sub    $0xc,%esp
80102ef6:	68 49 74 10 80       	push   $0x80107449
80102efb:	e8 90 d4 ff ff       	call   80100390 <panic>

80102f00 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102f00:	55                   	push   %ebp
80102f01:	89 e5                	mov    %esp,%ebp
80102f03:	53                   	push   %ebx
80102f04:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102f07:	e8 74 09 00 00       	call   80103880 <cpuid>
80102f0c:	89 c3                	mov    %eax,%ebx
80102f0e:	e8 6d 09 00 00       	call   80103880 <cpuid>
80102f13:	83 ec 04             	sub    $0x4,%esp
80102f16:	53                   	push   %ebx
80102f17:	50                   	push   %eax
80102f18:	68 64 74 10 80       	push   $0x80107464
80102f1d:	e8 3e d7 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80102f22:	e8 69 28 00 00       	call   80105790 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102f27:	e8 d4 08 00 00       	call   80103800 <mycpu>
80102f2c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102f2e:	b8 01 00 00 00       	mov    $0x1,%eax
80102f33:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102f3a:	e8 21 0c 00 00       	call   80103b60 <scheduler>
80102f3f:	90                   	nop

80102f40 <mpenter>:
{
80102f40:	55                   	push   %ebp
80102f41:	89 e5                	mov    %esp,%ebp
80102f43:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102f46:	e8 35 39 00 00       	call   80106880 <switchkvm>
  seginit();
80102f4b:	e8 a0 38 00 00       	call   801067f0 <seginit>
  lapicinit();
80102f50:	e8 9b f7 ff ff       	call   801026f0 <lapicinit>
  mpmain();
80102f55:	e8 a6 ff ff ff       	call   80102f00 <mpmain>
80102f5a:	66 90                	xchg   %ax,%ax
80102f5c:	66 90                	xchg   %ax,%ax
80102f5e:	66 90                	xchg   %ax,%ax

80102f60 <main>:
{
80102f60:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102f64:	83 e4 f0             	and    $0xfffffff0,%esp
80102f67:	ff 71 fc             	pushl  -0x4(%ecx)
80102f6a:	55                   	push   %ebp
80102f6b:	89 e5                	mov    %esp,%ebp
80102f6d:	53                   	push   %ebx
80102f6e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102f6f:	83 ec 08             	sub    $0x8,%esp
80102f72:	68 00 00 40 80       	push   $0x80400000
80102f77:	68 a8 54 11 80       	push   $0x801154a8
80102f7c:	e8 2f f5 ff ff       	call   801024b0 <kinit1>
  kvmalloc();      // kernel page table
80102f81:	e8 ca 3d 00 00       	call   80106d50 <kvmalloc>
  mpinit();        // detect other processors
80102f86:	e8 75 01 00 00       	call   80103100 <mpinit>
  lapicinit();     // interrupt controller
80102f8b:	e8 60 f7 ff ff       	call   801026f0 <lapicinit>
  seginit();       // segment descriptors
80102f90:	e8 5b 38 00 00       	call   801067f0 <seginit>
  picinit();       // disable pic
80102f95:	e8 46 03 00 00       	call   801032e0 <picinit>
  ioapicinit();    // another interrupt controller
80102f9a:	e8 41 f3 ff ff       	call   801022e0 <ioapicinit>
  consoleinit();   // console hardware
80102f9f:	e8 1c da ff ff       	call   801009c0 <consoleinit>
  uartinit();      // serial port
80102fa4:	e8 17 2b 00 00       	call   80105ac0 <uartinit>
  pinit();         // process table
80102fa9:	e8 32 08 00 00       	call   801037e0 <pinit>
  tvinit();        // trap vectors
80102fae:	e8 5d 27 00 00       	call   80105710 <tvinit>
  binit();         // buffer cache
80102fb3:	e8 88 d0 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80102fb8:	e8 a3 dd ff ff       	call   80100d60 <fileinit>
  ideinit();       // disk 
80102fbd:	e8 fe f0 ff ff       	call   801020c0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102fc2:	83 c4 0c             	add    $0xc,%esp
80102fc5:	68 8a 00 00 00       	push   $0x8a
80102fca:	68 8c a4 10 80       	push   $0x8010a48c
80102fcf:	68 00 70 00 80       	push   $0x80007000
80102fd4:	e8 e7 15 00 00       	call   801045c0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102fd9:	69 05 00 2d 11 80 b0 	imul   $0xb0,0x80112d00,%eax
80102fe0:	00 00 00 
80102fe3:	83 c4 10             	add    $0x10,%esp
80102fe6:	05 80 27 11 80       	add    $0x80112780,%eax
80102feb:	3d 80 27 11 80       	cmp    $0x80112780,%eax
80102ff0:	76 71                	jbe    80103063 <main+0x103>
80102ff2:	bb 80 27 11 80       	mov    $0x80112780,%ebx
80102ff7:	89 f6                	mov    %esi,%esi
80102ff9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c == mycpu())  // We've started already.
80103000:	e8 fb 07 00 00       	call   80103800 <mycpu>
80103005:	39 d8                	cmp    %ebx,%eax
80103007:	74 41                	je     8010304a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103009:	e8 72 f5 ff ff       	call   80102580 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
8010300e:	05 00 10 00 00       	add    $0x1000,%eax
    *(void(**)(void))(code-8) = mpenter;
80103013:	c7 05 f8 6f 00 80 40 	movl   $0x80102f40,0x80006ff8
8010301a:	2f 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
8010301d:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
80103024:	90 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80103027:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
8010302c:	0f b6 03             	movzbl (%ebx),%eax
8010302f:	83 ec 08             	sub    $0x8,%esp
80103032:	68 00 70 00 00       	push   $0x7000
80103037:	50                   	push   %eax
80103038:	e8 03 f8 ff ff       	call   80102840 <lapicstartap>
8010303d:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103040:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103046:	85 c0                	test   %eax,%eax
80103048:	74 f6                	je     80103040 <main+0xe0>
  for(c = cpus; c < cpus+ncpu; c++){
8010304a:	69 05 00 2d 11 80 b0 	imul   $0xb0,0x80112d00,%eax
80103051:	00 00 00 
80103054:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
8010305a:	05 80 27 11 80       	add    $0x80112780,%eax
8010305f:	39 c3                	cmp    %eax,%ebx
80103061:	72 9d                	jb     80103000 <main+0xa0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103063:	83 ec 08             	sub    $0x8,%esp
80103066:	68 00 00 00 8e       	push   $0x8e000000
8010306b:	68 00 00 40 80       	push   $0x80400000
80103070:	e8 ab f4 ff ff       	call   80102520 <kinit2>
  userinit();      // first user process
80103075:	e8 56 08 00 00       	call   801038d0 <userinit>
  mpmain();        // finish this processor's setup
8010307a:	e8 81 fe ff ff       	call   80102f00 <mpmain>
8010307f:	90                   	nop

80103080 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103080:	55                   	push   %ebp
80103081:	89 e5                	mov    %esp,%ebp
80103083:	57                   	push   %edi
80103084:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103085:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010308b:	53                   	push   %ebx
  e = addr+len;
8010308c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010308f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103092:	39 de                	cmp    %ebx,%esi
80103094:	72 10                	jb     801030a6 <mpsearch1+0x26>
80103096:	eb 50                	jmp    801030e8 <mpsearch1+0x68>
80103098:	90                   	nop
80103099:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801030a0:	39 fb                	cmp    %edi,%ebx
801030a2:	89 fe                	mov    %edi,%esi
801030a4:	76 42                	jbe    801030e8 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801030a6:	83 ec 04             	sub    $0x4,%esp
801030a9:	8d 7e 10             	lea    0x10(%esi),%edi
801030ac:	6a 04                	push   $0x4
801030ae:	68 78 74 10 80       	push   $0x80107478
801030b3:	56                   	push   %esi
801030b4:	e8 a7 14 00 00       	call   80104560 <memcmp>
801030b9:	83 c4 10             	add    $0x10,%esp
801030bc:	85 c0                	test   %eax,%eax
801030be:	75 e0                	jne    801030a0 <mpsearch1+0x20>
801030c0:	89 f1                	mov    %esi,%ecx
801030c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
801030c8:	0f b6 11             	movzbl (%ecx),%edx
801030cb:	83 c1 01             	add    $0x1,%ecx
801030ce:	01 d0                	add    %edx,%eax
  for(i=0; i<len; i++)
801030d0:	39 f9                	cmp    %edi,%ecx
801030d2:	75 f4                	jne    801030c8 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801030d4:	84 c0                	test   %al,%al
801030d6:	75 c8                	jne    801030a0 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
801030d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801030db:	89 f0                	mov    %esi,%eax
801030dd:	5b                   	pop    %ebx
801030de:	5e                   	pop    %esi
801030df:	5f                   	pop    %edi
801030e0:	5d                   	pop    %ebp
801030e1:	c3                   	ret    
801030e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801030e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801030eb:	31 f6                	xor    %esi,%esi
}
801030ed:	89 f0                	mov    %esi,%eax
801030ef:	5b                   	pop    %ebx
801030f0:	5e                   	pop    %esi
801030f1:	5f                   	pop    %edi
801030f2:	5d                   	pop    %ebp
801030f3:	c3                   	ret    
801030f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801030fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103100 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103100:	55                   	push   %ebp
80103101:	89 e5                	mov    %esp,%ebp
80103103:	57                   	push   %edi
80103104:	56                   	push   %esi
80103105:	53                   	push   %ebx
80103106:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103109:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103110:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103117:	c1 e0 08             	shl    $0x8,%eax
8010311a:	09 d0                	or     %edx,%eax
8010311c:	c1 e0 04             	shl    $0x4,%eax
8010311f:	85 c0                	test   %eax,%eax
80103121:	75 1b                	jne    8010313e <mpinit+0x3e>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103123:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010312a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103131:	c1 e0 08             	shl    $0x8,%eax
80103134:	09 d0                	or     %edx,%eax
80103136:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103139:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010313e:	ba 00 04 00 00       	mov    $0x400,%edx
80103143:	e8 38 ff ff ff       	call   80103080 <mpsearch1>
80103148:	85 c0                	test   %eax,%eax
8010314a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010314d:	0f 84 3d 01 00 00    	je     80103290 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103153:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103156:	8b 58 04             	mov    0x4(%eax),%ebx
80103159:	85 db                	test   %ebx,%ebx
8010315b:	0f 84 4f 01 00 00    	je     801032b0 <mpinit+0x1b0>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103161:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
80103167:	83 ec 04             	sub    $0x4,%esp
8010316a:	6a 04                	push   $0x4
8010316c:	68 95 74 10 80       	push   $0x80107495
80103171:	56                   	push   %esi
80103172:	e8 e9 13 00 00       	call   80104560 <memcmp>
80103177:	83 c4 10             	add    $0x10,%esp
8010317a:	85 c0                	test   %eax,%eax
8010317c:	0f 85 2e 01 00 00    	jne    801032b0 <mpinit+0x1b0>
  if(conf->version != 1 && conf->version != 4)
80103182:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
80103189:	3c 01                	cmp    $0x1,%al
8010318b:	0f 95 c2             	setne  %dl
8010318e:	3c 04                	cmp    $0x4,%al
80103190:	0f 95 c0             	setne  %al
80103193:	20 c2                	and    %al,%dl
80103195:	0f 85 15 01 00 00    	jne    801032b0 <mpinit+0x1b0>
  if(sum((uchar*)conf, conf->length) != 0)
8010319b:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
  for(i=0; i<len; i++)
801031a2:	66 85 ff             	test   %di,%di
801031a5:	74 1a                	je     801031c1 <mpinit+0xc1>
801031a7:	89 f0                	mov    %esi,%eax
801031a9:	01 f7                	add    %esi,%edi
  sum = 0;
801031ab:	31 d2                	xor    %edx,%edx
801031ad:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
801031b0:	0f b6 08             	movzbl (%eax),%ecx
801031b3:	83 c0 01             	add    $0x1,%eax
801031b6:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
801031b8:	39 c7                	cmp    %eax,%edi
801031ba:	75 f4                	jne    801031b0 <mpinit+0xb0>
801031bc:	84 d2                	test   %dl,%dl
801031be:	0f 95 c2             	setne  %dl
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
801031c1:	85 f6                	test   %esi,%esi
801031c3:	0f 84 e7 00 00 00    	je     801032b0 <mpinit+0x1b0>
801031c9:	84 d2                	test   %dl,%dl
801031cb:	0f 85 df 00 00 00    	jne    801032b0 <mpinit+0x1b0>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801031d1:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
801031d7:	a3 7c 26 11 80       	mov    %eax,0x8011267c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801031dc:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
801031e3:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  ismp = 1;
801031e9:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801031ee:	01 d6                	add    %edx,%esi
801031f0:	39 c6                	cmp    %eax,%esi
801031f2:	76 23                	jbe    80103217 <mpinit+0x117>
    switch(*p){
801031f4:	0f b6 10             	movzbl (%eax),%edx
801031f7:	80 fa 04             	cmp    $0x4,%dl
801031fa:	0f 87 ca 00 00 00    	ja     801032ca <mpinit+0x1ca>
80103200:	ff 24 95 bc 74 10 80 	jmp    *-0x7fef8b44(,%edx,4)
80103207:	89 f6                	mov    %esi,%esi
80103209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103210:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103213:	39 c6                	cmp    %eax,%esi
80103215:	77 dd                	ja     801031f4 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103217:	85 db                	test   %ebx,%ebx
80103219:	0f 84 9e 00 00 00    	je     801032bd <mpinit+0x1bd>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010321f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103222:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80103226:	74 15                	je     8010323d <mpinit+0x13d>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103228:	b8 70 00 00 00       	mov    $0x70,%eax
8010322d:	ba 22 00 00 00       	mov    $0x22,%edx
80103232:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103233:	ba 23 00 00 00       	mov    $0x23,%edx
80103238:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103239:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010323c:	ee                   	out    %al,(%dx)
  }
}
8010323d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103240:	5b                   	pop    %ebx
80103241:	5e                   	pop    %esi
80103242:	5f                   	pop    %edi
80103243:	5d                   	pop    %ebp
80103244:	c3                   	ret    
80103245:	8d 76 00             	lea    0x0(%esi),%esi
      if(ncpu < NCPU) {
80103248:	8b 0d 00 2d 11 80    	mov    0x80112d00,%ecx
8010324e:	83 f9 07             	cmp    $0x7,%ecx
80103251:	7f 19                	jg     8010326c <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103253:	0f b6 50 01          	movzbl 0x1(%eax),%edx
80103257:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
8010325d:	83 c1 01             	add    $0x1,%ecx
80103260:	89 0d 00 2d 11 80    	mov    %ecx,0x80112d00
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103266:	88 97 80 27 11 80    	mov    %dl,-0x7feed880(%edi)
      p += sizeof(struct mpproc);
8010326c:	83 c0 14             	add    $0x14,%eax
      continue;
8010326f:	e9 7c ff ff ff       	jmp    801031f0 <mpinit+0xf0>
80103274:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80103278:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
8010327c:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
8010327f:	88 15 60 27 11 80    	mov    %dl,0x80112760
      continue;
80103285:	e9 66 ff ff ff       	jmp    801031f0 <mpinit+0xf0>
8010328a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return mpsearch1(0xF0000, 0x10000);
80103290:	ba 00 00 01 00       	mov    $0x10000,%edx
80103295:	b8 00 00 0f 00       	mov    $0xf0000,%eax
8010329a:	e8 e1 fd ff ff       	call   80103080 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
8010329f:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
801032a1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801032a4:	0f 85 a9 fe ff ff    	jne    80103153 <mpinit+0x53>
801032aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
801032b0:	83 ec 0c             	sub    $0xc,%esp
801032b3:	68 7d 74 10 80       	push   $0x8010747d
801032b8:	e8 d3 d0 ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
801032bd:	83 ec 0c             	sub    $0xc,%esp
801032c0:	68 9c 74 10 80       	push   $0x8010749c
801032c5:	e8 c6 d0 ff ff       	call   80100390 <panic>
      ismp = 0;
801032ca:	31 db                	xor    %ebx,%ebx
801032cc:	e9 26 ff ff ff       	jmp    801031f7 <mpinit+0xf7>
801032d1:	66 90                	xchg   %ax,%ax
801032d3:	66 90                	xchg   %ax,%ax
801032d5:	66 90                	xchg   %ax,%ax
801032d7:	66 90                	xchg   %ax,%ax
801032d9:	66 90                	xchg   %ax,%ax
801032db:	66 90                	xchg   %ax,%ax
801032dd:	66 90                	xchg   %ax,%ax
801032df:	90                   	nop

801032e0 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
801032e0:	55                   	push   %ebp
801032e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801032e6:	ba 21 00 00 00       	mov    $0x21,%edx
801032eb:	89 e5                	mov    %esp,%ebp
801032ed:	ee                   	out    %al,(%dx)
801032ee:	ba a1 00 00 00       	mov    $0xa1,%edx
801032f3:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
801032f4:	5d                   	pop    %ebp
801032f5:	c3                   	ret    
801032f6:	66 90                	xchg   %ax,%ax
801032f8:	66 90                	xchg   %ax,%ax
801032fa:	66 90                	xchg   %ax,%ax
801032fc:	66 90                	xchg   %ax,%ax
801032fe:	66 90                	xchg   %ax,%ax

80103300 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103300:	55                   	push   %ebp
80103301:	89 e5                	mov    %esp,%ebp
80103303:	57                   	push   %edi
80103304:	56                   	push   %esi
80103305:	53                   	push   %ebx
80103306:	83 ec 0c             	sub    $0xc,%esp
80103309:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010330c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010330f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103315:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010331b:	e8 60 da ff ff       	call   80100d80 <filealloc>
80103320:	85 c0                	test   %eax,%eax
80103322:	89 03                	mov    %eax,(%ebx)
80103324:	74 22                	je     80103348 <pipealloc+0x48>
80103326:	e8 55 da ff ff       	call   80100d80 <filealloc>
8010332b:	85 c0                	test   %eax,%eax
8010332d:	89 06                	mov    %eax,(%esi)
8010332f:	74 3f                	je     80103370 <pipealloc+0x70>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103331:	e8 4a f2 ff ff       	call   80102580 <kalloc>
80103336:	85 c0                	test   %eax,%eax
80103338:	89 c7                	mov    %eax,%edi
8010333a:	75 54                	jne    80103390 <pipealloc+0x90>

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
8010333c:	8b 03                	mov    (%ebx),%eax
8010333e:	85 c0                	test   %eax,%eax
80103340:	75 34                	jne    80103376 <pipealloc+0x76>
80103342:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fileclose(*f0);
  if(*f1)
80103348:	8b 06                	mov    (%esi),%eax
8010334a:	85 c0                	test   %eax,%eax
8010334c:	74 0c                	je     8010335a <pipealloc+0x5a>
    fileclose(*f1);
8010334e:	83 ec 0c             	sub    $0xc,%esp
80103351:	50                   	push   %eax
80103352:	e8 e9 da ff ff       	call   80100e40 <fileclose>
80103357:	83 c4 10             	add    $0x10,%esp
  return -1;
}
8010335a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010335d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103362:	5b                   	pop    %ebx
80103363:	5e                   	pop    %esi
80103364:	5f                   	pop    %edi
80103365:	5d                   	pop    %ebp
80103366:	c3                   	ret    
80103367:	89 f6                	mov    %esi,%esi
80103369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(*f0)
80103370:	8b 03                	mov    (%ebx),%eax
80103372:	85 c0                	test   %eax,%eax
80103374:	74 e4                	je     8010335a <pipealloc+0x5a>
    fileclose(*f0);
80103376:	83 ec 0c             	sub    $0xc,%esp
80103379:	50                   	push   %eax
8010337a:	e8 c1 da ff ff       	call   80100e40 <fileclose>
  if(*f1)
8010337f:	8b 06                	mov    (%esi),%eax
    fileclose(*f0);
80103381:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103384:	85 c0                	test   %eax,%eax
80103386:	75 c6                	jne    8010334e <pipealloc+0x4e>
80103388:	eb d0                	jmp    8010335a <pipealloc+0x5a>
8010338a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  initlock(&p->lock, "pipe");
80103390:	83 ec 08             	sub    $0x8,%esp
  p->readopen = 1;
80103393:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010339a:	00 00 00 
  p->writeopen = 1;
8010339d:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801033a4:	00 00 00 
  p->nwrite = 0;
801033a7:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801033ae:	00 00 00 
  p->nread = 0;
801033b1:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801033b8:	00 00 00 
  initlock(&p->lock, "pipe");
801033bb:	68 d0 74 10 80       	push   $0x801074d0
801033c0:	50                   	push   %eax
801033c1:	e8 fa 0e 00 00       	call   801042c0 <initlock>
  (*f0)->type = FD_PIPE;
801033c6:	8b 03                	mov    (%ebx),%eax
  return 0;
801033c8:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
801033cb:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801033d1:	8b 03                	mov    (%ebx),%eax
801033d3:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801033d7:	8b 03                	mov    (%ebx),%eax
801033d9:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801033dd:	8b 03                	mov    (%ebx),%eax
801033df:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
801033e2:	8b 06                	mov    (%esi),%eax
801033e4:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801033ea:	8b 06                	mov    (%esi),%eax
801033ec:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801033f0:	8b 06                	mov    (%esi),%eax
801033f2:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801033f6:	8b 06                	mov    (%esi),%eax
801033f8:	89 78 0c             	mov    %edi,0xc(%eax)
}
801033fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801033fe:	31 c0                	xor    %eax,%eax
}
80103400:	5b                   	pop    %ebx
80103401:	5e                   	pop    %esi
80103402:	5f                   	pop    %edi
80103403:	5d                   	pop    %ebp
80103404:	c3                   	ret    
80103405:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103410 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103410:	55                   	push   %ebp
80103411:	89 e5                	mov    %esp,%ebp
80103413:	56                   	push   %esi
80103414:	53                   	push   %ebx
80103415:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103418:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010341b:	83 ec 0c             	sub    $0xc,%esp
8010341e:	53                   	push   %ebx
8010341f:	e8 dc 0f 00 00       	call   80104400 <acquire>
  if(writable){
80103424:	83 c4 10             	add    $0x10,%esp
80103427:	85 f6                	test   %esi,%esi
80103429:	74 45                	je     80103470 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010342b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103431:	83 ec 0c             	sub    $0xc,%esp
    p->writeopen = 0;
80103434:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010343b:	00 00 00 
    wakeup(&p->nread);
8010343e:	50                   	push   %eax
8010343f:	e8 ac 0b 00 00       	call   80103ff0 <wakeup>
80103444:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103447:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010344d:	85 d2                	test   %edx,%edx
8010344f:	75 0a                	jne    8010345b <pipeclose+0x4b>
80103451:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103457:	85 c0                	test   %eax,%eax
80103459:	74 35                	je     80103490 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010345b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010345e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103461:	5b                   	pop    %ebx
80103462:	5e                   	pop    %esi
80103463:	5d                   	pop    %ebp
    release(&p->lock);
80103464:	e9 57 10 00 00       	jmp    801044c0 <release>
80103469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
80103470:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103476:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
80103479:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103480:	00 00 00 
    wakeup(&p->nwrite);
80103483:	50                   	push   %eax
80103484:	e8 67 0b 00 00       	call   80103ff0 <wakeup>
80103489:	83 c4 10             	add    $0x10,%esp
8010348c:	eb b9                	jmp    80103447 <pipeclose+0x37>
8010348e:	66 90                	xchg   %ax,%ax
    release(&p->lock);
80103490:	83 ec 0c             	sub    $0xc,%esp
80103493:	53                   	push   %ebx
80103494:	e8 27 10 00 00       	call   801044c0 <release>
    kfree((char*)p);
80103499:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010349c:	83 c4 10             	add    $0x10,%esp
}
8010349f:	8d 65 f8             	lea    -0x8(%ebp),%esp
801034a2:	5b                   	pop    %ebx
801034a3:	5e                   	pop    %esi
801034a4:	5d                   	pop    %ebp
    kfree((char*)p);
801034a5:	e9 26 ef ff ff       	jmp    801023d0 <kfree>
801034aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801034b0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801034b0:	55                   	push   %ebp
801034b1:	89 e5                	mov    %esp,%ebp
801034b3:	57                   	push   %edi
801034b4:	56                   	push   %esi
801034b5:	53                   	push   %ebx
801034b6:	83 ec 28             	sub    $0x28,%esp
801034b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
801034bc:	53                   	push   %ebx
801034bd:	e8 3e 0f 00 00       	call   80104400 <acquire>
  for(i = 0; i < n; i++){
801034c2:	8b 45 10             	mov    0x10(%ebp),%eax
801034c5:	83 c4 10             	add    $0x10,%esp
801034c8:	85 c0                	test   %eax,%eax
801034ca:	0f 8e c9 00 00 00    	jle    80103599 <pipewrite+0xe9>
801034d0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801034d3:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801034d9:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
801034df:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801034e2:	03 4d 10             	add    0x10(%ebp),%ecx
801034e5:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801034e8:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
801034ee:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
801034f4:	39 d0                	cmp    %edx,%eax
801034f6:	75 71                	jne    80103569 <pipewrite+0xb9>
      if(p->readopen == 0 || myproc()->killed){
801034f8:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801034fe:	85 c0                	test   %eax,%eax
80103500:	74 4e                	je     80103550 <pipewrite+0xa0>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103502:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103508:	eb 3a                	jmp    80103544 <pipewrite+0x94>
8010350a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      wakeup(&p->nread);
80103510:	83 ec 0c             	sub    $0xc,%esp
80103513:	57                   	push   %edi
80103514:	e8 d7 0a 00 00       	call   80103ff0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103519:	5a                   	pop    %edx
8010351a:	59                   	pop    %ecx
8010351b:	53                   	push   %ebx
8010351c:	56                   	push   %esi
8010351d:	e8 1e 09 00 00       	call   80103e40 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103522:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103528:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010352e:	83 c4 10             	add    $0x10,%esp
80103531:	05 00 02 00 00       	add    $0x200,%eax
80103536:	39 c2                	cmp    %eax,%edx
80103538:	75 36                	jne    80103570 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
8010353a:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103540:	85 c0                	test   %eax,%eax
80103542:	74 0c                	je     80103550 <pipewrite+0xa0>
80103544:	e8 57 03 00 00       	call   801038a0 <myproc>
80103549:	8b 40 24             	mov    0x24(%eax),%eax
8010354c:	85 c0                	test   %eax,%eax
8010354e:	74 c0                	je     80103510 <pipewrite+0x60>
        release(&p->lock);
80103550:	83 ec 0c             	sub    $0xc,%esp
80103553:	53                   	push   %ebx
80103554:	e8 67 0f 00 00       	call   801044c0 <release>
        return -1;
80103559:	83 c4 10             	add    $0x10,%esp
8010355c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103561:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103564:	5b                   	pop    %ebx
80103565:	5e                   	pop    %esi
80103566:	5f                   	pop    %edi
80103567:	5d                   	pop    %ebp
80103568:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103569:	89 c2                	mov    %eax,%edx
8010356b:	90                   	nop
8010356c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103570:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80103573:	8d 42 01             	lea    0x1(%edx),%eax
80103576:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
8010357c:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103582:	83 c6 01             	add    $0x1,%esi
80103585:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
  for(i = 0; i < n; i++){
80103589:	3b 75 e0             	cmp    -0x20(%ebp),%esi
8010358c:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010358f:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80103593:	0f 85 4f ff ff ff    	jne    801034e8 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103599:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
8010359f:	83 ec 0c             	sub    $0xc,%esp
801035a2:	50                   	push   %eax
801035a3:	e8 48 0a 00 00       	call   80103ff0 <wakeup>
  release(&p->lock);
801035a8:	89 1c 24             	mov    %ebx,(%esp)
801035ab:	e8 10 0f 00 00       	call   801044c0 <release>
  return n;
801035b0:	83 c4 10             	add    $0x10,%esp
801035b3:	8b 45 10             	mov    0x10(%ebp),%eax
801035b6:	eb a9                	jmp    80103561 <pipewrite+0xb1>
801035b8:	90                   	nop
801035b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801035c0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801035c0:	55                   	push   %ebp
801035c1:	89 e5                	mov    %esp,%ebp
801035c3:	57                   	push   %edi
801035c4:	56                   	push   %esi
801035c5:	53                   	push   %ebx
801035c6:	83 ec 18             	sub    $0x18,%esp
801035c9:	8b 75 08             	mov    0x8(%ebp),%esi
801035cc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801035cf:	56                   	push   %esi
801035d0:	e8 2b 0e 00 00       	call   80104400 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801035d5:	83 c4 10             	add    $0x10,%esp
801035d8:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801035de:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801035e4:	75 6a                	jne    80103650 <piperead+0x90>
801035e6:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
801035ec:	85 db                	test   %ebx,%ebx
801035ee:	0f 84 c4 00 00 00    	je     801036b8 <piperead+0xf8>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801035f4:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
801035fa:	eb 2d                	jmp    80103629 <piperead+0x69>
801035fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103600:	83 ec 08             	sub    $0x8,%esp
80103603:	56                   	push   %esi
80103604:	53                   	push   %ebx
80103605:	e8 36 08 00 00       	call   80103e40 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010360a:	83 c4 10             	add    $0x10,%esp
8010360d:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103613:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103619:	75 35                	jne    80103650 <piperead+0x90>
8010361b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103621:	85 d2                	test   %edx,%edx
80103623:	0f 84 8f 00 00 00    	je     801036b8 <piperead+0xf8>
    if(myproc()->killed){
80103629:	e8 72 02 00 00       	call   801038a0 <myproc>
8010362e:	8b 48 24             	mov    0x24(%eax),%ecx
80103631:	85 c9                	test   %ecx,%ecx
80103633:	74 cb                	je     80103600 <piperead+0x40>
      release(&p->lock);
80103635:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103638:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
8010363d:	56                   	push   %esi
8010363e:	e8 7d 0e 00 00       	call   801044c0 <release>
      return -1;
80103643:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103646:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103649:	89 d8                	mov    %ebx,%eax
8010364b:	5b                   	pop    %ebx
8010364c:	5e                   	pop    %esi
8010364d:	5f                   	pop    %edi
8010364e:	5d                   	pop    %ebp
8010364f:	c3                   	ret    
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103650:	8b 45 10             	mov    0x10(%ebp),%eax
80103653:	85 c0                	test   %eax,%eax
80103655:	7e 61                	jle    801036b8 <piperead+0xf8>
    if(p->nread == p->nwrite)
80103657:	31 db                	xor    %ebx,%ebx
80103659:	eb 13                	jmp    8010366e <piperead+0xae>
8010365b:	90                   	nop
8010365c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103660:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103666:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
8010366c:	74 1f                	je     8010368d <piperead+0xcd>
    addr[i] = p->data[p->nread++ % PIPESIZE];
8010366e:	8d 41 01             	lea    0x1(%ecx),%eax
80103671:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80103677:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
8010367d:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
80103682:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103685:	83 c3 01             	add    $0x1,%ebx
80103688:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010368b:	75 d3                	jne    80103660 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010368d:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103693:	83 ec 0c             	sub    $0xc,%esp
80103696:	50                   	push   %eax
80103697:	e8 54 09 00 00       	call   80103ff0 <wakeup>
  release(&p->lock);
8010369c:	89 34 24             	mov    %esi,(%esp)
8010369f:	e8 1c 0e 00 00       	call   801044c0 <release>
  return i;
801036a4:	83 c4 10             	add    $0x10,%esp
}
801036a7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801036aa:	89 d8                	mov    %ebx,%eax
801036ac:	5b                   	pop    %ebx
801036ad:	5e                   	pop    %esi
801036ae:	5f                   	pop    %edi
801036af:	5d                   	pop    %ebp
801036b0:	c3                   	ret    
801036b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801036b8:	31 db                	xor    %ebx,%ebx
801036ba:	eb d1                	jmp    8010368d <piperead+0xcd>
801036bc:	66 90                	xchg   %ax,%ax
801036be:	66 90                	xchg   %ax,%ax

801036c0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801036c0:	55                   	push   %ebp
801036c1:	89 e5                	mov    %esp,%ebp
801036c3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801036c4:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
{
801036c9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
801036cc:	68 20 2d 11 80       	push   $0x80112d20
801036d1:	e8 2a 0d 00 00       	call   80104400 <acquire>
801036d6:	83 c4 10             	add    $0x10,%esp
801036d9:	eb 10                	jmp    801036eb <allocproc+0x2b>
801036db:	90                   	nop
801036dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801036e0:	83 c3 7c             	add    $0x7c,%ebx
801036e3:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
801036e9:	73 75                	jae    80103760 <allocproc+0xa0>
    if(p->state == UNUSED)
801036eb:	8b 43 0c             	mov    0xc(%ebx),%eax
801036ee:	85 c0                	test   %eax,%eax
801036f0:	75 ee                	jne    801036e0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801036f2:	a1 04 a0 10 80       	mov    0x8010a004,%eax

  release(&ptable.lock);
801036f7:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
801036fa:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103701:	8d 50 01             	lea    0x1(%eax),%edx
80103704:	89 43 10             	mov    %eax,0x10(%ebx)
  release(&ptable.lock);
80103707:	68 20 2d 11 80       	push   $0x80112d20
  p->pid = nextpid++;
8010370c:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
  release(&ptable.lock);
80103712:	e8 a9 0d 00 00       	call   801044c0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103717:	e8 64 ee ff ff       	call   80102580 <kalloc>
8010371c:	83 c4 10             	add    $0x10,%esp
8010371f:	85 c0                	test   %eax,%eax
80103721:	89 43 08             	mov    %eax,0x8(%ebx)
80103724:	74 53                	je     80103779 <allocproc+0xb9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103726:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010372c:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
8010372f:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103734:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103737:	c7 40 14 02 57 10 80 	movl   $0x80105702,0x14(%eax)
  p->context = (struct context*)sp;
8010373e:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103741:	6a 14                	push   $0x14
80103743:	6a 00                	push   $0x0
80103745:	50                   	push   %eax
80103746:	e8 c5 0d 00 00       	call   80104510 <memset>
  p->context->eip = (uint)forkret;
8010374b:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
8010374e:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103751:	c7 40 10 90 37 10 80 	movl   $0x80103790,0x10(%eax)
}
80103758:	89 d8                	mov    %ebx,%eax
8010375a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010375d:	c9                   	leave  
8010375e:	c3                   	ret    
8010375f:	90                   	nop
  release(&ptable.lock);
80103760:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103763:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103765:	68 20 2d 11 80       	push   $0x80112d20
8010376a:	e8 51 0d 00 00       	call   801044c0 <release>
}
8010376f:	89 d8                	mov    %ebx,%eax
  return 0;
80103771:	83 c4 10             	add    $0x10,%esp
}
80103774:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103777:	c9                   	leave  
80103778:	c3                   	ret    
    p->state = UNUSED;
80103779:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103780:	31 db                	xor    %ebx,%ebx
80103782:	eb d4                	jmp    80103758 <allocproc+0x98>
80103784:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010378a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103790 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103790:	55                   	push   %ebp
80103791:	89 e5                	mov    %esp,%ebp
80103793:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103796:	68 20 2d 11 80       	push   $0x80112d20
8010379b:	e8 20 0d 00 00       	call   801044c0 <release>

  if (first) {
801037a0:	a1 00 a0 10 80       	mov    0x8010a000,%eax
801037a5:	83 c4 10             	add    $0x10,%esp
801037a8:	85 c0                	test   %eax,%eax
801037aa:	75 04                	jne    801037b0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801037ac:	c9                   	leave  
801037ad:	c3                   	ret    
801037ae:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
801037b0:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
801037b3:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
801037ba:	00 00 00 
    iinit(ROOTDEV);
801037bd:	6a 01                	push   $0x1
801037bf:	e8 7c dd ff ff       	call   80101540 <iinit>
    initlog(ROOTDEV);
801037c4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801037cb:	e8 f0 f3 ff ff       	call   80102bc0 <initlog>
801037d0:	83 c4 10             	add    $0x10,%esp
}
801037d3:	c9                   	leave  
801037d4:	c3                   	ret    
801037d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801037d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801037e0 <pinit>:
{
801037e0:	55                   	push   %ebp
801037e1:	89 e5                	mov    %esp,%ebp
801037e3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
801037e6:	68 d5 74 10 80       	push   $0x801074d5
801037eb:	68 20 2d 11 80       	push   $0x80112d20
801037f0:	e8 cb 0a 00 00       	call   801042c0 <initlock>
}
801037f5:	83 c4 10             	add    $0x10,%esp
801037f8:	c9                   	leave  
801037f9:	c3                   	ret    
801037fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103800 <mycpu>:
{
80103800:	55                   	push   %ebp
80103801:	89 e5                	mov    %esp,%ebp
80103803:	56                   	push   %esi
80103804:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103805:	9c                   	pushf  
80103806:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103807:	f6 c4 02             	test   $0x2,%ah
8010380a:	75 5e                	jne    8010386a <mycpu+0x6a>
  apicid = lapicid();
8010380c:	e8 df ef ff ff       	call   801027f0 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103811:	8b 35 00 2d 11 80    	mov    0x80112d00,%esi
80103817:	85 f6                	test   %esi,%esi
80103819:	7e 42                	jle    8010385d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
8010381b:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
80103822:	39 d0                	cmp    %edx,%eax
80103824:	74 30                	je     80103856 <mycpu+0x56>
80103826:	b9 30 28 11 80       	mov    $0x80112830,%ecx
  for (i = 0; i < ncpu; ++i) {
8010382b:	31 d2                	xor    %edx,%edx
8010382d:	8d 76 00             	lea    0x0(%esi),%esi
80103830:	83 c2 01             	add    $0x1,%edx
80103833:	39 f2                	cmp    %esi,%edx
80103835:	74 26                	je     8010385d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
80103837:	0f b6 19             	movzbl (%ecx),%ebx
8010383a:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80103840:	39 c3                	cmp    %eax,%ebx
80103842:	75 ec                	jne    80103830 <mycpu+0x30>
80103844:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
8010384a:	05 80 27 11 80       	add    $0x80112780,%eax
}
8010384f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103852:	5b                   	pop    %ebx
80103853:	5e                   	pop    %esi
80103854:	5d                   	pop    %ebp
80103855:	c3                   	ret    
    if (cpus[i].apicid == apicid)
80103856:	b8 80 27 11 80       	mov    $0x80112780,%eax
      return &cpus[i];
8010385b:	eb f2                	jmp    8010384f <mycpu+0x4f>
  panic("unknown apicid\n");
8010385d:	83 ec 0c             	sub    $0xc,%esp
80103860:	68 dc 74 10 80       	push   $0x801074dc
80103865:	e8 26 cb ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
8010386a:	83 ec 0c             	sub    $0xc,%esp
8010386d:	68 b8 75 10 80       	push   $0x801075b8
80103872:	e8 19 cb ff ff       	call   80100390 <panic>
80103877:	89 f6                	mov    %esi,%esi
80103879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103880 <cpuid>:
cpuid() {
80103880:	55                   	push   %ebp
80103881:	89 e5                	mov    %esp,%ebp
80103883:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103886:	e8 75 ff ff ff       	call   80103800 <mycpu>
8010388b:	2d 80 27 11 80       	sub    $0x80112780,%eax
}
80103890:	c9                   	leave  
  return mycpu()-cpus;
80103891:	c1 f8 04             	sar    $0x4,%eax
80103894:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010389a:	c3                   	ret    
8010389b:	90                   	nop
8010389c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801038a0 <myproc>:
myproc(void) {
801038a0:	55                   	push   %ebp
801038a1:	89 e5                	mov    %esp,%ebp
801038a3:	53                   	push   %ebx
801038a4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
801038a7:	e8 84 0a 00 00       	call   80104330 <pushcli>
  c = mycpu();
801038ac:	e8 4f ff ff ff       	call   80103800 <mycpu>
  p = c->proc;
801038b1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801038b7:	e8 b4 0a 00 00       	call   80104370 <popcli>
}
801038bc:	83 c4 04             	add    $0x4,%esp
801038bf:	89 d8                	mov    %ebx,%eax
801038c1:	5b                   	pop    %ebx
801038c2:	5d                   	pop    %ebp
801038c3:	c3                   	ret    
801038c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801038ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801038d0 <userinit>:
{
801038d0:	55                   	push   %ebp
801038d1:	89 e5                	mov    %esp,%ebp
801038d3:	53                   	push   %ebx
801038d4:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
801038d7:	e8 e4 fd ff ff       	call   801036c0 <allocproc>
801038dc:	89 c3                	mov    %eax,%ebx
  initproc = p;
801038de:	a3 b8 a5 10 80       	mov    %eax,0x8010a5b8
  if((p->pgdir = setupkvm()) == 0)
801038e3:	e8 e8 33 00 00       	call   80106cd0 <setupkvm>
801038e8:	85 c0                	test   %eax,%eax
801038ea:	89 43 04             	mov    %eax,0x4(%ebx)
801038ed:	0f 84 bd 00 00 00    	je     801039b0 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801038f3:	83 ec 04             	sub    $0x4,%esp
801038f6:	68 2c 00 00 00       	push   $0x2c
801038fb:	68 60 a4 10 80       	push   $0x8010a460
80103900:	50                   	push   %eax
80103901:	e8 aa 30 00 00       	call   801069b0 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103906:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103909:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
8010390f:	6a 4c                	push   $0x4c
80103911:	6a 00                	push   $0x0
80103913:	ff 73 18             	pushl  0x18(%ebx)
80103916:	e8 f5 0b 00 00       	call   80104510 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010391b:	8b 43 18             	mov    0x18(%ebx),%eax
8010391e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103923:	b9 23 00 00 00       	mov    $0x23,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103928:	83 c4 0c             	add    $0xc,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010392b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010392f:	8b 43 18             	mov    0x18(%ebx),%eax
80103932:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103936:	8b 43 18             	mov    0x18(%ebx),%eax
80103939:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010393d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103941:	8b 43 18             	mov    0x18(%ebx),%eax
80103944:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103948:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010394c:	8b 43 18             	mov    0x18(%ebx),%eax
8010394f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103956:	8b 43 18             	mov    0x18(%ebx),%eax
80103959:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103960:	8b 43 18             	mov    0x18(%ebx),%eax
80103963:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
8010396a:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010396d:	6a 10                	push   $0x10
8010396f:	68 05 75 10 80       	push   $0x80107505
80103974:	50                   	push   %eax
80103975:	e8 76 0d 00 00       	call   801046f0 <safestrcpy>
  p->cwd = namei("/");
8010397a:	c7 04 24 0e 75 10 80 	movl   $0x8010750e,(%esp)
80103981:	e8 1a e6 ff ff       	call   80101fa0 <namei>
80103986:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103989:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103990:	e8 6b 0a 00 00       	call   80104400 <acquire>
  p->state = RUNNABLE;
80103995:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
8010399c:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801039a3:	e8 18 0b 00 00       	call   801044c0 <release>
}
801039a8:	83 c4 10             	add    $0x10,%esp
801039ab:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801039ae:	c9                   	leave  
801039af:	c3                   	ret    
    panic("userinit: out of memory?");
801039b0:	83 ec 0c             	sub    $0xc,%esp
801039b3:	68 ec 74 10 80       	push   $0x801074ec
801039b8:	e8 d3 c9 ff ff       	call   80100390 <panic>
801039bd:	8d 76 00             	lea    0x0(%esi),%esi

801039c0 <growproc>:
{
801039c0:	55                   	push   %ebp
801039c1:	89 e5                	mov    %esp,%ebp
801039c3:	56                   	push   %esi
801039c4:	53                   	push   %ebx
801039c5:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
801039c8:	e8 63 09 00 00       	call   80104330 <pushcli>
  c = mycpu();
801039cd:	e8 2e fe ff ff       	call   80103800 <mycpu>
  p = c->proc;
801039d2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801039d8:	e8 93 09 00 00       	call   80104370 <popcli>
  if(n > 0){
801039dd:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
801039e0:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
801039e2:	7f 1c                	jg     80103a00 <growproc+0x40>
  } else if(n < 0){
801039e4:	75 3a                	jne    80103a20 <growproc+0x60>
  switchuvm(curproc);
801039e6:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
801039e9:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
801039eb:	53                   	push   %ebx
801039ec:	e8 af 2e 00 00       	call   801068a0 <switchuvm>
  return 0;
801039f1:	83 c4 10             	add    $0x10,%esp
801039f4:	31 c0                	xor    %eax,%eax
}
801039f6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801039f9:	5b                   	pop    %ebx
801039fa:	5e                   	pop    %esi
801039fb:	5d                   	pop    %ebp
801039fc:	c3                   	ret    
801039fd:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103a00:	83 ec 04             	sub    $0x4,%esp
80103a03:	01 c6                	add    %eax,%esi
80103a05:	56                   	push   %esi
80103a06:	50                   	push   %eax
80103a07:	ff 73 04             	pushl  0x4(%ebx)
80103a0a:	e8 e1 30 00 00       	call   80106af0 <allocuvm>
80103a0f:	83 c4 10             	add    $0x10,%esp
80103a12:	85 c0                	test   %eax,%eax
80103a14:	75 d0                	jne    801039e6 <growproc+0x26>
      return -1;
80103a16:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103a1b:	eb d9                	jmp    801039f6 <growproc+0x36>
80103a1d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103a20:	83 ec 04             	sub    $0x4,%esp
80103a23:	01 c6                	add    %eax,%esi
80103a25:	56                   	push   %esi
80103a26:	50                   	push   %eax
80103a27:	ff 73 04             	pushl  0x4(%ebx)
80103a2a:	e8 f1 31 00 00       	call   80106c20 <deallocuvm>
80103a2f:	83 c4 10             	add    $0x10,%esp
80103a32:	85 c0                	test   %eax,%eax
80103a34:	75 b0                	jne    801039e6 <growproc+0x26>
80103a36:	eb de                	jmp    80103a16 <growproc+0x56>
80103a38:	90                   	nop
80103a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103a40 <fork>:
{
80103a40:	55                   	push   %ebp
80103a41:	89 e5                	mov    %esp,%ebp
80103a43:	57                   	push   %edi
80103a44:	56                   	push   %esi
80103a45:	53                   	push   %ebx
80103a46:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103a49:	e8 e2 08 00 00       	call   80104330 <pushcli>
  c = mycpu();
80103a4e:	e8 ad fd ff ff       	call   80103800 <mycpu>
  p = c->proc;
80103a53:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103a59:	e8 12 09 00 00       	call   80104370 <popcli>
  if((np = allocproc()) == 0){
80103a5e:	e8 5d fc ff ff       	call   801036c0 <allocproc>
80103a63:	85 c0                	test   %eax,%eax
80103a65:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103a68:	0f 84 b7 00 00 00    	je     80103b25 <fork+0xe5>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103a6e:	83 ec 08             	sub    $0x8,%esp
80103a71:	ff 33                	pushl  (%ebx)
80103a73:	ff 73 04             	pushl  0x4(%ebx)
80103a76:	89 c7                	mov    %eax,%edi
80103a78:	e8 23 33 00 00       	call   80106da0 <copyuvm>
80103a7d:	83 c4 10             	add    $0x10,%esp
80103a80:	85 c0                	test   %eax,%eax
80103a82:	89 47 04             	mov    %eax,0x4(%edi)
80103a85:	0f 84 a1 00 00 00    	je     80103b2c <fork+0xec>
  np->sz = curproc->sz;
80103a8b:	8b 03                	mov    (%ebx),%eax
80103a8d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103a90:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
80103a92:	89 59 14             	mov    %ebx,0x14(%ecx)
80103a95:	89 c8                	mov    %ecx,%eax
  *np->tf = *curproc->tf;
80103a97:	8b 79 18             	mov    0x18(%ecx),%edi
80103a9a:	8b 73 18             	mov    0x18(%ebx),%esi
80103a9d:	b9 13 00 00 00       	mov    $0x13,%ecx
80103aa2:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103aa4:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103aa6:	8b 40 18             	mov    0x18(%eax),%eax
80103aa9:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80103ab0:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103ab4:	85 c0                	test   %eax,%eax
80103ab6:	74 13                	je     80103acb <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103ab8:	83 ec 0c             	sub    $0xc,%esp
80103abb:	50                   	push   %eax
80103abc:	e8 2f d3 ff ff       	call   80100df0 <filedup>
80103ac1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103ac4:	83 c4 10             	add    $0x10,%esp
80103ac7:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103acb:	83 c6 01             	add    $0x1,%esi
80103ace:	83 fe 10             	cmp    $0x10,%esi
80103ad1:	75 dd                	jne    80103ab0 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103ad3:	83 ec 0c             	sub    $0xc,%esp
80103ad6:	ff 73 68             	pushl  0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103ad9:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80103adc:	e8 2f dc ff ff       	call   80101710 <idup>
80103ae1:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103ae4:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103ae7:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103aea:	8d 47 6c             	lea    0x6c(%edi),%eax
80103aed:	6a 10                	push   $0x10
80103aef:	53                   	push   %ebx
80103af0:	50                   	push   %eax
80103af1:	e8 fa 0b 00 00       	call   801046f0 <safestrcpy>
  pid = np->pid;
80103af6:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103af9:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103b00:	e8 fb 08 00 00       	call   80104400 <acquire>
  np->state = RUNNABLE;
80103b05:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103b0c:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103b13:	e8 a8 09 00 00       	call   801044c0 <release>
  return pid;
80103b18:	83 c4 10             	add    $0x10,%esp
}
80103b1b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b1e:	89 d8                	mov    %ebx,%eax
80103b20:	5b                   	pop    %ebx
80103b21:	5e                   	pop    %esi
80103b22:	5f                   	pop    %edi
80103b23:	5d                   	pop    %ebp
80103b24:	c3                   	ret    
    return -1;
80103b25:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103b2a:	eb ef                	jmp    80103b1b <fork+0xdb>
    kfree(np->kstack);
80103b2c:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103b2f:	83 ec 0c             	sub    $0xc,%esp
80103b32:	ff 73 08             	pushl  0x8(%ebx)
80103b35:	e8 96 e8 ff ff       	call   801023d0 <kfree>
    np->kstack = 0;
80103b3a:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    np->state = UNUSED;
80103b41:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103b48:	83 c4 10             	add    $0x10,%esp
80103b4b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103b50:	eb c9                	jmp    80103b1b <fork+0xdb>
80103b52:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103b60 <scheduler>:
{
80103b60:	55                   	push   %ebp
80103b61:	89 e5                	mov    %esp,%ebp
80103b63:	57                   	push   %edi
80103b64:	56                   	push   %esi
80103b65:	53                   	push   %ebx
80103b66:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103b69:	e8 92 fc ff ff       	call   80103800 <mycpu>
80103b6e:	8d 78 04             	lea    0x4(%eax),%edi
80103b71:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103b73:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103b7a:	00 00 00 
80103b7d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80103b80:	fb                   	sti    
    acquire(&ptable.lock);
80103b81:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b84:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
    acquire(&ptable.lock);
80103b89:	68 20 2d 11 80       	push   $0x80112d20
80103b8e:	e8 6d 08 00 00       	call   80104400 <acquire>
80103b93:	83 c4 10             	add    $0x10,%esp
80103b96:	8d 76 00             	lea    0x0(%esi),%esi
80103b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      if(p->state != RUNNABLE)
80103ba0:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103ba4:	75 33                	jne    80103bd9 <scheduler+0x79>
      switchuvm(p);
80103ba6:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103ba9:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103baf:	53                   	push   %ebx
80103bb0:	e8 eb 2c 00 00       	call   801068a0 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103bb5:	58                   	pop    %eax
80103bb6:	5a                   	pop    %edx
80103bb7:	ff 73 1c             	pushl  0x1c(%ebx)
80103bba:	57                   	push   %edi
      p->state = RUNNING;
80103bbb:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103bc2:	e8 84 0b 00 00       	call   8010474b <swtch>
      switchkvm();
80103bc7:	e8 b4 2c 00 00       	call   80106880 <switchkvm>
      c->proc = 0;
80103bcc:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103bd3:	00 00 00 
80103bd6:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103bd9:	83 c3 7c             	add    $0x7c,%ebx
80103bdc:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80103be2:	72 bc                	jb     80103ba0 <scheduler+0x40>
    release(&ptable.lock);
80103be4:	83 ec 0c             	sub    $0xc,%esp
80103be7:	68 20 2d 11 80       	push   $0x80112d20
80103bec:	e8 cf 08 00 00       	call   801044c0 <release>
    sti();
80103bf1:	83 c4 10             	add    $0x10,%esp
80103bf4:	eb 8a                	jmp    80103b80 <scheduler+0x20>
80103bf6:	8d 76 00             	lea    0x0(%esi),%esi
80103bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103c00 <sched>:
{
80103c00:	55                   	push   %ebp
80103c01:	89 e5                	mov    %esp,%ebp
80103c03:	56                   	push   %esi
80103c04:	53                   	push   %ebx
  pushcli();
80103c05:	e8 26 07 00 00       	call   80104330 <pushcli>
  c = mycpu();
80103c0a:	e8 f1 fb ff ff       	call   80103800 <mycpu>
  p = c->proc;
80103c0f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103c15:	e8 56 07 00 00       	call   80104370 <popcli>
  if(!holding(&ptable.lock))
80103c1a:	83 ec 0c             	sub    $0xc,%esp
80103c1d:	68 20 2d 11 80       	push   $0x80112d20
80103c22:	e8 a9 07 00 00       	call   801043d0 <holding>
80103c27:	83 c4 10             	add    $0x10,%esp
80103c2a:	85 c0                	test   %eax,%eax
80103c2c:	74 4f                	je     80103c7d <sched+0x7d>
  if(mycpu()->ncli != 1)
80103c2e:	e8 cd fb ff ff       	call   80103800 <mycpu>
80103c33:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103c3a:	75 68                	jne    80103ca4 <sched+0xa4>
  if(p->state == RUNNING)
80103c3c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103c40:	74 55                	je     80103c97 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103c42:	9c                   	pushf  
80103c43:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103c44:	f6 c4 02             	test   $0x2,%ah
80103c47:	75 41                	jne    80103c8a <sched+0x8a>
  intena = mycpu()->intena;
80103c49:	e8 b2 fb ff ff       	call   80103800 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103c4e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103c51:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103c57:	e8 a4 fb ff ff       	call   80103800 <mycpu>
80103c5c:	83 ec 08             	sub    $0x8,%esp
80103c5f:	ff 70 04             	pushl  0x4(%eax)
80103c62:	53                   	push   %ebx
80103c63:	e8 e3 0a 00 00       	call   8010474b <swtch>
  mycpu()->intena = intena;
80103c68:	e8 93 fb ff ff       	call   80103800 <mycpu>
}
80103c6d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103c70:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103c76:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103c79:	5b                   	pop    %ebx
80103c7a:	5e                   	pop    %esi
80103c7b:	5d                   	pop    %ebp
80103c7c:	c3                   	ret    
    panic("sched ptable.lock");
80103c7d:	83 ec 0c             	sub    $0xc,%esp
80103c80:	68 10 75 10 80       	push   $0x80107510
80103c85:	e8 06 c7 ff ff       	call   80100390 <panic>
    panic("sched interruptible");
80103c8a:	83 ec 0c             	sub    $0xc,%esp
80103c8d:	68 3c 75 10 80       	push   $0x8010753c
80103c92:	e8 f9 c6 ff ff       	call   80100390 <panic>
    panic("sched running");
80103c97:	83 ec 0c             	sub    $0xc,%esp
80103c9a:	68 2e 75 10 80       	push   $0x8010752e
80103c9f:	e8 ec c6 ff ff       	call   80100390 <panic>
    panic("sched locks");
80103ca4:	83 ec 0c             	sub    $0xc,%esp
80103ca7:	68 22 75 10 80       	push   $0x80107522
80103cac:	e8 df c6 ff ff       	call   80100390 <panic>
80103cb1:	eb 0d                	jmp    80103cc0 <exit>
80103cb3:	90                   	nop
80103cb4:	90                   	nop
80103cb5:	90                   	nop
80103cb6:	90                   	nop
80103cb7:	90                   	nop
80103cb8:	90                   	nop
80103cb9:	90                   	nop
80103cba:	90                   	nop
80103cbb:	90                   	nop
80103cbc:	90                   	nop
80103cbd:	90                   	nop
80103cbe:	90                   	nop
80103cbf:	90                   	nop

80103cc0 <exit>:
{
80103cc0:	55                   	push   %ebp
80103cc1:	89 e5                	mov    %esp,%ebp
80103cc3:	57                   	push   %edi
80103cc4:	56                   	push   %esi
80103cc5:	53                   	push   %ebx
80103cc6:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
80103cc9:	e8 62 06 00 00       	call   80104330 <pushcli>
  c = mycpu();
80103cce:	e8 2d fb ff ff       	call   80103800 <mycpu>
  p = c->proc;
80103cd3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103cd9:	e8 92 06 00 00       	call   80104370 <popcli>
  if(curproc == initproc)
80103cde:	39 35 b8 a5 10 80    	cmp    %esi,0x8010a5b8
80103ce4:	8d 5e 28             	lea    0x28(%esi),%ebx
80103ce7:	8d 7e 68             	lea    0x68(%esi),%edi
80103cea:	0f 84 e7 00 00 00    	je     80103dd7 <exit+0x117>
    if(curproc->ofile[fd]){
80103cf0:	8b 03                	mov    (%ebx),%eax
80103cf2:	85 c0                	test   %eax,%eax
80103cf4:	74 12                	je     80103d08 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80103cf6:	83 ec 0c             	sub    $0xc,%esp
80103cf9:	50                   	push   %eax
80103cfa:	e8 41 d1 ff ff       	call   80100e40 <fileclose>
      curproc->ofile[fd] = 0;
80103cff:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103d05:	83 c4 10             	add    $0x10,%esp
80103d08:	83 c3 04             	add    $0x4,%ebx
  for(fd = 0; fd < NOFILE; fd++){
80103d0b:	39 fb                	cmp    %edi,%ebx
80103d0d:	75 e1                	jne    80103cf0 <exit+0x30>
  begin_op();
80103d0f:	e8 4c ef ff ff       	call   80102c60 <begin_op>
  iput(curproc->cwd);
80103d14:	83 ec 0c             	sub    $0xc,%esp
80103d17:	ff 76 68             	pushl  0x68(%esi)
80103d1a:	e8 51 db ff ff       	call   80101870 <iput>
  end_op();
80103d1f:	e8 ac ef ff ff       	call   80102cd0 <end_op>
  curproc->cwd = 0;
80103d24:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
80103d2b:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103d32:	e8 c9 06 00 00       	call   80104400 <acquire>
  wakeup1(curproc->parent);
80103d37:	8b 56 14             	mov    0x14(%esi),%edx
80103d3a:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d3d:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103d42:	eb 0e                	jmp    80103d52 <exit+0x92>
80103d44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103d48:	83 c0 7c             	add    $0x7c,%eax
80103d4b:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80103d50:	73 1c                	jae    80103d6e <exit+0xae>
    if(p->state == SLEEPING && p->chan == chan)
80103d52:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103d56:	75 f0                	jne    80103d48 <exit+0x88>
80103d58:	3b 50 20             	cmp    0x20(%eax),%edx
80103d5b:	75 eb                	jne    80103d48 <exit+0x88>
      p->state = RUNNABLE;
80103d5d:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d64:	83 c0 7c             	add    $0x7c,%eax
80103d67:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80103d6c:	72 e4                	jb     80103d52 <exit+0x92>
      p->parent = initproc;
80103d6e:	8b 0d b8 a5 10 80    	mov    0x8010a5b8,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d74:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
80103d79:	eb 10                	jmp    80103d8b <exit+0xcb>
80103d7b:	90                   	nop
80103d7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103d80:	83 c2 7c             	add    $0x7c,%edx
80103d83:	81 fa 54 4c 11 80    	cmp    $0x80114c54,%edx
80103d89:	73 33                	jae    80103dbe <exit+0xfe>
    if(p->parent == curproc){
80103d8b:	39 72 14             	cmp    %esi,0x14(%edx)
80103d8e:	75 f0                	jne    80103d80 <exit+0xc0>
      if(p->state == ZOMBIE)
80103d90:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103d94:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103d97:	75 e7                	jne    80103d80 <exit+0xc0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d99:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103d9e:	eb 0a                	jmp    80103daa <exit+0xea>
80103da0:	83 c0 7c             	add    $0x7c,%eax
80103da3:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80103da8:	73 d6                	jae    80103d80 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80103daa:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103dae:	75 f0                	jne    80103da0 <exit+0xe0>
80103db0:	3b 48 20             	cmp    0x20(%eax),%ecx
80103db3:	75 eb                	jne    80103da0 <exit+0xe0>
      p->state = RUNNABLE;
80103db5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103dbc:	eb e2                	jmp    80103da0 <exit+0xe0>
  curproc->state = ZOMBIE;
80103dbe:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103dc5:	e8 36 fe ff ff       	call   80103c00 <sched>
  panic("zombie exit");
80103dca:	83 ec 0c             	sub    $0xc,%esp
80103dcd:	68 5d 75 10 80       	push   $0x8010755d
80103dd2:	e8 b9 c5 ff ff       	call   80100390 <panic>
    panic("init exiting");
80103dd7:	83 ec 0c             	sub    $0xc,%esp
80103dda:	68 50 75 10 80       	push   $0x80107550
80103ddf:	e8 ac c5 ff ff       	call   80100390 <panic>
80103de4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103dea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103df0 <yield>:
{
80103df0:	55                   	push   %ebp
80103df1:	89 e5                	mov    %esp,%ebp
80103df3:	53                   	push   %ebx
80103df4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103df7:	68 20 2d 11 80       	push   $0x80112d20
80103dfc:	e8 ff 05 00 00       	call   80104400 <acquire>
  pushcli();
80103e01:	e8 2a 05 00 00       	call   80104330 <pushcli>
  c = mycpu();
80103e06:	e8 f5 f9 ff ff       	call   80103800 <mycpu>
  p = c->proc;
80103e0b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e11:	e8 5a 05 00 00       	call   80104370 <popcli>
  myproc()->state = RUNNABLE;
80103e16:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103e1d:	e8 de fd ff ff       	call   80103c00 <sched>
  release(&ptable.lock);
80103e22:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103e29:	e8 92 06 00 00       	call   801044c0 <release>
}
80103e2e:	83 c4 10             	add    $0x10,%esp
80103e31:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103e34:	c9                   	leave  
80103e35:	c3                   	ret    
80103e36:	8d 76 00             	lea    0x0(%esi),%esi
80103e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103e40 <sleep>:
{
80103e40:	55                   	push   %ebp
80103e41:	89 e5                	mov    %esp,%ebp
80103e43:	57                   	push   %edi
80103e44:	56                   	push   %esi
80103e45:	53                   	push   %ebx
80103e46:	83 ec 0c             	sub    $0xc,%esp
80103e49:	8b 7d 08             	mov    0x8(%ebp),%edi
80103e4c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80103e4f:	e8 dc 04 00 00       	call   80104330 <pushcli>
  c = mycpu();
80103e54:	e8 a7 f9 ff ff       	call   80103800 <mycpu>
  p = c->proc;
80103e59:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e5f:	e8 0c 05 00 00       	call   80104370 <popcli>
  if(p == 0)
80103e64:	85 db                	test   %ebx,%ebx
80103e66:	0f 84 87 00 00 00    	je     80103ef3 <sleep+0xb3>
  if(lk == 0)
80103e6c:	85 f6                	test   %esi,%esi
80103e6e:	74 76                	je     80103ee6 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103e70:	81 fe 20 2d 11 80    	cmp    $0x80112d20,%esi
80103e76:	74 50                	je     80103ec8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103e78:	83 ec 0c             	sub    $0xc,%esp
80103e7b:	68 20 2d 11 80       	push   $0x80112d20
80103e80:	e8 7b 05 00 00       	call   80104400 <acquire>
    release(lk);
80103e85:	89 34 24             	mov    %esi,(%esp)
80103e88:	e8 33 06 00 00       	call   801044c0 <release>
  p->chan = chan;
80103e8d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103e90:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103e97:	e8 64 fd ff ff       	call   80103c00 <sched>
  p->chan = 0;
80103e9c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80103ea3:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103eaa:	e8 11 06 00 00       	call   801044c0 <release>
    acquire(lk);
80103eaf:	89 75 08             	mov    %esi,0x8(%ebp)
80103eb2:	83 c4 10             	add    $0x10,%esp
}
80103eb5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103eb8:	5b                   	pop    %ebx
80103eb9:	5e                   	pop    %esi
80103eba:	5f                   	pop    %edi
80103ebb:	5d                   	pop    %ebp
    acquire(lk);
80103ebc:	e9 3f 05 00 00       	jmp    80104400 <acquire>
80103ec1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80103ec8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103ecb:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103ed2:	e8 29 fd ff ff       	call   80103c00 <sched>
  p->chan = 0;
80103ed7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80103ede:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103ee1:	5b                   	pop    %ebx
80103ee2:	5e                   	pop    %esi
80103ee3:	5f                   	pop    %edi
80103ee4:	5d                   	pop    %ebp
80103ee5:	c3                   	ret    
    panic("sleep without lk");
80103ee6:	83 ec 0c             	sub    $0xc,%esp
80103ee9:	68 6f 75 10 80       	push   $0x8010756f
80103eee:	e8 9d c4 ff ff       	call   80100390 <panic>
    panic("sleep");
80103ef3:	83 ec 0c             	sub    $0xc,%esp
80103ef6:	68 69 75 10 80       	push   $0x80107569
80103efb:	e8 90 c4 ff ff       	call   80100390 <panic>

80103f00 <wait>:
{
80103f00:	55                   	push   %ebp
80103f01:	89 e5                	mov    %esp,%ebp
80103f03:	56                   	push   %esi
80103f04:	53                   	push   %ebx
  pushcli();
80103f05:	e8 26 04 00 00       	call   80104330 <pushcli>
  c = mycpu();
80103f0a:	e8 f1 f8 ff ff       	call   80103800 <mycpu>
  p = c->proc;
80103f0f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103f15:	e8 56 04 00 00       	call   80104370 <popcli>
  acquire(&ptable.lock);
80103f1a:	83 ec 0c             	sub    $0xc,%esp
80103f1d:	68 20 2d 11 80       	push   $0x80112d20
80103f22:	e8 d9 04 00 00       	call   80104400 <acquire>
80103f27:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80103f2a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f2c:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
80103f31:	eb 10                	jmp    80103f43 <wait+0x43>
80103f33:	90                   	nop
80103f34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f38:	83 c3 7c             	add    $0x7c,%ebx
80103f3b:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80103f41:	73 1b                	jae    80103f5e <wait+0x5e>
      if(p->parent != curproc)
80103f43:	39 73 14             	cmp    %esi,0x14(%ebx)
80103f46:	75 f0                	jne    80103f38 <wait+0x38>
      if(p->state == ZOMBIE){
80103f48:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103f4c:	74 32                	je     80103f80 <wait+0x80>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f4e:	83 c3 7c             	add    $0x7c,%ebx
      havekids = 1;
80103f51:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f56:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80103f5c:	72 e5                	jb     80103f43 <wait+0x43>
    if(!havekids || curproc->killed){
80103f5e:	85 c0                	test   %eax,%eax
80103f60:	74 74                	je     80103fd6 <wait+0xd6>
80103f62:	8b 46 24             	mov    0x24(%esi),%eax
80103f65:	85 c0                	test   %eax,%eax
80103f67:	75 6d                	jne    80103fd6 <wait+0xd6>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80103f69:	83 ec 08             	sub    $0x8,%esp
80103f6c:	68 20 2d 11 80       	push   $0x80112d20
80103f71:	56                   	push   %esi
80103f72:	e8 c9 fe ff ff       	call   80103e40 <sleep>
    havekids = 0;
80103f77:	83 c4 10             	add    $0x10,%esp
80103f7a:	eb ae                	jmp    80103f2a <wait+0x2a>
80103f7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        kfree(p->kstack);
80103f80:	83 ec 0c             	sub    $0xc,%esp
80103f83:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
80103f86:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103f89:	e8 42 e4 ff ff       	call   801023d0 <kfree>
        freevm(p->pgdir);
80103f8e:	5a                   	pop    %edx
80103f8f:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
80103f92:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103f99:	e8 b2 2c 00 00       	call   80106c50 <freevm>
        release(&ptable.lock);
80103f9e:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
        p->pid = 0;
80103fa5:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103fac:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103fb3:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103fb7:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103fbe:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80103fc5:	e8 f6 04 00 00       	call   801044c0 <release>
        return pid;
80103fca:	83 c4 10             	add    $0x10,%esp
}
80103fcd:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103fd0:	89 f0                	mov    %esi,%eax
80103fd2:	5b                   	pop    %ebx
80103fd3:	5e                   	pop    %esi
80103fd4:	5d                   	pop    %ebp
80103fd5:	c3                   	ret    
      release(&ptable.lock);
80103fd6:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103fd9:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80103fde:	68 20 2d 11 80       	push   $0x80112d20
80103fe3:	e8 d8 04 00 00       	call   801044c0 <release>
      return -1;
80103fe8:	83 c4 10             	add    $0x10,%esp
80103feb:	eb e0                	jmp    80103fcd <wait+0xcd>
80103fed:	8d 76 00             	lea    0x0(%esi),%esi

80103ff0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80103ff0:	55                   	push   %ebp
80103ff1:	89 e5                	mov    %esp,%ebp
80103ff3:	53                   	push   %ebx
80103ff4:	83 ec 10             	sub    $0x10,%esp
80103ff7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80103ffa:	68 20 2d 11 80       	push   $0x80112d20
80103fff:	e8 fc 03 00 00       	call   80104400 <acquire>
80104004:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104007:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010400c:	eb 0c                	jmp    8010401a <wakeup+0x2a>
8010400e:	66 90                	xchg   %ax,%ax
80104010:	83 c0 7c             	add    $0x7c,%eax
80104013:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80104018:	73 1c                	jae    80104036 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
8010401a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010401e:	75 f0                	jne    80104010 <wakeup+0x20>
80104020:	3b 58 20             	cmp    0x20(%eax),%ebx
80104023:	75 eb                	jne    80104010 <wakeup+0x20>
      p->state = RUNNABLE;
80104025:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010402c:	83 c0 7c             	add    $0x7c,%eax
8010402f:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80104034:	72 e4                	jb     8010401a <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
80104036:	c7 45 08 20 2d 11 80 	movl   $0x80112d20,0x8(%ebp)
}
8010403d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104040:	c9                   	leave  
  release(&ptable.lock);
80104041:	e9 7a 04 00 00       	jmp    801044c0 <release>
80104046:	8d 76 00             	lea    0x0(%esi),%esi
80104049:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104050 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104050:	55                   	push   %ebp
80104051:	89 e5                	mov    %esp,%ebp
80104053:	53                   	push   %ebx
80104054:	83 ec 10             	sub    $0x10,%esp
80104057:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010405a:	68 20 2d 11 80       	push   $0x80112d20
8010405f:	e8 9c 03 00 00       	call   80104400 <acquire>
80104064:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104067:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010406c:	eb 0c                	jmp    8010407a <kill+0x2a>
8010406e:	66 90                	xchg   %ax,%ax
80104070:	83 c0 7c             	add    $0x7c,%eax
80104073:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80104078:	73 36                	jae    801040b0 <kill+0x60>
    if(p->pid == pid){
8010407a:	39 58 10             	cmp    %ebx,0x10(%eax)
8010407d:	75 f1                	jne    80104070 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010407f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104083:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
8010408a:	75 07                	jne    80104093 <kill+0x43>
        p->state = RUNNABLE;
8010408c:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104093:	83 ec 0c             	sub    $0xc,%esp
80104096:	68 20 2d 11 80       	push   $0x80112d20
8010409b:	e8 20 04 00 00       	call   801044c0 <release>
      return 0;
801040a0:	83 c4 10             	add    $0x10,%esp
801040a3:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
801040a5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040a8:	c9                   	leave  
801040a9:	c3                   	ret    
801040aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
801040b0:	83 ec 0c             	sub    $0xc,%esp
801040b3:	68 20 2d 11 80       	push   $0x80112d20
801040b8:	e8 03 04 00 00       	call   801044c0 <release>
  return -1;
801040bd:	83 c4 10             	add    $0x10,%esp
801040c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801040c5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040c8:	c9                   	leave  
801040c9:	c3                   	ret    
801040ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801040d0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801040d0:	55                   	push   %ebp
801040d1:	89 e5                	mov    %esp,%ebp
801040d3:	57                   	push   %edi
801040d4:	56                   	push   %esi
801040d5:	53                   	push   %ebx
801040d6:	8d 75 e8             	lea    -0x18(%ebp),%esi
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040d9:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
{
801040de:	83 ec 3c             	sub    $0x3c,%esp
801040e1:	eb 24                	jmp    80104107 <procdump+0x37>
801040e3:	90                   	nop
801040e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801040e8:	83 ec 0c             	sub    $0xc,%esp
801040eb:	68 f7 78 10 80       	push   $0x801078f7
801040f0:	e8 6b c5 ff ff       	call   80100660 <cprintf>
801040f5:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040f8:	83 c3 7c             	add    $0x7c,%ebx
801040fb:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80104101:	0f 83 81 00 00 00    	jae    80104188 <procdump+0xb8>
    if(p->state == UNUSED)
80104107:	8b 43 0c             	mov    0xc(%ebx),%eax
8010410a:	85 c0                	test   %eax,%eax
8010410c:	74 ea                	je     801040f8 <procdump+0x28>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010410e:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
80104111:	ba 80 75 10 80       	mov    $0x80107580,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104116:	77 11                	ja     80104129 <procdump+0x59>
80104118:	8b 14 85 e0 75 10 80 	mov    -0x7fef8a20(,%eax,4),%edx
      state = "???";
8010411f:	b8 80 75 10 80       	mov    $0x80107580,%eax
80104124:	85 d2                	test   %edx,%edx
80104126:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104129:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010412c:	50                   	push   %eax
8010412d:	52                   	push   %edx
8010412e:	ff 73 10             	pushl  0x10(%ebx)
80104131:	68 84 75 10 80       	push   $0x80107584
80104136:	e8 25 c5 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
8010413b:	83 c4 10             	add    $0x10,%esp
8010413e:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
80104142:	75 a4                	jne    801040e8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104144:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104147:	83 ec 08             	sub    $0x8,%esp
8010414a:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010414d:	50                   	push   %eax
8010414e:	8b 43 1c             	mov    0x1c(%ebx),%eax
80104151:	8b 40 0c             	mov    0xc(%eax),%eax
80104154:	83 c0 08             	add    $0x8,%eax
80104157:	50                   	push   %eax
80104158:	e8 83 01 00 00       	call   801042e0 <getcallerpcs>
8010415d:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80104160:	8b 17                	mov    (%edi),%edx
80104162:	85 d2                	test   %edx,%edx
80104164:	74 82                	je     801040e8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104166:	83 ec 08             	sub    $0x8,%esp
80104169:	83 c7 04             	add    $0x4,%edi
8010416c:	52                   	push   %edx
8010416d:	68 c1 6f 10 80       	push   $0x80106fc1
80104172:	e8 e9 c4 ff ff       	call   80100660 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104177:	83 c4 10             	add    $0x10,%esp
8010417a:	39 fe                	cmp    %edi,%esi
8010417c:	75 e2                	jne    80104160 <procdump+0x90>
8010417e:	e9 65 ff ff ff       	jmp    801040e8 <procdump+0x18>
80104183:	90                   	nop
80104184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
}
80104188:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010418b:	5b                   	pop    %ebx
8010418c:	5e                   	pop    %esi
8010418d:	5f                   	pop    %edi
8010418e:	5d                   	pop    %ebp
8010418f:	c3                   	ret    

80104190 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104190:	55                   	push   %ebp
80104191:	89 e5                	mov    %esp,%ebp
80104193:	53                   	push   %ebx
80104194:	83 ec 0c             	sub    $0xc,%esp
80104197:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010419a:	68 f8 75 10 80       	push   $0x801075f8
8010419f:	8d 43 04             	lea    0x4(%ebx),%eax
801041a2:	50                   	push   %eax
801041a3:	e8 18 01 00 00       	call   801042c0 <initlock>
  lk->name = name;
801041a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801041ab:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
801041b1:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
801041b4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
801041bb:	89 43 38             	mov    %eax,0x38(%ebx)
}
801041be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801041c1:	c9                   	leave  
801041c2:	c3                   	ret    
801041c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801041c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801041d0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801041d0:	55                   	push   %ebp
801041d1:	89 e5                	mov    %esp,%ebp
801041d3:	56                   	push   %esi
801041d4:	53                   	push   %ebx
801041d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801041d8:	83 ec 0c             	sub    $0xc,%esp
801041db:	8d 73 04             	lea    0x4(%ebx),%esi
801041de:	56                   	push   %esi
801041df:	e8 1c 02 00 00       	call   80104400 <acquire>
  while (lk->locked) {
801041e4:	8b 13                	mov    (%ebx),%edx
801041e6:	83 c4 10             	add    $0x10,%esp
801041e9:	85 d2                	test   %edx,%edx
801041eb:	74 16                	je     80104203 <acquiresleep+0x33>
801041ed:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
801041f0:	83 ec 08             	sub    $0x8,%esp
801041f3:	56                   	push   %esi
801041f4:	53                   	push   %ebx
801041f5:	e8 46 fc ff ff       	call   80103e40 <sleep>
  while (lk->locked) {
801041fa:	8b 03                	mov    (%ebx),%eax
801041fc:	83 c4 10             	add    $0x10,%esp
801041ff:	85 c0                	test   %eax,%eax
80104201:	75 ed                	jne    801041f0 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104203:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104209:	e8 92 f6 ff ff       	call   801038a0 <myproc>
8010420e:	8b 40 10             	mov    0x10(%eax),%eax
80104211:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104214:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104217:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010421a:	5b                   	pop    %ebx
8010421b:	5e                   	pop    %esi
8010421c:	5d                   	pop    %ebp
  release(&lk->lk);
8010421d:	e9 9e 02 00 00       	jmp    801044c0 <release>
80104222:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104230 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104230:	55                   	push   %ebp
80104231:	89 e5                	mov    %esp,%ebp
80104233:	56                   	push   %esi
80104234:	53                   	push   %ebx
80104235:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104238:	83 ec 0c             	sub    $0xc,%esp
8010423b:	8d 73 04             	lea    0x4(%ebx),%esi
8010423e:	56                   	push   %esi
8010423f:	e8 bc 01 00 00       	call   80104400 <acquire>
  lk->locked = 0;
80104244:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010424a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104251:	89 1c 24             	mov    %ebx,(%esp)
80104254:	e8 97 fd ff ff       	call   80103ff0 <wakeup>
  release(&lk->lk);
80104259:	89 75 08             	mov    %esi,0x8(%ebp)
8010425c:	83 c4 10             	add    $0x10,%esp
}
8010425f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104262:	5b                   	pop    %ebx
80104263:	5e                   	pop    %esi
80104264:	5d                   	pop    %ebp
  release(&lk->lk);
80104265:	e9 56 02 00 00       	jmp    801044c0 <release>
8010426a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104270 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104270:	55                   	push   %ebp
80104271:	89 e5                	mov    %esp,%ebp
80104273:	57                   	push   %edi
80104274:	56                   	push   %esi
80104275:	53                   	push   %ebx
80104276:	31 ff                	xor    %edi,%edi
80104278:	83 ec 18             	sub    $0x18,%esp
8010427b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010427e:	8d 73 04             	lea    0x4(%ebx),%esi
80104281:	56                   	push   %esi
80104282:	e8 79 01 00 00       	call   80104400 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104287:	8b 03                	mov    (%ebx),%eax
80104289:	83 c4 10             	add    $0x10,%esp
8010428c:	85 c0                	test   %eax,%eax
8010428e:	74 13                	je     801042a3 <holdingsleep+0x33>
80104290:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104293:	e8 08 f6 ff ff       	call   801038a0 <myproc>
80104298:	39 58 10             	cmp    %ebx,0x10(%eax)
8010429b:	0f 94 c0             	sete   %al
8010429e:	0f b6 c0             	movzbl %al,%eax
801042a1:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
801042a3:	83 ec 0c             	sub    $0xc,%esp
801042a6:	56                   	push   %esi
801042a7:	e8 14 02 00 00       	call   801044c0 <release>
  return r;
}
801042ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
801042af:	89 f8                	mov    %edi,%eax
801042b1:	5b                   	pop    %ebx
801042b2:	5e                   	pop    %esi
801042b3:	5f                   	pop    %edi
801042b4:	5d                   	pop    %ebp
801042b5:	c3                   	ret    
801042b6:	66 90                	xchg   %ax,%ax
801042b8:	66 90                	xchg   %ax,%ax
801042ba:	66 90                	xchg   %ax,%ax
801042bc:	66 90                	xchg   %ax,%ax
801042be:	66 90                	xchg   %ax,%ax

801042c0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801042c0:	55                   	push   %ebp
801042c1:	89 e5                	mov    %esp,%ebp
801042c3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801042c6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801042c9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
801042cf:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
801042d2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801042d9:	5d                   	pop    %ebp
801042da:	c3                   	ret    
801042db:	90                   	nop
801042dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801042e0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801042e0:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801042e1:	31 d2                	xor    %edx,%edx
{
801042e3:	89 e5                	mov    %esp,%ebp
801042e5:	53                   	push   %ebx
  ebp = (uint*)v - 2;
801042e6:	8b 45 08             	mov    0x8(%ebp),%eax
{
801042e9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
801042ec:	83 e8 08             	sub    $0x8,%eax
801042ef:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801042f0:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
801042f6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801042fc:	77 1a                	ja     80104318 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
801042fe:	8b 58 04             	mov    0x4(%eax),%ebx
80104301:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104304:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104307:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104309:	83 fa 0a             	cmp    $0xa,%edx
8010430c:	75 e2                	jne    801042f0 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010430e:	5b                   	pop    %ebx
8010430f:	5d                   	pop    %ebp
80104310:	c3                   	ret    
80104311:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104318:	8d 04 91             	lea    (%ecx,%edx,4),%eax
8010431b:	83 c1 28             	add    $0x28,%ecx
8010431e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104320:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104326:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104329:	39 c1                	cmp    %eax,%ecx
8010432b:	75 f3                	jne    80104320 <getcallerpcs+0x40>
}
8010432d:	5b                   	pop    %ebx
8010432e:	5d                   	pop    %ebp
8010432f:	c3                   	ret    

80104330 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104330:	55                   	push   %ebp
80104331:	89 e5                	mov    %esp,%ebp
80104333:	53                   	push   %ebx
80104334:	83 ec 04             	sub    $0x4,%esp
80104337:	9c                   	pushf  
80104338:	5b                   	pop    %ebx
  asm volatile("cli");
80104339:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010433a:	e8 c1 f4 ff ff       	call   80103800 <mycpu>
8010433f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104345:	85 c0                	test   %eax,%eax
80104347:	75 11                	jne    8010435a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80104349:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010434f:	e8 ac f4 ff ff       	call   80103800 <mycpu>
80104354:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
8010435a:	e8 a1 f4 ff ff       	call   80103800 <mycpu>
8010435f:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104366:	83 c4 04             	add    $0x4,%esp
80104369:	5b                   	pop    %ebx
8010436a:	5d                   	pop    %ebp
8010436b:	c3                   	ret    
8010436c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104370 <popcli>:

void
popcli(void)
{
80104370:	55                   	push   %ebp
80104371:	89 e5                	mov    %esp,%ebp
80104373:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104376:	9c                   	pushf  
80104377:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104378:	f6 c4 02             	test   $0x2,%ah
8010437b:	75 35                	jne    801043b2 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010437d:	e8 7e f4 ff ff       	call   80103800 <mycpu>
80104382:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104389:	78 34                	js     801043bf <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010438b:	e8 70 f4 ff ff       	call   80103800 <mycpu>
80104390:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104396:	85 d2                	test   %edx,%edx
80104398:	74 06                	je     801043a0 <popcli+0x30>
    sti();
}
8010439a:	c9                   	leave  
8010439b:	c3                   	ret    
8010439c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
801043a0:	e8 5b f4 ff ff       	call   80103800 <mycpu>
801043a5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801043ab:	85 c0                	test   %eax,%eax
801043ad:	74 eb                	je     8010439a <popcli+0x2a>
  asm volatile("sti");
801043af:	fb                   	sti    
}
801043b0:	c9                   	leave  
801043b1:	c3                   	ret    
    panic("popcli - interruptible");
801043b2:	83 ec 0c             	sub    $0xc,%esp
801043b5:	68 03 76 10 80       	push   $0x80107603
801043ba:	e8 d1 bf ff ff       	call   80100390 <panic>
    panic("popcli");
801043bf:	83 ec 0c             	sub    $0xc,%esp
801043c2:	68 1a 76 10 80       	push   $0x8010761a
801043c7:	e8 c4 bf ff ff       	call   80100390 <panic>
801043cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801043d0 <holding>:
{
801043d0:	55                   	push   %ebp
801043d1:	89 e5                	mov    %esp,%ebp
801043d3:	56                   	push   %esi
801043d4:	53                   	push   %ebx
801043d5:	8b 75 08             	mov    0x8(%ebp),%esi
801043d8:	31 db                	xor    %ebx,%ebx
  pushcli();
801043da:	e8 51 ff ff ff       	call   80104330 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801043df:	8b 06                	mov    (%esi),%eax
801043e1:	85 c0                	test   %eax,%eax
801043e3:	74 10                	je     801043f5 <holding+0x25>
801043e5:	8b 5e 08             	mov    0x8(%esi),%ebx
801043e8:	e8 13 f4 ff ff       	call   80103800 <mycpu>
801043ed:	39 c3                	cmp    %eax,%ebx
801043ef:	0f 94 c3             	sete   %bl
801043f2:	0f b6 db             	movzbl %bl,%ebx
  popcli();
801043f5:	e8 76 ff ff ff       	call   80104370 <popcli>
}
801043fa:	89 d8                	mov    %ebx,%eax
801043fc:	5b                   	pop    %ebx
801043fd:	5e                   	pop    %esi
801043fe:	5d                   	pop    %ebp
801043ff:	c3                   	ret    

80104400 <acquire>:
{
80104400:	55                   	push   %ebp
80104401:	89 e5                	mov    %esp,%ebp
80104403:	56                   	push   %esi
80104404:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104405:	e8 26 ff ff ff       	call   80104330 <pushcli>
  if(holding(lk))
8010440a:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010440d:	83 ec 0c             	sub    $0xc,%esp
80104410:	53                   	push   %ebx
80104411:	e8 ba ff ff ff       	call   801043d0 <holding>
80104416:	83 c4 10             	add    $0x10,%esp
80104419:	85 c0                	test   %eax,%eax
8010441b:	0f 85 83 00 00 00    	jne    801044a4 <acquire+0xa4>
80104421:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80104423:	ba 01 00 00 00       	mov    $0x1,%edx
80104428:	eb 09                	jmp    80104433 <acquire+0x33>
8010442a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104430:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104433:	89 d0                	mov    %edx,%eax
80104435:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80104438:	85 c0                	test   %eax,%eax
8010443a:	75 f4                	jne    80104430 <acquire+0x30>
  __sync_synchronize();
8010443c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104441:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104444:	e8 b7 f3 ff ff       	call   80103800 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80104449:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
8010444c:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
8010444f:	89 e8                	mov    %ebp,%eax
80104451:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104458:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
8010445e:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
80104464:	77 1a                	ja     80104480 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
80104466:	8b 48 04             	mov    0x4(%eax),%ecx
80104469:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
8010446c:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
8010446f:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104471:	83 fe 0a             	cmp    $0xa,%esi
80104474:	75 e2                	jne    80104458 <acquire+0x58>
}
80104476:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104479:	5b                   	pop    %ebx
8010447a:	5e                   	pop    %esi
8010447b:	5d                   	pop    %ebp
8010447c:	c3                   	ret    
8010447d:	8d 76 00             	lea    0x0(%esi),%esi
80104480:	8d 04 b2             	lea    (%edx,%esi,4),%eax
80104483:	83 c2 28             	add    $0x28,%edx
80104486:	8d 76 00             	lea    0x0(%esi),%esi
80104489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
80104490:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104496:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104499:	39 d0                	cmp    %edx,%eax
8010449b:	75 f3                	jne    80104490 <acquire+0x90>
}
8010449d:	8d 65 f8             	lea    -0x8(%ebp),%esp
801044a0:	5b                   	pop    %ebx
801044a1:	5e                   	pop    %esi
801044a2:	5d                   	pop    %ebp
801044a3:	c3                   	ret    
    panic("acquire");
801044a4:	83 ec 0c             	sub    $0xc,%esp
801044a7:	68 21 76 10 80       	push   $0x80107621
801044ac:	e8 df be ff ff       	call   80100390 <panic>
801044b1:	eb 0d                	jmp    801044c0 <release>
801044b3:	90                   	nop
801044b4:	90                   	nop
801044b5:	90                   	nop
801044b6:	90                   	nop
801044b7:	90                   	nop
801044b8:	90                   	nop
801044b9:	90                   	nop
801044ba:	90                   	nop
801044bb:	90                   	nop
801044bc:	90                   	nop
801044bd:	90                   	nop
801044be:	90                   	nop
801044bf:	90                   	nop

801044c0 <release>:
{
801044c0:	55                   	push   %ebp
801044c1:	89 e5                	mov    %esp,%ebp
801044c3:	53                   	push   %ebx
801044c4:	83 ec 10             	sub    $0x10,%esp
801044c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
801044ca:	53                   	push   %ebx
801044cb:	e8 00 ff ff ff       	call   801043d0 <holding>
801044d0:	83 c4 10             	add    $0x10,%esp
801044d3:	85 c0                	test   %eax,%eax
801044d5:	74 22                	je     801044f9 <release+0x39>
  lk->pcs[0] = 0;
801044d7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
801044de:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
801044e5:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
801044ea:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
801044f0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801044f3:	c9                   	leave  
  popcli();
801044f4:	e9 77 fe ff ff       	jmp    80104370 <popcli>
    panic("release");
801044f9:	83 ec 0c             	sub    $0xc,%esp
801044fc:	68 29 76 10 80       	push   $0x80107629
80104501:	e8 8a be ff ff       	call   80100390 <panic>
80104506:	66 90                	xchg   %ax,%ax
80104508:	66 90                	xchg   %ax,%ax
8010450a:	66 90                	xchg   %ax,%ax
8010450c:	66 90                	xchg   %ax,%ax
8010450e:	66 90                	xchg   %ax,%ax

80104510 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104510:	55                   	push   %ebp
80104511:	89 e5                	mov    %esp,%ebp
80104513:	57                   	push   %edi
80104514:	53                   	push   %ebx
80104515:	8b 55 08             	mov    0x8(%ebp),%edx
80104518:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
8010451b:	f6 c2 03             	test   $0x3,%dl
8010451e:	75 05                	jne    80104525 <memset+0x15>
80104520:	f6 c1 03             	test   $0x3,%cl
80104523:	74 13                	je     80104538 <memset+0x28>
  asm volatile("cld; rep stosb" :
80104525:	89 d7                	mov    %edx,%edi
80104527:	8b 45 0c             	mov    0xc(%ebp),%eax
8010452a:	fc                   	cld    
8010452b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
8010452d:	5b                   	pop    %ebx
8010452e:	89 d0                	mov    %edx,%eax
80104530:	5f                   	pop    %edi
80104531:	5d                   	pop    %ebp
80104532:	c3                   	ret    
80104533:	90                   	nop
80104534:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
80104538:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
8010453c:	c1 e9 02             	shr    $0x2,%ecx
8010453f:	89 f8                	mov    %edi,%eax
80104541:	89 fb                	mov    %edi,%ebx
80104543:	c1 e0 18             	shl    $0x18,%eax
80104546:	c1 e3 10             	shl    $0x10,%ebx
80104549:	09 d8                	or     %ebx,%eax
8010454b:	09 f8                	or     %edi,%eax
8010454d:	c1 e7 08             	shl    $0x8,%edi
80104550:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80104552:	89 d7                	mov    %edx,%edi
80104554:	fc                   	cld    
80104555:	f3 ab                	rep stos %eax,%es:(%edi)
}
80104557:	5b                   	pop    %ebx
80104558:	89 d0                	mov    %edx,%eax
8010455a:	5f                   	pop    %edi
8010455b:	5d                   	pop    %ebp
8010455c:	c3                   	ret    
8010455d:	8d 76 00             	lea    0x0(%esi),%esi

80104560 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104560:	55                   	push   %ebp
80104561:	89 e5                	mov    %esp,%ebp
80104563:	57                   	push   %edi
80104564:	56                   	push   %esi
80104565:	53                   	push   %ebx
80104566:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104569:	8b 75 08             	mov    0x8(%ebp),%esi
8010456c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010456f:	85 db                	test   %ebx,%ebx
80104571:	74 29                	je     8010459c <memcmp+0x3c>
    if(*s1 != *s2)
80104573:	0f b6 16             	movzbl (%esi),%edx
80104576:	0f b6 0f             	movzbl (%edi),%ecx
80104579:	38 d1                	cmp    %dl,%cl
8010457b:	75 2b                	jne    801045a8 <memcmp+0x48>
8010457d:	b8 01 00 00 00       	mov    $0x1,%eax
80104582:	eb 14                	jmp    80104598 <memcmp+0x38>
80104584:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104588:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
8010458c:	83 c0 01             	add    $0x1,%eax
8010458f:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80104594:	38 ca                	cmp    %cl,%dl
80104596:	75 10                	jne    801045a8 <memcmp+0x48>
  while(n-- > 0){
80104598:	39 d8                	cmp    %ebx,%eax
8010459a:	75 ec                	jne    80104588 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
8010459c:	5b                   	pop    %ebx
  return 0;
8010459d:	31 c0                	xor    %eax,%eax
}
8010459f:	5e                   	pop    %esi
801045a0:	5f                   	pop    %edi
801045a1:	5d                   	pop    %ebp
801045a2:	c3                   	ret    
801045a3:	90                   	nop
801045a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
801045a8:	0f b6 c2             	movzbl %dl,%eax
}
801045ab:	5b                   	pop    %ebx
      return *s1 - *s2;
801045ac:	29 c8                	sub    %ecx,%eax
}
801045ae:	5e                   	pop    %esi
801045af:	5f                   	pop    %edi
801045b0:	5d                   	pop    %ebp
801045b1:	c3                   	ret    
801045b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801045c0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
801045c0:	55                   	push   %ebp
801045c1:	89 e5                	mov    %esp,%ebp
801045c3:	56                   	push   %esi
801045c4:	53                   	push   %ebx
801045c5:	8b 45 08             	mov    0x8(%ebp),%eax
801045c8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801045cb:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
801045ce:	39 c3                	cmp    %eax,%ebx
801045d0:	73 26                	jae    801045f8 <memmove+0x38>
801045d2:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
801045d5:	39 c8                	cmp    %ecx,%eax
801045d7:	73 1f                	jae    801045f8 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
801045d9:	85 f6                	test   %esi,%esi
801045db:	8d 56 ff             	lea    -0x1(%esi),%edx
801045de:	74 0f                	je     801045ef <memmove+0x2f>
      *--d = *--s;
801045e0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
801045e4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
801045e7:	83 ea 01             	sub    $0x1,%edx
801045ea:	83 fa ff             	cmp    $0xffffffff,%edx
801045ed:	75 f1                	jne    801045e0 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
801045ef:	5b                   	pop    %ebx
801045f0:	5e                   	pop    %esi
801045f1:	5d                   	pop    %ebp
801045f2:	c3                   	ret    
801045f3:	90                   	nop
801045f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
801045f8:	31 d2                	xor    %edx,%edx
801045fa:	85 f6                	test   %esi,%esi
801045fc:	74 f1                	je     801045ef <memmove+0x2f>
801045fe:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80104600:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104604:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104607:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
8010460a:	39 d6                	cmp    %edx,%esi
8010460c:	75 f2                	jne    80104600 <memmove+0x40>
}
8010460e:	5b                   	pop    %ebx
8010460f:	5e                   	pop    %esi
80104610:	5d                   	pop    %ebp
80104611:	c3                   	ret    
80104612:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104620 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104620:	55                   	push   %ebp
80104621:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104623:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80104624:	eb 9a                	jmp    801045c0 <memmove>
80104626:	8d 76 00             	lea    0x0(%esi),%esi
80104629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104630 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80104630:	55                   	push   %ebp
80104631:	89 e5                	mov    %esp,%ebp
80104633:	57                   	push   %edi
80104634:	56                   	push   %esi
80104635:	8b 7d 10             	mov    0x10(%ebp),%edi
80104638:	53                   	push   %ebx
80104639:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010463c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
8010463f:	85 ff                	test   %edi,%edi
80104641:	74 2f                	je     80104672 <strncmp+0x42>
80104643:	0f b6 01             	movzbl (%ecx),%eax
80104646:	0f b6 1e             	movzbl (%esi),%ebx
80104649:	84 c0                	test   %al,%al
8010464b:	74 37                	je     80104684 <strncmp+0x54>
8010464d:	38 c3                	cmp    %al,%bl
8010464f:	75 33                	jne    80104684 <strncmp+0x54>
80104651:	01 f7                	add    %esi,%edi
80104653:	eb 13                	jmp    80104668 <strncmp+0x38>
80104655:	8d 76 00             	lea    0x0(%esi),%esi
80104658:	0f b6 01             	movzbl (%ecx),%eax
8010465b:	84 c0                	test   %al,%al
8010465d:	74 21                	je     80104680 <strncmp+0x50>
8010465f:	0f b6 1a             	movzbl (%edx),%ebx
80104662:	89 d6                	mov    %edx,%esi
80104664:	38 d8                	cmp    %bl,%al
80104666:	75 1c                	jne    80104684 <strncmp+0x54>
    n--, p++, q++;
80104668:	8d 56 01             	lea    0x1(%esi),%edx
8010466b:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
8010466e:	39 fa                	cmp    %edi,%edx
80104670:	75 e6                	jne    80104658 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80104672:	5b                   	pop    %ebx
    return 0;
80104673:	31 c0                	xor    %eax,%eax
}
80104675:	5e                   	pop    %esi
80104676:	5f                   	pop    %edi
80104677:	5d                   	pop    %ebp
80104678:	c3                   	ret    
80104679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104680:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
80104684:	29 d8                	sub    %ebx,%eax
}
80104686:	5b                   	pop    %ebx
80104687:	5e                   	pop    %esi
80104688:	5f                   	pop    %edi
80104689:	5d                   	pop    %ebp
8010468a:	c3                   	ret    
8010468b:	90                   	nop
8010468c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104690 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104690:	55                   	push   %ebp
80104691:	89 e5                	mov    %esp,%ebp
80104693:	56                   	push   %esi
80104694:	53                   	push   %ebx
80104695:	8b 45 08             	mov    0x8(%ebp),%eax
80104698:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010469b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
8010469e:	89 c2                	mov    %eax,%edx
801046a0:	eb 19                	jmp    801046bb <strncpy+0x2b>
801046a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801046a8:	83 c3 01             	add    $0x1,%ebx
801046ab:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
801046af:	83 c2 01             	add    $0x1,%edx
801046b2:	84 c9                	test   %cl,%cl
801046b4:	88 4a ff             	mov    %cl,-0x1(%edx)
801046b7:	74 09                	je     801046c2 <strncpy+0x32>
801046b9:	89 f1                	mov    %esi,%ecx
801046bb:	85 c9                	test   %ecx,%ecx
801046bd:	8d 71 ff             	lea    -0x1(%ecx),%esi
801046c0:	7f e6                	jg     801046a8 <strncpy+0x18>
    ;
  while(n-- > 0)
801046c2:	31 c9                	xor    %ecx,%ecx
801046c4:	85 f6                	test   %esi,%esi
801046c6:	7e 17                	jle    801046df <strncpy+0x4f>
801046c8:	90                   	nop
801046c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
801046d0:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
801046d4:	89 f3                	mov    %esi,%ebx
801046d6:	83 c1 01             	add    $0x1,%ecx
801046d9:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
801046db:	85 db                	test   %ebx,%ebx
801046dd:	7f f1                	jg     801046d0 <strncpy+0x40>
  return os;
}
801046df:	5b                   	pop    %ebx
801046e0:	5e                   	pop    %esi
801046e1:	5d                   	pop    %ebp
801046e2:	c3                   	ret    
801046e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801046e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801046f0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
801046f0:	55                   	push   %ebp
801046f1:	89 e5                	mov    %esp,%ebp
801046f3:	56                   	push   %esi
801046f4:	53                   	push   %ebx
801046f5:	8b 4d 10             	mov    0x10(%ebp),%ecx
801046f8:	8b 45 08             	mov    0x8(%ebp),%eax
801046fb:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
801046fe:	85 c9                	test   %ecx,%ecx
80104700:	7e 26                	jle    80104728 <safestrcpy+0x38>
80104702:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104706:	89 c1                	mov    %eax,%ecx
80104708:	eb 17                	jmp    80104721 <safestrcpy+0x31>
8010470a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104710:	83 c2 01             	add    $0x1,%edx
80104713:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104717:	83 c1 01             	add    $0x1,%ecx
8010471a:	84 db                	test   %bl,%bl
8010471c:	88 59 ff             	mov    %bl,-0x1(%ecx)
8010471f:	74 04                	je     80104725 <safestrcpy+0x35>
80104721:	39 f2                	cmp    %esi,%edx
80104723:	75 eb                	jne    80104710 <safestrcpy+0x20>
    ;
  *s = 0;
80104725:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104728:	5b                   	pop    %ebx
80104729:	5e                   	pop    %esi
8010472a:	5d                   	pop    %ebp
8010472b:	c3                   	ret    
8010472c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104730 <strlen>:

int
strlen(const char *s)
{
80104730:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104731:	31 c0                	xor    %eax,%eax
{
80104733:	89 e5                	mov    %esp,%ebp
80104735:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104738:	80 3a 00             	cmpb   $0x0,(%edx)
8010473b:	74 0c                	je     80104749 <strlen+0x19>
8010473d:	8d 76 00             	lea    0x0(%esi),%esi
80104740:	83 c0 01             	add    $0x1,%eax
80104743:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104747:	75 f7                	jne    80104740 <strlen+0x10>
    ;
  return n;
}
80104749:	5d                   	pop    %ebp
8010474a:	c3                   	ret    

8010474b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010474b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010474f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104753:	55                   	push   %ebp
  pushl %ebx
80104754:	53                   	push   %ebx
  pushl %esi
80104755:	56                   	push   %esi
  pushl %edi
80104756:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104757:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104759:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
8010475b:	5f                   	pop    %edi
  popl %esi
8010475c:	5e                   	pop    %esi
  popl %ebx
8010475d:	5b                   	pop    %ebx
  popl %ebp
8010475e:	5d                   	pop    %ebp
  ret
8010475f:	c3                   	ret    

80104760 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104760:	55                   	push   %ebp
80104761:	89 e5                	mov    %esp,%ebp
80104763:	53                   	push   %ebx
80104764:	83 ec 04             	sub    $0x4,%esp
80104767:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010476a:	e8 31 f1 ff ff       	call   801038a0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010476f:	8b 00                	mov    (%eax),%eax
80104771:	39 d8                	cmp    %ebx,%eax
80104773:	76 1b                	jbe    80104790 <fetchint+0x30>
80104775:	8d 53 04             	lea    0x4(%ebx),%edx
80104778:	39 d0                	cmp    %edx,%eax
8010477a:	72 14                	jb     80104790 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
8010477c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010477f:	8b 13                	mov    (%ebx),%edx
80104781:	89 10                	mov    %edx,(%eax)
  return 0;
80104783:	31 c0                	xor    %eax,%eax
}
80104785:	83 c4 04             	add    $0x4,%esp
80104788:	5b                   	pop    %ebx
80104789:	5d                   	pop    %ebp
8010478a:	c3                   	ret    
8010478b:	90                   	nop
8010478c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104790:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104795:	eb ee                	jmp    80104785 <fetchint+0x25>
80104797:	89 f6                	mov    %esi,%esi
80104799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801047a0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
801047a0:	55                   	push   %ebp
801047a1:	89 e5                	mov    %esp,%ebp
801047a3:	53                   	push   %ebx
801047a4:	83 ec 04             	sub    $0x4,%esp
801047a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
801047aa:	e8 f1 f0 ff ff       	call   801038a0 <myproc>

  if(addr >= curproc->sz)
801047af:	39 18                	cmp    %ebx,(%eax)
801047b1:	76 29                	jbe    801047dc <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
801047b3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801047b6:	89 da                	mov    %ebx,%edx
801047b8:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
801047ba:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
801047bc:	39 c3                	cmp    %eax,%ebx
801047be:	73 1c                	jae    801047dc <fetchstr+0x3c>
    if(*s == 0)
801047c0:	80 3b 00             	cmpb   $0x0,(%ebx)
801047c3:	75 10                	jne    801047d5 <fetchstr+0x35>
801047c5:	eb 39                	jmp    80104800 <fetchstr+0x60>
801047c7:	89 f6                	mov    %esi,%esi
801047c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801047d0:	80 3a 00             	cmpb   $0x0,(%edx)
801047d3:	74 1b                	je     801047f0 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
801047d5:	83 c2 01             	add    $0x1,%edx
801047d8:	39 d0                	cmp    %edx,%eax
801047da:	77 f4                	ja     801047d0 <fetchstr+0x30>
    return -1;
801047dc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
801047e1:	83 c4 04             	add    $0x4,%esp
801047e4:	5b                   	pop    %ebx
801047e5:	5d                   	pop    %ebp
801047e6:	c3                   	ret    
801047e7:	89 f6                	mov    %esi,%esi
801047e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801047f0:	83 c4 04             	add    $0x4,%esp
801047f3:	89 d0                	mov    %edx,%eax
801047f5:	29 d8                	sub    %ebx,%eax
801047f7:	5b                   	pop    %ebx
801047f8:	5d                   	pop    %ebp
801047f9:	c3                   	ret    
801047fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s == 0)
80104800:	31 c0                	xor    %eax,%eax
      return s - *pp;
80104802:	eb dd                	jmp    801047e1 <fetchstr+0x41>
80104804:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010480a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104810 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104810:	55                   	push   %ebp
80104811:	89 e5                	mov    %esp,%ebp
80104813:	56                   	push   %esi
80104814:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104815:	e8 86 f0 ff ff       	call   801038a0 <myproc>
8010481a:	8b 40 18             	mov    0x18(%eax),%eax
8010481d:	8b 55 08             	mov    0x8(%ebp),%edx
80104820:	8b 40 44             	mov    0x44(%eax),%eax
80104823:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104826:	e8 75 f0 ff ff       	call   801038a0 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010482b:	8b 00                	mov    (%eax),%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010482d:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104830:	39 c6                	cmp    %eax,%esi
80104832:	73 1c                	jae    80104850 <argint+0x40>
80104834:	8d 53 08             	lea    0x8(%ebx),%edx
80104837:	39 d0                	cmp    %edx,%eax
80104839:	72 15                	jb     80104850 <argint+0x40>
  *ip = *(int*)(addr);
8010483b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010483e:	8b 53 04             	mov    0x4(%ebx),%edx
80104841:	89 10                	mov    %edx,(%eax)
  return 0;
80104843:	31 c0                	xor    %eax,%eax
}
80104845:	5b                   	pop    %ebx
80104846:	5e                   	pop    %esi
80104847:	5d                   	pop    %ebp
80104848:	c3                   	ret    
80104849:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104850:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104855:	eb ee                	jmp    80104845 <argint+0x35>
80104857:	89 f6                	mov    %esi,%esi
80104859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104860 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104860:	55                   	push   %ebp
80104861:	89 e5                	mov    %esp,%ebp
80104863:	56                   	push   %esi
80104864:	53                   	push   %ebx
80104865:	83 ec 10             	sub    $0x10,%esp
80104868:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
8010486b:	e8 30 f0 ff ff       	call   801038a0 <myproc>
80104870:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104872:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104875:	83 ec 08             	sub    $0x8,%esp
80104878:	50                   	push   %eax
80104879:	ff 75 08             	pushl  0x8(%ebp)
8010487c:	e8 8f ff ff ff       	call   80104810 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104881:	83 c4 10             	add    $0x10,%esp
80104884:	85 c0                	test   %eax,%eax
80104886:	78 28                	js     801048b0 <argptr+0x50>
80104888:	85 db                	test   %ebx,%ebx
8010488a:	78 24                	js     801048b0 <argptr+0x50>
8010488c:	8b 16                	mov    (%esi),%edx
8010488e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104891:	39 c2                	cmp    %eax,%edx
80104893:	76 1b                	jbe    801048b0 <argptr+0x50>
80104895:	01 c3                	add    %eax,%ebx
80104897:	39 da                	cmp    %ebx,%edx
80104899:	72 15                	jb     801048b0 <argptr+0x50>
    return -1;
  *pp = (char*)i;
8010489b:	8b 55 0c             	mov    0xc(%ebp),%edx
8010489e:	89 02                	mov    %eax,(%edx)
  return 0;
801048a0:	31 c0                	xor    %eax,%eax
}
801048a2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801048a5:	5b                   	pop    %ebx
801048a6:	5e                   	pop    %esi
801048a7:	5d                   	pop    %ebp
801048a8:	c3                   	ret    
801048a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801048b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801048b5:	eb eb                	jmp    801048a2 <argptr+0x42>
801048b7:	89 f6                	mov    %esi,%esi
801048b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801048c0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
801048c0:	55                   	push   %ebp
801048c1:	89 e5                	mov    %esp,%ebp
801048c3:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
801048c6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801048c9:	50                   	push   %eax
801048ca:	ff 75 08             	pushl  0x8(%ebp)
801048cd:	e8 3e ff ff ff       	call   80104810 <argint>
801048d2:	83 c4 10             	add    $0x10,%esp
801048d5:	85 c0                	test   %eax,%eax
801048d7:	78 17                	js     801048f0 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
801048d9:	83 ec 08             	sub    $0x8,%esp
801048dc:	ff 75 0c             	pushl  0xc(%ebp)
801048df:	ff 75 f4             	pushl  -0xc(%ebp)
801048e2:	e8 b9 fe ff ff       	call   801047a0 <fetchstr>
801048e7:	83 c4 10             	add    $0x10,%esp
}
801048ea:	c9                   	leave  
801048eb:	c3                   	ret    
801048ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801048f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801048f5:	c9                   	leave  
801048f6:	c3                   	ret    
801048f7:	89 f6                	mov    %esi,%esi
801048f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104900 <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
80104900:	55                   	push   %ebp
80104901:	89 e5                	mov    %esp,%ebp
80104903:	53                   	push   %ebx
80104904:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80104907:	e8 94 ef ff ff       	call   801038a0 <myproc>
8010490c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
8010490e:	8b 40 18             	mov    0x18(%eax),%eax
80104911:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104914:	8d 50 ff             	lea    -0x1(%eax),%edx
80104917:	83 fa 14             	cmp    $0x14,%edx
8010491a:	77 1c                	ja     80104938 <syscall+0x38>
8010491c:	8b 14 85 60 76 10 80 	mov    -0x7fef89a0(,%eax,4),%edx
80104923:	85 d2                	test   %edx,%edx
80104925:	74 11                	je     80104938 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80104927:	ff d2                	call   *%edx
80104929:	8b 53 18             	mov    0x18(%ebx),%edx
8010492c:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
8010492f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104932:	c9                   	leave  
80104933:	c3                   	ret    
80104934:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104938:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104939:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
8010493c:	50                   	push   %eax
8010493d:	ff 73 10             	pushl  0x10(%ebx)
80104940:	68 31 76 10 80       	push   $0x80107631
80104945:	e8 16 bd ff ff       	call   80100660 <cprintf>
    curproc->tf->eax = -1;
8010494a:	8b 43 18             	mov    0x18(%ebx),%eax
8010494d:	83 c4 10             	add    $0x10,%esp
80104950:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104957:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010495a:	c9                   	leave  
8010495b:	c3                   	ret    
8010495c:	66 90                	xchg   %ax,%ax
8010495e:	66 90                	xchg   %ax,%ax

80104960 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104960:	55                   	push   %ebp
80104961:	89 e5                	mov    %esp,%ebp
80104963:	57                   	push   %edi
80104964:	56                   	push   %esi
80104965:	53                   	push   %ebx
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104966:	8d 75 da             	lea    -0x26(%ebp),%esi
{
80104969:	83 ec 34             	sub    $0x34,%esp
8010496c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
8010496f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80104972:	56                   	push   %esi
80104973:	50                   	push   %eax
{
80104974:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80104977:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
8010497a:	e8 41 d6 ff ff       	call   80101fc0 <nameiparent>
8010497f:	83 c4 10             	add    $0x10,%esp
80104982:	85 c0                	test   %eax,%eax
80104984:	0f 84 46 01 00 00    	je     80104ad0 <create+0x170>
    return 0;
  ilock(dp);
8010498a:	83 ec 0c             	sub    $0xc,%esp
8010498d:	89 c3                	mov    %eax,%ebx
8010498f:	50                   	push   %eax
80104990:	e8 ab cd ff ff       	call   80101740 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80104995:	83 c4 0c             	add    $0xc,%esp
80104998:	6a 00                	push   $0x0
8010499a:	56                   	push   %esi
8010499b:	53                   	push   %ebx
8010499c:	e8 cf d2 ff ff       	call   80101c70 <dirlookup>
801049a1:	83 c4 10             	add    $0x10,%esp
801049a4:	85 c0                	test   %eax,%eax
801049a6:	89 c7                	mov    %eax,%edi
801049a8:	74 36                	je     801049e0 <create+0x80>
    iunlockput(dp);
801049aa:	83 ec 0c             	sub    $0xc,%esp
801049ad:	53                   	push   %ebx
801049ae:	e8 1d d0 ff ff       	call   801019d0 <iunlockput>
    ilock(ip);
801049b3:	89 3c 24             	mov    %edi,(%esp)
801049b6:	e8 85 cd ff ff       	call   80101740 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
801049bb:	83 c4 10             	add    $0x10,%esp
801049be:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
801049c3:	0f 85 97 00 00 00    	jne    80104a60 <create+0x100>
801049c9:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
801049ce:	0f 85 8c 00 00 00    	jne    80104a60 <create+0x100>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
801049d4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801049d7:	89 f8                	mov    %edi,%eax
801049d9:	5b                   	pop    %ebx
801049da:	5e                   	pop    %esi
801049db:	5f                   	pop    %edi
801049dc:	5d                   	pop    %ebp
801049dd:	c3                   	ret    
801049de:	66 90                	xchg   %ax,%ax
  if((ip = ialloc(dp->dev, type)) == 0)
801049e0:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
801049e4:	83 ec 08             	sub    $0x8,%esp
801049e7:	50                   	push   %eax
801049e8:	ff 33                	pushl  (%ebx)
801049ea:	e8 e1 cb ff ff       	call   801015d0 <ialloc>
801049ef:	83 c4 10             	add    $0x10,%esp
801049f2:	85 c0                	test   %eax,%eax
801049f4:	89 c7                	mov    %eax,%edi
801049f6:	0f 84 e8 00 00 00    	je     80104ae4 <create+0x184>
  ilock(ip);
801049fc:	83 ec 0c             	sub    $0xc,%esp
801049ff:	50                   	push   %eax
80104a00:	e8 3b cd ff ff       	call   80101740 <ilock>
  ip->major = major;
80104a05:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80104a09:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
80104a0d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80104a11:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80104a15:	b8 01 00 00 00       	mov    $0x1,%eax
80104a1a:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
80104a1e:	89 3c 24             	mov    %edi,(%esp)
80104a21:	e8 6a cc ff ff       	call   80101690 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104a26:	83 c4 10             	add    $0x10,%esp
80104a29:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80104a2e:	74 50                	je     80104a80 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80104a30:	83 ec 04             	sub    $0x4,%esp
80104a33:	ff 77 04             	pushl  0x4(%edi)
80104a36:	56                   	push   %esi
80104a37:	53                   	push   %ebx
80104a38:	e8 a3 d4 ff ff       	call   80101ee0 <dirlink>
80104a3d:	83 c4 10             	add    $0x10,%esp
80104a40:	85 c0                	test   %eax,%eax
80104a42:	0f 88 8f 00 00 00    	js     80104ad7 <create+0x177>
  iunlockput(dp);
80104a48:	83 ec 0c             	sub    $0xc,%esp
80104a4b:	53                   	push   %ebx
80104a4c:	e8 7f cf ff ff       	call   801019d0 <iunlockput>
  return ip;
80104a51:	83 c4 10             	add    $0x10,%esp
}
80104a54:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104a57:	89 f8                	mov    %edi,%eax
80104a59:	5b                   	pop    %ebx
80104a5a:	5e                   	pop    %esi
80104a5b:	5f                   	pop    %edi
80104a5c:	5d                   	pop    %ebp
80104a5d:	c3                   	ret    
80104a5e:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80104a60:	83 ec 0c             	sub    $0xc,%esp
80104a63:	57                   	push   %edi
    return 0;
80104a64:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80104a66:	e8 65 cf ff ff       	call   801019d0 <iunlockput>
    return 0;
80104a6b:	83 c4 10             	add    $0x10,%esp
}
80104a6e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104a71:	89 f8                	mov    %edi,%eax
80104a73:	5b                   	pop    %ebx
80104a74:	5e                   	pop    %esi
80104a75:	5f                   	pop    %edi
80104a76:	5d                   	pop    %ebp
80104a77:	c3                   	ret    
80104a78:	90                   	nop
80104a79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80104a80:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80104a85:	83 ec 0c             	sub    $0xc,%esp
80104a88:	53                   	push   %ebx
80104a89:	e8 02 cc ff ff       	call   80101690 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104a8e:	83 c4 0c             	add    $0xc,%esp
80104a91:	ff 77 04             	pushl  0x4(%edi)
80104a94:	68 d4 76 10 80       	push   $0x801076d4
80104a99:	57                   	push   %edi
80104a9a:	e8 41 d4 ff ff       	call   80101ee0 <dirlink>
80104a9f:	83 c4 10             	add    $0x10,%esp
80104aa2:	85 c0                	test   %eax,%eax
80104aa4:	78 1c                	js     80104ac2 <create+0x162>
80104aa6:	83 ec 04             	sub    $0x4,%esp
80104aa9:	ff 73 04             	pushl  0x4(%ebx)
80104aac:	68 d3 76 10 80       	push   $0x801076d3
80104ab1:	57                   	push   %edi
80104ab2:	e8 29 d4 ff ff       	call   80101ee0 <dirlink>
80104ab7:	83 c4 10             	add    $0x10,%esp
80104aba:	85 c0                	test   %eax,%eax
80104abc:	0f 89 6e ff ff ff    	jns    80104a30 <create+0xd0>
      panic("create dots");
80104ac2:	83 ec 0c             	sub    $0xc,%esp
80104ac5:	68 c7 76 10 80       	push   $0x801076c7
80104aca:	e8 c1 b8 ff ff       	call   80100390 <panic>
80104acf:	90                   	nop
    return 0;
80104ad0:	31 ff                	xor    %edi,%edi
80104ad2:	e9 fd fe ff ff       	jmp    801049d4 <create+0x74>
    panic("create: dirlink");
80104ad7:	83 ec 0c             	sub    $0xc,%esp
80104ada:	68 d6 76 10 80       	push   $0x801076d6
80104adf:	e8 ac b8 ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80104ae4:	83 ec 0c             	sub    $0xc,%esp
80104ae7:	68 b8 76 10 80       	push   $0x801076b8
80104aec:	e8 9f b8 ff ff       	call   80100390 <panic>
80104af1:	eb 0d                	jmp    80104b00 <argfd.constprop.0>
80104af3:	90                   	nop
80104af4:	90                   	nop
80104af5:	90                   	nop
80104af6:	90                   	nop
80104af7:	90                   	nop
80104af8:	90                   	nop
80104af9:	90                   	nop
80104afa:	90                   	nop
80104afb:	90                   	nop
80104afc:	90                   	nop
80104afd:	90                   	nop
80104afe:	90                   	nop
80104aff:	90                   	nop

80104b00 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80104b00:	55                   	push   %ebp
80104b01:	89 e5                	mov    %esp,%ebp
80104b03:	56                   	push   %esi
80104b04:	53                   	push   %ebx
80104b05:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80104b07:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
80104b0a:	89 d6                	mov    %edx,%esi
80104b0c:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104b0f:	50                   	push   %eax
80104b10:	6a 00                	push   $0x0
80104b12:	e8 f9 fc ff ff       	call   80104810 <argint>
80104b17:	83 c4 10             	add    $0x10,%esp
80104b1a:	85 c0                	test   %eax,%eax
80104b1c:	78 2a                	js     80104b48 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104b1e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104b22:	77 24                	ja     80104b48 <argfd.constprop.0+0x48>
80104b24:	e8 77 ed ff ff       	call   801038a0 <myproc>
80104b29:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104b2c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104b30:	85 c0                	test   %eax,%eax
80104b32:	74 14                	je     80104b48 <argfd.constprop.0+0x48>
  if(pfd)
80104b34:	85 db                	test   %ebx,%ebx
80104b36:	74 02                	je     80104b3a <argfd.constprop.0+0x3a>
    *pfd = fd;
80104b38:	89 13                	mov    %edx,(%ebx)
    *pf = f;
80104b3a:	89 06                	mov    %eax,(%esi)
  return 0;
80104b3c:	31 c0                	xor    %eax,%eax
}
80104b3e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104b41:	5b                   	pop    %ebx
80104b42:	5e                   	pop    %esi
80104b43:	5d                   	pop    %ebp
80104b44:	c3                   	ret    
80104b45:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104b48:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104b4d:	eb ef                	jmp    80104b3e <argfd.constprop.0+0x3e>
80104b4f:	90                   	nop

80104b50 <sys_dup>:
{
80104b50:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80104b51:	31 c0                	xor    %eax,%eax
{
80104b53:	89 e5                	mov    %esp,%ebp
80104b55:	56                   	push   %esi
80104b56:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80104b57:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
80104b5a:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
80104b5d:	e8 9e ff ff ff       	call   80104b00 <argfd.constprop.0>
80104b62:	85 c0                	test   %eax,%eax
80104b64:	78 42                	js     80104ba8 <sys_dup+0x58>
  if((fd=fdalloc(f)) < 0)
80104b66:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104b69:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80104b6b:	e8 30 ed ff ff       	call   801038a0 <myproc>
80104b70:	eb 0e                	jmp    80104b80 <sys_dup+0x30>
80104b72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104b78:	83 c3 01             	add    $0x1,%ebx
80104b7b:	83 fb 10             	cmp    $0x10,%ebx
80104b7e:	74 28                	je     80104ba8 <sys_dup+0x58>
    if(curproc->ofile[fd] == 0){
80104b80:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104b84:	85 d2                	test   %edx,%edx
80104b86:	75 f0                	jne    80104b78 <sys_dup+0x28>
      curproc->ofile[fd] = f;
80104b88:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80104b8c:	83 ec 0c             	sub    $0xc,%esp
80104b8f:	ff 75 f4             	pushl  -0xc(%ebp)
80104b92:	e8 59 c2 ff ff       	call   80100df0 <filedup>
  return fd;
80104b97:	83 c4 10             	add    $0x10,%esp
}
80104b9a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104b9d:	89 d8                	mov    %ebx,%eax
80104b9f:	5b                   	pop    %ebx
80104ba0:	5e                   	pop    %esi
80104ba1:	5d                   	pop    %ebp
80104ba2:	c3                   	ret    
80104ba3:	90                   	nop
80104ba4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ba8:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80104bab:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104bb0:	89 d8                	mov    %ebx,%eax
80104bb2:	5b                   	pop    %ebx
80104bb3:	5e                   	pop    %esi
80104bb4:	5d                   	pop    %ebp
80104bb5:	c3                   	ret    
80104bb6:	8d 76 00             	lea    0x0(%esi),%esi
80104bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104bc0 <sys_read>:
{
80104bc0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104bc1:	31 c0                	xor    %eax,%eax
{
80104bc3:	89 e5                	mov    %esp,%ebp
80104bc5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104bc8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104bcb:	e8 30 ff ff ff       	call   80104b00 <argfd.constprop.0>
80104bd0:	85 c0                	test   %eax,%eax
80104bd2:	78 4c                	js     80104c20 <sys_read+0x60>
80104bd4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104bd7:	83 ec 08             	sub    $0x8,%esp
80104bda:	50                   	push   %eax
80104bdb:	6a 02                	push   $0x2
80104bdd:	e8 2e fc ff ff       	call   80104810 <argint>
80104be2:	83 c4 10             	add    $0x10,%esp
80104be5:	85 c0                	test   %eax,%eax
80104be7:	78 37                	js     80104c20 <sys_read+0x60>
80104be9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104bec:	83 ec 04             	sub    $0x4,%esp
80104bef:	ff 75 f0             	pushl  -0x10(%ebp)
80104bf2:	50                   	push   %eax
80104bf3:	6a 01                	push   $0x1
80104bf5:	e8 66 fc ff ff       	call   80104860 <argptr>
80104bfa:	83 c4 10             	add    $0x10,%esp
80104bfd:	85 c0                	test   %eax,%eax
80104bff:	78 1f                	js     80104c20 <sys_read+0x60>
  return fileread(f, p, n);
80104c01:	83 ec 04             	sub    $0x4,%esp
80104c04:	ff 75 f0             	pushl  -0x10(%ebp)
80104c07:	ff 75 f4             	pushl  -0xc(%ebp)
80104c0a:	ff 75 ec             	pushl  -0x14(%ebp)
80104c0d:	e8 4e c3 ff ff       	call   80100f60 <fileread>
80104c12:	83 c4 10             	add    $0x10,%esp
}
80104c15:	c9                   	leave  
80104c16:	c3                   	ret    
80104c17:	89 f6                	mov    %esi,%esi
80104c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104c20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104c25:	c9                   	leave  
80104c26:	c3                   	ret    
80104c27:	89 f6                	mov    %esi,%esi
80104c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c30 <sys_write>:
{
80104c30:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104c31:	31 c0                	xor    %eax,%eax
{
80104c33:	89 e5                	mov    %esp,%ebp
80104c35:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104c38:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104c3b:	e8 c0 fe ff ff       	call   80104b00 <argfd.constprop.0>
80104c40:	85 c0                	test   %eax,%eax
80104c42:	78 4c                	js     80104c90 <sys_write+0x60>
80104c44:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104c47:	83 ec 08             	sub    $0x8,%esp
80104c4a:	50                   	push   %eax
80104c4b:	6a 02                	push   $0x2
80104c4d:	e8 be fb ff ff       	call   80104810 <argint>
80104c52:	83 c4 10             	add    $0x10,%esp
80104c55:	85 c0                	test   %eax,%eax
80104c57:	78 37                	js     80104c90 <sys_write+0x60>
80104c59:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104c5c:	83 ec 04             	sub    $0x4,%esp
80104c5f:	ff 75 f0             	pushl  -0x10(%ebp)
80104c62:	50                   	push   %eax
80104c63:	6a 01                	push   $0x1
80104c65:	e8 f6 fb ff ff       	call   80104860 <argptr>
80104c6a:	83 c4 10             	add    $0x10,%esp
80104c6d:	85 c0                	test   %eax,%eax
80104c6f:	78 1f                	js     80104c90 <sys_write+0x60>
  return filewrite(f, p, n);
80104c71:	83 ec 04             	sub    $0x4,%esp
80104c74:	ff 75 f0             	pushl  -0x10(%ebp)
80104c77:	ff 75 f4             	pushl  -0xc(%ebp)
80104c7a:	ff 75 ec             	pushl  -0x14(%ebp)
80104c7d:	e8 6e c3 ff ff       	call   80100ff0 <filewrite>
80104c82:	83 c4 10             	add    $0x10,%esp
}
80104c85:	c9                   	leave  
80104c86:	c3                   	ret    
80104c87:	89 f6                	mov    %esi,%esi
80104c89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104c90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104c95:	c9                   	leave  
80104c96:	c3                   	ret    
80104c97:	89 f6                	mov    %esi,%esi
80104c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ca0 <sys_close>:
{
80104ca0:	55                   	push   %ebp
80104ca1:	89 e5                	mov    %esp,%ebp
80104ca3:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
80104ca6:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104ca9:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104cac:	e8 4f fe ff ff       	call   80104b00 <argfd.constprop.0>
80104cb1:	85 c0                	test   %eax,%eax
80104cb3:	78 2b                	js     80104ce0 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
80104cb5:	e8 e6 eb ff ff       	call   801038a0 <myproc>
80104cba:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80104cbd:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80104cc0:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104cc7:	00 
  fileclose(f);
80104cc8:	ff 75 f4             	pushl  -0xc(%ebp)
80104ccb:	e8 70 c1 ff ff       	call   80100e40 <fileclose>
  return 0;
80104cd0:	83 c4 10             	add    $0x10,%esp
80104cd3:	31 c0                	xor    %eax,%eax
}
80104cd5:	c9                   	leave  
80104cd6:	c3                   	ret    
80104cd7:	89 f6                	mov    %esi,%esi
80104cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104ce0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104ce5:	c9                   	leave  
80104ce6:	c3                   	ret    
80104ce7:	89 f6                	mov    %esi,%esi
80104ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104cf0 <sys_fstat>:
{
80104cf0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104cf1:	31 c0                	xor    %eax,%eax
{
80104cf3:	89 e5                	mov    %esp,%ebp
80104cf5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104cf8:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104cfb:	e8 00 fe ff ff       	call   80104b00 <argfd.constprop.0>
80104d00:	85 c0                	test   %eax,%eax
80104d02:	78 2c                	js     80104d30 <sys_fstat+0x40>
80104d04:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d07:	83 ec 04             	sub    $0x4,%esp
80104d0a:	6a 14                	push   $0x14
80104d0c:	50                   	push   %eax
80104d0d:	6a 01                	push   $0x1
80104d0f:	e8 4c fb ff ff       	call   80104860 <argptr>
80104d14:	83 c4 10             	add    $0x10,%esp
80104d17:	85 c0                	test   %eax,%eax
80104d19:	78 15                	js     80104d30 <sys_fstat+0x40>
  return filestat(f, st);
80104d1b:	83 ec 08             	sub    $0x8,%esp
80104d1e:	ff 75 f4             	pushl  -0xc(%ebp)
80104d21:	ff 75 f0             	pushl  -0x10(%ebp)
80104d24:	e8 e7 c1 ff ff       	call   80100f10 <filestat>
80104d29:	83 c4 10             	add    $0x10,%esp
}
80104d2c:	c9                   	leave  
80104d2d:	c3                   	ret    
80104d2e:	66 90                	xchg   %ax,%ax
    return -1;
80104d30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d35:	c9                   	leave  
80104d36:	c3                   	ret    
80104d37:	89 f6                	mov    %esi,%esi
80104d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d40 <sys_link>:
{
80104d40:	55                   	push   %ebp
80104d41:	89 e5                	mov    %esp,%ebp
80104d43:	57                   	push   %edi
80104d44:	56                   	push   %esi
80104d45:	53                   	push   %ebx
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104d46:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80104d49:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104d4c:	50                   	push   %eax
80104d4d:	6a 00                	push   $0x0
80104d4f:	e8 6c fb ff ff       	call   801048c0 <argstr>
80104d54:	83 c4 10             	add    $0x10,%esp
80104d57:	85 c0                	test   %eax,%eax
80104d59:	0f 88 fb 00 00 00    	js     80104e5a <sys_link+0x11a>
80104d5f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104d62:	83 ec 08             	sub    $0x8,%esp
80104d65:	50                   	push   %eax
80104d66:	6a 01                	push   $0x1
80104d68:	e8 53 fb ff ff       	call   801048c0 <argstr>
80104d6d:	83 c4 10             	add    $0x10,%esp
80104d70:	85 c0                	test   %eax,%eax
80104d72:	0f 88 e2 00 00 00    	js     80104e5a <sys_link+0x11a>
  begin_op();
80104d78:	e8 e3 de ff ff       	call   80102c60 <begin_op>
  if((ip = namei(old)) == 0){
80104d7d:	83 ec 0c             	sub    $0xc,%esp
80104d80:	ff 75 d4             	pushl  -0x2c(%ebp)
80104d83:	e8 18 d2 ff ff       	call   80101fa0 <namei>
80104d88:	83 c4 10             	add    $0x10,%esp
80104d8b:	85 c0                	test   %eax,%eax
80104d8d:	89 c3                	mov    %eax,%ebx
80104d8f:	0f 84 ea 00 00 00    	je     80104e7f <sys_link+0x13f>
  ilock(ip);
80104d95:	83 ec 0c             	sub    $0xc,%esp
80104d98:	50                   	push   %eax
80104d99:	e8 a2 c9 ff ff       	call   80101740 <ilock>
  if(ip->type == T_DIR){
80104d9e:	83 c4 10             	add    $0x10,%esp
80104da1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104da6:	0f 84 bb 00 00 00    	je     80104e67 <sys_link+0x127>
  ip->nlink++;
80104dac:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80104db1:	83 ec 0c             	sub    $0xc,%esp
  if((dp = nameiparent(new, name)) == 0)
80104db4:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80104db7:	53                   	push   %ebx
80104db8:	e8 d3 c8 ff ff       	call   80101690 <iupdate>
  iunlock(ip);
80104dbd:	89 1c 24             	mov    %ebx,(%esp)
80104dc0:	e8 5b ca ff ff       	call   80101820 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80104dc5:	58                   	pop    %eax
80104dc6:	5a                   	pop    %edx
80104dc7:	57                   	push   %edi
80104dc8:	ff 75 d0             	pushl  -0x30(%ebp)
80104dcb:	e8 f0 d1 ff ff       	call   80101fc0 <nameiparent>
80104dd0:	83 c4 10             	add    $0x10,%esp
80104dd3:	85 c0                	test   %eax,%eax
80104dd5:	89 c6                	mov    %eax,%esi
80104dd7:	74 5b                	je     80104e34 <sys_link+0xf4>
  ilock(dp);
80104dd9:	83 ec 0c             	sub    $0xc,%esp
80104ddc:	50                   	push   %eax
80104ddd:	e8 5e c9 ff ff       	call   80101740 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104de2:	83 c4 10             	add    $0x10,%esp
80104de5:	8b 03                	mov    (%ebx),%eax
80104de7:	39 06                	cmp    %eax,(%esi)
80104de9:	75 3d                	jne    80104e28 <sys_link+0xe8>
80104deb:	83 ec 04             	sub    $0x4,%esp
80104dee:	ff 73 04             	pushl  0x4(%ebx)
80104df1:	57                   	push   %edi
80104df2:	56                   	push   %esi
80104df3:	e8 e8 d0 ff ff       	call   80101ee0 <dirlink>
80104df8:	83 c4 10             	add    $0x10,%esp
80104dfb:	85 c0                	test   %eax,%eax
80104dfd:	78 29                	js     80104e28 <sys_link+0xe8>
  iunlockput(dp);
80104dff:	83 ec 0c             	sub    $0xc,%esp
80104e02:	56                   	push   %esi
80104e03:	e8 c8 cb ff ff       	call   801019d0 <iunlockput>
  iput(ip);
80104e08:	89 1c 24             	mov    %ebx,(%esp)
80104e0b:	e8 60 ca ff ff       	call   80101870 <iput>
  end_op();
80104e10:	e8 bb de ff ff       	call   80102cd0 <end_op>
  return 0;
80104e15:	83 c4 10             	add    $0x10,%esp
80104e18:	31 c0                	xor    %eax,%eax
}
80104e1a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104e1d:	5b                   	pop    %ebx
80104e1e:	5e                   	pop    %esi
80104e1f:	5f                   	pop    %edi
80104e20:	5d                   	pop    %ebp
80104e21:	c3                   	ret    
80104e22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80104e28:	83 ec 0c             	sub    $0xc,%esp
80104e2b:	56                   	push   %esi
80104e2c:	e8 9f cb ff ff       	call   801019d0 <iunlockput>
    goto bad;
80104e31:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80104e34:	83 ec 0c             	sub    $0xc,%esp
80104e37:	53                   	push   %ebx
80104e38:	e8 03 c9 ff ff       	call   80101740 <ilock>
  ip->nlink--;
80104e3d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104e42:	89 1c 24             	mov    %ebx,(%esp)
80104e45:	e8 46 c8 ff ff       	call   80101690 <iupdate>
  iunlockput(ip);
80104e4a:	89 1c 24             	mov    %ebx,(%esp)
80104e4d:	e8 7e cb ff ff       	call   801019d0 <iunlockput>
  end_op();
80104e52:	e8 79 de ff ff       	call   80102cd0 <end_op>
  return -1;
80104e57:	83 c4 10             	add    $0x10,%esp
}
80104e5a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80104e5d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e62:	5b                   	pop    %ebx
80104e63:	5e                   	pop    %esi
80104e64:	5f                   	pop    %edi
80104e65:	5d                   	pop    %ebp
80104e66:	c3                   	ret    
    iunlockput(ip);
80104e67:	83 ec 0c             	sub    $0xc,%esp
80104e6a:	53                   	push   %ebx
80104e6b:	e8 60 cb ff ff       	call   801019d0 <iunlockput>
    end_op();
80104e70:	e8 5b de ff ff       	call   80102cd0 <end_op>
    return -1;
80104e75:	83 c4 10             	add    $0x10,%esp
80104e78:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e7d:	eb 9b                	jmp    80104e1a <sys_link+0xda>
    end_op();
80104e7f:	e8 4c de ff ff       	call   80102cd0 <end_op>
    return -1;
80104e84:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e89:	eb 8f                	jmp    80104e1a <sys_link+0xda>
80104e8b:	90                   	nop
80104e8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104e90 <sys_unlink>:
{
80104e90:	55                   	push   %ebp
80104e91:	89 e5                	mov    %esp,%ebp
80104e93:	57                   	push   %edi
80104e94:	56                   	push   %esi
80104e95:	53                   	push   %ebx
  if(argstr(0, &path) < 0)
80104e96:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80104e99:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
80104e9c:	50                   	push   %eax
80104e9d:	6a 00                	push   $0x0
80104e9f:	e8 1c fa ff ff       	call   801048c0 <argstr>
80104ea4:	83 c4 10             	add    $0x10,%esp
80104ea7:	85 c0                	test   %eax,%eax
80104ea9:	0f 88 77 01 00 00    	js     80105026 <sys_unlink+0x196>
  if((dp = nameiparent(path, name)) == 0){
80104eaf:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
80104eb2:	e8 a9 dd ff ff       	call   80102c60 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80104eb7:	83 ec 08             	sub    $0x8,%esp
80104eba:	53                   	push   %ebx
80104ebb:	ff 75 c0             	pushl  -0x40(%ebp)
80104ebe:	e8 fd d0 ff ff       	call   80101fc0 <nameiparent>
80104ec3:	83 c4 10             	add    $0x10,%esp
80104ec6:	85 c0                	test   %eax,%eax
80104ec8:	89 c6                	mov    %eax,%esi
80104eca:	0f 84 60 01 00 00    	je     80105030 <sys_unlink+0x1a0>
  ilock(dp);
80104ed0:	83 ec 0c             	sub    $0xc,%esp
80104ed3:	50                   	push   %eax
80104ed4:	e8 67 c8 ff ff       	call   80101740 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80104ed9:	58                   	pop    %eax
80104eda:	5a                   	pop    %edx
80104edb:	68 d4 76 10 80       	push   $0x801076d4
80104ee0:	53                   	push   %ebx
80104ee1:	e8 6a cd ff ff       	call   80101c50 <namecmp>
80104ee6:	83 c4 10             	add    $0x10,%esp
80104ee9:	85 c0                	test   %eax,%eax
80104eeb:	0f 84 03 01 00 00    	je     80104ff4 <sys_unlink+0x164>
80104ef1:	83 ec 08             	sub    $0x8,%esp
80104ef4:	68 d3 76 10 80       	push   $0x801076d3
80104ef9:	53                   	push   %ebx
80104efa:	e8 51 cd ff ff       	call   80101c50 <namecmp>
80104eff:	83 c4 10             	add    $0x10,%esp
80104f02:	85 c0                	test   %eax,%eax
80104f04:	0f 84 ea 00 00 00    	je     80104ff4 <sys_unlink+0x164>
  if((ip = dirlookup(dp, name, &off)) == 0)
80104f0a:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80104f0d:	83 ec 04             	sub    $0x4,%esp
80104f10:	50                   	push   %eax
80104f11:	53                   	push   %ebx
80104f12:	56                   	push   %esi
80104f13:	e8 58 cd ff ff       	call   80101c70 <dirlookup>
80104f18:	83 c4 10             	add    $0x10,%esp
80104f1b:	85 c0                	test   %eax,%eax
80104f1d:	89 c3                	mov    %eax,%ebx
80104f1f:	0f 84 cf 00 00 00    	je     80104ff4 <sys_unlink+0x164>
  ilock(ip);
80104f25:	83 ec 0c             	sub    $0xc,%esp
80104f28:	50                   	push   %eax
80104f29:	e8 12 c8 ff ff       	call   80101740 <ilock>
  if(ip->nlink < 1)
80104f2e:	83 c4 10             	add    $0x10,%esp
80104f31:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80104f36:	0f 8e 10 01 00 00    	jle    8010504c <sys_unlink+0x1bc>
  if(ip->type == T_DIR && !isdirempty(ip)){
80104f3c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104f41:	74 6d                	je     80104fb0 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80104f43:	8d 45 d8             	lea    -0x28(%ebp),%eax
80104f46:	83 ec 04             	sub    $0x4,%esp
80104f49:	6a 10                	push   $0x10
80104f4b:	6a 00                	push   $0x0
80104f4d:	50                   	push   %eax
80104f4e:	e8 bd f5 ff ff       	call   80104510 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80104f53:	8d 45 d8             	lea    -0x28(%ebp),%eax
80104f56:	6a 10                	push   $0x10
80104f58:	ff 75 c4             	pushl  -0x3c(%ebp)
80104f5b:	50                   	push   %eax
80104f5c:	56                   	push   %esi
80104f5d:	e8 be cb ff ff       	call   80101b20 <writei>
80104f62:	83 c4 20             	add    $0x20,%esp
80104f65:	83 f8 10             	cmp    $0x10,%eax
80104f68:	0f 85 eb 00 00 00    	jne    80105059 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
80104f6e:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104f73:	0f 84 97 00 00 00    	je     80105010 <sys_unlink+0x180>
  iunlockput(dp);
80104f79:	83 ec 0c             	sub    $0xc,%esp
80104f7c:	56                   	push   %esi
80104f7d:	e8 4e ca ff ff       	call   801019d0 <iunlockput>
  ip->nlink--;
80104f82:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104f87:	89 1c 24             	mov    %ebx,(%esp)
80104f8a:	e8 01 c7 ff ff       	call   80101690 <iupdate>
  iunlockput(ip);
80104f8f:	89 1c 24             	mov    %ebx,(%esp)
80104f92:	e8 39 ca ff ff       	call   801019d0 <iunlockput>
  end_op();
80104f97:	e8 34 dd ff ff       	call   80102cd0 <end_op>
  return 0;
80104f9c:	83 c4 10             	add    $0x10,%esp
80104f9f:	31 c0                	xor    %eax,%eax
}
80104fa1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104fa4:	5b                   	pop    %ebx
80104fa5:	5e                   	pop    %esi
80104fa6:	5f                   	pop    %edi
80104fa7:	5d                   	pop    %ebp
80104fa8:	c3                   	ret    
80104fa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80104fb0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80104fb4:	76 8d                	jbe    80104f43 <sys_unlink+0xb3>
80104fb6:	bf 20 00 00 00       	mov    $0x20,%edi
80104fbb:	eb 0f                	jmp    80104fcc <sys_unlink+0x13c>
80104fbd:	8d 76 00             	lea    0x0(%esi),%esi
80104fc0:	83 c7 10             	add    $0x10,%edi
80104fc3:	3b 7b 58             	cmp    0x58(%ebx),%edi
80104fc6:	0f 83 77 ff ff ff    	jae    80104f43 <sys_unlink+0xb3>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80104fcc:	8d 45 d8             	lea    -0x28(%ebp),%eax
80104fcf:	6a 10                	push   $0x10
80104fd1:	57                   	push   %edi
80104fd2:	50                   	push   %eax
80104fd3:	53                   	push   %ebx
80104fd4:	e8 47 ca ff ff       	call   80101a20 <readi>
80104fd9:	83 c4 10             	add    $0x10,%esp
80104fdc:	83 f8 10             	cmp    $0x10,%eax
80104fdf:	75 5e                	jne    8010503f <sys_unlink+0x1af>
    if(de.inum != 0)
80104fe1:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80104fe6:	74 d8                	je     80104fc0 <sys_unlink+0x130>
    iunlockput(ip);
80104fe8:	83 ec 0c             	sub    $0xc,%esp
80104feb:	53                   	push   %ebx
80104fec:	e8 df c9 ff ff       	call   801019d0 <iunlockput>
    goto bad;
80104ff1:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
80104ff4:	83 ec 0c             	sub    $0xc,%esp
80104ff7:	56                   	push   %esi
80104ff8:	e8 d3 c9 ff ff       	call   801019d0 <iunlockput>
  end_op();
80104ffd:	e8 ce dc ff ff       	call   80102cd0 <end_op>
  return -1;
80105002:	83 c4 10             	add    $0x10,%esp
80105005:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010500a:	eb 95                	jmp    80104fa1 <sys_unlink+0x111>
8010500c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
80105010:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80105015:	83 ec 0c             	sub    $0xc,%esp
80105018:	56                   	push   %esi
80105019:	e8 72 c6 ff ff       	call   80101690 <iupdate>
8010501e:	83 c4 10             	add    $0x10,%esp
80105021:	e9 53 ff ff ff       	jmp    80104f79 <sys_unlink+0xe9>
    return -1;
80105026:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010502b:	e9 71 ff ff ff       	jmp    80104fa1 <sys_unlink+0x111>
    end_op();
80105030:	e8 9b dc ff ff       	call   80102cd0 <end_op>
    return -1;
80105035:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010503a:	e9 62 ff ff ff       	jmp    80104fa1 <sys_unlink+0x111>
      panic("isdirempty: readi");
8010503f:	83 ec 0c             	sub    $0xc,%esp
80105042:	68 f8 76 10 80       	push   $0x801076f8
80105047:	e8 44 b3 ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
8010504c:	83 ec 0c             	sub    $0xc,%esp
8010504f:	68 e6 76 10 80       	push   $0x801076e6
80105054:	e8 37 b3 ff ff       	call   80100390 <panic>
    panic("unlink: writei");
80105059:	83 ec 0c             	sub    $0xc,%esp
8010505c:	68 0a 77 10 80       	push   $0x8010770a
80105061:	e8 2a b3 ff ff       	call   80100390 <panic>
80105066:	8d 76 00             	lea    0x0(%esi),%esi
80105069:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105070 <sys_open>:

int
sys_open(void)
{
80105070:	55                   	push   %ebp
80105071:	89 e5                	mov    %esp,%ebp
80105073:	57                   	push   %edi
80105074:	56                   	push   %esi
80105075:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105076:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105079:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010507c:	50                   	push   %eax
8010507d:	6a 00                	push   $0x0
8010507f:	e8 3c f8 ff ff       	call   801048c0 <argstr>
80105084:	83 c4 10             	add    $0x10,%esp
80105087:	85 c0                	test   %eax,%eax
80105089:	0f 88 1d 01 00 00    	js     801051ac <sys_open+0x13c>
8010508f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105092:	83 ec 08             	sub    $0x8,%esp
80105095:	50                   	push   %eax
80105096:	6a 01                	push   $0x1
80105098:	e8 73 f7 ff ff       	call   80104810 <argint>
8010509d:	83 c4 10             	add    $0x10,%esp
801050a0:	85 c0                	test   %eax,%eax
801050a2:	0f 88 04 01 00 00    	js     801051ac <sys_open+0x13c>
    return -1;

  begin_op();
801050a8:	e8 b3 db ff ff       	call   80102c60 <begin_op>

  if(omode & O_CREATE){
801050ad:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801050b1:	0f 85 a9 00 00 00    	jne    80105160 <sys_open+0xf0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801050b7:	83 ec 0c             	sub    $0xc,%esp
801050ba:	ff 75 e0             	pushl  -0x20(%ebp)
801050bd:	e8 de ce ff ff       	call   80101fa0 <namei>
801050c2:	83 c4 10             	add    $0x10,%esp
801050c5:	85 c0                	test   %eax,%eax
801050c7:	89 c6                	mov    %eax,%esi
801050c9:	0f 84 b2 00 00 00    	je     80105181 <sys_open+0x111>
      end_op();
      return -1;
    }
    ilock(ip);
801050cf:	83 ec 0c             	sub    $0xc,%esp
801050d2:	50                   	push   %eax
801050d3:	e8 68 c6 ff ff       	call   80101740 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801050d8:	83 c4 10             	add    $0x10,%esp
801050db:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801050e0:	0f 84 aa 00 00 00    	je     80105190 <sys_open+0x120>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801050e6:	e8 95 bc ff ff       	call   80100d80 <filealloc>
801050eb:	85 c0                	test   %eax,%eax
801050ed:	89 c7                	mov    %eax,%edi
801050ef:	0f 84 a6 00 00 00    	je     8010519b <sys_open+0x12b>
  struct proc *curproc = myproc();
801050f5:	e8 a6 e7 ff ff       	call   801038a0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801050fa:	31 db                	xor    %ebx,%ebx
801050fc:	eb 0e                	jmp    8010510c <sys_open+0x9c>
801050fe:	66 90                	xchg   %ax,%ax
80105100:	83 c3 01             	add    $0x1,%ebx
80105103:	83 fb 10             	cmp    $0x10,%ebx
80105106:	0f 84 ac 00 00 00    	je     801051b8 <sys_open+0x148>
    if(curproc->ofile[fd] == 0){
8010510c:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105110:	85 d2                	test   %edx,%edx
80105112:	75 ec                	jne    80105100 <sys_open+0x90>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105114:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105117:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
8010511b:	56                   	push   %esi
8010511c:	e8 ff c6 ff ff       	call   80101820 <iunlock>
  end_op();
80105121:	e8 aa db ff ff       	call   80102cd0 <end_op>

  f->type = FD_INODE;
80105126:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
8010512c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010512f:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105132:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
80105135:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
8010513c:	89 d0                	mov    %edx,%eax
8010513e:	f7 d0                	not    %eax
80105140:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105143:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105146:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105149:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
8010514d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105150:	89 d8                	mov    %ebx,%eax
80105152:	5b                   	pop    %ebx
80105153:	5e                   	pop    %esi
80105154:	5f                   	pop    %edi
80105155:	5d                   	pop    %ebp
80105156:	c3                   	ret    
80105157:	89 f6                	mov    %esi,%esi
80105159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ip = create(path, T_FILE, 0, 0);
80105160:	83 ec 0c             	sub    $0xc,%esp
80105163:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105166:	31 c9                	xor    %ecx,%ecx
80105168:	6a 00                	push   $0x0
8010516a:	ba 02 00 00 00       	mov    $0x2,%edx
8010516f:	e8 ec f7 ff ff       	call   80104960 <create>
    if(ip == 0){
80105174:	83 c4 10             	add    $0x10,%esp
80105177:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80105179:	89 c6                	mov    %eax,%esi
    if(ip == 0){
8010517b:	0f 85 65 ff ff ff    	jne    801050e6 <sys_open+0x76>
      end_op();
80105181:	e8 4a db ff ff       	call   80102cd0 <end_op>
      return -1;
80105186:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010518b:	eb c0                	jmp    8010514d <sys_open+0xdd>
8010518d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105190:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105193:	85 c9                	test   %ecx,%ecx
80105195:	0f 84 4b ff ff ff    	je     801050e6 <sys_open+0x76>
    iunlockput(ip);
8010519b:	83 ec 0c             	sub    $0xc,%esp
8010519e:	56                   	push   %esi
8010519f:	e8 2c c8 ff ff       	call   801019d0 <iunlockput>
    end_op();
801051a4:	e8 27 db ff ff       	call   80102cd0 <end_op>
    return -1;
801051a9:	83 c4 10             	add    $0x10,%esp
801051ac:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801051b1:	eb 9a                	jmp    8010514d <sys_open+0xdd>
801051b3:	90                   	nop
801051b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
801051b8:	83 ec 0c             	sub    $0xc,%esp
801051bb:	57                   	push   %edi
801051bc:	e8 7f bc ff ff       	call   80100e40 <fileclose>
801051c1:	83 c4 10             	add    $0x10,%esp
801051c4:	eb d5                	jmp    8010519b <sys_open+0x12b>
801051c6:	8d 76 00             	lea    0x0(%esi),%esi
801051c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801051d0 <sys_mkdir>:

int
sys_mkdir(void)
{
801051d0:	55                   	push   %ebp
801051d1:	89 e5                	mov    %esp,%ebp
801051d3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801051d6:	e8 85 da ff ff       	call   80102c60 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801051db:	8d 45 f4             	lea    -0xc(%ebp),%eax
801051de:	83 ec 08             	sub    $0x8,%esp
801051e1:	50                   	push   %eax
801051e2:	6a 00                	push   $0x0
801051e4:	e8 d7 f6 ff ff       	call   801048c0 <argstr>
801051e9:	83 c4 10             	add    $0x10,%esp
801051ec:	85 c0                	test   %eax,%eax
801051ee:	78 30                	js     80105220 <sys_mkdir+0x50>
801051f0:	83 ec 0c             	sub    $0xc,%esp
801051f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801051f6:	31 c9                	xor    %ecx,%ecx
801051f8:	6a 00                	push   $0x0
801051fa:	ba 01 00 00 00       	mov    $0x1,%edx
801051ff:	e8 5c f7 ff ff       	call   80104960 <create>
80105204:	83 c4 10             	add    $0x10,%esp
80105207:	85 c0                	test   %eax,%eax
80105209:	74 15                	je     80105220 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010520b:	83 ec 0c             	sub    $0xc,%esp
8010520e:	50                   	push   %eax
8010520f:	e8 bc c7 ff ff       	call   801019d0 <iunlockput>
  end_op();
80105214:	e8 b7 da ff ff       	call   80102cd0 <end_op>
  return 0;
80105219:	83 c4 10             	add    $0x10,%esp
8010521c:	31 c0                	xor    %eax,%eax
}
8010521e:	c9                   	leave  
8010521f:	c3                   	ret    
    end_op();
80105220:	e8 ab da ff ff       	call   80102cd0 <end_op>
    return -1;
80105225:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010522a:	c9                   	leave  
8010522b:	c3                   	ret    
8010522c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105230 <sys_mknod>:

int
sys_mknod(void)
{
80105230:	55                   	push   %ebp
80105231:	89 e5                	mov    %esp,%ebp
80105233:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105236:	e8 25 da ff ff       	call   80102c60 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010523b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010523e:	83 ec 08             	sub    $0x8,%esp
80105241:	50                   	push   %eax
80105242:	6a 00                	push   $0x0
80105244:	e8 77 f6 ff ff       	call   801048c0 <argstr>
80105249:	83 c4 10             	add    $0x10,%esp
8010524c:	85 c0                	test   %eax,%eax
8010524e:	78 60                	js     801052b0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105250:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105253:	83 ec 08             	sub    $0x8,%esp
80105256:	50                   	push   %eax
80105257:	6a 01                	push   $0x1
80105259:	e8 b2 f5 ff ff       	call   80104810 <argint>
  if((argstr(0, &path)) < 0 ||
8010525e:	83 c4 10             	add    $0x10,%esp
80105261:	85 c0                	test   %eax,%eax
80105263:	78 4b                	js     801052b0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105265:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105268:	83 ec 08             	sub    $0x8,%esp
8010526b:	50                   	push   %eax
8010526c:	6a 02                	push   $0x2
8010526e:	e8 9d f5 ff ff       	call   80104810 <argint>
     argint(1, &major) < 0 ||
80105273:	83 c4 10             	add    $0x10,%esp
80105276:	85 c0                	test   %eax,%eax
80105278:	78 36                	js     801052b0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010527a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
8010527e:	83 ec 0c             	sub    $0xc,%esp
     (ip = create(path, T_DEV, major, minor)) == 0){
80105281:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
     argint(2, &minor) < 0 ||
80105285:	ba 03 00 00 00       	mov    $0x3,%edx
8010528a:	50                   	push   %eax
8010528b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010528e:	e8 cd f6 ff ff       	call   80104960 <create>
80105293:	83 c4 10             	add    $0x10,%esp
80105296:	85 c0                	test   %eax,%eax
80105298:	74 16                	je     801052b0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010529a:	83 ec 0c             	sub    $0xc,%esp
8010529d:	50                   	push   %eax
8010529e:	e8 2d c7 ff ff       	call   801019d0 <iunlockput>
  end_op();
801052a3:	e8 28 da ff ff       	call   80102cd0 <end_op>
  return 0;
801052a8:	83 c4 10             	add    $0x10,%esp
801052ab:	31 c0                	xor    %eax,%eax
}
801052ad:	c9                   	leave  
801052ae:	c3                   	ret    
801052af:	90                   	nop
    end_op();
801052b0:	e8 1b da ff ff       	call   80102cd0 <end_op>
    return -1;
801052b5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801052ba:	c9                   	leave  
801052bb:	c3                   	ret    
801052bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801052c0 <sys_chdir>:

int
sys_chdir(void)
{
801052c0:	55                   	push   %ebp
801052c1:	89 e5                	mov    %esp,%ebp
801052c3:	56                   	push   %esi
801052c4:	53                   	push   %ebx
801052c5:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
801052c8:	e8 d3 e5 ff ff       	call   801038a0 <myproc>
801052cd:	89 c6                	mov    %eax,%esi
  
  begin_op();
801052cf:	e8 8c d9 ff ff       	call   80102c60 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801052d4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801052d7:	83 ec 08             	sub    $0x8,%esp
801052da:	50                   	push   %eax
801052db:	6a 00                	push   $0x0
801052dd:	e8 de f5 ff ff       	call   801048c0 <argstr>
801052e2:	83 c4 10             	add    $0x10,%esp
801052e5:	85 c0                	test   %eax,%eax
801052e7:	78 77                	js     80105360 <sys_chdir+0xa0>
801052e9:	83 ec 0c             	sub    $0xc,%esp
801052ec:	ff 75 f4             	pushl  -0xc(%ebp)
801052ef:	e8 ac cc ff ff       	call   80101fa0 <namei>
801052f4:	83 c4 10             	add    $0x10,%esp
801052f7:	85 c0                	test   %eax,%eax
801052f9:	89 c3                	mov    %eax,%ebx
801052fb:	74 63                	je     80105360 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
801052fd:	83 ec 0c             	sub    $0xc,%esp
80105300:	50                   	push   %eax
80105301:	e8 3a c4 ff ff       	call   80101740 <ilock>
  if(ip->type != T_DIR){
80105306:	83 c4 10             	add    $0x10,%esp
80105309:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010530e:	75 30                	jne    80105340 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105310:	83 ec 0c             	sub    $0xc,%esp
80105313:	53                   	push   %ebx
80105314:	e8 07 c5 ff ff       	call   80101820 <iunlock>
  iput(curproc->cwd);
80105319:	58                   	pop    %eax
8010531a:	ff 76 68             	pushl  0x68(%esi)
8010531d:	e8 4e c5 ff ff       	call   80101870 <iput>
  end_op();
80105322:	e8 a9 d9 ff ff       	call   80102cd0 <end_op>
  curproc->cwd = ip;
80105327:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010532a:	83 c4 10             	add    $0x10,%esp
8010532d:	31 c0                	xor    %eax,%eax
}
8010532f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105332:	5b                   	pop    %ebx
80105333:	5e                   	pop    %esi
80105334:	5d                   	pop    %ebp
80105335:	c3                   	ret    
80105336:	8d 76 00             	lea    0x0(%esi),%esi
80105339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
80105340:	83 ec 0c             	sub    $0xc,%esp
80105343:	53                   	push   %ebx
80105344:	e8 87 c6 ff ff       	call   801019d0 <iunlockput>
    end_op();
80105349:	e8 82 d9 ff ff       	call   80102cd0 <end_op>
    return -1;
8010534e:	83 c4 10             	add    $0x10,%esp
80105351:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105356:	eb d7                	jmp    8010532f <sys_chdir+0x6f>
80105358:	90                   	nop
80105359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105360:	e8 6b d9 ff ff       	call   80102cd0 <end_op>
    return -1;
80105365:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010536a:	eb c3                	jmp    8010532f <sys_chdir+0x6f>
8010536c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105370 <sys_exec>:

int
sys_exec(void)
{
80105370:	55                   	push   %ebp
80105371:	89 e5                	mov    %esp,%ebp
80105373:	57                   	push   %edi
80105374:	56                   	push   %esi
80105375:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105376:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010537c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105382:	50                   	push   %eax
80105383:	6a 00                	push   $0x0
80105385:	e8 36 f5 ff ff       	call   801048c0 <argstr>
8010538a:	83 c4 10             	add    $0x10,%esp
8010538d:	85 c0                	test   %eax,%eax
8010538f:	0f 88 87 00 00 00    	js     8010541c <sys_exec+0xac>
80105395:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010539b:	83 ec 08             	sub    $0x8,%esp
8010539e:	50                   	push   %eax
8010539f:	6a 01                	push   $0x1
801053a1:	e8 6a f4 ff ff       	call   80104810 <argint>
801053a6:	83 c4 10             	add    $0x10,%esp
801053a9:	85 c0                	test   %eax,%eax
801053ab:	78 6f                	js     8010541c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801053ad:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801053b3:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
801053b6:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
801053b8:	68 80 00 00 00       	push   $0x80
801053bd:	6a 00                	push   $0x0
801053bf:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
801053c5:	50                   	push   %eax
801053c6:	e8 45 f1 ff ff       	call   80104510 <memset>
801053cb:	83 c4 10             	add    $0x10,%esp
801053ce:	eb 2c                	jmp    801053fc <sys_exec+0x8c>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
801053d0:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801053d6:	85 c0                	test   %eax,%eax
801053d8:	74 56                	je     80105430 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801053da:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
801053e0:	83 ec 08             	sub    $0x8,%esp
801053e3:	8d 14 31             	lea    (%ecx,%esi,1),%edx
801053e6:	52                   	push   %edx
801053e7:	50                   	push   %eax
801053e8:	e8 b3 f3 ff ff       	call   801047a0 <fetchstr>
801053ed:	83 c4 10             	add    $0x10,%esp
801053f0:	85 c0                	test   %eax,%eax
801053f2:	78 28                	js     8010541c <sys_exec+0xac>
  for(i=0;; i++){
801053f4:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
801053f7:	83 fb 20             	cmp    $0x20,%ebx
801053fa:	74 20                	je     8010541c <sys_exec+0xac>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801053fc:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105402:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80105409:	83 ec 08             	sub    $0x8,%esp
8010540c:	57                   	push   %edi
8010540d:	01 f0                	add    %esi,%eax
8010540f:	50                   	push   %eax
80105410:	e8 4b f3 ff ff       	call   80104760 <fetchint>
80105415:	83 c4 10             	add    $0x10,%esp
80105418:	85 c0                	test   %eax,%eax
8010541a:	79 b4                	jns    801053d0 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010541c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010541f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105424:	5b                   	pop    %ebx
80105425:	5e                   	pop    %esi
80105426:	5f                   	pop    %edi
80105427:	5d                   	pop    %ebp
80105428:	c3                   	ret    
80105429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80105430:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105436:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
80105439:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105440:	00 00 00 00 
  return exec(path, argv);
80105444:	50                   	push   %eax
80105445:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
8010544b:	e8 c0 b5 ff ff       	call   80100a10 <exec>
80105450:	83 c4 10             	add    $0x10,%esp
}
80105453:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105456:	5b                   	pop    %ebx
80105457:	5e                   	pop    %esi
80105458:	5f                   	pop    %edi
80105459:	5d                   	pop    %ebp
8010545a:	c3                   	ret    
8010545b:	90                   	nop
8010545c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105460 <sys_pipe>:

int
sys_pipe(void)
{
80105460:	55                   	push   %ebp
80105461:	89 e5                	mov    %esp,%ebp
80105463:	57                   	push   %edi
80105464:	56                   	push   %esi
80105465:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105466:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105469:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010546c:	6a 08                	push   $0x8
8010546e:	50                   	push   %eax
8010546f:	6a 00                	push   $0x0
80105471:	e8 ea f3 ff ff       	call   80104860 <argptr>
80105476:	83 c4 10             	add    $0x10,%esp
80105479:	85 c0                	test   %eax,%eax
8010547b:	0f 88 ae 00 00 00    	js     8010552f <sys_pipe+0xcf>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105481:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105484:	83 ec 08             	sub    $0x8,%esp
80105487:	50                   	push   %eax
80105488:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010548b:	50                   	push   %eax
8010548c:	e8 6f de ff ff       	call   80103300 <pipealloc>
80105491:	83 c4 10             	add    $0x10,%esp
80105494:	85 c0                	test   %eax,%eax
80105496:	0f 88 93 00 00 00    	js     8010552f <sys_pipe+0xcf>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010549c:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
8010549f:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801054a1:	e8 fa e3 ff ff       	call   801038a0 <myproc>
801054a6:	eb 10                	jmp    801054b8 <sys_pipe+0x58>
801054a8:	90                   	nop
801054a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
801054b0:	83 c3 01             	add    $0x1,%ebx
801054b3:	83 fb 10             	cmp    $0x10,%ebx
801054b6:	74 60                	je     80105518 <sys_pipe+0xb8>
    if(curproc->ofile[fd] == 0){
801054b8:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801054bc:	85 f6                	test   %esi,%esi
801054be:	75 f0                	jne    801054b0 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
801054c0:	8d 73 08             	lea    0x8(%ebx),%esi
801054c3:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801054c7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
801054ca:	e8 d1 e3 ff ff       	call   801038a0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801054cf:	31 d2                	xor    %edx,%edx
801054d1:	eb 0d                	jmp    801054e0 <sys_pipe+0x80>
801054d3:	90                   	nop
801054d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801054d8:	83 c2 01             	add    $0x1,%edx
801054db:	83 fa 10             	cmp    $0x10,%edx
801054de:	74 28                	je     80105508 <sys_pipe+0xa8>
    if(curproc->ofile[fd] == 0){
801054e0:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
801054e4:	85 c9                	test   %ecx,%ecx
801054e6:	75 f0                	jne    801054d8 <sys_pipe+0x78>
      curproc->ofile[fd] = f;
801054e8:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
801054ec:	8b 45 dc             	mov    -0x24(%ebp),%eax
801054ef:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
801054f1:	8b 45 dc             	mov    -0x24(%ebp),%eax
801054f4:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
801054f7:	31 c0                	xor    %eax,%eax
}
801054f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801054fc:	5b                   	pop    %ebx
801054fd:	5e                   	pop    %esi
801054fe:	5f                   	pop    %edi
801054ff:	5d                   	pop    %ebp
80105500:	c3                   	ret    
80105501:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      myproc()->ofile[fd0] = 0;
80105508:	e8 93 e3 ff ff       	call   801038a0 <myproc>
8010550d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105514:	00 
80105515:	8d 76 00             	lea    0x0(%esi),%esi
    fileclose(rf);
80105518:	83 ec 0c             	sub    $0xc,%esp
8010551b:	ff 75 e0             	pushl  -0x20(%ebp)
8010551e:	e8 1d b9 ff ff       	call   80100e40 <fileclose>
    fileclose(wf);
80105523:	58                   	pop    %eax
80105524:	ff 75 e4             	pushl  -0x1c(%ebp)
80105527:	e8 14 b9 ff ff       	call   80100e40 <fileclose>
    return -1;
8010552c:	83 c4 10             	add    $0x10,%esp
8010552f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105534:	eb c3                	jmp    801054f9 <sys_pipe+0x99>
80105536:	66 90                	xchg   %ax,%ax
80105538:	66 90                	xchg   %ax,%ax
8010553a:	66 90                	xchg   %ax,%ax
8010553c:	66 90                	xchg   %ax,%ax
8010553e:	66 90                	xchg   %ax,%ax

80105540 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80105540:	55                   	push   %ebp
80105541:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105543:	5d                   	pop    %ebp
  return fork();
80105544:	e9 f7 e4 ff ff       	jmp    80103a40 <fork>
80105549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105550 <sys_exit>:

int
sys_exit(void)
{
80105550:	55                   	push   %ebp
80105551:	89 e5                	mov    %esp,%ebp
80105553:	83 ec 08             	sub    $0x8,%esp
  exit();
80105556:	e8 65 e7 ff ff       	call   80103cc0 <exit>
  return 0;  // not reached
}
8010555b:	31 c0                	xor    %eax,%eax
8010555d:	c9                   	leave  
8010555e:	c3                   	ret    
8010555f:	90                   	nop

80105560 <sys_wait>:

int
sys_wait(void)
{
80105560:	55                   	push   %ebp
80105561:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105563:	5d                   	pop    %ebp
  return wait();
80105564:	e9 97 e9 ff ff       	jmp    80103f00 <wait>
80105569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105570 <sys_kill>:

int
sys_kill(void)
{
80105570:	55                   	push   %ebp
80105571:	89 e5                	mov    %esp,%ebp
80105573:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105576:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105579:	50                   	push   %eax
8010557a:	6a 00                	push   $0x0
8010557c:	e8 8f f2 ff ff       	call   80104810 <argint>
80105581:	83 c4 10             	add    $0x10,%esp
80105584:	85 c0                	test   %eax,%eax
80105586:	78 18                	js     801055a0 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105588:	83 ec 0c             	sub    $0xc,%esp
8010558b:	ff 75 f4             	pushl  -0xc(%ebp)
8010558e:	e8 bd ea ff ff       	call   80104050 <kill>
80105593:	83 c4 10             	add    $0x10,%esp
}
80105596:	c9                   	leave  
80105597:	c3                   	ret    
80105598:	90                   	nop
80105599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801055a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801055a5:	c9                   	leave  
801055a6:	c3                   	ret    
801055a7:	89 f6                	mov    %esi,%esi
801055a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801055b0 <sys_getpid>:

int
sys_getpid(void)
{
801055b0:	55                   	push   %ebp
801055b1:	89 e5                	mov    %esp,%ebp
801055b3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
801055b6:	e8 e5 e2 ff ff       	call   801038a0 <myproc>
801055bb:	8b 40 10             	mov    0x10(%eax),%eax
}
801055be:	c9                   	leave  
801055bf:	c3                   	ret    

801055c0 <sys_sbrk>:

int
sys_sbrk(void)
{
801055c0:	55                   	push   %ebp
801055c1:	89 e5                	mov    %esp,%ebp
801055c3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
801055c4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801055c7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801055ca:	50                   	push   %eax
801055cb:	6a 00                	push   $0x0
801055cd:	e8 3e f2 ff ff       	call   80104810 <argint>
801055d2:	83 c4 10             	add    $0x10,%esp
801055d5:	85 c0                	test   %eax,%eax
801055d7:	78 27                	js     80105600 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
801055d9:	e8 c2 e2 ff ff       	call   801038a0 <myproc>
  if(growproc(n) < 0)
801055de:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
801055e1:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
801055e3:	ff 75 f4             	pushl  -0xc(%ebp)
801055e6:	e8 d5 e3 ff ff       	call   801039c0 <growproc>
801055eb:	83 c4 10             	add    $0x10,%esp
801055ee:	85 c0                	test   %eax,%eax
801055f0:	78 0e                	js     80105600 <sys_sbrk+0x40>
    return -1;
  return addr;
}
801055f2:	89 d8                	mov    %ebx,%eax
801055f4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801055f7:	c9                   	leave  
801055f8:	c3                   	ret    
801055f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105600:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105605:	eb eb                	jmp    801055f2 <sys_sbrk+0x32>
80105607:	89 f6                	mov    %esi,%esi
80105609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105610 <sys_sleep>:

int
sys_sleep(void)
{
80105610:	55                   	push   %ebp
80105611:	89 e5                	mov    %esp,%ebp
80105613:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105614:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105617:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010561a:	50                   	push   %eax
8010561b:	6a 00                	push   $0x0
8010561d:	e8 ee f1 ff ff       	call   80104810 <argint>
80105622:	83 c4 10             	add    $0x10,%esp
80105625:	85 c0                	test   %eax,%eax
80105627:	0f 88 8a 00 00 00    	js     801056b7 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
8010562d:	83 ec 0c             	sub    $0xc,%esp
80105630:	68 60 4c 11 80       	push   $0x80114c60
80105635:	e8 c6 ed ff ff       	call   80104400 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010563a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010563d:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80105640:	8b 1d a0 54 11 80    	mov    0x801154a0,%ebx
  while(ticks - ticks0 < n){
80105646:	85 d2                	test   %edx,%edx
80105648:	75 27                	jne    80105671 <sys_sleep+0x61>
8010564a:	eb 54                	jmp    801056a0 <sys_sleep+0x90>
8010564c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105650:	83 ec 08             	sub    $0x8,%esp
80105653:	68 60 4c 11 80       	push   $0x80114c60
80105658:	68 a0 54 11 80       	push   $0x801154a0
8010565d:	e8 de e7 ff ff       	call   80103e40 <sleep>
  while(ticks - ticks0 < n){
80105662:	a1 a0 54 11 80       	mov    0x801154a0,%eax
80105667:	83 c4 10             	add    $0x10,%esp
8010566a:	29 d8                	sub    %ebx,%eax
8010566c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010566f:	73 2f                	jae    801056a0 <sys_sleep+0x90>
    if(myproc()->killed){
80105671:	e8 2a e2 ff ff       	call   801038a0 <myproc>
80105676:	8b 40 24             	mov    0x24(%eax),%eax
80105679:	85 c0                	test   %eax,%eax
8010567b:	74 d3                	je     80105650 <sys_sleep+0x40>
      release(&tickslock);
8010567d:	83 ec 0c             	sub    $0xc,%esp
80105680:	68 60 4c 11 80       	push   $0x80114c60
80105685:	e8 36 ee ff ff       	call   801044c0 <release>
      return -1;
8010568a:	83 c4 10             	add    $0x10,%esp
8010568d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
80105692:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105695:	c9                   	leave  
80105696:	c3                   	ret    
80105697:	89 f6                	mov    %esi,%esi
80105699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
801056a0:	83 ec 0c             	sub    $0xc,%esp
801056a3:	68 60 4c 11 80       	push   $0x80114c60
801056a8:	e8 13 ee ff ff       	call   801044c0 <release>
  return 0;
801056ad:	83 c4 10             	add    $0x10,%esp
801056b0:	31 c0                	xor    %eax,%eax
}
801056b2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801056b5:	c9                   	leave  
801056b6:	c3                   	ret    
    return -1;
801056b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056bc:	eb f4                	jmp    801056b2 <sys_sleep+0xa2>
801056be:	66 90                	xchg   %ax,%ax

801056c0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801056c0:	55                   	push   %ebp
801056c1:	89 e5                	mov    %esp,%ebp
801056c3:	53                   	push   %ebx
801056c4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
801056c7:	68 60 4c 11 80       	push   $0x80114c60
801056cc:	e8 2f ed ff ff       	call   80104400 <acquire>
  xticks = ticks;
801056d1:	8b 1d a0 54 11 80    	mov    0x801154a0,%ebx
  release(&tickslock);
801056d7:	c7 04 24 60 4c 11 80 	movl   $0x80114c60,(%esp)
801056de:	e8 dd ed ff ff       	call   801044c0 <release>
  return xticks;
}
801056e3:	89 d8                	mov    %ebx,%eax
801056e5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801056e8:	c9                   	leave  
801056e9:	c3                   	ret    

801056ea <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
801056ea:	1e                   	push   %ds
  pushl %es
801056eb:	06                   	push   %es
  pushl %fs
801056ec:	0f a0                	push   %fs
  pushl %gs
801056ee:	0f a8                	push   %gs
  pushal
801056f0:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
801056f1:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
801056f5:	8e d8                	mov    %eax,%ds
  movw %ax, %es
801056f7:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
801056f9:	54                   	push   %esp
  call trap
801056fa:	e8 c1 00 00 00       	call   801057c0 <trap>
  addl $4, %esp
801056ff:	83 c4 04             	add    $0x4,%esp

80105702 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105702:	61                   	popa   
  popl %gs
80105703:	0f a9                	pop    %gs
  popl %fs
80105705:	0f a1                	pop    %fs
  popl %es
80105707:	07                   	pop    %es
  popl %ds
80105708:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105709:	83 c4 08             	add    $0x8,%esp
  iret
8010570c:	cf                   	iret   
8010570d:	66 90                	xchg   %ax,%ax
8010570f:	90                   	nop

80105710 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105710:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105711:	31 c0                	xor    %eax,%eax
{
80105713:	89 e5                	mov    %esp,%ebp
80105715:	83 ec 08             	sub    $0x8,%esp
80105718:	90                   	nop
80105719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105720:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
80105727:	c7 04 c5 a2 4c 11 80 	movl   $0x8e000008,-0x7feeb35e(,%eax,8)
8010572e:	08 00 00 8e 
80105732:	66 89 14 c5 a0 4c 11 	mov    %dx,-0x7feeb360(,%eax,8)
80105739:	80 
8010573a:	c1 ea 10             	shr    $0x10,%edx
8010573d:	66 89 14 c5 a6 4c 11 	mov    %dx,-0x7feeb35a(,%eax,8)
80105744:	80 
  for(i = 0; i < 256; i++)
80105745:	83 c0 01             	add    $0x1,%eax
80105748:	3d 00 01 00 00       	cmp    $0x100,%eax
8010574d:	75 d1                	jne    80105720 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010574f:	a1 08 a1 10 80       	mov    0x8010a108,%eax

  initlock(&tickslock, "time");
80105754:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105757:	c7 05 a2 4e 11 80 08 	movl   $0xef000008,0x80114ea2
8010575e:	00 00 ef 
  initlock(&tickslock, "time");
80105761:	68 19 77 10 80       	push   $0x80107719
80105766:	68 60 4c 11 80       	push   $0x80114c60
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010576b:	66 a3 a0 4e 11 80    	mov    %ax,0x80114ea0
80105771:	c1 e8 10             	shr    $0x10,%eax
80105774:	66 a3 a6 4e 11 80    	mov    %ax,0x80114ea6
  initlock(&tickslock, "time");
8010577a:	e8 41 eb ff ff       	call   801042c0 <initlock>
}
8010577f:	83 c4 10             	add    $0x10,%esp
80105782:	c9                   	leave  
80105783:	c3                   	ret    
80105784:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010578a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105790 <idtinit>:

void
idtinit(void)
{
80105790:	55                   	push   %ebp
  pd[0] = size-1;
80105791:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105796:	89 e5                	mov    %esp,%ebp
80105798:	83 ec 10             	sub    $0x10,%esp
8010579b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010579f:	b8 a0 4c 11 80       	mov    $0x80114ca0,%eax
801057a4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801057a8:	c1 e8 10             	shr    $0x10,%eax
801057ab:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
801057af:	8d 45 fa             	lea    -0x6(%ebp),%eax
801057b2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
801057b5:	c9                   	leave  
801057b6:	c3                   	ret    
801057b7:	89 f6                	mov    %esi,%esi
801057b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801057c0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801057c0:	55                   	push   %ebp
801057c1:	89 e5                	mov    %esp,%ebp
801057c3:	57                   	push   %edi
801057c4:	56                   	push   %esi
801057c5:	53                   	push   %ebx
801057c6:	83 ec 1c             	sub    $0x1c,%esp
801057c9:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
801057cc:	8b 47 30             	mov    0x30(%edi),%eax
801057cf:	83 f8 40             	cmp    $0x40,%eax
801057d2:	0f 84 f0 00 00 00    	je     801058c8 <trap+0x108>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
801057d8:	83 e8 20             	sub    $0x20,%eax
801057db:	83 f8 1f             	cmp    $0x1f,%eax
801057de:	77 10                	ja     801057f0 <trap+0x30>
801057e0:	ff 24 85 c0 77 10 80 	jmp    *-0x7fef8840(,%eax,4)
801057e7:	89 f6                	mov    %esi,%esi
801057e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
801057f0:	e8 ab e0 ff ff       	call   801038a0 <myproc>
801057f5:	85 c0                	test   %eax,%eax
801057f7:	8b 5f 38             	mov    0x38(%edi),%ebx
801057fa:	0f 84 14 02 00 00    	je     80105a14 <trap+0x254>
80105800:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80105804:	0f 84 0a 02 00 00    	je     80105a14 <trap+0x254>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
8010580a:	0f 20 d1             	mov    %cr2,%ecx
8010580d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105810:	e8 6b e0 ff ff       	call   80103880 <cpuid>
80105815:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105818:	8b 47 34             	mov    0x34(%edi),%eax
8010581b:	8b 77 30             	mov    0x30(%edi),%esi
8010581e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105821:	e8 7a e0 ff ff       	call   801038a0 <myproc>
80105826:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105829:	e8 72 e0 ff ff       	call   801038a0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010582e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105831:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105834:	51                   	push   %ecx
80105835:	53                   	push   %ebx
80105836:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
80105837:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010583a:	ff 75 e4             	pushl  -0x1c(%ebp)
8010583d:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
8010583e:	83 c2 6c             	add    $0x6c,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105841:	52                   	push   %edx
80105842:	ff 70 10             	pushl  0x10(%eax)
80105845:	68 7c 77 10 80       	push   $0x8010777c
8010584a:	e8 11 ae ff ff       	call   80100660 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
8010584f:	83 c4 20             	add    $0x20,%esp
80105852:	e8 49 e0 ff ff       	call   801038a0 <myproc>
80105857:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010585e:	e8 3d e0 ff ff       	call   801038a0 <myproc>
80105863:	85 c0                	test   %eax,%eax
80105865:	74 1d                	je     80105884 <trap+0xc4>
80105867:	e8 34 e0 ff ff       	call   801038a0 <myproc>
8010586c:	8b 50 24             	mov    0x24(%eax),%edx
8010586f:	85 d2                	test   %edx,%edx
80105871:	74 11                	je     80105884 <trap+0xc4>
80105873:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105877:	83 e0 03             	and    $0x3,%eax
8010587a:	66 83 f8 03          	cmp    $0x3,%ax
8010587e:	0f 84 4c 01 00 00    	je     801059d0 <trap+0x210>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105884:	e8 17 e0 ff ff       	call   801038a0 <myproc>
80105889:	85 c0                	test   %eax,%eax
8010588b:	74 0b                	je     80105898 <trap+0xd8>
8010588d:	e8 0e e0 ff ff       	call   801038a0 <myproc>
80105892:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105896:	74 68                	je     80105900 <trap+0x140>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105898:	e8 03 e0 ff ff       	call   801038a0 <myproc>
8010589d:	85 c0                	test   %eax,%eax
8010589f:	74 19                	je     801058ba <trap+0xfa>
801058a1:	e8 fa df ff ff       	call   801038a0 <myproc>
801058a6:	8b 40 24             	mov    0x24(%eax),%eax
801058a9:	85 c0                	test   %eax,%eax
801058ab:	74 0d                	je     801058ba <trap+0xfa>
801058ad:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
801058b1:	83 e0 03             	and    $0x3,%eax
801058b4:	66 83 f8 03          	cmp    $0x3,%ax
801058b8:	74 37                	je     801058f1 <trap+0x131>
    exit();
}
801058ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
801058bd:	5b                   	pop    %ebx
801058be:	5e                   	pop    %esi
801058bf:	5f                   	pop    %edi
801058c0:	5d                   	pop    %ebp
801058c1:	c3                   	ret    
801058c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed)
801058c8:	e8 d3 df ff ff       	call   801038a0 <myproc>
801058cd:	8b 58 24             	mov    0x24(%eax),%ebx
801058d0:	85 db                	test   %ebx,%ebx
801058d2:	0f 85 e8 00 00 00    	jne    801059c0 <trap+0x200>
    myproc()->tf = tf;
801058d8:	e8 c3 df ff ff       	call   801038a0 <myproc>
801058dd:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
801058e0:	e8 1b f0 ff ff       	call   80104900 <syscall>
    if(myproc()->killed)
801058e5:	e8 b6 df ff ff       	call   801038a0 <myproc>
801058ea:	8b 48 24             	mov    0x24(%eax),%ecx
801058ed:	85 c9                	test   %ecx,%ecx
801058ef:	74 c9                	je     801058ba <trap+0xfa>
}
801058f1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801058f4:	5b                   	pop    %ebx
801058f5:	5e                   	pop    %esi
801058f6:	5f                   	pop    %edi
801058f7:	5d                   	pop    %ebp
      exit();
801058f8:	e9 c3 e3 ff ff       	jmp    80103cc0 <exit>
801058fd:	8d 76 00             	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
80105900:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80105904:	75 92                	jne    80105898 <trap+0xd8>
    yield();
80105906:	e8 e5 e4 ff ff       	call   80103df0 <yield>
8010590b:	eb 8b                	jmp    80105898 <trap+0xd8>
8010590d:	8d 76 00             	lea    0x0(%esi),%esi
    if(cpuid() == 0){
80105910:	e8 6b df ff ff       	call   80103880 <cpuid>
80105915:	85 c0                	test   %eax,%eax
80105917:	0f 84 c3 00 00 00    	je     801059e0 <trap+0x220>
    lapiceoi();
8010591d:	e8 ee ce ff ff       	call   80102810 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105922:	e8 79 df ff ff       	call   801038a0 <myproc>
80105927:	85 c0                	test   %eax,%eax
80105929:	0f 85 38 ff ff ff    	jne    80105867 <trap+0xa7>
8010592f:	e9 50 ff ff ff       	jmp    80105884 <trap+0xc4>
80105934:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80105938:	e8 93 cd ff ff       	call   801026d0 <kbdintr>
    lapiceoi();
8010593d:	e8 ce ce ff ff       	call   80102810 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105942:	e8 59 df ff ff       	call   801038a0 <myproc>
80105947:	85 c0                	test   %eax,%eax
80105949:	0f 85 18 ff ff ff    	jne    80105867 <trap+0xa7>
8010594f:	e9 30 ff ff ff       	jmp    80105884 <trap+0xc4>
80105954:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80105958:	e8 53 02 00 00       	call   80105bb0 <uartintr>
    lapiceoi();
8010595d:	e8 ae ce ff ff       	call   80102810 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105962:	e8 39 df ff ff       	call   801038a0 <myproc>
80105967:	85 c0                	test   %eax,%eax
80105969:	0f 85 f8 fe ff ff    	jne    80105867 <trap+0xa7>
8010596f:	e9 10 ff ff ff       	jmp    80105884 <trap+0xc4>
80105974:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105978:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
8010597c:	8b 77 38             	mov    0x38(%edi),%esi
8010597f:	e8 fc de ff ff       	call   80103880 <cpuid>
80105984:	56                   	push   %esi
80105985:	53                   	push   %ebx
80105986:	50                   	push   %eax
80105987:	68 24 77 10 80       	push   $0x80107724
8010598c:	e8 cf ac ff ff       	call   80100660 <cprintf>
    lapiceoi();
80105991:	e8 7a ce ff ff       	call   80102810 <lapiceoi>
    break;
80105996:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105999:	e8 02 df ff ff       	call   801038a0 <myproc>
8010599e:	85 c0                	test   %eax,%eax
801059a0:	0f 85 c1 fe ff ff    	jne    80105867 <trap+0xa7>
801059a6:	e9 d9 fe ff ff       	jmp    80105884 <trap+0xc4>
801059ab:	90                   	nop
801059ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
801059b0:	e8 8b c7 ff ff       	call   80102140 <ideintr>
801059b5:	e9 63 ff ff ff       	jmp    8010591d <trap+0x15d>
801059ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
801059c0:	e8 fb e2 ff ff       	call   80103cc0 <exit>
801059c5:	e9 0e ff ff ff       	jmp    801058d8 <trap+0x118>
801059ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
801059d0:	e8 eb e2 ff ff       	call   80103cc0 <exit>
801059d5:	e9 aa fe ff ff       	jmp    80105884 <trap+0xc4>
801059da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
801059e0:	83 ec 0c             	sub    $0xc,%esp
801059e3:	68 60 4c 11 80       	push   $0x80114c60
801059e8:	e8 13 ea ff ff       	call   80104400 <acquire>
      wakeup(&ticks);
801059ed:	c7 04 24 a0 54 11 80 	movl   $0x801154a0,(%esp)
      ticks++;
801059f4:	83 05 a0 54 11 80 01 	addl   $0x1,0x801154a0
      wakeup(&ticks);
801059fb:	e8 f0 e5 ff ff       	call   80103ff0 <wakeup>
      release(&tickslock);
80105a00:	c7 04 24 60 4c 11 80 	movl   $0x80114c60,(%esp)
80105a07:	e8 b4 ea ff ff       	call   801044c0 <release>
80105a0c:	83 c4 10             	add    $0x10,%esp
80105a0f:	e9 09 ff ff ff       	jmp    8010591d <trap+0x15d>
80105a14:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105a17:	e8 64 de ff ff       	call   80103880 <cpuid>
80105a1c:	83 ec 0c             	sub    $0xc,%esp
80105a1f:	56                   	push   %esi
80105a20:	53                   	push   %ebx
80105a21:	50                   	push   %eax
80105a22:	ff 77 30             	pushl  0x30(%edi)
80105a25:	68 48 77 10 80       	push   $0x80107748
80105a2a:	e8 31 ac ff ff       	call   80100660 <cprintf>
      panic("trap");
80105a2f:	83 c4 14             	add    $0x14,%esp
80105a32:	68 1e 77 10 80       	push   $0x8010771e
80105a37:	e8 54 a9 ff ff       	call   80100390 <panic>
80105a3c:	66 90                	xchg   %ax,%ax
80105a3e:	66 90                	xchg   %ax,%ax

80105a40 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105a40:	a1 bc a5 10 80       	mov    0x8010a5bc,%eax
{
80105a45:	55                   	push   %ebp
80105a46:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105a48:	85 c0                	test   %eax,%eax
80105a4a:	74 1c                	je     80105a68 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105a4c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105a51:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105a52:	a8 01                	test   $0x1,%al
80105a54:	74 12                	je     80105a68 <uartgetc+0x28>
80105a56:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105a5b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105a5c:	0f b6 c0             	movzbl %al,%eax
}
80105a5f:	5d                   	pop    %ebp
80105a60:	c3                   	ret    
80105a61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105a68:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105a6d:	5d                   	pop    %ebp
80105a6e:	c3                   	ret    
80105a6f:	90                   	nop

80105a70 <uartputc.part.0>:
uartputc(int c)
80105a70:	55                   	push   %ebp
80105a71:	89 e5                	mov    %esp,%ebp
80105a73:	57                   	push   %edi
80105a74:	56                   	push   %esi
80105a75:	53                   	push   %ebx
80105a76:	89 c7                	mov    %eax,%edi
80105a78:	bb 80 00 00 00       	mov    $0x80,%ebx
80105a7d:	be fd 03 00 00       	mov    $0x3fd,%esi
80105a82:	83 ec 0c             	sub    $0xc,%esp
80105a85:	eb 1b                	jmp    80105aa2 <uartputc.part.0+0x32>
80105a87:	89 f6                	mov    %esi,%esi
80105a89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80105a90:	83 ec 0c             	sub    $0xc,%esp
80105a93:	6a 0a                	push   $0xa
80105a95:	e8 96 cd ff ff       	call   80102830 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105a9a:	83 c4 10             	add    $0x10,%esp
80105a9d:	83 eb 01             	sub    $0x1,%ebx
80105aa0:	74 07                	je     80105aa9 <uartputc.part.0+0x39>
80105aa2:	89 f2                	mov    %esi,%edx
80105aa4:	ec                   	in     (%dx),%al
80105aa5:	a8 20                	test   $0x20,%al
80105aa7:	74 e7                	je     80105a90 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105aa9:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105aae:	89 f8                	mov    %edi,%eax
80105ab0:	ee                   	out    %al,(%dx)
}
80105ab1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ab4:	5b                   	pop    %ebx
80105ab5:	5e                   	pop    %esi
80105ab6:	5f                   	pop    %edi
80105ab7:	5d                   	pop    %ebp
80105ab8:	c3                   	ret    
80105ab9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105ac0 <uartinit>:
{
80105ac0:	55                   	push   %ebp
80105ac1:	31 c9                	xor    %ecx,%ecx
80105ac3:	89 c8                	mov    %ecx,%eax
80105ac5:	89 e5                	mov    %esp,%ebp
80105ac7:	57                   	push   %edi
80105ac8:	56                   	push   %esi
80105ac9:	53                   	push   %ebx
80105aca:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105acf:	89 da                	mov    %ebx,%edx
80105ad1:	83 ec 0c             	sub    $0xc,%esp
80105ad4:	ee                   	out    %al,(%dx)
80105ad5:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105ada:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105adf:	89 fa                	mov    %edi,%edx
80105ae1:	ee                   	out    %al,(%dx)
80105ae2:	b8 0c 00 00 00       	mov    $0xc,%eax
80105ae7:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105aec:	ee                   	out    %al,(%dx)
80105aed:	be f9 03 00 00       	mov    $0x3f9,%esi
80105af2:	89 c8                	mov    %ecx,%eax
80105af4:	89 f2                	mov    %esi,%edx
80105af6:	ee                   	out    %al,(%dx)
80105af7:	b8 03 00 00 00       	mov    $0x3,%eax
80105afc:	89 fa                	mov    %edi,%edx
80105afe:	ee                   	out    %al,(%dx)
80105aff:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105b04:	89 c8                	mov    %ecx,%eax
80105b06:	ee                   	out    %al,(%dx)
80105b07:	b8 01 00 00 00       	mov    $0x1,%eax
80105b0c:	89 f2                	mov    %esi,%edx
80105b0e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105b0f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105b14:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105b15:	3c ff                	cmp    $0xff,%al
80105b17:	74 5a                	je     80105b73 <uartinit+0xb3>
  uart = 1;
80105b19:	c7 05 bc a5 10 80 01 	movl   $0x1,0x8010a5bc
80105b20:	00 00 00 
80105b23:	89 da                	mov    %ebx,%edx
80105b25:	ec                   	in     (%dx),%al
80105b26:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105b2b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80105b2c:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
80105b2f:	bb 40 78 10 80       	mov    $0x80107840,%ebx
  ioapicenable(IRQ_COM1, 0);
80105b34:	6a 00                	push   $0x0
80105b36:	6a 04                	push   $0x4
80105b38:	e8 53 c8 ff ff       	call   80102390 <ioapicenable>
80105b3d:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80105b40:	b8 78 00 00 00       	mov    $0x78,%eax
80105b45:	eb 13                	jmp    80105b5a <uartinit+0x9a>
80105b47:	89 f6                	mov    %esi,%esi
80105b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105b50:	83 c3 01             	add    $0x1,%ebx
80105b53:	0f be 03             	movsbl (%ebx),%eax
80105b56:	84 c0                	test   %al,%al
80105b58:	74 19                	je     80105b73 <uartinit+0xb3>
  if(!uart)
80105b5a:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
80105b60:	85 d2                	test   %edx,%edx
80105b62:	74 ec                	je     80105b50 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
80105b64:	83 c3 01             	add    $0x1,%ebx
80105b67:	e8 04 ff ff ff       	call   80105a70 <uartputc.part.0>
80105b6c:	0f be 03             	movsbl (%ebx),%eax
80105b6f:	84 c0                	test   %al,%al
80105b71:	75 e7                	jne    80105b5a <uartinit+0x9a>
}
80105b73:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b76:	5b                   	pop    %ebx
80105b77:	5e                   	pop    %esi
80105b78:	5f                   	pop    %edi
80105b79:	5d                   	pop    %ebp
80105b7a:	c3                   	ret    
80105b7b:	90                   	nop
80105b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105b80 <uartputc>:
  if(!uart)
80105b80:	8b 15 bc a5 10 80    	mov    0x8010a5bc,%edx
{
80105b86:	55                   	push   %ebp
80105b87:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105b89:	85 d2                	test   %edx,%edx
{
80105b8b:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
80105b8e:	74 10                	je     80105ba0 <uartputc+0x20>
}
80105b90:	5d                   	pop    %ebp
80105b91:	e9 da fe ff ff       	jmp    80105a70 <uartputc.part.0>
80105b96:	8d 76 00             	lea    0x0(%esi),%esi
80105b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105ba0:	5d                   	pop    %ebp
80105ba1:	c3                   	ret    
80105ba2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105bb0 <uartintr>:

void
uartintr(void)
{
80105bb0:	55                   	push   %ebp
80105bb1:	89 e5                	mov    %esp,%ebp
80105bb3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105bb6:	68 40 5a 10 80       	push   $0x80105a40
80105bbb:	e8 50 ac ff ff       	call   80100810 <consoleintr>
}
80105bc0:	83 c4 10             	add    $0x10,%esp
80105bc3:	c9                   	leave  
80105bc4:	c3                   	ret    

80105bc5 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105bc5:	6a 00                	push   $0x0
  pushl $0
80105bc7:	6a 00                	push   $0x0
  jmp alltraps
80105bc9:	e9 1c fb ff ff       	jmp    801056ea <alltraps>

80105bce <vector1>:
.globl vector1
vector1:
  pushl $0
80105bce:	6a 00                	push   $0x0
  pushl $1
80105bd0:	6a 01                	push   $0x1
  jmp alltraps
80105bd2:	e9 13 fb ff ff       	jmp    801056ea <alltraps>

80105bd7 <vector2>:
.globl vector2
vector2:
  pushl $0
80105bd7:	6a 00                	push   $0x0
  pushl $2
80105bd9:	6a 02                	push   $0x2
  jmp alltraps
80105bdb:	e9 0a fb ff ff       	jmp    801056ea <alltraps>

80105be0 <vector3>:
.globl vector3
vector3:
  pushl $0
80105be0:	6a 00                	push   $0x0
  pushl $3
80105be2:	6a 03                	push   $0x3
  jmp alltraps
80105be4:	e9 01 fb ff ff       	jmp    801056ea <alltraps>

80105be9 <vector4>:
.globl vector4
vector4:
  pushl $0
80105be9:	6a 00                	push   $0x0
  pushl $4
80105beb:	6a 04                	push   $0x4
  jmp alltraps
80105bed:	e9 f8 fa ff ff       	jmp    801056ea <alltraps>

80105bf2 <vector5>:
.globl vector5
vector5:
  pushl $0
80105bf2:	6a 00                	push   $0x0
  pushl $5
80105bf4:	6a 05                	push   $0x5
  jmp alltraps
80105bf6:	e9 ef fa ff ff       	jmp    801056ea <alltraps>

80105bfb <vector6>:
.globl vector6
vector6:
  pushl $0
80105bfb:	6a 00                	push   $0x0
  pushl $6
80105bfd:	6a 06                	push   $0x6
  jmp alltraps
80105bff:	e9 e6 fa ff ff       	jmp    801056ea <alltraps>

80105c04 <vector7>:
.globl vector7
vector7:
  pushl $0
80105c04:	6a 00                	push   $0x0
  pushl $7
80105c06:	6a 07                	push   $0x7
  jmp alltraps
80105c08:	e9 dd fa ff ff       	jmp    801056ea <alltraps>

80105c0d <vector8>:
.globl vector8
vector8:
  pushl $8
80105c0d:	6a 08                	push   $0x8
  jmp alltraps
80105c0f:	e9 d6 fa ff ff       	jmp    801056ea <alltraps>

80105c14 <vector9>:
.globl vector9
vector9:
  pushl $0
80105c14:	6a 00                	push   $0x0
  pushl $9
80105c16:	6a 09                	push   $0x9
  jmp alltraps
80105c18:	e9 cd fa ff ff       	jmp    801056ea <alltraps>

80105c1d <vector10>:
.globl vector10
vector10:
  pushl $10
80105c1d:	6a 0a                	push   $0xa
  jmp alltraps
80105c1f:	e9 c6 fa ff ff       	jmp    801056ea <alltraps>

80105c24 <vector11>:
.globl vector11
vector11:
  pushl $11
80105c24:	6a 0b                	push   $0xb
  jmp alltraps
80105c26:	e9 bf fa ff ff       	jmp    801056ea <alltraps>

80105c2b <vector12>:
.globl vector12
vector12:
  pushl $12
80105c2b:	6a 0c                	push   $0xc
  jmp alltraps
80105c2d:	e9 b8 fa ff ff       	jmp    801056ea <alltraps>

80105c32 <vector13>:
.globl vector13
vector13:
  pushl $13
80105c32:	6a 0d                	push   $0xd
  jmp alltraps
80105c34:	e9 b1 fa ff ff       	jmp    801056ea <alltraps>

80105c39 <vector14>:
.globl vector14
vector14:
  pushl $14
80105c39:	6a 0e                	push   $0xe
  jmp alltraps
80105c3b:	e9 aa fa ff ff       	jmp    801056ea <alltraps>

80105c40 <vector15>:
.globl vector15
vector15:
  pushl $0
80105c40:	6a 00                	push   $0x0
  pushl $15
80105c42:	6a 0f                	push   $0xf
  jmp alltraps
80105c44:	e9 a1 fa ff ff       	jmp    801056ea <alltraps>

80105c49 <vector16>:
.globl vector16
vector16:
  pushl $0
80105c49:	6a 00                	push   $0x0
  pushl $16
80105c4b:	6a 10                	push   $0x10
  jmp alltraps
80105c4d:	e9 98 fa ff ff       	jmp    801056ea <alltraps>

80105c52 <vector17>:
.globl vector17
vector17:
  pushl $17
80105c52:	6a 11                	push   $0x11
  jmp alltraps
80105c54:	e9 91 fa ff ff       	jmp    801056ea <alltraps>

80105c59 <vector18>:
.globl vector18
vector18:
  pushl $0
80105c59:	6a 00                	push   $0x0
  pushl $18
80105c5b:	6a 12                	push   $0x12
  jmp alltraps
80105c5d:	e9 88 fa ff ff       	jmp    801056ea <alltraps>

80105c62 <vector19>:
.globl vector19
vector19:
  pushl $0
80105c62:	6a 00                	push   $0x0
  pushl $19
80105c64:	6a 13                	push   $0x13
  jmp alltraps
80105c66:	e9 7f fa ff ff       	jmp    801056ea <alltraps>

80105c6b <vector20>:
.globl vector20
vector20:
  pushl $0
80105c6b:	6a 00                	push   $0x0
  pushl $20
80105c6d:	6a 14                	push   $0x14
  jmp alltraps
80105c6f:	e9 76 fa ff ff       	jmp    801056ea <alltraps>

80105c74 <vector21>:
.globl vector21
vector21:
  pushl $0
80105c74:	6a 00                	push   $0x0
  pushl $21
80105c76:	6a 15                	push   $0x15
  jmp alltraps
80105c78:	e9 6d fa ff ff       	jmp    801056ea <alltraps>

80105c7d <vector22>:
.globl vector22
vector22:
  pushl $0
80105c7d:	6a 00                	push   $0x0
  pushl $22
80105c7f:	6a 16                	push   $0x16
  jmp alltraps
80105c81:	e9 64 fa ff ff       	jmp    801056ea <alltraps>

80105c86 <vector23>:
.globl vector23
vector23:
  pushl $0
80105c86:	6a 00                	push   $0x0
  pushl $23
80105c88:	6a 17                	push   $0x17
  jmp alltraps
80105c8a:	e9 5b fa ff ff       	jmp    801056ea <alltraps>

80105c8f <vector24>:
.globl vector24
vector24:
  pushl $0
80105c8f:	6a 00                	push   $0x0
  pushl $24
80105c91:	6a 18                	push   $0x18
  jmp alltraps
80105c93:	e9 52 fa ff ff       	jmp    801056ea <alltraps>

80105c98 <vector25>:
.globl vector25
vector25:
  pushl $0
80105c98:	6a 00                	push   $0x0
  pushl $25
80105c9a:	6a 19                	push   $0x19
  jmp alltraps
80105c9c:	e9 49 fa ff ff       	jmp    801056ea <alltraps>

80105ca1 <vector26>:
.globl vector26
vector26:
  pushl $0
80105ca1:	6a 00                	push   $0x0
  pushl $26
80105ca3:	6a 1a                	push   $0x1a
  jmp alltraps
80105ca5:	e9 40 fa ff ff       	jmp    801056ea <alltraps>

80105caa <vector27>:
.globl vector27
vector27:
  pushl $0
80105caa:	6a 00                	push   $0x0
  pushl $27
80105cac:	6a 1b                	push   $0x1b
  jmp alltraps
80105cae:	e9 37 fa ff ff       	jmp    801056ea <alltraps>

80105cb3 <vector28>:
.globl vector28
vector28:
  pushl $0
80105cb3:	6a 00                	push   $0x0
  pushl $28
80105cb5:	6a 1c                	push   $0x1c
  jmp alltraps
80105cb7:	e9 2e fa ff ff       	jmp    801056ea <alltraps>

80105cbc <vector29>:
.globl vector29
vector29:
  pushl $0
80105cbc:	6a 00                	push   $0x0
  pushl $29
80105cbe:	6a 1d                	push   $0x1d
  jmp alltraps
80105cc0:	e9 25 fa ff ff       	jmp    801056ea <alltraps>

80105cc5 <vector30>:
.globl vector30
vector30:
  pushl $0
80105cc5:	6a 00                	push   $0x0
  pushl $30
80105cc7:	6a 1e                	push   $0x1e
  jmp alltraps
80105cc9:	e9 1c fa ff ff       	jmp    801056ea <alltraps>

80105cce <vector31>:
.globl vector31
vector31:
  pushl $0
80105cce:	6a 00                	push   $0x0
  pushl $31
80105cd0:	6a 1f                	push   $0x1f
  jmp alltraps
80105cd2:	e9 13 fa ff ff       	jmp    801056ea <alltraps>

80105cd7 <vector32>:
.globl vector32
vector32:
  pushl $0
80105cd7:	6a 00                	push   $0x0
  pushl $32
80105cd9:	6a 20                	push   $0x20
  jmp alltraps
80105cdb:	e9 0a fa ff ff       	jmp    801056ea <alltraps>

80105ce0 <vector33>:
.globl vector33
vector33:
  pushl $0
80105ce0:	6a 00                	push   $0x0
  pushl $33
80105ce2:	6a 21                	push   $0x21
  jmp alltraps
80105ce4:	e9 01 fa ff ff       	jmp    801056ea <alltraps>

80105ce9 <vector34>:
.globl vector34
vector34:
  pushl $0
80105ce9:	6a 00                	push   $0x0
  pushl $34
80105ceb:	6a 22                	push   $0x22
  jmp alltraps
80105ced:	e9 f8 f9 ff ff       	jmp    801056ea <alltraps>

80105cf2 <vector35>:
.globl vector35
vector35:
  pushl $0
80105cf2:	6a 00                	push   $0x0
  pushl $35
80105cf4:	6a 23                	push   $0x23
  jmp alltraps
80105cf6:	e9 ef f9 ff ff       	jmp    801056ea <alltraps>

80105cfb <vector36>:
.globl vector36
vector36:
  pushl $0
80105cfb:	6a 00                	push   $0x0
  pushl $36
80105cfd:	6a 24                	push   $0x24
  jmp alltraps
80105cff:	e9 e6 f9 ff ff       	jmp    801056ea <alltraps>

80105d04 <vector37>:
.globl vector37
vector37:
  pushl $0
80105d04:	6a 00                	push   $0x0
  pushl $37
80105d06:	6a 25                	push   $0x25
  jmp alltraps
80105d08:	e9 dd f9 ff ff       	jmp    801056ea <alltraps>

80105d0d <vector38>:
.globl vector38
vector38:
  pushl $0
80105d0d:	6a 00                	push   $0x0
  pushl $38
80105d0f:	6a 26                	push   $0x26
  jmp alltraps
80105d11:	e9 d4 f9 ff ff       	jmp    801056ea <alltraps>

80105d16 <vector39>:
.globl vector39
vector39:
  pushl $0
80105d16:	6a 00                	push   $0x0
  pushl $39
80105d18:	6a 27                	push   $0x27
  jmp alltraps
80105d1a:	e9 cb f9 ff ff       	jmp    801056ea <alltraps>

80105d1f <vector40>:
.globl vector40
vector40:
  pushl $0
80105d1f:	6a 00                	push   $0x0
  pushl $40
80105d21:	6a 28                	push   $0x28
  jmp alltraps
80105d23:	e9 c2 f9 ff ff       	jmp    801056ea <alltraps>

80105d28 <vector41>:
.globl vector41
vector41:
  pushl $0
80105d28:	6a 00                	push   $0x0
  pushl $41
80105d2a:	6a 29                	push   $0x29
  jmp alltraps
80105d2c:	e9 b9 f9 ff ff       	jmp    801056ea <alltraps>

80105d31 <vector42>:
.globl vector42
vector42:
  pushl $0
80105d31:	6a 00                	push   $0x0
  pushl $42
80105d33:	6a 2a                	push   $0x2a
  jmp alltraps
80105d35:	e9 b0 f9 ff ff       	jmp    801056ea <alltraps>

80105d3a <vector43>:
.globl vector43
vector43:
  pushl $0
80105d3a:	6a 00                	push   $0x0
  pushl $43
80105d3c:	6a 2b                	push   $0x2b
  jmp alltraps
80105d3e:	e9 a7 f9 ff ff       	jmp    801056ea <alltraps>

80105d43 <vector44>:
.globl vector44
vector44:
  pushl $0
80105d43:	6a 00                	push   $0x0
  pushl $44
80105d45:	6a 2c                	push   $0x2c
  jmp alltraps
80105d47:	e9 9e f9 ff ff       	jmp    801056ea <alltraps>

80105d4c <vector45>:
.globl vector45
vector45:
  pushl $0
80105d4c:	6a 00                	push   $0x0
  pushl $45
80105d4e:	6a 2d                	push   $0x2d
  jmp alltraps
80105d50:	e9 95 f9 ff ff       	jmp    801056ea <alltraps>

80105d55 <vector46>:
.globl vector46
vector46:
  pushl $0
80105d55:	6a 00                	push   $0x0
  pushl $46
80105d57:	6a 2e                	push   $0x2e
  jmp alltraps
80105d59:	e9 8c f9 ff ff       	jmp    801056ea <alltraps>

80105d5e <vector47>:
.globl vector47
vector47:
  pushl $0
80105d5e:	6a 00                	push   $0x0
  pushl $47
80105d60:	6a 2f                	push   $0x2f
  jmp alltraps
80105d62:	e9 83 f9 ff ff       	jmp    801056ea <alltraps>

80105d67 <vector48>:
.globl vector48
vector48:
  pushl $0
80105d67:	6a 00                	push   $0x0
  pushl $48
80105d69:	6a 30                	push   $0x30
  jmp alltraps
80105d6b:	e9 7a f9 ff ff       	jmp    801056ea <alltraps>

80105d70 <vector49>:
.globl vector49
vector49:
  pushl $0
80105d70:	6a 00                	push   $0x0
  pushl $49
80105d72:	6a 31                	push   $0x31
  jmp alltraps
80105d74:	e9 71 f9 ff ff       	jmp    801056ea <alltraps>

80105d79 <vector50>:
.globl vector50
vector50:
  pushl $0
80105d79:	6a 00                	push   $0x0
  pushl $50
80105d7b:	6a 32                	push   $0x32
  jmp alltraps
80105d7d:	e9 68 f9 ff ff       	jmp    801056ea <alltraps>

80105d82 <vector51>:
.globl vector51
vector51:
  pushl $0
80105d82:	6a 00                	push   $0x0
  pushl $51
80105d84:	6a 33                	push   $0x33
  jmp alltraps
80105d86:	e9 5f f9 ff ff       	jmp    801056ea <alltraps>

80105d8b <vector52>:
.globl vector52
vector52:
  pushl $0
80105d8b:	6a 00                	push   $0x0
  pushl $52
80105d8d:	6a 34                	push   $0x34
  jmp alltraps
80105d8f:	e9 56 f9 ff ff       	jmp    801056ea <alltraps>

80105d94 <vector53>:
.globl vector53
vector53:
  pushl $0
80105d94:	6a 00                	push   $0x0
  pushl $53
80105d96:	6a 35                	push   $0x35
  jmp alltraps
80105d98:	e9 4d f9 ff ff       	jmp    801056ea <alltraps>

80105d9d <vector54>:
.globl vector54
vector54:
  pushl $0
80105d9d:	6a 00                	push   $0x0
  pushl $54
80105d9f:	6a 36                	push   $0x36
  jmp alltraps
80105da1:	e9 44 f9 ff ff       	jmp    801056ea <alltraps>

80105da6 <vector55>:
.globl vector55
vector55:
  pushl $0
80105da6:	6a 00                	push   $0x0
  pushl $55
80105da8:	6a 37                	push   $0x37
  jmp alltraps
80105daa:	e9 3b f9 ff ff       	jmp    801056ea <alltraps>

80105daf <vector56>:
.globl vector56
vector56:
  pushl $0
80105daf:	6a 00                	push   $0x0
  pushl $56
80105db1:	6a 38                	push   $0x38
  jmp alltraps
80105db3:	e9 32 f9 ff ff       	jmp    801056ea <alltraps>

80105db8 <vector57>:
.globl vector57
vector57:
  pushl $0
80105db8:	6a 00                	push   $0x0
  pushl $57
80105dba:	6a 39                	push   $0x39
  jmp alltraps
80105dbc:	e9 29 f9 ff ff       	jmp    801056ea <alltraps>

80105dc1 <vector58>:
.globl vector58
vector58:
  pushl $0
80105dc1:	6a 00                	push   $0x0
  pushl $58
80105dc3:	6a 3a                	push   $0x3a
  jmp alltraps
80105dc5:	e9 20 f9 ff ff       	jmp    801056ea <alltraps>

80105dca <vector59>:
.globl vector59
vector59:
  pushl $0
80105dca:	6a 00                	push   $0x0
  pushl $59
80105dcc:	6a 3b                	push   $0x3b
  jmp alltraps
80105dce:	e9 17 f9 ff ff       	jmp    801056ea <alltraps>

80105dd3 <vector60>:
.globl vector60
vector60:
  pushl $0
80105dd3:	6a 00                	push   $0x0
  pushl $60
80105dd5:	6a 3c                	push   $0x3c
  jmp alltraps
80105dd7:	e9 0e f9 ff ff       	jmp    801056ea <alltraps>

80105ddc <vector61>:
.globl vector61
vector61:
  pushl $0
80105ddc:	6a 00                	push   $0x0
  pushl $61
80105dde:	6a 3d                	push   $0x3d
  jmp alltraps
80105de0:	e9 05 f9 ff ff       	jmp    801056ea <alltraps>

80105de5 <vector62>:
.globl vector62
vector62:
  pushl $0
80105de5:	6a 00                	push   $0x0
  pushl $62
80105de7:	6a 3e                	push   $0x3e
  jmp alltraps
80105de9:	e9 fc f8 ff ff       	jmp    801056ea <alltraps>

80105dee <vector63>:
.globl vector63
vector63:
  pushl $0
80105dee:	6a 00                	push   $0x0
  pushl $63
80105df0:	6a 3f                	push   $0x3f
  jmp alltraps
80105df2:	e9 f3 f8 ff ff       	jmp    801056ea <alltraps>

80105df7 <vector64>:
.globl vector64
vector64:
  pushl $0
80105df7:	6a 00                	push   $0x0
  pushl $64
80105df9:	6a 40                	push   $0x40
  jmp alltraps
80105dfb:	e9 ea f8 ff ff       	jmp    801056ea <alltraps>

80105e00 <vector65>:
.globl vector65
vector65:
  pushl $0
80105e00:	6a 00                	push   $0x0
  pushl $65
80105e02:	6a 41                	push   $0x41
  jmp alltraps
80105e04:	e9 e1 f8 ff ff       	jmp    801056ea <alltraps>

80105e09 <vector66>:
.globl vector66
vector66:
  pushl $0
80105e09:	6a 00                	push   $0x0
  pushl $66
80105e0b:	6a 42                	push   $0x42
  jmp alltraps
80105e0d:	e9 d8 f8 ff ff       	jmp    801056ea <alltraps>

80105e12 <vector67>:
.globl vector67
vector67:
  pushl $0
80105e12:	6a 00                	push   $0x0
  pushl $67
80105e14:	6a 43                	push   $0x43
  jmp alltraps
80105e16:	e9 cf f8 ff ff       	jmp    801056ea <alltraps>

80105e1b <vector68>:
.globl vector68
vector68:
  pushl $0
80105e1b:	6a 00                	push   $0x0
  pushl $68
80105e1d:	6a 44                	push   $0x44
  jmp alltraps
80105e1f:	e9 c6 f8 ff ff       	jmp    801056ea <alltraps>

80105e24 <vector69>:
.globl vector69
vector69:
  pushl $0
80105e24:	6a 00                	push   $0x0
  pushl $69
80105e26:	6a 45                	push   $0x45
  jmp alltraps
80105e28:	e9 bd f8 ff ff       	jmp    801056ea <alltraps>

80105e2d <vector70>:
.globl vector70
vector70:
  pushl $0
80105e2d:	6a 00                	push   $0x0
  pushl $70
80105e2f:	6a 46                	push   $0x46
  jmp alltraps
80105e31:	e9 b4 f8 ff ff       	jmp    801056ea <alltraps>

80105e36 <vector71>:
.globl vector71
vector71:
  pushl $0
80105e36:	6a 00                	push   $0x0
  pushl $71
80105e38:	6a 47                	push   $0x47
  jmp alltraps
80105e3a:	e9 ab f8 ff ff       	jmp    801056ea <alltraps>

80105e3f <vector72>:
.globl vector72
vector72:
  pushl $0
80105e3f:	6a 00                	push   $0x0
  pushl $72
80105e41:	6a 48                	push   $0x48
  jmp alltraps
80105e43:	e9 a2 f8 ff ff       	jmp    801056ea <alltraps>

80105e48 <vector73>:
.globl vector73
vector73:
  pushl $0
80105e48:	6a 00                	push   $0x0
  pushl $73
80105e4a:	6a 49                	push   $0x49
  jmp alltraps
80105e4c:	e9 99 f8 ff ff       	jmp    801056ea <alltraps>

80105e51 <vector74>:
.globl vector74
vector74:
  pushl $0
80105e51:	6a 00                	push   $0x0
  pushl $74
80105e53:	6a 4a                	push   $0x4a
  jmp alltraps
80105e55:	e9 90 f8 ff ff       	jmp    801056ea <alltraps>

80105e5a <vector75>:
.globl vector75
vector75:
  pushl $0
80105e5a:	6a 00                	push   $0x0
  pushl $75
80105e5c:	6a 4b                	push   $0x4b
  jmp alltraps
80105e5e:	e9 87 f8 ff ff       	jmp    801056ea <alltraps>

80105e63 <vector76>:
.globl vector76
vector76:
  pushl $0
80105e63:	6a 00                	push   $0x0
  pushl $76
80105e65:	6a 4c                	push   $0x4c
  jmp alltraps
80105e67:	e9 7e f8 ff ff       	jmp    801056ea <alltraps>

80105e6c <vector77>:
.globl vector77
vector77:
  pushl $0
80105e6c:	6a 00                	push   $0x0
  pushl $77
80105e6e:	6a 4d                	push   $0x4d
  jmp alltraps
80105e70:	e9 75 f8 ff ff       	jmp    801056ea <alltraps>

80105e75 <vector78>:
.globl vector78
vector78:
  pushl $0
80105e75:	6a 00                	push   $0x0
  pushl $78
80105e77:	6a 4e                	push   $0x4e
  jmp alltraps
80105e79:	e9 6c f8 ff ff       	jmp    801056ea <alltraps>

80105e7e <vector79>:
.globl vector79
vector79:
  pushl $0
80105e7e:	6a 00                	push   $0x0
  pushl $79
80105e80:	6a 4f                	push   $0x4f
  jmp alltraps
80105e82:	e9 63 f8 ff ff       	jmp    801056ea <alltraps>

80105e87 <vector80>:
.globl vector80
vector80:
  pushl $0
80105e87:	6a 00                	push   $0x0
  pushl $80
80105e89:	6a 50                	push   $0x50
  jmp alltraps
80105e8b:	e9 5a f8 ff ff       	jmp    801056ea <alltraps>

80105e90 <vector81>:
.globl vector81
vector81:
  pushl $0
80105e90:	6a 00                	push   $0x0
  pushl $81
80105e92:	6a 51                	push   $0x51
  jmp alltraps
80105e94:	e9 51 f8 ff ff       	jmp    801056ea <alltraps>

80105e99 <vector82>:
.globl vector82
vector82:
  pushl $0
80105e99:	6a 00                	push   $0x0
  pushl $82
80105e9b:	6a 52                	push   $0x52
  jmp alltraps
80105e9d:	e9 48 f8 ff ff       	jmp    801056ea <alltraps>

80105ea2 <vector83>:
.globl vector83
vector83:
  pushl $0
80105ea2:	6a 00                	push   $0x0
  pushl $83
80105ea4:	6a 53                	push   $0x53
  jmp alltraps
80105ea6:	e9 3f f8 ff ff       	jmp    801056ea <alltraps>

80105eab <vector84>:
.globl vector84
vector84:
  pushl $0
80105eab:	6a 00                	push   $0x0
  pushl $84
80105ead:	6a 54                	push   $0x54
  jmp alltraps
80105eaf:	e9 36 f8 ff ff       	jmp    801056ea <alltraps>

80105eb4 <vector85>:
.globl vector85
vector85:
  pushl $0
80105eb4:	6a 00                	push   $0x0
  pushl $85
80105eb6:	6a 55                	push   $0x55
  jmp alltraps
80105eb8:	e9 2d f8 ff ff       	jmp    801056ea <alltraps>

80105ebd <vector86>:
.globl vector86
vector86:
  pushl $0
80105ebd:	6a 00                	push   $0x0
  pushl $86
80105ebf:	6a 56                	push   $0x56
  jmp alltraps
80105ec1:	e9 24 f8 ff ff       	jmp    801056ea <alltraps>

80105ec6 <vector87>:
.globl vector87
vector87:
  pushl $0
80105ec6:	6a 00                	push   $0x0
  pushl $87
80105ec8:	6a 57                	push   $0x57
  jmp alltraps
80105eca:	e9 1b f8 ff ff       	jmp    801056ea <alltraps>

80105ecf <vector88>:
.globl vector88
vector88:
  pushl $0
80105ecf:	6a 00                	push   $0x0
  pushl $88
80105ed1:	6a 58                	push   $0x58
  jmp alltraps
80105ed3:	e9 12 f8 ff ff       	jmp    801056ea <alltraps>

80105ed8 <vector89>:
.globl vector89
vector89:
  pushl $0
80105ed8:	6a 00                	push   $0x0
  pushl $89
80105eda:	6a 59                	push   $0x59
  jmp alltraps
80105edc:	e9 09 f8 ff ff       	jmp    801056ea <alltraps>

80105ee1 <vector90>:
.globl vector90
vector90:
  pushl $0
80105ee1:	6a 00                	push   $0x0
  pushl $90
80105ee3:	6a 5a                	push   $0x5a
  jmp alltraps
80105ee5:	e9 00 f8 ff ff       	jmp    801056ea <alltraps>

80105eea <vector91>:
.globl vector91
vector91:
  pushl $0
80105eea:	6a 00                	push   $0x0
  pushl $91
80105eec:	6a 5b                	push   $0x5b
  jmp alltraps
80105eee:	e9 f7 f7 ff ff       	jmp    801056ea <alltraps>

80105ef3 <vector92>:
.globl vector92
vector92:
  pushl $0
80105ef3:	6a 00                	push   $0x0
  pushl $92
80105ef5:	6a 5c                	push   $0x5c
  jmp alltraps
80105ef7:	e9 ee f7 ff ff       	jmp    801056ea <alltraps>

80105efc <vector93>:
.globl vector93
vector93:
  pushl $0
80105efc:	6a 00                	push   $0x0
  pushl $93
80105efe:	6a 5d                	push   $0x5d
  jmp alltraps
80105f00:	e9 e5 f7 ff ff       	jmp    801056ea <alltraps>

80105f05 <vector94>:
.globl vector94
vector94:
  pushl $0
80105f05:	6a 00                	push   $0x0
  pushl $94
80105f07:	6a 5e                	push   $0x5e
  jmp alltraps
80105f09:	e9 dc f7 ff ff       	jmp    801056ea <alltraps>

80105f0e <vector95>:
.globl vector95
vector95:
  pushl $0
80105f0e:	6a 00                	push   $0x0
  pushl $95
80105f10:	6a 5f                	push   $0x5f
  jmp alltraps
80105f12:	e9 d3 f7 ff ff       	jmp    801056ea <alltraps>

80105f17 <vector96>:
.globl vector96
vector96:
  pushl $0
80105f17:	6a 00                	push   $0x0
  pushl $96
80105f19:	6a 60                	push   $0x60
  jmp alltraps
80105f1b:	e9 ca f7 ff ff       	jmp    801056ea <alltraps>

80105f20 <vector97>:
.globl vector97
vector97:
  pushl $0
80105f20:	6a 00                	push   $0x0
  pushl $97
80105f22:	6a 61                	push   $0x61
  jmp alltraps
80105f24:	e9 c1 f7 ff ff       	jmp    801056ea <alltraps>

80105f29 <vector98>:
.globl vector98
vector98:
  pushl $0
80105f29:	6a 00                	push   $0x0
  pushl $98
80105f2b:	6a 62                	push   $0x62
  jmp alltraps
80105f2d:	e9 b8 f7 ff ff       	jmp    801056ea <alltraps>

80105f32 <vector99>:
.globl vector99
vector99:
  pushl $0
80105f32:	6a 00                	push   $0x0
  pushl $99
80105f34:	6a 63                	push   $0x63
  jmp alltraps
80105f36:	e9 af f7 ff ff       	jmp    801056ea <alltraps>

80105f3b <vector100>:
.globl vector100
vector100:
  pushl $0
80105f3b:	6a 00                	push   $0x0
  pushl $100
80105f3d:	6a 64                	push   $0x64
  jmp alltraps
80105f3f:	e9 a6 f7 ff ff       	jmp    801056ea <alltraps>

80105f44 <vector101>:
.globl vector101
vector101:
  pushl $0
80105f44:	6a 00                	push   $0x0
  pushl $101
80105f46:	6a 65                	push   $0x65
  jmp alltraps
80105f48:	e9 9d f7 ff ff       	jmp    801056ea <alltraps>

80105f4d <vector102>:
.globl vector102
vector102:
  pushl $0
80105f4d:	6a 00                	push   $0x0
  pushl $102
80105f4f:	6a 66                	push   $0x66
  jmp alltraps
80105f51:	e9 94 f7 ff ff       	jmp    801056ea <alltraps>

80105f56 <vector103>:
.globl vector103
vector103:
  pushl $0
80105f56:	6a 00                	push   $0x0
  pushl $103
80105f58:	6a 67                	push   $0x67
  jmp alltraps
80105f5a:	e9 8b f7 ff ff       	jmp    801056ea <alltraps>

80105f5f <vector104>:
.globl vector104
vector104:
  pushl $0
80105f5f:	6a 00                	push   $0x0
  pushl $104
80105f61:	6a 68                	push   $0x68
  jmp alltraps
80105f63:	e9 82 f7 ff ff       	jmp    801056ea <alltraps>

80105f68 <vector105>:
.globl vector105
vector105:
  pushl $0
80105f68:	6a 00                	push   $0x0
  pushl $105
80105f6a:	6a 69                	push   $0x69
  jmp alltraps
80105f6c:	e9 79 f7 ff ff       	jmp    801056ea <alltraps>

80105f71 <vector106>:
.globl vector106
vector106:
  pushl $0
80105f71:	6a 00                	push   $0x0
  pushl $106
80105f73:	6a 6a                	push   $0x6a
  jmp alltraps
80105f75:	e9 70 f7 ff ff       	jmp    801056ea <alltraps>

80105f7a <vector107>:
.globl vector107
vector107:
  pushl $0
80105f7a:	6a 00                	push   $0x0
  pushl $107
80105f7c:	6a 6b                	push   $0x6b
  jmp alltraps
80105f7e:	e9 67 f7 ff ff       	jmp    801056ea <alltraps>

80105f83 <vector108>:
.globl vector108
vector108:
  pushl $0
80105f83:	6a 00                	push   $0x0
  pushl $108
80105f85:	6a 6c                	push   $0x6c
  jmp alltraps
80105f87:	e9 5e f7 ff ff       	jmp    801056ea <alltraps>

80105f8c <vector109>:
.globl vector109
vector109:
  pushl $0
80105f8c:	6a 00                	push   $0x0
  pushl $109
80105f8e:	6a 6d                	push   $0x6d
  jmp alltraps
80105f90:	e9 55 f7 ff ff       	jmp    801056ea <alltraps>

80105f95 <vector110>:
.globl vector110
vector110:
  pushl $0
80105f95:	6a 00                	push   $0x0
  pushl $110
80105f97:	6a 6e                	push   $0x6e
  jmp alltraps
80105f99:	e9 4c f7 ff ff       	jmp    801056ea <alltraps>

80105f9e <vector111>:
.globl vector111
vector111:
  pushl $0
80105f9e:	6a 00                	push   $0x0
  pushl $111
80105fa0:	6a 6f                	push   $0x6f
  jmp alltraps
80105fa2:	e9 43 f7 ff ff       	jmp    801056ea <alltraps>

80105fa7 <vector112>:
.globl vector112
vector112:
  pushl $0
80105fa7:	6a 00                	push   $0x0
  pushl $112
80105fa9:	6a 70                	push   $0x70
  jmp alltraps
80105fab:	e9 3a f7 ff ff       	jmp    801056ea <alltraps>

80105fb0 <vector113>:
.globl vector113
vector113:
  pushl $0
80105fb0:	6a 00                	push   $0x0
  pushl $113
80105fb2:	6a 71                	push   $0x71
  jmp alltraps
80105fb4:	e9 31 f7 ff ff       	jmp    801056ea <alltraps>

80105fb9 <vector114>:
.globl vector114
vector114:
  pushl $0
80105fb9:	6a 00                	push   $0x0
  pushl $114
80105fbb:	6a 72                	push   $0x72
  jmp alltraps
80105fbd:	e9 28 f7 ff ff       	jmp    801056ea <alltraps>

80105fc2 <vector115>:
.globl vector115
vector115:
  pushl $0
80105fc2:	6a 00                	push   $0x0
  pushl $115
80105fc4:	6a 73                	push   $0x73
  jmp alltraps
80105fc6:	e9 1f f7 ff ff       	jmp    801056ea <alltraps>

80105fcb <vector116>:
.globl vector116
vector116:
  pushl $0
80105fcb:	6a 00                	push   $0x0
  pushl $116
80105fcd:	6a 74                	push   $0x74
  jmp alltraps
80105fcf:	e9 16 f7 ff ff       	jmp    801056ea <alltraps>

80105fd4 <vector117>:
.globl vector117
vector117:
  pushl $0
80105fd4:	6a 00                	push   $0x0
  pushl $117
80105fd6:	6a 75                	push   $0x75
  jmp alltraps
80105fd8:	e9 0d f7 ff ff       	jmp    801056ea <alltraps>

80105fdd <vector118>:
.globl vector118
vector118:
  pushl $0
80105fdd:	6a 00                	push   $0x0
  pushl $118
80105fdf:	6a 76                	push   $0x76
  jmp alltraps
80105fe1:	e9 04 f7 ff ff       	jmp    801056ea <alltraps>

80105fe6 <vector119>:
.globl vector119
vector119:
  pushl $0
80105fe6:	6a 00                	push   $0x0
  pushl $119
80105fe8:	6a 77                	push   $0x77
  jmp alltraps
80105fea:	e9 fb f6 ff ff       	jmp    801056ea <alltraps>

80105fef <vector120>:
.globl vector120
vector120:
  pushl $0
80105fef:	6a 00                	push   $0x0
  pushl $120
80105ff1:	6a 78                	push   $0x78
  jmp alltraps
80105ff3:	e9 f2 f6 ff ff       	jmp    801056ea <alltraps>

80105ff8 <vector121>:
.globl vector121
vector121:
  pushl $0
80105ff8:	6a 00                	push   $0x0
  pushl $121
80105ffa:	6a 79                	push   $0x79
  jmp alltraps
80105ffc:	e9 e9 f6 ff ff       	jmp    801056ea <alltraps>

80106001 <vector122>:
.globl vector122
vector122:
  pushl $0
80106001:	6a 00                	push   $0x0
  pushl $122
80106003:	6a 7a                	push   $0x7a
  jmp alltraps
80106005:	e9 e0 f6 ff ff       	jmp    801056ea <alltraps>

8010600a <vector123>:
.globl vector123
vector123:
  pushl $0
8010600a:	6a 00                	push   $0x0
  pushl $123
8010600c:	6a 7b                	push   $0x7b
  jmp alltraps
8010600e:	e9 d7 f6 ff ff       	jmp    801056ea <alltraps>

80106013 <vector124>:
.globl vector124
vector124:
  pushl $0
80106013:	6a 00                	push   $0x0
  pushl $124
80106015:	6a 7c                	push   $0x7c
  jmp alltraps
80106017:	e9 ce f6 ff ff       	jmp    801056ea <alltraps>

8010601c <vector125>:
.globl vector125
vector125:
  pushl $0
8010601c:	6a 00                	push   $0x0
  pushl $125
8010601e:	6a 7d                	push   $0x7d
  jmp alltraps
80106020:	e9 c5 f6 ff ff       	jmp    801056ea <alltraps>

80106025 <vector126>:
.globl vector126
vector126:
  pushl $0
80106025:	6a 00                	push   $0x0
  pushl $126
80106027:	6a 7e                	push   $0x7e
  jmp alltraps
80106029:	e9 bc f6 ff ff       	jmp    801056ea <alltraps>

8010602e <vector127>:
.globl vector127
vector127:
  pushl $0
8010602e:	6a 00                	push   $0x0
  pushl $127
80106030:	6a 7f                	push   $0x7f
  jmp alltraps
80106032:	e9 b3 f6 ff ff       	jmp    801056ea <alltraps>

80106037 <vector128>:
.globl vector128
vector128:
  pushl $0
80106037:	6a 00                	push   $0x0
  pushl $128
80106039:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010603e:	e9 a7 f6 ff ff       	jmp    801056ea <alltraps>

80106043 <vector129>:
.globl vector129
vector129:
  pushl $0
80106043:	6a 00                	push   $0x0
  pushl $129
80106045:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010604a:	e9 9b f6 ff ff       	jmp    801056ea <alltraps>

8010604f <vector130>:
.globl vector130
vector130:
  pushl $0
8010604f:	6a 00                	push   $0x0
  pushl $130
80106051:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106056:	e9 8f f6 ff ff       	jmp    801056ea <alltraps>

8010605b <vector131>:
.globl vector131
vector131:
  pushl $0
8010605b:	6a 00                	push   $0x0
  pushl $131
8010605d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106062:	e9 83 f6 ff ff       	jmp    801056ea <alltraps>

80106067 <vector132>:
.globl vector132
vector132:
  pushl $0
80106067:	6a 00                	push   $0x0
  pushl $132
80106069:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010606e:	e9 77 f6 ff ff       	jmp    801056ea <alltraps>

80106073 <vector133>:
.globl vector133
vector133:
  pushl $0
80106073:	6a 00                	push   $0x0
  pushl $133
80106075:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010607a:	e9 6b f6 ff ff       	jmp    801056ea <alltraps>

8010607f <vector134>:
.globl vector134
vector134:
  pushl $0
8010607f:	6a 00                	push   $0x0
  pushl $134
80106081:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106086:	e9 5f f6 ff ff       	jmp    801056ea <alltraps>

8010608b <vector135>:
.globl vector135
vector135:
  pushl $0
8010608b:	6a 00                	push   $0x0
  pushl $135
8010608d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106092:	e9 53 f6 ff ff       	jmp    801056ea <alltraps>

80106097 <vector136>:
.globl vector136
vector136:
  pushl $0
80106097:	6a 00                	push   $0x0
  pushl $136
80106099:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010609e:	e9 47 f6 ff ff       	jmp    801056ea <alltraps>

801060a3 <vector137>:
.globl vector137
vector137:
  pushl $0
801060a3:	6a 00                	push   $0x0
  pushl $137
801060a5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801060aa:	e9 3b f6 ff ff       	jmp    801056ea <alltraps>

801060af <vector138>:
.globl vector138
vector138:
  pushl $0
801060af:	6a 00                	push   $0x0
  pushl $138
801060b1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801060b6:	e9 2f f6 ff ff       	jmp    801056ea <alltraps>

801060bb <vector139>:
.globl vector139
vector139:
  pushl $0
801060bb:	6a 00                	push   $0x0
  pushl $139
801060bd:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801060c2:	e9 23 f6 ff ff       	jmp    801056ea <alltraps>

801060c7 <vector140>:
.globl vector140
vector140:
  pushl $0
801060c7:	6a 00                	push   $0x0
  pushl $140
801060c9:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
801060ce:	e9 17 f6 ff ff       	jmp    801056ea <alltraps>

801060d3 <vector141>:
.globl vector141
vector141:
  pushl $0
801060d3:	6a 00                	push   $0x0
  pushl $141
801060d5:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
801060da:	e9 0b f6 ff ff       	jmp    801056ea <alltraps>

801060df <vector142>:
.globl vector142
vector142:
  pushl $0
801060df:	6a 00                	push   $0x0
  pushl $142
801060e1:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
801060e6:	e9 ff f5 ff ff       	jmp    801056ea <alltraps>

801060eb <vector143>:
.globl vector143
vector143:
  pushl $0
801060eb:	6a 00                	push   $0x0
  pushl $143
801060ed:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
801060f2:	e9 f3 f5 ff ff       	jmp    801056ea <alltraps>

801060f7 <vector144>:
.globl vector144
vector144:
  pushl $0
801060f7:	6a 00                	push   $0x0
  pushl $144
801060f9:	68 90 00 00 00       	push   $0x90
  jmp alltraps
801060fe:	e9 e7 f5 ff ff       	jmp    801056ea <alltraps>

80106103 <vector145>:
.globl vector145
vector145:
  pushl $0
80106103:	6a 00                	push   $0x0
  pushl $145
80106105:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010610a:	e9 db f5 ff ff       	jmp    801056ea <alltraps>

8010610f <vector146>:
.globl vector146
vector146:
  pushl $0
8010610f:	6a 00                	push   $0x0
  pushl $146
80106111:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106116:	e9 cf f5 ff ff       	jmp    801056ea <alltraps>

8010611b <vector147>:
.globl vector147
vector147:
  pushl $0
8010611b:	6a 00                	push   $0x0
  pushl $147
8010611d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106122:	e9 c3 f5 ff ff       	jmp    801056ea <alltraps>

80106127 <vector148>:
.globl vector148
vector148:
  pushl $0
80106127:	6a 00                	push   $0x0
  pushl $148
80106129:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010612e:	e9 b7 f5 ff ff       	jmp    801056ea <alltraps>

80106133 <vector149>:
.globl vector149
vector149:
  pushl $0
80106133:	6a 00                	push   $0x0
  pushl $149
80106135:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010613a:	e9 ab f5 ff ff       	jmp    801056ea <alltraps>

8010613f <vector150>:
.globl vector150
vector150:
  pushl $0
8010613f:	6a 00                	push   $0x0
  pushl $150
80106141:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106146:	e9 9f f5 ff ff       	jmp    801056ea <alltraps>

8010614b <vector151>:
.globl vector151
vector151:
  pushl $0
8010614b:	6a 00                	push   $0x0
  pushl $151
8010614d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106152:	e9 93 f5 ff ff       	jmp    801056ea <alltraps>

80106157 <vector152>:
.globl vector152
vector152:
  pushl $0
80106157:	6a 00                	push   $0x0
  pushl $152
80106159:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010615e:	e9 87 f5 ff ff       	jmp    801056ea <alltraps>

80106163 <vector153>:
.globl vector153
vector153:
  pushl $0
80106163:	6a 00                	push   $0x0
  pushl $153
80106165:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010616a:	e9 7b f5 ff ff       	jmp    801056ea <alltraps>

8010616f <vector154>:
.globl vector154
vector154:
  pushl $0
8010616f:	6a 00                	push   $0x0
  pushl $154
80106171:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106176:	e9 6f f5 ff ff       	jmp    801056ea <alltraps>

8010617b <vector155>:
.globl vector155
vector155:
  pushl $0
8010617b:	6a 00                	push   $0x0
  pushl $155
8010617d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106182:	e9 63 f5 ff ff       	jmp    801056ea <alltraps>

80106187 <vector156>:
.globl vector156
vector156:
  pushl $0
80106187:	6a 00                	push   $0x0
  pushl $156
80106189:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010618e:	e9 57 f5 ff ff       	jmp    801056ea <alltraps>

80106193 <vector157>:
.globl vector157
vector157:
  pushl $0
80106193:	6a 00                	push   $0x0
  pushl $157
80106195:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010619a:	e9 4b f5 ff ff       	jmp    801056ea <alltraps>

8010619f <vector158>:
.globl vector158
vector158:
  pushl $0
8010619f:	6a 00                	push   $0x0
  pushl $158
801061a1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801061a6:	e9 3f f5 ff ff       	jmp    801056ea <alltraps>

801061ab <vector159>:
.globl vector159
vector159:
  pushl $0
801061ab:	6a 00                	push   $0x0
  pushl $159
801061ad:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801061b2:	e9 33 f5 ff ff       	jmp    801056ea <alltraps>

801061b7 <vector160>:
.globl vector160
vector160:
  pushl $0
801061b7:	6a 00                	push   $0x0
  pushl $160
801061b9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801061be:	e9 27 f5 ff ff       	jmp    801056ea <alltraps>

801061c3 <vector161>:
.globl vector161
vector161:
  pushl $0
801061c3:	6a 00                	push   $0x0
  pushl $161
801061c5:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801061ca:	e9 1b f5 ff ff       	jmp    801056ea <alltraps>

801061cf <vector162>:
.globl vector162
vector162:
  pushl $0
801061cf:	6a 00                	push   $0x0
  pushl $162
801061d1:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801061d6:	e9 0f f5 ff ff       	jmp    801056ea <alltraps>

801061db <vector163>:
.globl vector163
vector163:
  pushl $0
801061db:	6a 00                	push   $0x0
  pushl $163
801061dd:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801061e2:	e9 03 f5 ff ff       	jmp    801056ea <alltraps>

801061e7 <vector164>:
.globl vector164
vector164:
  pushl $0
801061e7:	6a 00                	push   $0x0
  pushl $164
801061e9:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801061ee:	e9 f7 f4 ff ff       	jmp    801056ea <alltraps>

801061f3 <vector165>:
.globl vector165
vector165:
  pushl $0
801061f3:	6a 00                	push   $0x0
  pushl $165
801061f5:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801061fa:	e9 eb f4 ff ff       	jmp    801056ea <alltraps>

801061ff <vector166>:
.globl vector166
vector166:
  pushl $0
801061ff:	6a 00                	push   $0x0
  pushl $166
80106201:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106206:	e9 df f4 ff ff       	jmp    801056ea <alltraps>

8010620b <vector167>:
.globl vector167
vector167:
  pushl $0
8010620b:	6a 00                	push   $0x0
  pushl $167
8010620d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106212:	e9 d3 f4 ff ff       	jmp    801056ea <alltraps>

80106217 <vector168>:
.globl vector168
vector168:
  pushl $0
80106217:	6a 00                	push   $0x0
  pushl $168
80106219:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010621e:	e9 c7 f4 ff ff       	jmp    801056ea <alltraps>

80106223 <vector169>:
.globl vector169
vector169:
  pushl $0
80106223:	6a 00                	push   $0x0
  pushl $169
80106225:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010622a:	e9 bb f4 ff ff       	jmp    801056ea <alltraps>

8010622f <vector170>:
.globl vector170
vector170:
  pushl $0
8010622f:	6a 00                	push   $0x0
  pushl $170
80106231:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106236:	e9 af f4 ff ff       	jmp    801056ea <alltraps>

8010623b <vector171>:
.globl vector171
vector171:
  pushl $0
8010623b:	6a 00                	push   $0x0
  pushl $171
8010623d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106242:	e9 a3 f4 ff ff       	jmp    801056ea <alltraps>

80106247 <vector172>:
.globl vector172
vector172:
  pushl $0
80106247:	6a 00                	push   $0x0
  pushl $172
80106249:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010624e:	e9 97 f4 ff ff       	jmp    801056ea <alltraps>

80106253 <vector173>:
.globl vector173
vector173:
  pushl $0
80106253:	6a 00                	push   $0x0
  pushl $173
80106255:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010625a:	e9 8b f4 ff ff       	jmp    801056ea <alltraps>

8010625f <vector174>:
.globl vector174
vector174:
  pushl $0
8010625f:	6a 00                	push   $0x0
  pushl $174
80106261:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106266:	e9 7f f4 ff ff       	jmp    801056ea <alltraps>

8010626b <vector175>:
.globl vector175
vector175:
  pushl $0
8010626b:	6a 00                	push   $0x0
  pushl $175
8010626d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106272:	e9 73 f4 ff ff       	jmp    801056ea <alltraps>

80106277 <vector176>:
.globl vector176
vector176:
  pushl $0
80106277:	6a 00                	push   $0x0
  pushl $176
80106279:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010627e:	e9 67 f4 ff ff       	jmp    801056ea <alltraps>

80106283 <vector177>:
.globl vector177
vector177:
  pushl $0
80106283:	6a 00                	push   $0x0
  pushl $177
80106285:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010628a:	e9 5b f4 ff ff       	jmp    801056ea <alltraps>

8010628f <vector178>:
.globl vector178
vector178:
  pushl $0
8010628f:	6a 00                	push   $0x0
  pushl $178
80106291:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106296:	e9 4f f4 ff ff       	jmp    801056ea <alltraps>

8010629b <vector179>:
.globl vector179
vector179:
  pushl $0
8010629b:	6a 00                	push   $0x0
  pushl $179
8010629d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801062a2:	e9 43 f4 ff ff       	jmp    801056ea <alltraps>

801062a7 <vector180>:
.globl vector180
vector180:
  pushl $0
801062a7:	6a 00                	push   $0x0
  pushl $180
801062a9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801062ae:	e9 37 f4 ff ff       	jmp    801056ea <alltraps>

801062b3 <vector181>:
.globl vector181
vector181:
  pushl $0
801062b3:	6a 00                	push   $0x0
  pushl $181
801062b5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801062ba:	e9 2b f4 ff ff       	jmp    801056ea <alltraps>

801062bf <vector182>:
.globl vector182
vector182:
  pushl $0
801062bf:	6a 00                	push   $0x0
  pushl $182
801062c1:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801062c6:	e9 1f f4 ff ff       	jmp    801056ea <alltraps>

801062cb <vector183>:
.globl vector183
vector183:
  pushl $0
801062cb:	6a 00                	push   $0x0
  pushl $183
801062cd:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801062d2:	e9 13 f4 ff ff       	jmp    801056ea <alltraps>

801062d7 <vector184>:
.globl vector184
vector184:
  pushl $0
801062d7:	6a 00                	push   $0x0
  pushl $184
801062d9:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801062de:	e9 07 f4 ff ff       	jmp    801056ea <alltraps>

801062e3 <vector185>:
.globl vector185
vector185:
  pushl $0
801062e3:	6a 00                	push   $0x0
  pushl $185
801062e5:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801062ea:	e9 fb f3 ff ff       	jmp    801056ea <alltraps>

801062ef <vector186>:
.globl vector186
vector186:
  pushl $0
801062ef:	6a 00                	push   $0x0
  pushl $186
801062f1:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801062f6:	e9 ef f3 ff ff       	jmp    801056ea <alltraps>

801062fb <vector187>:
.globl vector187
vector187:
  pushl $0
801062fb:	6a 00                	push   $0x0
  pushl $187
801062fd:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106302:	e9 e3 f3 ff ff       	jmp    801056ea <alltraps>

80106307 <vector188>:
.globl vector188
vector188:
  pushl $0
80106307:	6a 00                	push   $0x0
  pushl $188
80106309:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010630e:	e9 d7 f3 ff ff       	jmp    801056ea <alltraps>

80106313 <vector189>:
.globl vector189
vector189:
  pushl $0
80106313:	6a 00                	push   $0x0
  pushl $189
80106315:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010631a:	e9 cb f3 ff ff       	jmp    801056ea <alltraps>

8010631f <vector190>:
.globl vector190
vector190:
  pushl $0
8010631f:	6a 00                	push   $0x0
  pushl $190
80106321:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106326:	e9 bf f3 ff ff       	jmp    801056ea <alltraps>

8010632b <vector191>:
.globl vector191
vector191:
  pushl $0
8010632b:	6a 00                	push   $0x0
  pushl $191
8010632d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106332:	e9 b3 f3 ff ff       	jmp    801056ea <alltraps>

80106337 <vector192>:
.globl vector192
vector192:
  pushl $0
80106337:	6a 00                	push   $0x0
  pushl $192
80106339:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010633e:	e9 a7 f3 ff ff       	jmp    801056ea <alltraps>

80106343 <vector193>:
.globl vector193
vector193:
  pushl $0
80106343:	6a 00                	push   $0x0
  pushl $193
80106345:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010634a:	e9 9b f3 ff ff       	jmp    801056ea <alltraps>

8010634f <vector194>:
.globl vector194
vector194:
  pushl $0
8010634f:	6a 00                	push   $0x0
  pushl $194
80106351:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106356:	e9 8f f3 ff ff       	jmp    801056ea <alltraps>

8010635b <vector195>:
.globl vector195
vector195:
  pushl $0
8010635b:	6a 00                	push   $0x0
  pushl $195
8010635d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106362:	e9 83 f3 ff ff       	jmp    801056ea <alltraps>

80106367 <vector196>:
.globl vector196
vector196:
  pushl $0
80106367:	6a 00                	push   $0x0
  pushl $196
80106369:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010636e:	e9 77 f3 ff ff       	jmp    801056ea <alltraps>

80106373 <vector197>:
.globl vector197
vector197:
  pushl $0
80106373:	6a 00                	push   $0x0
  pushl $197
80106375:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010637a:	e9 6b f3 ff ff       	jmp    801056ea <alltraps>

8010637f <vector198>:
.globl vector198
vector198:
  pushl $0
8010637f:	6a 00                	push   $0x0
  pushl $198
80106381:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106386:	e9 5f f3 ff ff       	jmp    801056ea <alltraps>

8010638b <vector199>:
.globl vector199
vector199:
  pushl $0
8010638b:	6a 00                	push   $0x0
  pushl $199
8010638d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106392:	e9 53 f3 ff ff       	jmp    801056ea <alltraps>

80106397 <vector200>:
.globl vector200
vector200:
  pushl $0
80106397:	6a 00                	push   $0x0
  pushl $200
80106399:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010639e:	e9 47 f3 ff ff       	jmp    801056ea <alltraps>

801063a3 <vector201>:
.globl vector201
vector201:
  pushl $0
801063a3:	6a 00                	push   $0x0
  pushl $201
801063a5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801063aa:	e9 3b f3 ff ff       	jmp    801056ea <alltraps>

801063af <vector202>:
.globl vector202
vector202:
  pushl $0
801063af:	6a 00                	push   $0x0
  pushl $202
801063b1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801063b6:	e9 2f f3 ff ff       	jmp    801056ea <alltraps>

801063bb <vector203>:
.globl vector203
vector203:
  pushl $0
801063bb:	6a 00                	push   $0x0
  pushl $203
801063bd:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801063c2:	e9 23 f3 ff ff       	jmp    801056ea <alltraps>

801063c7 <vector204>:
.globl vector204
vector204:
  pushl $0
801063c7:	6a 00                	push   $0x0
  pushl $204
801063c9:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801063ce:	e9 17 f3 ff ff       	jmp    801056ea <alltraps>

801063d3 <vector205>:
.globl vector205
vector205:
  pushl $0
801063d3:	6a 00                	push   $0x0
  pushl $205
801063d5:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801063da:	e9 0b f3 ff ff       	jmp    801056ea <alltraps>

801063df <vector206>:
.globl vector206
vector206:
  pushl $0
801063df:	6a 00                	push   $0x0
  pushl $206
801063e1:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801063e6:	e9 ff f2 ff ff       	jmp    801056ea <alltraps>

801063eb <vector207>:
.globl vector207
vector207:
  pushl $0
801063eb:	6a 00                	push   $0x0
  pushl $207
801063ed:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
801063f2:	e9 f3 f2 ff ff       	jmp    801056ea <alltraps>

801063f7 <vector208>:
.globl vector208
vector208:
  pushl $0
801063f7:	6a 00                	push   $0x0
  pushl $208
801063f9:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
801063fe:	e9 e7 f2 ff ff       	jmp    801056ea <alltraps>

80106403 <vector209>:
.globl vector209
vector209:
  pushl $0
80106403:	6a 00                	push   $0x0
  pushl $209
80106405:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010640a:	e9 db f2 ff ff       	jmp    801056ea <alltraps>

8010640f <vector210>:
.globl vector210
vector210:
  pushl $0
8010640f:	6a 00                	push   $0x0
  pushl $210
80106411:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106416:	e9 cf f2 ff ff       	jmp    801056ea <alltraps>

8010641b <vector211>:
.globl vector211
vector211:
  pushl $0
8010641b:	6a 00                	push   $0x0
  pushl $211
8010641d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106422:	e9 c3 f2 ff ff       	jmp    801056ea <alltraps>

80106427 <vector212>:
.globl vector212
vector212:
  pushl $0
80106427:	6a 00                	push   $0x0
  pushl $212
80106429:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010642e:	e9 b7 f2 ff ff       	jmp    801056ea <alltraps>

80106433 <vector213>:
.globl vector213
vector213:
  pushl $0
80106433:	6a 00                	push   $0x0
  pushl $213
80106435:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010643a:	e9 ab f2 ff ff       	jmp    801056ea <alltraps>

8010643f <vector214>:
.globl vector214
vector214:
  pushl $0
8010643f:	6a 00                	push   $0x0
  pushl $214
80106441:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106446:	e9 9f f2 ff ff       	jmp    801056ea <alltraps>

8010644b <vector215>:
.globl vector215
vector215:
  pushl $0
8010644b:	6a 00                	push   $0x0
  pushl $215
8010644d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106452:	e9 93 f2 ff ff       	jmp    801056ea <alltraps>

80106457 <vector216>:
.globl vector216
vector216:
  pushl $0
80106457:	6a 00                	push   $0x0
  pushl $216
80106459:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010645e:	e9 87 f2 ff ff       	jmp    801056ea <alltraps>

80106463 <vector217>:
.globl vector217
vector217:
  pushl $0
80106463:	6a 00                	push   $0x0
  pushl $217
80106465:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010646a:	e9 7b f2 ff ff       	jmp    801056ea <alltraps>

8010646f <vector218>:
.globl vector218
vector218:
  pushl $0
8010646f:	6a 00                	push   $0x0
  pushl $218
80106471:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106476:	e9 6f f2 ff ff       	jmp    801056ea <alltraps>

8010647b <vector219>:
.globl vector219
vector219:
  pushl $0
8010647b:	6a 00                	push   $0x0
  pushl $219
8010647d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106482:	e9 63 f2 ff ff       	jmp    801056ea <alltraps>

80106487 <vector220>:
.globl vector220
vector220:
  pushl $0
80106487:	6a 00                	push   $0x0
  pushl $220
80106489:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010648e:	e9 57 f2 ff ff       	jmp    801056ea <alltraps>

80106493 <vector221>:
.globl vector221
vector221:
  pushl $0
80106493:	6a 00                	push   $0x0
  pushl $221
80106495:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010649a:	e9 4b f2 ff ff       	jmp    801056ea <alltraps>

8010649f <vector222>:
.globl vector222
vector222:
  pushl $0
8010649f:	6a 00                	push   $0x0
  pushl $222
801064a1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801064a6:	e9 3f f2 ff ff       	jmp    801056ea <alltraps>

801064ab <vector223>:
.globl vector223
vector223:
  pushl $0
801064ab:	6a 00                	push   $0x0
  pushl $223
801064ad:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801064b2:	e9 33 f2 ff ff       	jmp    801056ea <alltraps>

801064b7 <vector224>:
.globl vector224
vector224:
  pushl $0
801064b7:	6a 00                	push   $0x0
  pushl $224
801064b9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801064be:	e9 27 f2 ff ff       	jmp    801056ea <alltraps>

801064c3 <vector225>:
.globl vector225
vector225:
  pushl $0
801064c3:	6a 00                	push   $0x0
  pushl $225
801064c5:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
801064ca:	e9 1b f2 ff ff       	jmp    801056ea <alltraps>

801064cf <vector226>:
.globl vector226
vector226:
  pushl $0
801064cf:	6a 00                	push   $0x0
  pushl $226
801064d1:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
801064d6:	e9 0f f2 ff ff       	jmp    801056ea <alltraps>

801064db <vector227>:
.globl vector227
vector227:
  pushl $0
801064db:	6a 00                	push   $0x0
  pushl $227
801064dd:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
801064e2:	e9 03 f2 ff ff       	jmp    801056ea <alltraps>

801064e7 <vector228>:
.globl vector228
vector228:
  pushl $0
801064e7:	6a 00                	push   $0x0
  pushl $228
801064e9:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
801064ee:	e9 f7 f1 ff ff       	jmp    801056ea <alltraps>

801064f3 <vector229>:
.globl vector229
vector229:
  pushl $0
801064f3:	6a 00                	push   $0x0
  pushl $229
801064f5:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
801064fa:	e9 eb f1 ff ff       	jmp    801056ea <alltraps>

801064ff <vector230>:
.globl vector230
vector230:
  pushl $0
801064ff:	6a 00                	push   $0x0
  pushl $230
80106501:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106506:	e9 df f1 ff ff       	jmp    801056ea <alltraps>

8010650b <vector231>:
.globl vector231
vector231:
  pushl $0
8010650b:	6a 00                	push   $0x0
  pushl $231
8010650d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106512:	e9 d3 f1 ff ff       	jmp    801056ea <alltraps>

80106517 <vector232>:
.globl vector232
vector232:
  pushl $0
80106517:	6a 00                	push   $0x0
  pushl $232
80106519:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010651e:	e9 c7 f1 ff ff       	jmp    801056ea <alltraps>

80106523 <vector233>:
.globl vector233
vector233:
  pushl $0
80106523:	6a 00                	push   $0x0
  pushl $233
80106525:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010652a:	e9 bb f1 ff ff       	jmp    801056ea <alltraps>

8010652f <vector234>:
.globl vector234
vector234:
  pushl $0
8010652f:	6a 00                	push   $0x0
  pushl $234
80106531:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106536:	e9 af f1 ff ff       	jmp    801056ea <alltraps>

8010653b <vector235>:
.globl vector235
vector235:
  pushl $0
8010653b:	6a 00                	push   $0x0
  pushl $235
8010653d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106542:	e9 a3 f1 ff ff       	jmp    801056ea <alltraps>

80106547 <vector236>:
.globl vector236
vector236:
  pushl $0
80106547:	6a 00                	push   $0x0
  pushl $236
80106549:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010654e:	e9 97 f1 ff ff       	jmp    801056ea <alltraps>

80106553 <vector237>:
.globl vector237
vector237:
  pushl $0
80106553:	6a 00                	push   $0x0
  pushl $237
80106555:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010655a:	e9 8b f1 ff ff       	jmp    801056ea <alltraps>

8010655f <vector238>:
.globl vector238
vector238:
  pushl $0
8010655f:	6a 00                	push   $0x0
  pushl $238
80106561:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106566:	e9 7f f1 ff ff       	jmp    801056ea <alltraps>

8010656b <vector239>:
.globl vector239
vector239:
  pushl $0
8010656b:	6a 00                	push   $0x0
  pushl $239
8010656d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106572:	e9 73 f1 ff ff       	jmp    801056ea <alltraps>

80106577 <vector240>:
.globl vector240
vector240:
  pushl $0
80106577:	6a 00                	push   $0x0
  pushl $240
80106579:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010657e:	e9 67 f1 ff ff       	jmp    801056ea <alltraps>

80106583 <vector241>:
.globl vector241
vector241:
  pushl $0
80106583:	6a 00                	push   $0x0
  pushl $241
80106585:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
8010658a:	e9 5b f1 ff ff       	jmp    801056ea <alltraps>

8010658f <vector242>:
.globl vector242
vector242:
  pushl $0
8010658f:	6a 00                	push   $0x0
  pushl $242
80106591:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106596:	e9 4f f1 ff ff       	jmp    801056ea <alltraps>

8010659b <vector243>:
.globl vector243
vector243:
  pushl $0
8010659b:	6a 00                	push   $0x0
  pushl $243
8010659d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801065a2:	e9 43 f1 ff ff       	jmp    801056ea <alltraps>

801065a7 <vector244>:
.globl vector244
vector244:
  pushl $0
801065a7:	6a 00                	push   $0x0
  pushl $244
801065a9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801065ae:	e9 37 f1 ff ff       	jmp    801056ea <alltraps>

801065b3 <vector245>:
.globl vector245
vector245:
  pushl $0
801065b3:	6a 00                	push   $0x0
  pushl $245
801065b5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
801065ba:	e9 2b f1 ff ff       	jmp    801056ea <alltraps>

801065bf <vector246>:
.globl vector246
vector246:
  pushl $0
801065bf:	6a 00                	push   $0x0
  pushl $246
801065c1:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
801065c6:	e9 1f f1 ff ff       	jmp    801056ea <alltraps>

801065cb <vector247>:
.globl vector247
vector247:
  pushl $0
801065cb:	6a 00                	push   $0x0
  pushl $247
801065cd:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
801065d2:	e9 13 f1 ff ff       	jmp    801056ea <alltraps>

801065d7 <vector248>:
.globl vector248
vector248:
  pushl $0
801065d7:	6a 00                	push   $0x0
  pushl $248
801065d9:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
801065de:	e9 07 f1 ff ff       	jmp    801056ea <alltraps>

801065e3 <vector249>:
.globl vector249
vector249:
  pushl $0
801065e3:	6a 00                	push   $0x0
  pushl $249
801065e5:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
801065ea:	e9 fb f0 ff ff       	jmp    801056ea <alltraps>

801065ef <vector250>:
.globl vector250
vector250:
  pushl $0
801065ef:	6a 00                	push   $0x0
  pushl $250
801065f1:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
801065f6:	e9 ef f0 ff ff       	jmp    801056ea <alltraps>

801065fb <vector251>:
.globl vector251
vector251:
  pushl $0
801065fb:	6a 00                	push   $0x0
  pushl $251
801065fd:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106602:	e9 e3 f0 ff ff       	jmp    801056ea <alltraps>

80106607 <vector252>:
.globl vector252
vector252:
  pushl $0
80106607:	6a 00                	push   $0x0
  pushl $252
80106609:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010660e:	e9 d7 f0 ff ff       	jmp    801056ea <alltraps>

80106613 <vector253>:
.globl vector253
vector253:
  pushl $0
80106613:	6a 00                	push   $0x0
  pushl $253
80106615:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010661a:	e9 cb f0 ff ff       	jmp    801056ea <alltraps>

8010661f <vector254>:
.globl vector254
vector254:
  pushl $0
8010661f:	6a 00                	push   $0x0
  pushl $254
80106621:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106626:	e9 bf f0 ff ff       	jmp    801056ea <alltraps>

8010662b <vector255>:
.globl vector255
vector255:
  pushl $0
8010662b:	6a 00                	push   $0x0
  pushl $255
8010662d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106632:	e9 b3 f0 ff ff       	jmp    801056ea <alltraps>
80106637:	66 90                	xchg   %ax,%ax
80106639:	66 90                	xchg   %ax,%ax
8010663b:	66 90                	xchg   %ax,%ax
8010663d:	66 90                	xchg   %ax,%ax
8010663f:	90                   	nop

80106640 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106640:	55                   	push   %ebp
80106641:	89 e5                	mov    %esp,%ebp
80106643:	57                   	push   %edi
80106644:	56                   	push   %esi
80106645:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106646:	89 d3                	mov    %edx,%ebx
{
80106648:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
8010664a:	c1 eb 16             	shr    $0x16,%ebx
8010664d:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80106650:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80106653:	8b 06                	mov    (%esi),%eax
80106655:	a8 01                	test   $0x1,%al
80106657:	74 27                	je     80106680 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106659:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010665e:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106664:	c1 ef 0a             	shr    $0xa,%edi
}
80106667:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
8010666a:	89 fa                	mov    %edi,%edx
8010666c:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106672:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80106675:	5b                   	pop    %ebx
80106676:	5e                   	pop    %esi
80106677:	5f                   	pop    %edi
80106678:	5d                   	pop    %ebp
80106679:	c3                   	ret    
8010667a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106680:	85 c9                	test   %ecx,%ecx
80106682:	74 2c                	je     801066b0 <walkpgdir+0x70>
80106684:	e8 f7 be ff ff       	call   80102580 <kalloc>
80106689:	85 c0                	test   %eax,%eax
8010668b:	89 c3                	mov    %eax,%ebx
8010668d:	74 21                	je     801066b0 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
8010668f:	83 ec 04             	sub    $0x4,%esp
80106692:	68 00 10 00 00       	push   $0x1000
80106697:	6a 00                	push   $0x0
80106699:	50                   	push   %eax
8010669a:	e8 71 de ff ff       	call   80104510 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010669f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801066a5:	83 c4 10             	add    $0x10,%esp
801066a8:	83 c8 07             	or     $0x7,%eax
801066ab:	89 06                	mov    %eax,(%esi)
801066ad:	eb b5                	jmp    80106664 <walkpgdir+0x24>
801066af:	90                   	nop
}
801066b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
801066b3:	31 c0                	xor    %eax,%eax
}
801066b5:	5b                   	pop    %ebx
801066b6:	5e                   	pop    %esi
801066b7:	5f                   	pop    %edi
801066b8:	5d                   	pop    %ebp
801066b9:	c3                   	ret    
801066ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801066c0 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801066c0:	55                   	push   %ebp
801066c1:	89 e5                	mov    %esp,%ebp
801066c3:	57                   	push   %edi
801066c4:	56                   	push   %esi
801066c5:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
801066c6:	89 d3                	mov    %edx,%ebx
801066c8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
801066ce:	83 ec 1c             	sub    $0x1c,%esp
801066d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801066d4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
801066d8:	8b 7d 08             	mov    0x8(%ebp),%edi
801066db:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801066e0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
801066e3:	8b 45 0c             	mov    0xc(%ebp),%eax
801066e6:	29 df                	sub    %ebx,%edi
801066e8:	83 c8 01             	or     $0x1,%eax
801066eb:	89 45 dc             	mov    %eax,-0x24(%ebp)
801066ee:	eb 15                	jmp    80106705 <mappages+0x45>
    if(*pte & PTE_P)
801066f0:	f6 00 01             	testb  $0x1,(%eax)
801066f3:	75 45                	jne    8010673a <mappages+0x7a>
    *pte = pa | perm | PTE_P;
801066f5:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
801066f8:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
801066fb:	89 30                	mov    %esi,(%eax)
    if(a == last)
801066fd:	74 31                	je     80106730 <mappages+0x70>
      break;
    a += PGSIZE;
801066ff:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106705:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106708:	b9 01 00 00 00       	mov    $0x1,%ecx
8010670d:	89 da                	mov    %ebx,%edx
8010670f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106712:	e8 29 ff ff ff       	call   80106640 <walkpgdir>
80106717:	85 c0                	test   %eax,%eax
80106719:	75 d5                	jne    801066f0 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
8010671b:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010671e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106723:	5b                   	pop    %ebx
80106724:	5e                   	pop    %esi
80106725:	5f                   	pop    %edi
80106726:	5d                   	pop    %ebp
80106727:	c3                   	ret    
80106728:	90                   	nop
80106729:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106730:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106733:	31 c0                	xor    %eax,%eax
}
80106735:	5b                   	pop    %ebx
80106736:	5e                   	pop    %esi
80106737:	5f                   	pop    %edi
80106738:	5d                   	pop    %ebp
80106739:	c3                   	ret    
      panic("remap");
8010673a:	83 ec 0c             	sub    $0xc,%esp
8010673d:	68 48 78 10 80       	push   $0x80107848
80106742:	e8 49 9c ff ff       	call   80100390 <panic>
80106747:	89 f6                	mov    %esi,%esi
80106749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106750 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106750:	55                   	push   %ebp
80106751:	89 e5                	mov    %esp,%ebp
80106753:	57                   	push   %edi
80106754:	56                   	push   %esi
80106755:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106756:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
8010675c:	89 c7                	mov    %eax,%edi
  a = PGROUNDUP(newsz);
8010675e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106764:	83 ec 1c             	sub    $0x1c,%esp
80106767:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
8010676a:	39 d3                	cmp    %edx,%ebx
8010676c:	73 66                	jae    801067d4 <deallocuvm.part.0+0x84>
8010676e:	89 d6                	mov    %edx,%esi
80106770:	eb 3d                	jmp    801067af <deallocuvm.part.0+0x5f>
80106772:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106778:	8b 10                	mov    (%eax),%edx
8010677a:	f6 c2 01             	test   $0x1,%dl
8010677d:	74 26                	je     801067a5 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
8010677f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106785:	74 58                	je     801067df <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106787:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
8010678a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106790:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(v);
80106793:	52                   	push   %edx
80106794:	e8 37 bc ff ff       	call   801023d0 <kfree>
      *pte = 0;
80106799:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010679c:	83 c4 10             	add    $0x10,%esp
8010679f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
801067a5:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801067ab:	39 f3                	cmp    %esi,%ebx
801067ad:	73 25                	jae    801067d4 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
801067af:	31 c9                	xor    %ecx,%ecx
801067b1:	89 da                	mov    %ebx,%edx
801067b3:	89 f8                	mov    %edi,%eax
801067b5:	e8 86 fe ff ff       	call   80106640 <walkpgdir>
    if(!pte)
801067ba:	85 c0                	test   %eax,%eax
801067bc:	75 ba                	jne    80106778 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
801067be:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
801067c4:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
801067ca:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801067d0:	39 f3                	cmp    %esi,%ebx
801067d2:	72 db                	jb     801067af <deallocuvm.part.0+0x5f>
    }
  }
  return newsz;
}
801067d4:	8b 45 e0             	mov    -0x20(%ebp),%eax
801067d7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801067da:	5b                   	pop    %ebx
801067db:	5e                   	pop    %esi
801067dc:	5f                   	pop    %edi
801067dd:	5d                   	pop    %ebp
801067de:	c3                   	ret    
        panic("kfree");
801067df:	83 ec 0c             	sub    $0xc,%esp
801067e2:	68 e6 71 10 80       	push   $0x801071e6
801067e7:	e8 a4 9b ff ff       	call   80100390 <panic>
801067ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801067f0 <seginit>:
{
801067f0:	55                   	push   %ebp
801067f1:	89 e5                	mov    %esp,%ebp
801067f3:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
801067f6:	e8 85 d0 ff ff       	call   80103880 <cpuid>
801067fb:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
  pd[0] = size-1;
80106801:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106806:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010680a:	c7 80 f8 27 11 80 ff 	movl   $0xffff,-0x7feed808(%eax)
80106811:	ff 00 00 
80106814:	c7 80 fc 27 11 80 00 	movl   $0xcf9a00,-0x7feed804(%eax)
8010681b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010681e:	c7 80 00 28 11 80 ff 	movl   $0xffff,-0x7feed800(%eax)
80106825:	ff 00 00 
80106828:	c7 80 04 28 11 80 00 	movl   $0xcf9200,-0x7feed7fc(%eax)
8010682f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106832:	c7 80 08 28 11 80 ff 	movl   $0xffff,-0x7feed7f8(%eax)
80106839:	ff 00 00 
8010683c:	c7 80 0c 28 11 80 00 	movl   $0xcffa00,-0x7feed7f4(%eax)
80106843:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106846:	c7 80 10 28 11 80 ff 	movl   $0xffff,-0x7feed7f0(%eax)
8010684d:	ff 00 00 
80106850:	c7 80 14 28 11 80 00 	movl   $0xcff200,-0x7feed7ec(%eax)
80106857:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
8010685a:	05 f0 27 11 80       	add    $0x801127f0,%eax
  pd[1] = (uint)p;
8010685f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106863:	c1 e8 10             	shr    $0x10,%eax
80106866:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
8010686a:	8d 45 f2             	lea    -0xe(%ebp),%eax
8010686d:	0f 01 10             	lgdtl  (%eax)
}
80106870:	c9                   	leave  
80106871:	c3                   	ret    
80106872:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106880 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106880:	a1 a4 54 11 80       	mov    0x801154a4,%eax
{
80106885:	55                   	push   %ebp
80106886:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106888:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010688d:	0f 22 d8             	mov    %eax,%cr3
}
80106890:	5d                   	pop    %ebp
80106891:	c3                   	ret    
80106892:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801068a0 <switchuvm>:
{
801068a0:	55                   	push   %ebp
801068a1:	89 e5                	mov    %esp,%ebp
801068a3:	57                   	push   %edi
801068a4:	56                   	push   %esi
801068a5:	53                   	push   %ebx
801068a6:	83 ec 1c             	sub    $0x1c,%esp
801068a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
801068ac:	85 db                	test   %ebx,%ebx
801068ae:	0f 84 cb 00 00 00    	je     8010697f <switchuvm+0xdf>
  if(p->kstack == 0)
801068b4:	8b 43 08             	mov    0x8(%ebx),%eax
801068b7:	85 c0                	test   %eax,%eax
801068b9:	0f 84 da 00 00 00    	je     80106999 <switchuvm+0xf9>
  if(p->pgdir == 0)
801068bf:	8b 43 04             	mov    0x4(%ebx),%eax
801068c2:	85 c0                	test   %eax,%eax
801068c4:	0f 84 c2 00 00 00    	je     8010698c <switchuvm+0xec>
  pushcli();
801068ca:	e8 61 da ff ff       	call   80104330 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801068cf:	e8 2c cf ff ff       	call   80103800 <mycpu>
801068d4:	89 c6                	mov    %eax,%esi
801068d6:	e8 25 cf ff ff       	call   80103800 <mycpu>
801068db:	89 c7                	mov    %eax,%edi
801068dd:	e8 1e cf ff ff       	call   80103800 <mycpu>
801068e2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801068e5:	83 c7 08             	add    $0x8,%edi
801068e8:	e8 13 cf ff ff       	call   80103800 <mycpu>
801068ed:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801068f0:	83 c0 08             	add    $0x8,%eax
801068f3:	ba 67 00 00 00       	mov    $0x67,%edx
801068f8:	c1 e8 18             	shr    $0x18,%eax
801068fb:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
80106902:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
80106909:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
8010690f:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106914:	83 c1 08             	add    $0x8,%ecx
80106917:	c1 e9 10             	shr    $0x10,%ecx
8010691a:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80106920:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106925:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010692c:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
80106931:	e8 ca ce ff ff       	call   80103800 <mycpu>
80106936:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010693d:	e8 be ce ff ff       	call   80103800 <mycpu>
80106942:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106946:	8b 73 08             	mov    0x8(%ebx),%esi
80106949:	e8 b2 ce ff ff       	call   80103800 <mycpu>
8010694e:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106954:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106957:	e8 a4 ce ff ff       	call   80103800 <mycpu>
8010695c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106960:	b8 28 00 00 00       	mov    $0x28,%eax
80106965:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106968:	8b 43 04             	mov    0x4(%ebx),%eax
8010696b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106970:	0f 22 d8             	mov    %eax,%cr3
}
80106973:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106976:	5b                   	pop    %ebx
80106977:	5e                   	pop    %esi
80106978:	5f                   	pop    %edi
80106979:	5d                   	pop    %ebp
  popcli();
8010697a:	e9 f1 d9 ff ff       	jmp    80104370 <popcli>
    panic("switchuvm: no process");
8010697f:	83 ec 0c             	sub    $0xc,%esp
80106982:	68 4e 78 10 80       	push   $0x8010784e
80106987:	e8 04 9a ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
8010698c:	83 ec 0c             	sub    $0xc,%esp
8010698f:	68 79 78 10 80       	push   $0x80107879
80106994:	e8 f7 99 ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
80106999:	83 ec 0c             	sub    $0xc,%esp
8010699c:	68 64 78 10 80       	push   $0x80107864
801069a1:	e8 ea 99 ff ff       	call   80100390 <panic>
801069a6:	8d 76 00             	lea    0x0(%esi),%esi
801069a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801069b0 <inituvm>:
{
801069b0:	55                   	push   %ebp
801069b1:	89 e5                	mov    %esp,%ebp
801069b3:	57                   	push   %edi
801069b4:	56                   	push   %esi
801069b5:	53                   	push   %ebx
801069b6:	83 ec 1c             	sub    $0x1c,%esp
801069b9:	8b 75 10             	mov    0x10(%ebp),%esi
801069bc:	8b 45 08             	mov    0x8(%ebp),%eax
801069bf:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
801069c2:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
801069c8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
801069cb:	77 49                	ja     80106a16 <inituvm+0x66>
  mem = kalloc();
801069cd:	e8 ae bb ff ff       	call   80102580 <kalloc>
  memset(mem, 0, PGSIZE);
801069d2:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
801069d5:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
801069d7:	68 00 10 00 00       	push   $0x1000
801069dc:	6a 00                	push   $0x0
801069de:	50                   	push   %eax
801069df:	e8 2c db ff ff       	call   80104510 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
801069e4:	58                   	pop    %eax
801069e5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801069eb:	b9 00 10 00 00       	mov    $0x1000,%ecx
801069f0:	5a                   	pop    %edx
801069f1:	6a 06                	push   $0x6
801069f3:	50                   	push   %eax
801069f4:	31 d2                	xor    %edx,%edx
801069f6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801069f9:	e8 c2 fc ff ff       	call   801066c0 <mappages>
  memmove(mem, init, sz);
801069fe:	89 75 10             	mov    %esi,0x10(%ebp)
80106a01:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106a04:	83 c4 10             	add    $0x10,%esp
80106a07:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106a0a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106a0d:	5b                   	pop    %ebx
80106a0e:	5e                   	pop    %esi
80106a0f:	5f                   	pop    %edi
80106a10:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106a11:	e9 aa db ff ff       	jmp    801045c0 <memmove>
    panic("inituvm: more than a page");
80106a16:	83 ec 0c             	sub    $0xc,%esp
80106a19:	68 8d 78 10 80       	push   $0x8010788d
80106a1e:	e8 6d 99 ff ff       	call   80100390 <panic>
80106a23:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106a30 <loaduvm>:
{
80106a30:	55                   	push   %ebp
80106a31:	89 e5                	mov    %esp,%ebp
80106a33:	57                   	push   %edi
80106a34:	56                   	push   %esi
80106a35:	53                   	push   %ebx
80106a36:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80106a39:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106a40:	0f 85 91 00 00 00    	jne    80106ad7 <loaduvm+0xa7>
  for(i = 0; i < sz; i += PGSIZE){
80106a46:	8b 75 18             	mov    0x18(%ebp),%esi
80106a49:	31 db                	xor    %ebx,%ebx
80106a4b:	85 f6                	test   %esi,%esi
80106a4d:	75 1a                	jne    80106a69 <loaduvm+0x39>
80106a4f:	eb 6f                	jmp    80106ac0 <loaduvm+0x90>
80106a51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a58:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106a5e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106a64:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106a67:	76 57                	jbe    80106ac0 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106a69:	8b 55 0c             	mov    0xc(%ebp),%edx
80106a6c:	8b 45 08             	mov    0x8(%ebp),%eax
80106a6f:	31 c9                	xor    %ecx,%ecx
80106a71:	01 da                	add    %ebx,%edx
80106a73:	e8 c8 fb ff ff       	call   80106640 <walkpgdir>
80106a78:	85 c0                	test   %eax,%eax
80106a7a:	74 4e                	je     80106aca <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
80106a7c:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106a7e:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
80106a81:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80106a86:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106a8b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106a91:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106a94:	01 d9                	add    %ebx,%ecx
80106a96:	05 00 00 00 80       	add    $0x80000000,%eax
80106a9b:	57                   	push   %edi
80106a9c:	51                   	push   %ecx
80106a9d:	50                   	push   %eax
80106a9e:	ff 75 10             	pushl  0x10(%ebp)
80106aa1:	e8 7a af ff ff       	call   80101a20 <readi>
80106aa6:	83 c4 10             	add    $0x10,%esp
80106aa9:	39 f8                	cmp    %edi,%eax
80106aab:	74 ab                	je     80106a58 <loaduvm+0x28>
}
80106aad:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106ab0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106ab5:	5b                   	pop    %ebx
80106ab6:	5e                   	pop    %esi
80106ab7:	5f                   	pop    %edi
80106ab8:	5d                   	pop    %ebp
80106ab9:	c3                   	ret    
80106aba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106ac0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106ac3:	31 c0                	xor    %eax,%eax
}
80106ac5:	5b                   	pop    %ebx
80106ac6:	5e                   	pop    %esi
80106ac7:	5f                   	pop    %edi
80106ac8:	5d                   	pop    %ebp
80106ac9:	c3                   	ret    
      panic("loaduvm: address should exist");
80106aca:	83 ec 0c             	sub    $0xc,%esp
80106acd:	68 a7 78 10 80       	push   $0x801078a7
80106ad2:	e8 b9 98 ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
80106ad7:	83 ec 0c             	sub    $0xc,%esp
80106ada:	68 48 79 10 80       	push   $0x80107948
80106adf:	e8 ac 98 ff ff       	call   80100390 <panic>
80106ae4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106aea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106af0 <allocuvm>:
{
80106af0:	55                   	push   %ebp
80106af1:	89 e5                	mov    %esp,%ebp
80106af3:	57                   	push   %edi
80106af4:	56                   	push   %esi
80106af5:	53                   	push   %ebx
80106af6:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80106af9:	8b 7d 10             	mov    0x10(%ebp),%edi
80106afc:	85 ff                	test   %edi,%edi
80106afe:	0f 88 8e 00 00 00    	js     80106b92 <allocuvm+0xa2>
  if(newsz < oldsz)
80106b04:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106b07:	0f 82 93 00 00 00    	jb     80106ba0 <allocuvm+0xb0>
  a = PGROUNDUP(oldsz);
80106b0d:	8b 45 0c             	mov    0xc(%ebp),%eax
80106b10:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106b16:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106b1c:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106b1f:	0f 86 7e 00 00 00    	jbe    80106ba3 <allocuvm+0xb3>
80106b25:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80106b28:	8b 7d 08             	mov    0x8(%ebp),%edi
80106b2b:	eb 42                	jmp    80106b6f <allocuvm+0x7f>
80106b2d:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
80106b30:	83 ec 04             	sub    $0x4,%esp
80106b33:	68 00 10 00 00       	push   $0x1000
80106b38:	6a 00                	push   $0x0
80106b3a:	50                   	push   %eax
80106b3b:	e8 d0 d9 ff ff       	call   80104510 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106b40:	58                   	pop    %eax
80106b41:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106b47:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106b4c:	5a                   	pop    %edx
80106b4d:	6a 06                	push   $0x6
80106b4f:	50                   	push   %eax
80106b50:	89 da                	mov    %ebx,%edx
80106b52:	89 f8                	mov    %edi,%eax
80106b54:	e8 67 fb ff ff       	call   801066c0 <mappages>
80106b59:	83 c4 10             	add    $0x10,%esp
80106b5c:	85 c0                	test   %eax,%eax
80106b5e:	78 50                	js     80106bb0 <allocuvm+0xc0>
  for(; a < newsz; a += PGSIZE){
80106b60:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106b66:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80106b69:	0f 86 81 00 00 00    	jbe    80106bf0 <allocuvm+0x100>
    mem = kalloc();
80106b6f:	e8 0c ba ff ff       	call   80102580 <kalloc>
    if(mem == 0){
80106b74:	85 c0                	test   %eax,%eax
    mem = kalloc();
80106b76:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106b78:	75 b6                	jne    80106b30 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80106b7a:	83 ec 0c             	sub    $0xc,%esp
80106b7d:	68 c5 78 10 80       	push   $0x801078c5
80106b82:	e8 d9 9a ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
80106b87:	83 c4 10             	add    $0x10,%esp
80106b8a:	8b 45 0c             	mov    0xc(%ebp),%eax
80106b8d:	39 45 10             	cmp    %eax,0x10(%ebp)
80106b90:	77 6e                	ja     80106c00 <allocuvm+0x110>
}
80106b92:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80106b95:	31 ff                	xor    %edi,%edi
}
80106b97:	89 f8                	mov    %edi,%eax
80106b99:	5b                   	pop    %ebx
80106b9a:	5e                   	pop    %esi
80106b9b:	5f                   	pop    %edi
80106b9c:	5d                   	pop    %ebp
80106b9d:	c3                   	ret    
80106b9e:	66 90                	xchg   %ax,%ax
    return oldsz;
80106ba0:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
80106ba3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ba6:	89 f8                	mov    %edi,%eax
80106ba8:	5b                   	pop    %ebx
80106ba9:	5e                   	pop    %esi
80106baa:	5f                   	pop    %edi
80106bab:	5d                   	pop    %ebp
80106bac:	c3                   	ret    
80106bad:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80106bb0:	83 ec 0c             	sub    $0xc,%esp
80106bb3:	68 dd 78 10 80       	push   $0x801078dd
80106bb8:	e8 a3 9a ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
80106bbd:	83 c4 10             	add    $0x10,%esp
80106bc0:	8b 45 0c             	mov    0xc(%ebp),%eax
80106bc3:	39 45 10             	cmp    %eax,0x10(%ebp)
80106bc6:	76 0d                	jbe    80106bd5 <allocuvm+0xe5>
80106bc8:	89 c1                	mov    %eax,%ecx
80106bca:	8b 55 10             	mov    0x10(%ebp),%edx
80106bcd:	8b 45 08             	mov    0x8(%ebp),%eax
80106bd0:	e8 7b fb ff ff       	call   80106750 <deallocuvm.part.0>
      kfree(mem);
80106bd5:	83 ec 0c             	sub    $0xc,%esp
      return 0;
80106bd8:	31 ff                	xor    %edi,%edi
      kfree(mem);
80106bda:	56                   	push   %esi
80106bdb:	e8 f0 b7 ff ff       	call   801023d0 <kfree>
      return 0;
80106be0:	83 c4 10             	add    $0x10,%esp
}
80106be3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106be6:	89 f8                	mov    %edi,%eax
80106be8:	5b                   	pop    %ebx
80106be9:	5e                   	pop    %esi
80106bea:	5f                   	pop    %edi
80106beb:	5d                   	pop    %ebp
80106bec:	c3                   	ret    
80106bed:	8d 76 00             	lea    0x0(%esi),%esi
80106bf0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80106bf3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106bf6:	5b                   	pop    %ebx
80106bf7:	89 f8                	mov    %edi,%eax
80106bf9:	5e                   	pop    %esi
80106bfa:	5f                   	pop    %edi
80106bfb:	5d                   	pop    %ebp
80106bfc:	c3                   	ret    
80106bfd:	8d 76 00             	lea    0x0(%esi),%esi
80106c00:	89 c1                	mov    %eax,%ecx
80106c02:	8b 55 10             	mov    0x10(%ebp),%edx
80106c05:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
80106c08:	31 ff                	xor    %edi,%edi
80106c0a:	e8 41 fb ff ff       	call   80106750 <deallocuvm.part.0>
80106c0f:	eb 92                	jmp    80106ba3 <allocuvm+0xb3>
80106c11:	eb 0d                	jmp    80106c20 <deallocuvm>
80106c13:	90                   	nop
80106c14:	90                   	nop
80106c15:	90                   	nop
80106c16:	90                   	nop
80106c17:	90                   	nop
80106c18:	90                   	nop
80106c19:	90                   	nop
80106c1a:	90                   	nop
80106c1b:	90                   	nop
80106c1c:	90                   	nop
80106c1d:	90                   	nop
80106c1e:	90                   	nop
80106c1f:	90                   	nop

80106c20 <deallocuvm>:
{
80106c20:	55                   	push   %ebp
80106c21:	89 e5                	mov    %esp,%ebp
80106c23:	8b 55 0c             	mov    0xc(%ebp),%edx
80106c26:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106c29:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80106c2c:	39 d1                	cmp    %edx,%ecx
80106c2e:	73 10                	jae    80106c40 <deallocuvm+0x20>
}
80106c30:	5d                   	pop    %ebp
80106c31:	e9 1a fb ff ff       	jmp    80106750 <deallocuvm.part.0>
80106c36:	8d 76 00             	lea    0x0(%esi),%esi
80106c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106c40:	89 d0                	mov    %edx,%eax
80106c42:	5d                   	pop    %ebp
80106c43:	c3                   	ret    
80106c44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106c4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106c50 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106c50:	55                   	push   %ebp
80106c51:	89 e5                	mov    %esp,%ebp
80106c53:	57                   	push   %edi
80106c54:	56                   	push   %esi
80106c55:	53                   	push   %ebx
80106c56:	83 ec 0c             	sub    $0xc,%esp
80106c59:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106c5c:	85 f6                	test   %esi,%esi
80106c5e:	74 59                	je     80106cb9 <freevm+0x69>
80106c60:	31 c9                	xor    %ecx,%ecx
80106c62:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106c67:	89 f0                	mov    %esi,%eax
80106c69:	e8 e2 fa ff ff       	call   80106750 <deallocuvm.part.0>
80106c6e:	89 f3                	mov    %esi,%ebx
80106c70:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80106c76:	eb 0f                	jmp    80106c87 <freevm+0x37>
80106c78:	90                   	nop
80106c79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106c80:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106c83:	39 fb                	cmp    %edi,%ebx
80106c85:	74 23                	je     80106caa <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106c87:	8b 03                	mov    (%ebx),%eax
80106c89:	a8 01                	test   $0x1,%al
80106c8b:	74 f3                	je     80106c80 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106c8d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80106c92:	83 ec 0c             	sub    $0xc,%esp
80106c95:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106c98:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80106c9d:	50                   	push   %eax
80106c9e:	e8 2d b7 ff ff       	call   801023d0 <kfree>
80106ca3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80106ca6:	39 fb                	cmp    %edi,%ebx
80106ca8:	75 dd                	jne    80106c87 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80106caa:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106cad:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106cb0:	5b                   	pop    %ebx
80106cb1:	5e                   	pop    %esi
80106cb2:	5f                   	pop    %edi
80106cb3:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80106cb4:	e9 17 b7 ff ff       	jmp    801023d0 <kfree>
    panic("freevm: no pgdir");
80106cb9:	83 ec 0c             	sub    $0xc,%esp
80106cbc:	68 f9 78 10 80       	push   $0x801078f9
80106cc1:	e8 ca 96 ff ff       	call   80100390 <panic>
80106cc6:	8d 76 00             	lea    0x0(%esi),%esi
80106cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106cd0 <setupkvm>:
{
80106cd0:	55                   	push   %ebp
80106cd1:	89 e5                	mov    %esp,%ebp
80106cd3:	56                   	push   %esi
80106cd4:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80106cd5:	e8 a6 b8 ff ff       	call   80102580 <kalloc>
80106cda:	85 c0                	test   %eax,%eax
80106cdc:	89 c6                	mov    %eax,%esi
80106cde:	74 42                	je     80106d22 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80106ce0:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106ce3:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  memset(pgdir, 0, PGSIZE);
80106ce8:	68 00 10 00 00       	push   $0x1000
80106ced:	6a 00                	push   $0x0
80106cef:	50                   	push   %eax
80106cf0:	e8 1b d8 ff ff       	call   80104510 <memset>
80106cf5:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80106cf8:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106cfb:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106cfe:	83 ec 08             	sub    $0x8,%esp
80106d01:	8b 13                	mov    (%ebx),%edx
80106d03:	ff 73 0c             	pushl  0xc(%ebx)
80106d06:	50                   	push   %eax
80106d07:	29 c1                	sub    %eax,%ecx
80106d09:	89 f0                	mov    %esi,%eax
80106d0b:	e8 b0 f9 ff ff       	call   801066c0 <mappages>
80106d10:	83 c4 10             	add    $0x10,%esp
80106d13:	85 c0                	test   %eax,%eax
80106d15:	78 19                	js     80106d30 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106d17:	83 c3 10             	add    $0x10,%ebx
80106d1a:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106d20:	75 d6                	jne    80106cf8 <setupkvm+0x28>
}
80106d22:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106d25:	89 f0                	mov    %esi,%eax
80106d27:	5b                   	pop    %ebx
80106d28:	5e                   	pop    %esi
80106d29:	5d                   	pop    %ebp
80106d2a:	c3                   	ret    
80106d2b:	90                   	nop
80106d2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80106d30:	83 ec 0c             	sub    $0xc,%esp
80106d33:	56                   	push   %esi
      return 0;
80106d34:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80106d36:	e8 15 ff ff ff       	call   80106c50 <freevm>
      return 0;
80106d3b:	83 c4 10             	add    $0x10,%esp
}
80106d3e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106d41:	89 f0                	mov    %esi,%eax
80106d43:	5b                   	pop    %ebx
80106d44:	5e                   	pop    %esi
80106d45:	5d                   	pop    %ebp
80106d46:	c3                   	ret    
80106d47:	89 f6                	mov    %esi,%esi
80106d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106d50 <kvmalloc>:
{
80106d50:	55                   	push   %ebp
80106d51:	89 e5                	mov    %esp,%ebp
80106d53:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106d56:	e8 75 ff ff ff       	call   80106cd0 <setupkvm>
80106d5b:	a3 a4 54 11 80       	mov    %eax,0x801154a4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106d60:	05 00 00 00 80       	add    $0x80000000,%eax
80106d65:	0f 22 d8             	mov    %eax,%cr3
}
80106d68:	c9                   	leave  
80106d69:	c3                   	ret    
80106d6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106d70 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106d70:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106d71:	31 c9                	xor    %ecx,%ecx
{
80106d73:	89 e5                	mov    %esp,%ebp
80106d75:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80106d78:	8b 55 0c             	mov    0xc(%ebp),%edx
80106d7b:	8b 45 08             	mov    0x8(%ebp),%eax
80106d7e:	e8 bd f8 ff ff       	call   80106640 <walkpgdir>
  if(pte == 0)
80106d83:	85 c0                	test   %eax,%eax
80106d85:	74 05                	je     80106d8c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80106d87:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80106d8a:	c9                   	leave  
80106d8b:	c3                   	ret    
    panic("clearpteu");
80106d8c:	83 ec 0c             	sub    $0xc,%esp
80106d8f:	68 0a 79 10 80       	push   $0x8010790a
80106d94:	e8 f7 95 ff ff       	call   80100390 <panic>
80106d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106da0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80106da0:	55                   	push   %ebp
80106da1:	89 e5                	mov    %esp,%ebp
80106da3:	57                   	push   %edi
80106da4:	56                   	push   %esi
80106da5:	53                   	push   %ebx
80106da6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80106da9:	e8 22 ff ff ff       	call   80106cd0 <setupkvm>
80106dae:	85 c0                	test   %eax,%eax
80106db0:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106db3:	0f 84 9f 00 00 00    	je     80106e58 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106db9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106dbc:	85 c9                	test   %ecx,%ecx
80106dbe:	0f 84 94 00 00 00    	je     80106e58 <copyuvm+0xb8>
80106dc4:	31 ff                	xor    %edi,%edi
80106dc6:	eb 4a                	jmp    80106e12 <copyuvm+0x72>
80106dc8:	90                   	nop
80106dc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80106dd0:	83 ec 04             	sub    $0x4,%esp
80106dd3:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
80106dd9:	68 00 10 00 00       	push   $0x1000
80106dde:	53                   	push   %ebx
80106ddf:	50                   	push   %eax
80106de0:	e8 db d7 ff ff       	call   801045c0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80106de5:	58                   	pop    %eax
80106de6:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106dec:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106df1:	5a                   	pop    %edx
80106df2:	ff 75 e4             	pushl  -0x1c(%ebp)
80106df5:	50                   	push   %eax
80106df6:	89 fa                	mov    %edi,%edx
80106df8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106dfb:	e8 c0 f8 ff ff       	call   801066c0 <mappages>
80106e00:	83 c4 10             	add    $0x10,%esp
80106e03:	85 c0                	test   %eax,%eax
80106e05:	78 61                	js     80106e68 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80106e07:	81 c7 00 10 00 00    	add    $0x1000,%edi
80106e0d:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80106e10:	76 46                	jbe    80106e58 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80106e12:	8b 45 08             	mov    0x8(%ebp),%eax
80106e15:	31 c9                	xor    %ecx,%ecx
80106e17:	89 fa                	mov    %edi,%edx
80106e19:	e8 22 f8 ff ff       	call   80106640 <walkpgdir>
80106e1e:	85 c0                	test   %eax,%eax
80106e20:	74 61                	je     80106e83 <copyuvm+0xe3>
    if(!(*pte & PTE_P))
80106e22:	8b 00                	mov    (%eax),%eax
80106e24:	a8 01                	test   $0x1,%al
80106e26:	74 4e                	je     80106e76 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
80106e28:	89 c3                	mov    %eax,%ebx
    flags = PTE_FLAGS(*pte);
80106e2a:	25 ff 0f 00 00       	and    $0xfff,%eax
    pa = PTE_ADDR(*pte);
80106e2f:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    flags = PTE_FLAGS(*pte);
80106e35:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80106e38:	e8 43 b7 ff ff       	call   80102580 <kalloc>
80106e3d:	85 c0                	test   %eax,%eax
80106e3f:	89 c6                	mov    %eax,%esi
80106e41:	75 8d                	jne    80106dd0 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
80106e43:	83 ec 0c             	sub    $0xc,%esp
80106e46:	ff 75 e0             	pushl  -0x20(%ebp)
80106e49:	e8 02 fe ff ff       	call   80106c50 <freevm>
  return 0;
80106e4e:	83 c4 10             	add    $0x10,%esp
80106e51:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80106e58:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106e5b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e5e:	5b                   	pop    %ebx
80106e5f:	5e                   	pop    %esi
80106e60:	5f                   	pop    %edi
80106e61:	5d                   	pop    %ebp
80106e62:	c3                   	ret    
80106e63:	90                   	nop
80106e64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80106e68:	83 ec 0c             	sub    $0xc,%esp
80106e6b:	56                   	push   %esi
80106e6c:	e8 5f b5 ff ff       	call   801023d0 <kfree>
      goto bad;
80106e71:	83 c4 10             	add    $0x10,%esp
80106e74:	eb cd                	jmp    80106e43 <copyuvm+0xa3>
      panic("copyuvm: page not present");
80106e76:	83 ec 0c             	sub    $0xc,%esp
80106e79:	68 2e 79 10 80       	push   $0x8010792e
80106e7e:	e8 0d 95 ff ff       	call   80100390 <panic>
      panic("copyuvm: pte should exist");
80106e83:	83 ec 0c             	sub    $0xc,%esp
80106e86:	68 14 79 10 80       	push   $0x80107914
80106e8b:	e8 00 95 ff ff       	call   80100390 <panic>

80106e90 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80106e90:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106e91:	31 c9                	xor    %ecx,%ecx
{
80106e93:	89 e5                	mov    %esp,%ebp
80106e95:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80106e98:	8b 55 0c             	mov    0xc(%ebp),%edx
80106e9b:	8b 45 08             	mov    0x8(%ebp),%eax
80106e9e:	e8 9d f7 ff ff       	call   80106640 <walkpgdir>
  if((*pte & PTE_P) == 0)
80106ea3:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80106ea5:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80106ea6:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80106ea8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80106ead:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80106eb0:	05 00 00 00 80       	add    $0x80000000,%eax
80106eb5:	83 fa 05             	cmp    $0x5,%edx
80106eb8:	ba 00 00 00 00       	mov    $0x0,%edx
80106ebd:	0f 45 c2             	cmovne %edx,%eax
}
80106ec0:	c3                   	ret    
80106ec1:	eb 0d                	jmp    80106ed0 <copyout>
80106ec3:	90                   	nop
80106ec4:	90                   	nop
80106ec5:	90                   	nop
80106ec6:	90                   	nop
80106ec7:	90                   	nop
80106ec8:	90                   	nop
80106ec9:	90                   	nop
80106eca:	90                   	nop
80106ecb:	90                   	nop
80106ecc:	90                   	nop
80106ecd:	90                   	nop
80106ece:	90                   	nop
80106ecf:	90                   	nop

80106ed0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80106ed0:	55                   	push   %ebp
80106ed1:	89 e5                	mov    %esp,%ebp
80106ed3:	57                   	push   %edi
80106ed4:	56                   	push   %esi
80106ed5:	53                   	push   %ebx
80106ed6:	83 ec 1c             	sub    $0x1c,%esp
80106ed9:	8b 5d 14             	mov    0x14(%ebp),%ebx
80106edc:	8b 55 0c             	mov    0xc(%ebp),%edx
80106edf:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80106ee2:	85 db                	test   %ebx,%ebx
80106ee4:	75 40                	jne    80106f26 <copyout+0x56>
80106ee6:	eb 70                	jmp    80106f58 <copyout+0x88>
80106ee8:	90                   	nop
80106ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80106ef0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106ef3:	89 f1                	mov    %esi,%ecx
80106ef5:	29 d1                	sub    %edx,%ecx
80106ef7:	81 c1 00 10 00 00    	add    $0x1000,%ecx
80106efd:	39 d9                	cmp    %ebx,%ecx
80106eff:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80106f02:	29 f2                	sub    %esi,%edx
80106f04:	83 ec 04             	sub    $0x4,%esp
80106f07:	01 d0                	add    %edx,%eax
80106f09:	51                   	push   %ecx
80106f0a:	57                   	push   %edi
80106f0b:	50                   	push   %eax
80106f0c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80106f0f:	e8 ac d6 ff ff       	call   801045c0 <memmove>
    len -= n;
    buf += n;
80106f14:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
80106f17:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
80106f1a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
80106f20:	01 cf                	add    %ecx,%edi
  while(len > 0){
80106f22:	29 cb                	sub    %ecx,%ebx
80106f24:	74 32                	je     80106f58 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80106f26:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80106f28:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
80106f2b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80106f2e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80106f34:	56                   	push   %esi
80106f35:	ff 75 08             	pushl  0x8(%ebp)
80106f38:	e8 53 ff ff ff       	call   80106e90 <uva2ka>
    if(pa0 == 0)
80106f3d:	83 c4 10             	add    $0x10,%esp
80106f40:	85 c0                	test   %eax,%eax
80106f42:	75 ac                	jne    80106ef0 <copyout+0x20>
  }
  return 0;
}
80106f44:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106f47:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106f4c:	5b                   	pop    %ebx
80106f4d:	5e                   	pop    %esi
80106f4e:	5f                   	pop    %edi
80106f4f:	5d                   	pop    %ebp
80106f50:	c3                   	ret    
80106f51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f58:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106f5b:	31 c0                	xor    %eax,%eax
}
80106f5d:	5b                   	pop    %ebx
80106f5e:	5e                   	pop    %esi
80106f5f:	5f                   	pop    %edi
80106f60:	5d                   	pop    %ebp
80106f61:	c3                   	ret    
