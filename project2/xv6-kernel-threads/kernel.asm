
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:
8010000c:	0f 20 e0             	mov    %cr4,%eax
8010000f:	83 c8 10             	or     $0x10,%eax
80100012:	0f 22 e0             	mov    %eax,%cr4
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc d0 c5 10 80       	mov    $0x8010c5d0,%esp
8010002d:	b8 90 2f 10 80       	mov    $0x80102f90,%eax
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
80100043:	83 ec 10             	sub    $0x10,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
80100046:	68 20 7b 10 80       	push   $0x80107b20
8010004b:	68 e0 c5 10 80       	push   $0x8010c5e0
80100050:	e8 8b 4a 00 00       	call   80104ae0 <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
80100055:	c7 05 f0 04 11 80 e4 	movl   $0x801104e4,0x801104f0
8010005c:	04 11 80 
  bcache.head.next = &bcache.head;
8010005f:	c7 05 f4 04 11 80 e4 	movl   $0x801104e4,0x801104f4
80100066:	04 11 80 
80100069:	83 c4 10             	add    $0x10,%esp
8010006c:	b9 e4 04 11 80       	mov    $0x801104e4,%ecx
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100071:	b8 14 c6 10 80       	mov    $0x8010c614,%eax
80100076:	eb 0a                	jmp    80100082 <binit+0x42>
80100078:	90                   	nop
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 d0                	mov    %edx,%eax
    b->next = bcache.head.next;
80100082:	89 48 10             	mov    %ecx,0x10(%eax)
    b->prev = &bcache.head;
80100085:	c7 40 0c e4 04 11 80 	movl   $0x801104e4,0xc(%eax)
8010008c:	89 c1                	mov    %eax,%ecx
    b->dev = -1;
8010008e:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
    bcache.head.next->prev = b;
80100095:	8b 15 f4 04 11 80    	mov    0x801104f4,%edx
8010009b:	89 42 0c             	mov    %eax,0xc(%edx)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010009e:	8d 90 18 02 00 00    	lea    0x218(%eax),%edx
    bcache.head.next = b;
801000a4:	a3 f4 04 11 80       	mov    %eax,0x801104f4
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a9:	81 fa e4 04 11 80    	cmp    $0x801104e4,%edx
801000af:	72 cf                	jb     80100080 <binit+0x40>
  }
}
801000b1:	c9                   	leave  
801000b2:	c3                   	ret    
801000b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801000b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000c0 <bread>:
}

// Return a B_BUSY buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000c0:	55                   	push   %ebp
801000c1:	89 e5                	mov    %esp,%ebp
801000c3:	57                   	push   %edi
801000c4:	56                   	push   %esi
801000c5:	53                   	push   %ebx
801000c6:	83 ec 18             	sub    $0x18,%esp
801000c9:	8b 75 08             	mov    0x8(%ebp),%esi
801000cc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000cf:	68 e0 c5 10 80       	push   $0x8010c5e0
801000d4:	e8 27 4a 00 00       	call   80104b00 <acquire>
801000d9:	83 c4 10             	add    $0x10,%esp
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000dc:	8b 1d f4 04 11 80    	mov    0x801104f4,%ebx
801000e2:	81 fb e4 04 11 80    	cmp    $0x801104e4,%ebx
801000e8:	75 11                	jne    801000fb <bread+0x3b>
801000ea:	eb 34                	jmp    80100120 <bread+0x60>
801000ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801000f0:	8b 5b 10             	mov    0x10(%ebx),%ebx
801000f3:	81 fb e4 04 11 80    	cmp    $0x801104e4,%ebx
801000f9:	74 25                	je     80100120 <bread+0x60>
    if(b->dev == dev && b->blockno == blockno){
801000fb:	3b 73 04             	cmp    0x4(%ebx),%esi
801000fe:	75 f0                	jne    801000f0 <bread+0x30>
80100100:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100103:	75 eb                	jne    801000f0 <bread+0x30>
      if(!(b->flags & B_BUSY)){
80100105:	8b 03                	mov    (%ebx),%eax
80100107:	a8 01                	test   $0x1,%al
80100109:	74 6c                	je     80100177 <bread+0xb7>
      sleep(b, &bcache.lock);
8010010b:	83 ec 08             	sub    $0x8,%esp
8010010e:	68 e0 c5 10 80       	push   $0x8010c5e0
80100113:	53                   	push   %ebx
80100114:	e8 07 40 00 00       	call   80104120 <sleep>
80100119:	83 c4 10             	add    $0x10,%esp
8010011c:	eb be                	jmp    801000dc <bread+0x1c>
8010011e:	66 90                	xchg   %ax,%ax
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d f0 04 11 80    	mov    0x801104f0,%ebx
80100126:	81 fb e4 04 11 80    	cmp    $0x801104e4,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x7b>
8010012e:	eb 5e                	jmp    8010018e <bread+0xce>
80100130:	8b 5b 0c             	mov    0xc(%ebx),%ebx
80100133:	81 fb e4 04 11 80    	cmp    $0x801104e4,%ebx
80100139:	74 53                	je     8010018e <bread+0xce>
    if((b->flags & B_BUSY) == 0 && (b->flags & B_DIRTY) == 0){
8010013b:	f6 03 05             	testb  $0x5,(%ebx)
8010013e:	75 f0                	jne    80100130 <bread+0x70>
      release(&bcache.lock);
80100140:	83 ec 0c             	sub    $0xc,%esp
      b->dev = dev;
80100143:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
80100146:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = B_BUSY;
80100149:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
      release(&bcache.lock);
8010014f:	68 e0 c5 10 80       	push   $0x8010c5e0
80100154:	e8 67 4b 00 00       	call   80104cc0 <release>
80100159:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

    //cprintf("bread dev=%d\n",dev);
  
  b = bget(dev, blockno);
  if(!(b->flags & B_VALID)) {
8010015c:	f6 03 02             	testb  $0x2,(%ebx)
8010015f:	75 0c                	jne    8010016d <bread+0xad>
	iderw(b);
80100161:	83 ec 0c             	sub    $0xc,%esp
80100164:	53                   	push   %ebx
80100165:	e8 06 20 00 00       	call   80102170 <iderw>
8010016a:	83 c4 10             	add    $0x10,%esp
  }
  return b;
}
8010016d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100170:	89 d8                	mov    %ebx,%eax
80100172:	5b                   	pop    %ebx
80100173:	5e                   	pop    %esi
80100174:	5f                   	pop    %edi
80100175:	5d                   	pop    %ebp
80100176:	c3                   	ret    
        release(&bcache.lock);
80100177:	83 ec 0c             	sub    $0xc,%esp
        b->flags |= B_BUSY;
8010017a:	83 c8 01             	or     $0x1,%eax
8010017d:	89 03                	mov    %eax,(%ebx)
        release(&bcache.lock);
8010017f:	68 e0 c5 10 80       	push   $0x8010c5e0
80100184:	e8 37 4b 00 00       	call   80104cc0 <release>
80100189:	83 c4 10             	add    $0x10,%esp
8010018c:	eb ce                	jmp    8010015c <bread+0x9c>
  panic("bget: no buffers");
8010018e:	83 ec 0c             	sub    $0xc,%esp
80100191:	68 27 7b 10 80       	push   $0x80107b27
80100196:	e8 d5 01 00 00       	call   80100370 <panic>
8010019b:	90                   	nop
8010019c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801001a0 <bwrite>:

// Write b's contents to disk.  Must be B_BUSY.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	83 ec 08             	sub    $0x8,%esp
801001a6:	8b 55 08             	mov    0x8(%ebp),%edx
  if((b->flags & B_BUSY) == 0)
801001a9:	8b 02                	mov    (%edx),%eax
801001ab:	a8 01                	test   $0x1,%al
801001ad:	74 0b                	je     801001ba <bwrite+0x1a>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001af:	83 c8 04             	or     $0x4,%eax
801001b2:	89 02                	mov    %eax,(%edx)
  iderw(b);
}
801001b4:	c9                   	leave  
  iderw(b);
801001b5:	e9 b6 1f 00 00       	jmp    80102170 <iderw>
    panic("bwrite");
801001ba:	83 ec 0c             	sub    $0xc,%esp
801001bd:	68 38 7b 10 80       	push   $0x80107b38
801001c2:	e8 a9 01 00 00       	call   80100370 <panic>
801001c7:	89 f6                	mov    %esi,%esi
801001c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001d0 <brelse>:

// Release a B_BUSY buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001d0:	55                   	push   %ebp
801001d1:	89 e5                	mov    %esp,%ebp
801001d3:	53                   	push   %ebx
801001d4:	83 ec 04             	sub    $0x4,%esp
801001d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((b->flags & B_BUSY) == 0)
801001da:	f6 03 01             	testb  $0x1,(%ebx)
801001dd:	74 5a                	je     80100239 <brelse+0x69>
    panic("brelse");

  acquire(&bcache.lock);
801001df:	83 ec 0c             	sub    $0xc,%esp
801001e2:	68 e0 c5 10 80       	push   $0x8010c5e0
801001e7:	e8 14 49 00 00       	call   80104b00 <acquire>

  b->next->prev = b->prev;
801001ec:	8b 43 10             	mov    0x10(%ebx),%eax
801001ef:	8b 53 0c             	mov    0xc(%ebx),%edx
801001f2:	89 50 0c             	mov    %edx,0xc(%eax)
  b->prev->next = b->next;
801001f5:	8b 43 0c             	mov    0xc(%ebx),%eax
801001f8:	8b 53 10             	mov    0x10(%ebx),%edx
801001fb:	89 50 10             	mov    %edx,0x10(%eax)
  b->next = bcache.head.next;
801001fe:	a1 f4 04 11 80       	mov    0x801104f4,%eax
  b->prev = &bcache.head;
80100203:	c7 43 0c e4 04 11 80 	movl   $0x801104e4,0xc(%ebx)
  b->next = bcache.head.next;
8010020a:	89 43 10             	mov    %eax,0x10(%ebx)
  bcache.head.next->prev = b;
8010020d:	a1 f4 04 11 80       	mov    0x801104f4,%eax
80100212:	89 58 0c             	mov    %ebx,0xc(%eax)
  bcache.head.next = b;
80100215:	89 1d f4 04 11 80    	mov    %ebx,0x801104f4

  b->flags &= ~B_BUSY;
8010021b:	83 23 fe             	andl   $0xfffffffe,(%ebx)
  wakeup(b);
8010021e:	89 1c 24             	mov    %ebx,(%esp)
80100221:	e8 0a 41 00 00       	call   80104330 <wakeup>

  release(&bcache.lock);
80100226:	83 c4 10             	add    $0x10,%esp
80100229:	c7 45 08 e0 c5 10 80 	movl   $0x8010c5e0,0x8(%ebp)
}
80100230:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100233:	c9                   	leave  
  release(&bcache.lock);
80100234:	e9 87 4a 00 00       	jmp    80104cc0 <release>
    panic("brelse");
80100239:	83 ec 0c             	sub    $0xc,%esp
8010023c:	68 3f 7b 10 80       	push   $0x80107b3f
80100241:	e8 2a 01 00 00       	call   80100370 <panic>
80100246:	66 90                	xchg   %ax,%ax
80100248:	66 90                	xchg   %ax,%ax
8010024a:	66 90                	xchg   %ax,%ax
8010024c:	66 90                	xchg   %ax,%ax
8010024e:	66 90                	xchg   %ax,%ax

80100250 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100250:	55                   	push   %ebp
80100251:	89 e5                	mov    %esp,%ebp
80100253:	57                   	push   %edi
80100254:	56                   	push   %esi
80100255:	53                   	push   %ebx
80100256:	83 ec 28             	sub    $0x28,%esp
80100259:	8b 7d 08             	mov    0x8(%ebp),%edi
8010025c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010025f:	57                   	push   %edi
80100260:	e8 2b 15 00 00       	call   80101790 <iunlock>
  target = n;
  acquire(&cons.lock);
80100265:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010026c:	e8 8f 48 00 00       	call   80104b00 <acquire>
  while(n > 0){
80100271:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100274:	83 c4 10             	add    $0x10,%esp
80100277:	31 c0                	xor    %eax,%eax
80100279:	85 db                	test   %ebx,%ebx
8010027b:	0f 8e a1 00 00 00    	jle    80100322 <consoleread+0xd2>
    while(input.r == input.w){
80100281:	8b 15 80 07 11 80    	mov    0x80110780,%edx
80100287:	39 15 84 07 11 80    	cmp    %edx,0x80110784
8010028d:	74 2c                	je     801002bb <consoleread+0x6b>
8010028f:	eb 5f                	jmp    801002f0 <consoleread+0xa0>
80100291:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(proc->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
80100298:	83 ec 08             	sub    $0x8,%esp
8010029b:	68 20 b5 10 80       	push   $0x8010b520
801002a0:	68 80 07 11 80       	push   $0x80110780
801002a5:	e8 76 3e 00 00       	call   80104120 <sleep>
    while(input.r == input.w){
801002aa:	8b 15 80 07 11 80    	mov    0x80110780,%edx
801002b0:	83 c4 10             	add    $0x10,%esp
801002b3:	3b 15 84 07 11 80    	cmp    0x80110784,%edx
801002b9:	75 35                	jne    801002f0 <consoleread+0xa0>
      if(proc->killed){
801002bb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801002c1:	8b 40 14             	mov    0x14(%eax),%eax
801002c4:	85 c0                	test   %eax,%eax
801002c6:	74 d0                	je     80100298 <consoleread+0x48>
        release(&cons.lock);
801002c8:	83 ec 0c             	sub    $0xc,%esp
801002cb:	68 20 b5 10 80       	push   $0x8010b520
801002d0:	e8 eb 49 00 00       	call   80104cc0 <release>
        ilock(ip);
801002d5:	89 3c 24             	mov    %edi,(%esp)
801002d8:	e8 a3 13 00 00       	call   80101680 <ilock>
        return -1;
801002dd:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
801002e3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801002e8:	5b                   	pop    %ebx
801002e9:	5e                   	pop    %esi
801002ea:	5f                   	pop    %edi
801002eb:	5d                   	pop    %ebp
801002ec:	c3                   	ret    
801002ed:	8d 76 00             	lea    0x0(%esi),%esi
    c = input.buf[input.r++ % INPUT_BUF];
801002f0:	8d 42 01             	lea    0x1(%edx),%eax
801002f3:	a3 80 07 11 80       	mov    %eax,0x80110780
801002f8:	89 d0                	mov    %edx,%eax
801002fa:	83 e0 7f             	and    $0x7f,%eax
801002fd:	0f be 80 00 07 11 80 	movsbl -0x7feef900(%eax),%eax
    if(c == C('D')){  // EOF
80100304:	83 f8 04             	cmp    $0x4,%eax
80100307:	74 3f                	je     80100348 <consoleread+0xf8>
    *dst++ = c;
80100309:	83 c6 01             	add    $0x1,%esi
    --n;
8010030c:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
8010030f:	83 f8 0a             	cmp    $0xa,%eax
    *dst++ = c;
80100312:	88 46 ff             	mov    %al,-0x1(%esi)
    if(c == '\n')
80100315:	74 43                	je     8010035a <consoleread+0x10a>
  while(n > 0){
80100317:	85 db                	test   %ebx,%ebx
80100319:	0f 85 62 ff ff ff    	jne    80100281 <consoleread+0x31>
8010031f:	8b 45 10             	mov    0x10(%ebp),%eax
  release(&cons.lock);
80100322:	83 ec 0c             	sub    $0xc,%esp
80100325:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100328:	68 20 b5 10 80       	push   $0x8010b520
8010032d:	e8 8e 49 00 00       	call   80104cc0 <release>
  ilock(ip);
80100332:	89 3c 24             	mov    %edi,(%esp)
80100335:	e8 46 13 00 00       	call   80101680 <ilock>
  return target - n;
8010033a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010033d:	83 c4 10             	add    $0x10,%esp
}
80100340:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100343:	5b                   	pop    %ebx
80100344:	5e                   	pop    %esi
80100345:	5f                   	pop    %edi
80100346:	5d                   	pop    %ebp
80100347:	c3                   	ret    
80100348:	8b 45 10             	mov    0x10(%ebp),%eax
8010034b:	29 d8                	sub    %ebx,%eax
      if(n < target){
8010034d:	3b 5d 10             	cmp    0x10(%ebp),%ebx
80100350:	73 d0                	jae    80100322 <consoleread+0xd2>
        input.r--;
80100352:	89 15 80 07 11 80    	mov    %edx,0x80110780
80100358:	eb c8                	jmp    80100322 <consoleread+0xd2>
8010035a:	8b 45 10             	mov    0x10(%ebp),%eax
8010035d:	29 d8                	sub    %ebx,%eax
8010035f:	eb c1                	jmp    80100322 <consoleread+0xd2>
80100361:	eb 0d                	jmp    80100370 <panic>
80100363:	90                   	nop
80100364:	90                   	nop
80100365:	90                   	nop
80100366:	90                   	nop
80100367:	90                   	nop
80100368:	90                   	nop
80100369:	90                   	nop
8010036a:	90                   	nop
8010036b:	90                   	nop
8010036c:	90                   	nop
8010036d:	90                   	nop
8010036e:	90                   	nop
8010036f:	90                   	nop

80100370 <panic>:
{
80100370:	55                   	push   %ebp
80100371:	89 e5                	mov    %esp,%ebp
80100373:	56                   	push   %esi
80100374:	53                   	push   %ebx
80100375:	83 ec 38             	sub    $0x38,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100378:	fa                   	cli    
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
80100379:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  cons.locking = 0;
8010037f:	c7 05 54 b5 10 80 00 	movl   $0x0,0x8010b554
80100386:	00 00 00 
  getcallerpcs(&s, pcs);
80100389:	8d 5d d0             	lea    -0x30(%ebp),%ebx
8010038c:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
8010038f:	0f b6 00             	movzbl (%eax),%eax
80100392:	50                   	push   %eax
80100393:	68 46 7b 10 80       	push   $0x80107b46
80100398:	e8 a3 02 00 00       	call   80100640 <cprintf>
  cprintf(s);
8010039d:	58                   	pop    %eax
8010039e:	ff 75 08             	pushl  0x8(%ebp)
801003a1:	e8 9a 02 00 00       	call   80100640 <cprintf>
  cprintf("\n");
801003a6:	c7 04 24 66 80 10 80 	movl   $0x80108066,(%esp)
801003ad:	e8 8e 02 00 00       	call   80100640 <cprintf>
  getcallerpcs(&s, pcs);
801003b2:	5a                   	pop    %edx
801003b3:	8d 45 08             	lea    0x8(%ebp),%eax
801003b6:	59                   	pop    %ecx
801003b7:	53                   	push   %ebx
801003b8:	50                   	push   %eax
801003b9:	e8 02 48 00 00       	call   80104bc0 <getcallerpcs>
801003be:	83 c4 10             	add    $0x10,%esp
801003c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    cprintf(" %p", pcs[i]);
801003c8:	83 ec 08             	sub    $0x8,%esp
801003cb:	ff 33                	pushl  (%ebx)
801003cd:	83 c3 04             	add    $0x4,%ebx
801003d0:	68 62 7b 10 80       	push   $0x80107b62
801003d5:	e8 66 02 00 00       	call   80100640 <cprintf>
  for(i=0; i<10; i++)
801003da:	83 c4 10             	add    $0x10,%esp
801003dd:	39 f3                	cmp    %esi,%ebx
801003df:	75 e7                	jne    801003c8 <panic+0x58>
  panicked = 1; // freeze other CPU
801003e1:	c7 05 58 b5 10 80 01 	movl   $0x1,0x8010b558
801003e8:	00 00 00 
801003eb:	eb fe                	jmp    801003eb <panic+0x7b>
801003ed:	8d 76 00             	lea    0x0(%esi),%esi

801003f0 <consputc>:
  if(panicked){
801003f0:	8b 0d 58 b5 10 80    	mov    0x8010b558,%ecx
801003f6:	85 c9                	test   %ecx,%ecx
801003f8:	74 06                	je     80100400 <consputc+0x10>
801003fa:	fa                   	cli    
801003fb:	eb fe                	jmp    801003fb <consputc+0xb>
801003fd:	8d 76 00             	lea    0x0(%esi),%esi
{
80100400:	55                   	push   %ebp
80100401:	89 e5                	mov    %esp,%ebp
80100403:	57                   	push   %edi
80100404:	56                   	push   %esi
80100405:	53                   	push   %ebx
80100406:	89 c6                	mov    %eax,%esi
80100408:	83 ec 0c             	sub    $0xc,%esp
  if(c == BACKSPACE){
8010040b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100410:	0f 84 b1 00 00 00    	je     801004c7 <consputc+0xd7>
    uartputc(c);
80100416:	83 ec 0c             	sub    $0xc,%esp
80100419:	50                   	push   %eax
8010041a:	e8 41 61 00 00       	call   80106560 <uartputc>
8010041f:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100422:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80100427:	b8 0e 00 00 00       	mov    $0xe,%eax
8010042c:	89 da                	mov    %ebx,%edx
8010042e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010042f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100434:	89 ca                	mov    %ecx,%edx
80100436:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100437:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010043a:	89 da                	mov    %ebx,%edx
8010043c:	c1 e0 08             	shl    $0x8,%eax
8010043f:	89 c7                	mov    %eax,%edi
80100441:	b8 0f 00 00 00       	mov    $0xf,%eax
80100446:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100447:	89 ca                	mov    %ecx,%edx
80100449:	ec                   	in     (%dx),%al
8010044a:	0f b6 d8             	movzbl %al,%ebx
  pos |= inb(CRTPORT+1);
8010044d:	09 fb                	or     %edi,%ebx
  if(c == '\n')
8010044f:	83 fe 0a             	cmp    $0xa,%esi
80100452:	0f 84 f3 00 00 00    	je     8010054b <consputc+0x15b>
  else if(c == BACKSPACE){
80100458:	81 fe 00 01 00 00    	cmp    $0x100,%esi
8010045e:	0f 84 d7 00 00 00    	je     8010053b <consputc+0x14b>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100464:	89 f0                	mov    %esi,%eax
80100466:	0f b6 c0             	movzbl %al,%eax
80100469:	80 cc 07             	or     $0x7,%ah
8010046c:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
80100473:	80 
80100474:	83 c3 01             	add    $0x1,%ebx
  if(pos < 0 || pos > 25*80)
80100477:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
8010047d:	0f 8f ab 00 00 00    	jg     8010052e <consputc+0x13e>
  if((pos/80) >= 24){  // Scroll up.
80100483:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
80100489:	7f 66                	jg     801004f1 <consputc+0x101>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010048b:	be d4 03 00 00       	mov    $0x3d4,%esi
80100490:	b8 0e 00 00 00       	mov    $0xe,%eax
80100495:	89 f2                	mov    %esi,%edx
80100497:	ee                   	out    %al,(%dx)
80100498:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
  outb(CRTPORT+1, pos>>8);
8010049d:	89 d8                	mov    %ebx,%eax
8010049f:	c1 f8 08             	sar    $0x8,%eax
801004a2:	89 ca                	mov    %ecx,%edx
801004a4:	ee                   	out    %al,(%dx)
801004a5:	b8 0f 00 00 00       	mov    $0xf,%eax
801004aa:	89 f2                	mov    %esi,%edx
801004ac:	ee                   	out    %al,(%dx)
801004ad:	89 d8                	mov    %ebx,%eax
801004af:	89 ca                	mov    %ecx,%edx
801004b1:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004b2:	b8 20 07 00 00       	mov    $0x720,%eax
801004b7:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
801004be:	80 
}
801004bf:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004c2:	5b                   	pop    %ebx
801004c3:	5e                   	pop    %esi
801004c4:	5f                   	pop    %edi
801004c5:	5d                   	pop    %ebp
801004c6:	c3                   	ret    
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004c7:	83 ec 0c             	sub    $0xc,%esp
801004ca:	6a 08                	push   $0x8
801004cc:	e8 8f 60 00 00       	call   80106560 <uartputc>
801004d1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004d8:	e8 83 60 00 00       	call   80106560 <uartputc>
801004dd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004e4:	e8 77 60 00 00       	call   80106560 <uartputc>
801004e9:	83 c4 10             	add    $0x10,%esp
801004ec:	e9 31 ff ff ff       	jmp    80100422 <consputc+0x32>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004f1:	52                   	push   %edx
801004f2:	68 60 0e 00 00       	push   $0xe60
    pos -= 80;
801004f7:	83 eb 50             	sub    $0x50,%ebx
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004fa:	68 a0 80 0b 80       	push   $0x800b80a0
801004ff:	68 00 80 0b 80       	push   $0x800b8000
80100504:	e8 b7 48 00 00       	call   80104dc0 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100509:	b8 80 07 00 00       	mov    $0x780,%eax
8010050e:	83 c4 0c             	add    $0xc,%esp
80100511:	29 d8                	sub    %ebx,%eax
80100513:	01 c0                	add    %eax,%eax
80100515:	50                   	push   %eax
80100516:	8d 04 1b             	lea    (%ebx,%ebx,1),%eax
80100519:	6a 00                	push   $0x0
8010051b:	2d 00 80 f4 7f       	sub    $0x7ff48000,%eax
80100520:	50                   	push   %eax
80100521:	e8 ea 47 00 00       	call   80104d10 <memset>
80100526:	83 c4 10             	add    $0x10,%esp
80100529:	e9 5d ff ff ff       	jmp    8010048b <consputc+0x9b>
    panic("pos under/overflow");
8010052e:	83 ec 0c             	sub    $0xc,%esp
80100531:	68 66 7b 10 80       	push   $0x80107b66
80100536:	e8 35 fe ff ff       	call   80100370 <panic>
    if(pos > 0) --pos;
8010053b:	85 db                	test   %ebx,%ebx
8010053d:	0f 84 48 ff ff ff    	je     8010048b <consputc+0x9b>
80100543:	83 eb 01             	sub    $0x1,%ebx
80100546:	e9 2c ff ff ff       	jmp    80100477 <consputc+0x87>
    pos += 80 - pos%80;
8010054b:	89 d8                	mov    %ebx,%eax
8010054d:	b9 50 00 00 00       	mov    $0x50,%ecx
80100552:	99                   	cltd   
80100553:	f7 f9                	idiv   %ecx
80100555:	29 d1                	sub    %edx,%ecx
80100557:	01 cb                	add    %ecx,%ebx
80100559:	e9 19 ff ff ff       	jmp    80100477 <consputc+0x87>
8010055e:	66 90                	xchg   %ax,%ax

80100560 <printint>:
{
80100560:	55                   	push   %ebp
80100561:	89 e5                	mov    %esp,%ebp
80100563:	57                   	push   %edi
80100564:	56                   	push   %esi
80100565:	53                   	push   %ebx
80100566:	89 d3                	mov    %edx,%ebx
80100568:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010056b:	85 c9                	test   %ecx,%ecx
{
8010056d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
80100570:	74 04                	je     80100576 <printint+0x16>
80100572:	85 c0                	test   %eax,%eax
80100574:	78 5a                	js     801005d0 <printint+0x70>
    x = xx;
80100576:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  i = 0;
8010057d:	31 c9                	xor    %ecx,%ecx
8010057f:	8d 75 d7             	lea    -0x29(%ebp),%esi
80100582:	eb 06                	jmp    8010058a <printint+0x2a>
80100584:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = digits[x % base];
80100588:	89 f9                	mov    %edi,%ecx
8010058a:	31 d2                	xor    %edx,%edx
8010058c:	8d 79 01             	lea    0x1(%ecx),%edi
8010058f:	f7 f3                	div    %ebx
80100591:	0f b6 92 94 7b 10 80 	movzbl -0x7fef846c(%edx),%edx
  }while((x /= base) != 0);
80100598:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
8010059a:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
8010059d:	75 e9                	jne    80100588 <printint+0x28>
  if(sign)
8010059f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801005a2:	85 c0                	test   %eax,%eax
801005a4:	74 08                	je     801005ae <printint+0x4e>
    buf[i++] = '-';
801005a6:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
801005ab:	8d 79 02             	lea    0x2(%ecx),%edi
801005ae:	8d 5c 3d d7          	lea    -0x29(%ebp,%edi,1),%ebx
801005b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    consputc(buf[i]);
801005b8:	0f be 03             	movsbl (%ebx),%eax
801005bb:	83 eb 01             	sub    $0x1,%ebx
801005be:	e8 2d fe ff ff       	call   801003f0 <consputc>
  while(--i >= 0)
801005c3:	39 f3                	cmp    %esi,%ebx
801005c5:	75 f1                	jne    801005b8 <printint+0x58>
}
801005c7:	83 c4 2c             	add    $0x2c,%esp
801005ca:	5b                   	pop    %ebx
801005cb:	5e                   	pop    %esi
801005cc:	5f                   	pop    %edi
801005cd:	5d                   	pop    %ebp
801005ce:	c3                   	ret    
801005cf:	90                   	nop
    x = -xx;
801005d0:	f7 d8                	neg    %eax
801005d2:	eb a9                	jmp    8010057d <printint+0x1d>
801005d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801005e0 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
801005e0:	55                   	push   %ebp
801005e1:	89 e5                	mov    %esp,%ebp
801005e3:	57                   	push   %edi
801005e4:	56                   	push   %esi
801005e5:	53                   	push   %ebx
801005e6:	83 ec 18             	sub    $0x18,%esp
801005e9:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
801005ec:	ff 75 08             	pushl  0x8(%ebp)
801005ef:	e8 9c 11 00 00       	call   80101790 <iunlock>
  acquire(&cons.lock);
801005f4:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
801005fb:	e8 00 45 00 00       	call   80104b00 <acquire>
  for(i = 0; i < n; i++)
80100600:	83 c4 10             	add    $0x10,%esp
80100603:	85 f6                	test   %esi,%esi
80100605:	7e 18                	jle    8010061f <consolewrite+0x3f>
80100607:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010060a:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010060d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100610:	0f b6 07             	movzbl (%edi),%eax
80100613:	83 c7 01             	add    $0x1,%edi
80100616:	e8 d5 fd ff ff       	call   801003f0 <consputc>
  for(i = 0; i < n; i++)
8010061b:	39 fb                	cmp    %edi,%ebx
8010061d:	75 f1                	jne    80100610 <consolewrite+0x30>
  release(&cons.lock);
8010061f:	83 ec 0c             	sub    $0xc,%esp
80100622:	68 20 b5 10 80       	push   $0x8010b520
80100627:	e8 94 46 00 00       	call   80104cc0 <release>
  ilock(ip);
8010062c:	58                   	pop    %eax
8010062d:	ff 75 08             	pushl  0x8(%ebp)
80100630:	e8 4b 10 00 00       	call   80101680 <ilock>

  return n;
}
80100635:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100638:	89 f0                	mov    %esi,%eax
8010063a:	5b                   	pop    %ebx
8010063b:	5e                   	pop    %esi
8010063c:	5f                   	pop    %edi
8010063d:	5d                   	pop    %ebp
8010063e:	c3                   	ret    
8010063f:	90                   	nop

80100640 <cprintf>:
{
80100640:	55                   	push   %ebp
80100641:	89 e5                	mov    %esp,%ebp
80100643:	57                   	push   %edi
80100644:	56                   	push   %esi
80100645:	53                   	push   %ebx
80100646:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100649:	a1 54 b5 10 80       	mov    0x8010b554,%eax
  if(locking)
8010064e:	85 c0                	test   %eax,%eax
  locking = cons.locking;
80100650:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if(locking)
80100653:	0f 85 6f 01 00 00    	jne    801007c8 <cprintf+0x188>
  if (fmt == 0)
80100659:	8b 45 08             	mov    0x8(%ebp),%eax
8010065c:	85 c0                	test   %eax,%eax
8010065e:	89 c7                	mov    %eax,%edi
80100660:	0f 84 77 01 00 00    	je     801007dd <cprintf+0x19d>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100666:	0f b6 00             	movzbl (%eax),%eax
  argp = (uint*)(void*)(&fmt + 1);
80100669:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010066c:	31 db                	xor    %ebx,%ebx
  argp = (uint*)(void*)(&fmt + 1);
8010066e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100671:	85 c0                	test   %eax,%eax
80100673:	75 56                	jne    801006cb <cprintf+0x8b>
80100675:	eb 79                	jmp    801006f0 <cprintf+0xb0>
80100677:	89 f6                	mov    %esi,%esi
80100679:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[++i] & 0xff;
80100680:	0f b6 16             	movzbl (%esi),%edx
    if(c == 0)
80100683:	85 d2                	test   %edx,%edx
80100685:	74 69                	je     801006f0 <cprintf+0xb0>
80100687:	83 c3 02             	add    $0x2,%ebx
    switch(c){
8010068a:	83 fa 70             	cmp    $0x70,%edx
8010068d:	8d 34 1f             	lea    (%edi,%ebx,1),%esi
80100690:	0f 84 84 00 00 00    	je     8010071a <cprintf+0xda>
80100696:	7f 78                	jg     80100710 <cprintf+0xd0>
80100698:	83 fa 25             	cmp    $0x25,%edx
8010069b:	0f 84 ff 00 00 00    	je     801007a0 <cprintf+0x160>
801006a1:	83 fa 64             	cmp    $0x64,%edx
801006a4:	0f 85 8e 00 00 00    	jne    80100738 <cprintf+0xf8>
      printint(*argp++, 10, 1);
801006aa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801006ad:	ba 0a 00 00 00       	mov    $0xa,%edx
801006b2:	8d 48 04             	lea    0x4(%eax),%ecx
801006b5:	8b 00                	mov    (%eax),%eax
801006b7:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801006ba:	b9 01 00 00 00       	mov    $0x1,%ecx
801006bf:	e8 9c fe ff ff       	call   80100560 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006c4:	0f b6 06             	movzbl (%esi),%eax
801006c7:	85 c0                	test   %eax,%eax
801006c9:	74 25                	je     801006f0 <cprintf+0xb0>
801006cb:	8d 53 01             	lea    0x1(%ebx),%edx
    if(c != '%'){
801006ce:	83 f8 25             	cmp    $0x25,%eax
801006d1:	8d 34 17             	lea    (%edi,%edx,1),%esi
801006d4:	74 aa                	je     80100680 <cprintf+0x40>
801006d6:	89 55 e0             	mov    %edx,-0x20(%ebp)
      consputc(c);
801006d9:	e8 12 fd ff ff       	call   801003f0 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006de:	0f b6 06             	movzbl (%esi),%eax
      continue;
801006e1:	8b 55 e0             	mov    -0x20(%ebp),%edx
801006e4:	89 d3                	mov    %edx,%ebx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006e6:	85 c0                	test   %eax,%eax
801006e8:	75 e1                	jne    801006cb <cprintf+0x8b>
801006ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(locking)
801006f0:	8b 45 dc             	mov    -0x24(%ebp),%eax
801006f3:	85 c0                	test   %eax,%eax
801006f5:	74 10                	je     80100707 <cprintf+0xc7>
    release(&cons.lock);
801006f7:	83 ec 0c             	sub    $0xc,%esp
801006fa:	68 20 b5 10 80       	push   $0x8010b520
801006ff:	e8 bc 45 00 00       	call   80104cc0 <release>
80100704:	83 c4 10             	add    $0x10,%esp
}
80100707:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010070a:	5b                   	pop    %ebx
8010070b:	5e                   	pop    %esi
8010070c:	5f                   	pop    %edi
8010070d:	5d                   	pop    %ebp
8010070e:	c3                   	ret    
8010070f:	90                   	nop
    switch(c){
80100710:	83 fa 73             	cmp    $0x73,%edx
80100713:	74 43                	je     80100758 <cprintf+0x118>
80100715:	83 fa 78             	cmp    $0x78,%edx
80100718:	75 1e                	jne    80100738 <cprintf+0xf8>
      printint(*argp++, 16, 0);
8010071a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010071d:	ba 10 00 00 00       	mov    $0x10,%edx
80100722:	8d 48 04             	lea    0x4(%eax),%ecx
80100725:	8b 00                	mov    (%eax),%eax
80100727:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010072a:	31 c9                	xor    %ecx,%ecx
8010072c:	e8 2f fe ff ff       	call   80100560 <printint>
      break;
80100731:	eb 91                	jmp    801006c4 <cprintf+0x84>
80100733:	90                   	nop
80100734:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      consputc('%');
80100738:	b8 25 00 00 00       	mov    $0x25,%eax
8010073d:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100740:	e8 ab fc ff ff       	call   801003f0 <consputc>
      consputc(c);
80100745:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100748:	89 d0                	mov    %edx,%eax
8010074a:	e8 a1 fc ff ff       	call   801003f0 <consputc>
      break;
8010074f:	e9 70 ff ff ff       	jmp    801006c4 <cprintf+0x84>
80100754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if((s = (char*)*argp++) == 0)
80100758:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010075b:	8b 10                	mov    (%eax),%edx
8010075d:	8d 48 04             	lea    0x4(%eax),%ecx
80100760:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100763:	85 d2                	test   %edx,%edx
80100765:	74 49                	je     801007b0 <cprintf+0x170>
      for(; *s; s++)
80100767:	0f be 02             	movsbl (%edx),%eax
      if((s = (char*)*argp++) == 0)
8010076a:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
      for(; *s; s++)
8010076d:	84 c0                	test   %al,%al
8010076f:	0f 84 4f ff ff ff    	je     801006c4 <cprintf+0x84>
80100775:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80100778:	89 d3                	mov    %edx,%ebx
8010077a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100780:	83 c3 01             	add    $0x1,%ebx
        consputc(*s);
80100783:	e8 68 fc ff ff       	call   801003f0 <consputc>
      for(; *s; s++)
80100788:	0f be 03             	movsbl (%ebx),%eax
8010078b:	84 c0                	test   %al,%al
8010078d:	75 f1                	jne    80100780 <cprintf+0x140>
      if((s = (char*)*argp++) == 0)
8010078f:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100792:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80100795:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100798:	e9 27 ff ff ff       	jmp    801006c4 <cprintf+0x84>
8010079d:	8d 76 00             	lea    0x0(%esi),%esi
      consputc('%');
801007a0:	b8 25 00 00 00       	mov    $0x25,%eax
801007a5:	e8 46 fc ff ff       	call   801003f0 <consputc>
      break;
801007aa:	e9 15 ff ff ff       	jmp    801006c4 <cprintf+0x84>
801007af:	90                   	nop
        s = "(null)";
801007b0:	ba 79 7b 10 80       	mov    $0x80107b79,%edx
      for(; *s; s++)
801007b5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801007b8:	b8 28 00 00 00       	mov    $0x28,%eax
801007bd:	89 d3                	mov    %edx,%ebx
801007bf:	eb bf                	jmp    80100780 <cprintf+0x140>
801007c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007c8:	83 ec 0c             	sub    $0xc,%esp
801007cb:	68 20 b5 10 80       	push   $0x8010b520
801007d0:	e8 2b 43 00 00       	call   80104b00 <acquire>
801007d5:	83 c4 10             	add    $0x10,%esp
801007d8:	e9 7c fe ff ff       	jmp    80100659 <cprintf+0x19>
    panic("null fmt");
801007dd:	83 ec 0c             	sub    $0xc,%esp
801007e0:	68 80 7b 10 80       	push   $0x80107b80
801007e5:	e8 86 fb ff ff       	call   80100370 <panic>
801007ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801007f0 <consoleintr>:
{
801007f0:	55                   	push   %ebp
801007f1:	89 e5                	mov    %esp,%ebp
801007f3:	57                   	push   %edi
801007f4:	56                   	push   %esi
801007f5:	53                   	push   %ebx
  int c, doprocdump = 0;
801007f6:	31 f6                	xor    %esi,%esi
{
801007f8:	83 ec 18             	sub    $0x18,%esp
801007fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
801007fe:	68 20 b5 10 80       	push   $0x8010b520
80100803:	e8 f8 42 00 00       	call   80104b00 <acquire>
  while((c = getc()) >= 0){
80100808:	83 c4 10             	add    $0x10,%esp
8010080b:	90                   	nop
8010080c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100810:	ff d3                	call   *%ebx
80100812:	85 c0                	test   %eax,%eax
80100814:	89 c7                	mov    %eax,%edi
80100816:	78 48                	js     80100860 <consoleintr+0x70>
    switch(c){
80100818:	83 ff 10             	cmp    $0x10,%edi
8010081b:	0f 84 e7 00 00 00    	je     80100908 <consoleintr+0x118>
80100821:	7e 5d                	jle    80100880 <consoleintr+0x90>
80100823:	83 ff 15             	cmp    $0x15,%edi
80100826:	0f 84 ec 00 00 00    	je     80100918 <consoleintr+0x128>
8010082c:	83 ff 7f             	cmp    $0x7f,%edi
8010082f:	75 54                	jne    80100885 <consoleintr+0x95>
      if(input.e != input.w){
80100831:	a1 88 07 11 80       	mov    0x80110788,%eax
80100836:	3b 05 84 07 11 80    	cmp    0x80110784,%eax
8010083c:	74 d2                	je     80100810 <consoleintr+0x20>
        input.e--;
8010083e:	83 e8 01             	sub    $0x1,%eax
80100841:	a3 88 07 11 80       	mov    %eax,0x80110788
        consputc(BACKSPACE);
80100846:	b8 00 01 00 00       	mov    $0x100,%eax
8010084b:	e8 a0 fb ff ff       	call   801003f0 <consputc>
  while((c = getc()) >= 0){
80100850:	ff d3                	call   *%ebx
80100852:	85 c0                	test   %eax,%eax
80100854:	89 c7                	mov    %eax,%edi
80100856:	79 c0                	jns    80100818 <consoleintr+0x28>
80100858:	90                   	nop
80100859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
80100860:	83 ec 0c             	sub    $0xc,%esp
80100863:	68 20 b5 10 80       	push   $0x8010b520
80100868:	e8 53 44 00 00       	call   80104cc0 <release>
  if(doprocdump) {
8010086d:	83 c4 10             	add    $0x10,%esp
80100870:	85 f6                	test   %esi,%esi
80100872:	0f 85 f8 00 00 00    	jne    80100970 <consoleintr+0x180>
}
80100878:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010087b:	5b                   	pop    %ebx
8010087c:	5e                   	pop    %esi
8010087d:	5f                   	pop    %edi
8010087e:	5d                   	pop    %ebp
8010087f:	c3                   	ret    
    switch(c){
80100880:	83 ff 08             	cmp    $0x8,%edi
80100883:	74 ac                	je     80100831 <consoleintr+0x41>
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100885:	85 ff                	test   %edi,%edi
80100887:	74 87                	je     80100810 <consoleintr+0x20>
80100889:	a1 88 07 11 80       	mov    0x80110788,%eax
8010088e:	89 c2                	mov    %eax,%edx
80100890:	2b 15 80 07 11 80    	sub    0x80110780,%edx
80100896:	83 fa 7f             	cmp    $0x7f,%edx
80100899:	0f 87 71 ff ff ff    	ja     80100810 <consoleintr+0x20>
8010089f:	8d 50 01             	lea    0x1(%eax),%edx
801008a2:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
801008a5:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
801008a8:	89 15 88 07 11 80    	mov    %edx,0x80110788
        c = (c == '\r') ? '\n' : c;
801008ae:	0f 84 cc 00 00 00    	je     80100980 <consoleintr+0x190>
        input.buf[input.e++ % INPUT_BUF] = c;
801008b4:	89 f9                	mov    %edi,%ecx
801008b6:	88 88 00 07 11 80    	mov    %cl,-0x7feef900(%eax)
        consputc(c);
801008bc:	89 f8                	mov    %edi,%eax
801008be:	e8 2d fb ff ff       	call   801003f0 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008c3:	83 ff 0a             	cmp    $0xa,%edi
801008c6:	0f 84 c5 00 00 00    	je     80100991 <consoleintr+0x1a1>
801008cc:	83 ff 04             	cmp    $0x4,%edi
801008cf:	0f 84 bc 00 00 00    	je     80100991 <consoleintr+0x1a1>
801008d5:	a1 80 07 11 80       	mov    0x80110780,%eax
801008da:	83 e8 80             	sub    $0xffffff80,%eax
801008dd:	39 05 88 07 11 80    	cmp    %eax,0x80110788
801008e3:	0f 85 27 ff ff ff    	jne    80100810 <consoleintr+0x20>
          wakeup(&input.r);
801008e9:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
801008ec:	a3 84 07 11 80       	mov    %eax,0x80110784
          wakeup(&input.r);
801008f1:	68 80 07 11 80       	push   $0x80110780
801008f6:	e8 35 3a 00 00       	call   80104330 <wakeup>
801008fb:	83 c4 10             	add    $0x10,%esp
801008fe:	e9 0d ff ff ff       	jmp    80100810 <consoleintr+0x20>
80100903:	90                   	nop
80100904:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      doprocdump = 1;
80100908:	be 01 00 00 00       	mov    $0x1,%esi
8010090d:	e9 fe fe ff ff       	jmp    80100810 <consoleintr+0x20>
80100912:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      while(input.e != input.w &&
80100918:	a1 88 07 11 80       	mov    0x80110788,%eax
8010091d:	39 05 84 07 11 80    	cmp    %eax,0x80110784
80100923:	75 2b                	jne    80100950 <consoleintr+0x160>
80100925:	e9 e6 fe ff ff       	jmp    80100810 <consoleintr+0x20>
8010092a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
80100930:	a3 88 07 11 80       	mov    %eax,0x80110788
        consputc(BACKSPACE);
80100935:	b8 00 01 00 00       	mov    $0x100,%eax
8010093a:	e8 b1 fa ff ff       	call   801003f0 <consputc>
      while(input.e != input.w &&
8010093f:	a1 88 07 11 80       	mov    0x80110788,%eax
80100944:	3b 05 84 07 11 80    	cmp    0x80110784,%eax
8010094a:	0f 84 c0 fe ff ff    	je     80100810 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100950:	83 e8 01             	sub    $0x1,%eax
80100953:	89 c2                	mov    %eax,%edx
80100955:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100958:	80 ba 00 07 11 80 0a 	cmpb   $0xa,-0x7feef900(%edx)
8010095f:	75 cf                	jne    80100930 <consoleintr+0x140>
80100961:	e9 aa fe ff ff       	jmp    80100810 <consoleintr+0x20>
80100966:	8d 76 00             	lea    0x0(%esi),%esi
80100969:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}
80100970:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100973:	5b                   	pop    %ebx
80100974:	5e                   	pop    %esi
80100975:	5f                   	pop    %edi
80100976:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100977:	e9 34 3b 00 00       	jmp    801044b0 <procdump>
8010097c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        input.buf[input.e++ % INPUT_BUF] = c;
80100980:	c6 80 00 07 11 80 0a 	movb   $0xa,-0x7feef900(%eax)
        consputc(c);
80100987:	b8 0a 00 00 00       	mov    $0xa,%eax
8010098c:	e8 5f fa ff ff       	call   801003f0 <consputc>
80100991:	a1 88 07 11 80       	mov    0x80110788,%eax
80100996:	e9 4e ff ff ff       	jmp    801008e9 <consoleintr+0xf9>
8010099b:	90                   	nop
8010099c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801009a0 <consoleinit>:

void
consoleinit(void)
{
801009a0:	55                   	push   %ebp
801009a1:	89 e5                	mov    %esp,%ebp
801009a3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
801009a6:	68 89 7b 10 80       	push   $0x80107b89
801009ab:	68 20 b5 10 80       	push   $0x8010b520
801009b0:	e8 2b 41 00 00       	call   80104ae0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  picenable(IRQ_KBD);
801009b5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  devsw[CONSOLE].write = consolewrite;
801009bc:	c7 05 4c 11 11 80 e0 	movl   $0x801005e0,0x8011114c
801009c3:	05 10 80 
  devsw[CONSOLE].read = consoleread;
801009c6:	c7 05 48 11 11 80 50 	movl   $0x80100250,0x80111148
801009cd:	02 10 80 
  cons.locking = 1;
801009d0:	c7 05 54 b5 10 80 01 	movl   $0x1,0x8010b554
801009d7:	00 00 00 
  picenable(IRQ_KBD);
801009da:	e8 81 29 00 00       	call   80103360 <picenable>
  ioapicenable(IRQ_KBD, 0);
801009df:	58                   	pop    %eax
801009e0:	5a                   	pop    %edx
801009e1:	6a 00                	push   $0x0
801009e3:	6a 01                	push   $0x1
801009e5:	e8 46 19 00 00       	call   80102330 <ioapicenable>
}
801009ea:	83 c4 10             	add    $0x10,%esp
801009ed:	c9                   	leave  
801009ee:	c3                   	ret    
801009ef:	90                   	nop

801009f0 <kill_others>:
//HN added. Tell other threads of the same process to destroy themselves
void
kill_others()
{
  struct thread *t;
  struct proc *p =  proc;
801009f0:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
{
801009f7:	55                   	push   %ebp
  for(t = p->threads; t < &p->threads[NTHREAD]; t++){
    if(t->state != TRUNNING && t->state != TUNUSED && t != thread) 
801009f8:	65 8b 0d 08 00 00 00 	mov    %gs:0x8,%ecx
{
801009ff:	89 e5                	mov    %esp,%ebp
  for(t = p->threads; t < &p->threads[NTHREAD]; t++){
80100a01:	8d 42 6c             	lea    0x6c(%edx),%eax
80100a04:	81 c2 6c 02 00 00    	add    $0x26c,%edx
80100a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(t->state != TRUNNING && t->state != TUNUSED && t != thread) 
80100a10:	f7 40 04 fb ff ff ff 	testl  $0xfffffffb,0x4(%eax)
80100a17:	74 0b                	je     80100a24 <kill_others+0x34>
80100a19:	39 c1                	cmp    %eax,%ecx
80100a1b:	74 07                	je     80100a24 <kill_others+0x34>
          t->state = TZOMBIE;
80100a1d:	c7 40 04 05 00 00 00 	movl   $0x5,0x4(%eax)
  for(t = p->threads; t < &p->threads[NTHREAD]; t++){
80100a24:	83 c0 20             	add    $0x20,%eax
80100a27:	39 d0                	cmp    %edx,%eax
80100a29:	72 e5                	jb     80100a10 <kill_others+0x20>
  }
}
80100a2b:	5d                   	pop    %ebp
80100a2c:	c3                   	ret    
80100a2d:	8d 76 00             	lea    0x0(%esi),%esi

80100a30 <exec>:

int
exec(char *path, char **argv)
{
80100a30:	55                   	push   %ebp
80100a31:	89 e5                	mov    %esp,%ebp
80100a33:	57                   	push   %edi
80100a34:	56                   	push   %esi
80100a35:	53                   	push   %ebx
80100a36:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  begin_op();
80100a3c:	e8 4f 22 00 00       	call   80102c90 <begin_op>
  if((ip = namei(path)) == 0){
80100a41:	83 ec 0c             	sub    $0xc,%esp
80100a44:	ff 75 08             	pushl  0x8(%ebp)
80100a47:	e8 d4 14 00 00       	call   80101f20 <namei>
80100a4c:	83 c4 10             	add    $0x10,%esp
80100a4f:	85 c0                	test   %eax,%eax
80100a51:	0f 84 9d 01 00 00    	je     80100bf4 <exec+0x1c4>
    end_op();
    return -1;
  }
  ilock(ip);
80100a57:	83 ec 0c             	sub    $0xc,%esp
80100a5a:	89 c3                	mov    %eax,%ebx
80100a5c:	50                   	push   %eax
80100a5d:	e8 1e 0c 00 00       	call   80101680 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
80100a62:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a68:	6a 34                	push   $0x34
80100a6a:	6a 00                	push   $0x0
80100a6c:	50                   	push   %eax
80100a6d:	53                   	push   %ebx
80100a6e:	e8 2d 0f 00 00       	call   801019a0 <readi>
80100a73:	83 c4 20             	add    $0x20,%esp
80100a76:	83 f8 33             	cmp    $0x33,%eax
80100a79:	77 25                	ja     80100aa0 <exec+0x70>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a7b:	83 ec 0c             	sub    $0xc,%esp
80100a7e:	53                   	push   %ebx
80100a7f:	e8 cc 0e 00 00       	call   80101950 <iunlockput>
    end_op();
80100a84:	e8 77 22 00 00       	call   80102d00 <end_op>
80100a89:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100a8c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a91:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a94:	5b                   	pop    %ebx
80100a95:	5e                   	pop    %esi
80100a96:	5f                   	pop    %edi
80100a97:	5d                   	pop    %ebp
80100a98:	c3                   	ret    
80100a99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80100aa0:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100aa7:	45 4c 46 
80100aaa:	75 cf                	jne    80100a7b <exec+0x4b>
  if((pgdir = setupkvm()) == 0)
80100aac:	e8 7f 67 00 00       	call   80107230 <setupkvm>
80100ab1:	85 c0                	test   %eax,%eax
80100ab3:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100ab9:	74 c0                	je     80100a7b <exec+0x4b>
  sz = 0;
80100abb:	31 ff                	xor    %edi,%edi
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100abd:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100ac4:	00 
80100ac5:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
80100acb:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100ad1:	0f 84 bf 02 00 00    	je     80100d96 <exec+0x366>
80100ad7:	31 f6                	xor    %esi,%esi
80100ad9:	eb 7f                	jmp    80100b5a <exec+0x12a>
80100adb:	90                   	nop
80100adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ph.type != ELF_PROG_LOAD)
80100ae0:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100ae7:	75 63                	jne    80100b4c <exec+0x11c>
    if(ph.memsz < ph.filesz)
80100ae9:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100aef:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100af5:	0f 82 86 00 00 00    	jb     80100b81 <exec+0x151>
80100afb:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100b01:	72 7e                	jb     80100b81 <exec+0x151>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100b03:	83 ec 04             	sub    $0x4,%esp
80100b06:	50                   	push   %eax
80100b07:	57                   	push   %edi
80100b08:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b0e:	e8 ad 6a 00 00       	call   801075c0 <allocuvm>
80100b13:	83 c4 10             	add    $0x10,%esp
80100b16:	85 c0                	test   %eax,%eax
80100b18:	89 c7                	mov    %eax,%edi
80100b1a:	74 65                	je     80100b81 <exec+0x151>
    if(ph.vaddr % PGSIZE != 0)
80100b1c:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b22:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b27:	75 58                	jne    80100b81 <exec+0x151>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b29:	83 ec 0c             	sub    $0xc,%esp
80100b2c:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b32:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100b38:	53                   	push   %ebx
80100b39:	50                   	push   %eax
80100b3a:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b40:	e8 bb 68 00 00       	call   80107400 <loaduvm>
80100b45:	83 c4 20             	add    $0x20,%esp
80100b48:	85 c0                	test   %eax,%eax
80100b4a:	78 35                	js     80100b81 <exec+0x151>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b4c:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100b53:	83 c6 01             	add    $0x1,%esi
80100b56:	39 f0                	cmp    %esi,%eax
80100b58:	7e 46                	jle    80100ba0 <exec+0x170>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100b5a:	89 f0                	mov    %esi,%eax
80100b5c:	6a 20                	push   $0x20
80100b5e:	c1 e0 05             	shl    $0x5,%eax
80100b61:	03 85 f0 fe ff ff    	add    -0x110(%ebp),%eax
80100b67:	50                   	push   %eax
80100b68:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100b6e:	50                   	push   %eax
80100b6f:	53                   	push   %ebx
80100b70:	e8 2b 0e 00 00       	call   801019a0 <readi>
80100b75:	83 c4 10             	add    $0x10,%esp
80100b78:	83 f8 20             	cmp    $0x20,%eax
80100b7b:	0f 84 5f ff ff ff    	je     80100ae0 <exec+0xb0>
    freevm(pgdir);
80100b81:	83 ec 0c             	sub    $0xc,%esp
80100b84:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b8a:	e8 61 6b 00 00       	call   801076f0 <freevm>
80100b8f:	83 c4 10             	add    $0x10,%esp
80100b92:	e9 e4 fe ff ff       	jmp    80100a7b <exec+0x4b>
80100b97:	89 f6                	mov    %esi,%esi
80100b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80100ba0:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100ba6:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80100bac:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80100bb2:	83 ec 0c             	sub    $0xc,%esp
80100bb5:	53                   	push   %ebx
80100bb6:	e8 95 0d 00 00       	call   80101950 <iunlockput>
  end_op();
80100bbb:	e8 40 21 00 00       	call   80102d00 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100bc0:	83 c4 0c             	add    $0xc,%esp
80100bc3:	56                   	push   %esi
80100bc4:	57                   	push   %edi
80100bc5:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100bcb:	e8 f0 69 00 00       	call   801075c0 <allocuvm>
80100bd0:	83 c4 10             	add    $0x10,%esp
80100bd3:	85 c0                	test   %eax,%eax
80100bd5:	89 c6                	mov    %eax,%esi
80100bd7:	75 2a                	jne    80100c03 <exec+0x1d3>
    freevm(pgdir);
80100bd9:	83 ec 0c             	sub    $0xc,%esp
80100bdc:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100be2:	e8 09 6b 00 00       	call   801076f0 <freevm>
80100be7:	83 c4 10             	add    $0x10,%esp
  return -1;
80100bea:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bef:	e9 9d fe ff ff       	jmp    80100a91 <exec+0x61>
    end_op();
80100bf4:	e8 07 21 00 00       	call   80102d00 <end_op>
    return -1;
80100bf9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bfe:	e9 8e fe ff ff       	jmp    80100a91 <exec+0x61>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c03:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100c09:	83 ec 08             	sub    $0x8,%esp
  for(argc = 0; argv[argc]; argc++) {
80100c0c:	31 ff                	xor    %edi,%edi
80100c0e:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c10:	50                   	push   %eax
80100c11:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100c17:	e8 74 6b 00 00       	call   80107790 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100c1c:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c1f:	83 c4 10             	add    $0x10,%esp
80100c22:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c28:	8b 00                	mov    (%eax),%eax
80100c2a:	85 c0                	test   %eax,%eax
80100c2c:	74 6f                	je     80100c9d <exec+0x26d>
80100c2e:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
80100c34:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100c3a:	eb 09                	jmp    80100c45 <exec+0x215>
80100c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(argc >= MAXARG)
80100c40:	83 ff 20             	cmp    $0x20,%edi
80100c43:	74 94                	je     80100bd9 <exec+0x1a9>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c45:	83 ec 0c             	sub    $0xc,%esp
80100c48:	50                   	push   %eax
80100c49:	e8 e2 42 00 00       	call   80104f30 <strlen>
80100c4e:	f7 d0                	not    %eax
80100c50:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c52:	58                   	pop    %eax
80100c53:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c56:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c59:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c5c:	e8 cf 42 00 00       	call   80104f30 <strlen>
80100c61:	83 c0 01             	add    $0x1,%eax
80100c64:	50                   	push   %eax
80100c65:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c68:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c6b:	53                   	push   %ebx
80100c6c:	56                   	push   %esi
80100c6d:	e8 7e 6c 00 00       	call   801078f0 <copyout>
80100c72:	83 c4 20             	add    $0x20,%esp
80100c75:	85 c0                	test   %eax,%eax
80100c77:	0f 88 5c ff ff ff    	js     80100bd9 <exec+0x1a9>
  for(argc = 0; argv[argc]; argc++) {
80100c7d:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100c80:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100c87:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100c8a:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100c90:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c93:	85 c0                	test   %eax,%eax
80100c95:	75 a9                	jne    80100c40 <exec+0x210>
80100c97:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c9d:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100ca4:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100ca6:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100cad:	00 00 00 00 
  ustack[0] = 0xffffffff;  // fake return PC
80100cb1:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100cb8:	ff ff ff 
  ustack[1] = argc;
80100cbb:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cc1:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100cc3:	83 c0 0c             	add    $0xc,%eax
80100cc6:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cc8:	50                   	push   %eax
80100cc9:	52                   	push   %edx
80100cca:	53                   	push   %ebx
80100ccb:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cd1:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cd7:	e8 14 6c 00 00       	call   801078f0 <copyout>
80100cdc:	83 c4 10             	add    $0x10,%esp
80100cdf:	85 c0                	test   %eax,%eax
80100ce1:	0f 88 f2 fe ff ff    	js     80100bd9 <exec+0x1a9>
  for(last=s=path; *s; s++)
80100ce7:	8b 45 08             	mov    0x8(%ebp),%eax
80100cea:	8b 55 08             	mov    0x8(%ebp),%edx
80100ced:	0f b6 00             	movzbl (%eax),%eax
80100cf0:	84 c0                	test   %al,%al
80100cf2:	74 11                	je     80100d05 <exec+0x2d5>
80100cf4:	89 d1                	mov    %edx,%ecx
80100cf6:	83 c1 01             	add    $0x1,%ecx
80100cf9:	3c 2f                	cmp    $0x2f,%al
80100cfb:	0f b6 01             	movzbl (%ecx),%eax
80100cfe:	0f 44 d1             	cmove  %ecx,%edx
80100d01:	84 c0                	test   %al,%al
80100d03:	75 f1                	jne    80100cf6 <exec+0x2c6>
  safestrcpy(proc->name, last, sizeof(proc->name));
80100d05:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100d0b:	83 ec 04             	sub    $0x4,%esp
80100d0e:	6a 10                	push   $0x10
80100d10:	52                   	push   %edx
80100d11:	83 c0 5c             	add    $0x5c,%eax
80100d14:	50                   	push   %eax
80100d15:	e8 d6 41 00 00       	call   80104ef0 <safestrcpy>
  struct proc *p =  proc;
80100d1a:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
    if(t->state != TRUNNING && t->state != TUNUSED && t != thread) 
80100d21:	65 8b 3d 08 00 00 00 	mov    %gs:0x8,%edi
80100d28:	83 c4 10             	add    $0x10,%esp
  for(t = p->threads; t < &p->threads[NTHREAD]; t++){
80100d2b:	8d 41 6c             	lea    0x6c(%ecx),%eax
80100d2e:	8d 91 6c 02 00 00    	lea    0x26c(%ecx),%edx
    if(t->state != TRUNNING && t->state != TUNUSED && t != thread) 
80100d34:	f7 40 04 fb ff ff ff 	testl  $0xfffffffb,0x4(%eax)
80100d3b:	74 0b                	je     80100d48 <exec+0x318>
80100d3d:	39 c7                	cmp    %eax,%edi
80100d3f:	74 07                	je     80100d48 <exec+0x318>
          t->state = TZOMBIE;
80100d41:	c7 40 04 05 00 00 00 	movl   $0x5,0x4(%eax)
  for(t = p->threads; t < &p->threads[NTHREAD]; t++){
80100d48:	83 c0 20             	add    $0x20,%eax
80100d4b:	39 d0                	cmp    %edx,%eax
80100d4d:	72 e5                	jb     80100d34 <exec+0x304>
  proc->pgdir = pgdir;
80100d4f:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
  proc->sz = sz;
80100d55:	89 31                	mov    %esi,(%ecx)
  switchuvm(proc);
80100d57:	83 ec 0c             	sub    $0xc,%esp
  oldpgdir = proc->pgdir;
80100d5a:	8b 79 04             	mov    0x4(%ecx),%edi
  proc->pgdir = pgdir;
80100d5d:	89 41 04             	mov    %eax,0x4(%ecx)
  thread->tf->eip = elf.entry;  // main
80100d60:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
80100d66:	8b 8d 3c ff ff ff    	mov    -0xc4(%ebp),%ecx
80100d6c:	8b 50 10             	mov    0x10(%eax),%edx
80100d6f:	89 4a 38             	mov    %ecx,0x38(%edx)
  thread->tf->esp = sp;
80100d72:	8b 40 10             	mov    0x10(%eax),%eax
80100d75:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(proc);
80100d78:	65 ff 35 04 00 00 00 	pushl  %gs:0x4
80100d7f:	e8 5c 65 00 00       	call   801072e0 <switchuvm>
  freevm(oldpgdir);
80100d84:	89 3c 24             	mov    %edi,(%esp)
80100d87:	e8 64 69 00 00       	call   801076f0 <freevm>
  return 0;
80100d8c:	83 c4 10             	add    $0x10,%esp
80100d8f:	31 c0                	xor    %eax,%eax
80100d91:	e9 fb fc ff ff       	jmp    80100a91 <exec+0x61>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100d96:	be 00 20 00 00       	mov    $0x2000,%esi
80100d9b:	e9 12 fe ff ff       	jmp    80100bb2 <exec+0x182>

80100da0 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100da0:	55                   	push   %ebp
80100da1:	89 e5                	mov    %esp,%ebp
80100da3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100da6:	68 a5 7b 10 80       	push   $0x80107ba5
80100dab:	68 a0 07 11 80       	push   $0x801107a0
80100db0:	e8 2b 3d 00 00       	call   80104ae0 <initlock>
}
80100db5:	83 c4 10             	add    $0x10,%esp
80100db8:	c9                   	leave  
80100db9:	c3                   	ret    
80100dba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100dc0 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100dc0:	55                   	push   %ebp
80100dc1:	89 e5                	mov    %esp,%ebp
80100dc3:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100dc4:	bb d4 07 11 80       	mov    $0x801107d4,%ebx
{
80100dc9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100dcc:	68 a0 07 11 80       	push   $0x801107a0
80100dd1:	e8 2a 3d 00 00       	call   80104b00 <acquire>
80100dd6:	83 c4 10             	add    $0x10,%esp
80100dd9:	eb 10                	jmp    80100deb <filealloc+0x2b>
80100ddb:	90                   	nop
80100ddc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100de0:	83 c3 18             	add    $0x18,%ebx
80100de3:	81 fb 34 11 11 80    	cmp    $0x80111134,%ebx
80100de9:	73 25                	jae    80100e10 <filealloc+0x50>
    if(f->ref == 0){
80100deb:	8b 43 04             	mov    0x4(%ebx),%eax
80100dee:	85 c0                	test   %eax,%eax
80100df0:	75 ee                	jne    80100de0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100df2:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100df5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100dfc:	68 a0 07 11 80       	push   $0x801107a0
80100e01:	e8 ba 3e 00 00       	call   80104cc0 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100e06:	89 d8                	mov    %ebx,%eax
      return f;
80100e08:	83 c4 10             	add    $0x10,%esp
}
80100e0b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e0e:	c9                   	leave  
80100e0f:	c3                   	ret    
  release(&ftable.lock);
80100e10:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100e13:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100e15:	68 a0 07 11 80       	push   $0x801107a0
80100e1a:	e8 a1 3e 00 00       	call   80104cc0 <release>
}
80100e1f:	89 d8                	mov    %ebx,%eax
  return 0;
80100e21:	83 c4 10             	add    $0x10,%esp
}
80100e24:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e27:	c9                   	leave  
80100e28:	c3                   	ret    
80100e29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100e30 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100e30:	55                   	push   %ebp
80100e31:	89 e5                	mov    %esp,%ebp
80100e33:	53                   	push   %ebx
80100e34:	83 ec 10             	sub    $0x10,%esp
80100e37:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100e3a:	68 a0 07 11 80       	push   $0x801107a0
80100e3f:	e8 bc 3c 00 00       	call   80104b00 <acquire>
  if(f->ref < 1)
80100e44:	8b 43 04             	mov    0x4(%ebx),%eax
80100e47:	83 c4 10             	add    $0x10,%esp
80100e4a:	85 c0                	test   %eax,%eax
80100e4c:	7e 1a                	jle    80100e68 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100e4e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100e51:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100e54:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100e57:	68 a0 07 11 80       	push   $0x801107a0
80100e5c:	e8 5f 3e 00 00       	call   80104cc0 <release>
  return f;
}
80100e61:	89 d8                	mov    %ebx,%eax
80100e63:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e66:	c9                   	leave  
80100e67:	c3                   	ret    
    panic("filedup");
80100e68:	83 ec 0c             	sub    $0xc,%esp
80100e6b:	68 ac 7b 10 80       	push   $0x80107bac
80100e70:	e8 fb f4 ff ff       	call   80100370 <panic>
80100e75:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e80 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e80:	55                   	push   %ebp
80100e81:	89 e5                	mov    %esp,%ebp
80100e83:	57                   	push   %edi
80100e84:	56                   	push   %esi
80100e85:	53                   	push   %ebx
80100e86:	83 ec 28             	sub    $0x28,%esp
80100e89:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100e8c:	68 a0 07 11 80       	push   $0x801107a0
80100e91:	e8 6a 3c 00 00       	call   80104b00 <acquire>
  if(f->ref < 1)
80100e96:	8b 43 04             	mov    0x4(%ebx),%eax
80100e99:	83 c4 10             	add    $0x10,%esp
80100e9c:	85 c0                	test   %eax,%eax
80100e9e:	0f 8e 9b 00 00 00    	jle    80100f3f <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100ea4:	83 e8 01             	sub    $0x1,%eax
80100ea7:	85 c0                	test   %eax,%eax
80100ea9:	89 43 04             	mov    %eax,0x4(%ebx)
80100eac:	74 1a                	je     80100ec8 <fileclose+0x48>
    release(&ftable.lock);
80100eae:	c7 45 08 a0 07 11 80 	movl   $0x801107a0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100eb5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100eb8:	5b                   	pop    %ebx
80100eb9:	5e                   	pop    %esi
80100eba:	5f                   	pop    %edi
80100ebb:	5d                   	pop    %ebp
    release(&ftable.lock);
80100ebc:	e9 ff 3d 00 00       	jmp    80104cc0 <release>
80100ec1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ff = *f;
80100ec8:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
80100ecc:	8b 3b                	mov    (%ebx),%edi
  release(&ftable.lock);
80100ece:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100ed1:	8b 73 0c             	mov    0xc(%ebx),%esi
  f->type = FD_NONE;
80100ed4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100eda:	88 45 e7             	mov    %al,-0x19(%ebp)
80100edd:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80100ee0:	68 a0 07 11 80       	push   $0x801107a0
  ff = *f;
80100ee5:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100ee8:	e8 d3 3d 00 00       	call   80104cc0 <release>
  if(ff.type == FD_PIPE)
80100eed:	83 c4 10             	add    $0x10,%esp
80100ef0:	83 ff 01             	cmp    $0x1,%edi
80100ef3:	74 13                	je     80100f08 <fileclose+0x88>
  else if(ff.type == FD_INODE){
80100ef5:	83 ff 02             	cmp    $0x2,%edi
80100ef8:	74 26                	je     80100f20 <fileclose+0xa0>
}
80100efa:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100efd:	5b                   	pop    %ebx
80100efe:	5e                   	pop    %esi
80100eff:	5f                   	pop    %edi
80100f00:	5d                   	pop    %ebp
80100f01:	c3                   	ret    
80100f02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pipeclose(ff.pipe, ff.writable);
80100f08:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100f0c:	83 ec 08             	sub    $0x8,%esp
80100f0f:	53                   	push   %ebx
80100f10:	56                   	push   %esi
80100f11:	e8 2a 26 00 00       	call   80103540 <pipeclose>
80100f16:	83 c4 10             	add    $0x10,%esp
80100f19:	eb df                	jmp    80100efa <fileclose+0x7a>
80100f1b:	90                   	nop
80100f1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    begin_op();
80100f20:	e8 6b 1d 00 00       	call   80102c90 <begin_op>
    iput(ff.ip);
80100f25:	83 ec 0c             	sub    $0xc,%esp
80100f28:	ff 75 e0             	pushl  -0x20(%ebp)
80100f2b:	e8 c0 08 00 00       	call   801017f0 <iput>
    end_op();
80100f30:	83 c4 10             	add    $0x10,%esp
}
80100f33:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f36:	5b                   	pop    %ebx
80100f37:	5e                   	pop    %esi
80100f38:	5f                   	pop    %edi
80100f39:	5d                   	pop    %ebp
    end_op();
80100f3a:	e9 c1 1d 00 00       	jmp    80102d00 <end_op>
    panic("fileclose");
80100f3f:	83 ec 0c             	sub    $0xc,%esp
80100f42:	68 b4 7b 10 80       	push   $0x80107bb4
80100f47:	e8 24 f4 ff ff       	call   80100370 <panic>
80100f4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f50 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100f50:	55                   	push   %ebp
80100f51:	89 e5                	mov    %esp,%ebp
80100f53:	53                   	push   %ebx
80100f54:	83 ec 04             	sub    $0x4,%esp
80100f57:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100f5a:	83 3b 02             	cmpl   $0x2,(%ebx)
80100f5d:	75 31                	jne    80100f90 <filestat+0x40>
    ilock(f->ip);
80100f5f:	83 ec 0c             	sub    $0xc,%esp
80100f62:	ff 73 10             	pushl  0x10(%ebx)
80100f65:	e8 16 07 00 00       	call   80101680 <ilock>
    stati(f->ip, st);
80100f6a:	58                   	pop    %eax
80100f6b:	5a                   	pop    %edx
80100f6c:	ff 75 0c             	pushl  0xc(%ebp)
80100f6f:	ff 73 10             	pushl  0x10(%ebx)
80100f72:	e8 f9 09 00 00       	call   80101970 <stati>
    iunlock(f->ip);
80100f77:	59                   	pop    %ecx
80100f78:	ff 73 10             	pushl  0x10(%ebx)
80100f7b:	e8 10 08 00 00       	call   80101790 <iunlock>
    return 0;
80100f80:	83 c4 10             	add    $0x10,%esp
80100f83:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100f85:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f88:	c9                   	leave  
80100f89:	c3                   	ret    
80100f8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return -1;
80100f90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100f95:	eb ee                	jmp    80100f85 <filestat+0x35>
80100f97:	89 f6                	mov    %esi,%esi
80100f99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100fa0 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100fa0:	55                   	push   %ebp
80100fa1:	89 e5                	mov    %esp,%ebp
80100fa3:	57                   	push   %edi
80100fa4:	56                   	push   %esi
80100fa5:	53                   	push   %ebx
80100fa6:	83 ec 0c             	sub    $0xc,%esp
80100fa9:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100fac:	8b 75 0c             	mov    0xc(%ebp),%esi
80100faf:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100fb2:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100fb6:	74 60                	je     80101018 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80100fb8:	8b 03                	mov    (%ebx),%eax
80100fba:	83 f8 01             	cmp    $0x1,%eax
80100fbd:	74 41                	je     80101000 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100fbf:	83 f8 02             	cmp    $0x2,%eax
80100fc2:	75 5b                	jne    8010101f <fileread+0x7f>
    ilock(f->ip);
80100fc4:	83 ec 0c             	sub    $0xc,%esp
80100fc7:	ff 73 10             	pushl  0x10(%ebx)
80100fca:	e8 b1 06 00 00       	call   80101680 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100fcf:	57                   	push   %edi
80100fd0:	ff 73 14             	pushl  0x14(%ebx)
80100fd3:	56                   	push   %esi
80100fd4:	ff 73 10             	pushl  0x10(%ebx)
80100fd7:	e8 c4 09 00 00       	call   801019a0 <readi>
80100fdc:	83 c4 20             	add    $0x20,%esp
80100fdf:	85 c0                	test   %eax,%eax
80100fe1:	89 c6                	mov    %eax,%esi
80100fe3:	7e 03                	jle    80100fe8 <fileread+0x48>
      f->off += r;
80100fe5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100fe8:	83 ec 0c             	sub    $0xc,%esp
80100feb:	ff 73 10             	pushl  0x10(%ebx)
80100fee:	e8 9d 07 00 00       	call   80101790 <iunlock>
    return r;
80100ff3:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80100ff6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ff9:	89 f0                	mov    %esi,%eax
80100ffb:	5b                   	pop    %ebx
80100ffc:	5e                   	pop    %esi
80100ffd:	5f                   	pop    %edi
80100ffe:	5d                   	pop    %ebp
80100fff:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80101000:	8b 43 0c             	mov    0xc(%ebx),%eax
80101003:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101006:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101009:	5b                   	pop    %ebx
8010100a:	5e                   	pop    %esi
8010100b:	5f                   	pop    %edi
8010100c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010100d:	e9 fe 26 00 00       	jmp    80103710 <piperead>
80101012:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101018:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010101d:	eb d7                	jmp    80100ff6 <fileread+0x56>
  panic("fileread");
8010101f:	83 ec 0c             	sub    $0xc,%esp
80101022:	68 be 7b 10 80       	push   $0x80107bbe
80101027:	e8 44 f3 ff ff       	call   80100370 <panic>
8010102c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101030 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101030:	55                   	push   %ebp
80101031:	89 e5                	mov    %esp,%ebp
80101033:	57                   	push   %edi
80101034:	56                   	push   %esi
80101035:	53                   	push   %ebx
80101036:	83 ec 1c             	sub    $0x1c,%esp
80101039:	8b 75 08             	mov    0x8(%ebp),%esi
8010103c:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
8010103f:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
80101043:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101046:	8b 45 10             	mov    0x10(%ebp),%eax
80101049:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010104c:	0f 84 aa 00 00 00    	je     801010fc <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80101052:	8b 06                	mov    (%esi),%eax
80101054:	83 f8 01             	cmp    $0x1,%eax
80101057:	0f 84 c3 00 00 00    	je     80101120 <filewrite+0xf0>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010105d:	83 f8 02             	cmp    $0x2,%eax
80101060:	0f 85 d9 00 00 00    	jne    8010113f <filewrite+0x10f>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101066:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101069:	31 ff                	xor    %edi,%edi
    while(i < n){
8010106b:	85 c0                	test   %eax,%eax
8010106d:	7f 34                	jg     801010a3 <filewrite+0x73>
8010106f:	e9 9c 00 00 00       	jmp    80101110 <filewrite+0xe0>
80101074:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101078:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010107b:	83 ec 0c             	sub    $0xc,%esp
8010107e:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
80101081:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101084:	e8 07 07 00 00       	call   80101790 <iunlock>
      end_op();
80101089:	e8 72 1c 00 00       	call   80102d00 <end_op>
8010108e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101091:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101094:	39 c3                	cmp    %eax,%ebx
80101096:	0f 85 96 00 00 00    	jne    80101132 <filewrite+0x102>
        panic("short filewrite");
      i += r;
8010109c:	01 df                	add    %ebx,%edi
    while(i < n){
8010109e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801010a1:	7e 6d                	jle    80101110 <filewrite+0xe0>
      int n1 = n - i;
801010a3:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801010a6:	b8 00 1a 00 00       	mov    $0x1a00,%eax
801010ab:	29 fb                	sub    %edi,%ebx
801010ad:	81 fb 00 1a 00 00    	cmp    $0x1a00,%ebx
801010b3:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
801010b6:	e8 d5 1b 00 00       	call   80102c90 <begin_op>
      ilock(f->ip);
801010bb:	83 ec 0c             	sub    $0xc,%esp
801010be:	ff 76 10             	pushl  0x10(%esi)
801010c1:	e8 ba 05 00 00       	call   80101680 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801010c6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801010c9:	53                   	push   %ebx
801010ca:	ff 76 14             	pushl  0x14(%esi)
801010cd:	01 f8                	add    %edi,%eax
801010cf:	50                   	push   %eax
801010d0:	ff 76 10             	pushl  0x10(%esi)
801010d3:	e8 c8 09 00 00       	call   80101aa0 <writei>
801010d8:	83 c4 20             	add    $0x20,%esp
801010db:	85 c0                	test   %eax,%eax
801010dd:	7f 99                	jg     80101078 <filewrite+0x48>
      iunlock(f->ip);
801010df:	83 ec 0c             	sub    $0xc,%esp
801010e2:	ff 76 10             	pushl  0x10(%esi)
801010e5:	89 45 e0             	mov    %eax,-0x20(%ebp)
801010e8:	e8 a3 06 00 00       	call   80101790 <iunlock>
      end_op();
801010ed:	e8 0e 1c 00 00       	call   80102d00 <end_op>
      if(r < 0)
801010f2:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010f5:	83 c4 10             	add    $0x10,%esp
801010f8:	85 c0                	test   %eax,%eax
801010fa:	74 98                	je     80101094 <filewrite+0x64>
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801010ff:	bf ff ff ff ff       	mov    $0xffffffff,%edi
}
80101104:	89 f8                	mov    %edi,%eax
80101106:	5b                   	pop    %ebx
80101107:	5e                   	pop    %esi
80101108:	5f                   	pop    %edi
80101109:	5d                   	pop    %ebp
8010110a:	c3                   	ret    
8010110b:	90                   	nop
8010110c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return i == n ? n : -1;
80101110:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101113:	75 e7                	jne    801010fc <filewrite+0xcc>
}
80101115:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101118:	89 f8                	mov    %edi,%eax
8010111a:	5b                   	pop    %ebx
8010111b:	5e                   	pop    %esi
8010111c:	5f                   	pop    %edi
8010111d:	5d                   	pop    %ebp
8010111e:	c3                   	ret    
8010111f:	90                   	nop
    return pipewrite(f->pipe, addr, n);
80101120:	8b 46 0c             	mov    0xc(%esi),%eax
80101123:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101126:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101129:	5b                   	pop    %ebx
8010112a:	5e                   	pop    %esi
8010112b:	5f                   	pop    %edi
8010112c:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
8010112d:	e9 ae 24 00 00       	jmp    801035e0 <pipewrite>
        panic("short filewrite");
80101132:	83 ec 0c             	sub    $0xc,%esp
80101135:	68 c7 7b 10 80       	push   $0x80107bc7
8010113a:	e8 31 f2 ff ff       	call   80100370 <panic>
  panic("filewrite");
8010113f:	83 ec 0c             	sub    $0xc,%esp
80101142:	68 cd 7b 10 80       	push   $0x80107bcd
80101147:	e8 24 f2 ff ff       	call   80100370 <panic>
8010114c:	66 90                	xchg   %ax,%ax
8010114e:	66 90                	xchg   %ax,%ax

80101150 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101150:	55                   	push   %ebp
80101151:	89 e5                	mov    %esp,%ebp
80101153:	57                   	push   %edi
80101154:	56                   	push   %esi
80101155:	53                   	push   %ebx
80101156:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101159:	8b 0d a0 11 11 80    	mov    0x801111a0,%ecx
{
8010115f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101162:	85 c9                	test   %ecx,%ecx
80101164:	0f 84 87 00 00 00    	je     801011f1 <balloc+0xa1>
8010116a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101171:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101174:	83 ec 08             	sub    $0x8,%esp
80101177:	89 f0                	mov    %esi,%eax
80101179:	c1 f8 0c             	sar    $0xc,%eax
8010117c:	03 05 b8 11 11 80    	add    0x801111b8,%eax
80101182:	50                   	push   %eax
80101183:	ff 75 d8             	pushl  -0x28(%ebp)
80101186:	e8 35 ef ff ff       	call   801000c0 <bread>
8010118b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010118e:	a1 a0 11 11 80       	mov    0x801111a0,%eax
80101193:	83 c4 10             	add    $0x10,%esp
80101196:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101199:	31 c0                	xor    %eax,%eax
8010119b:	eb 2f                	jmp    801011cc <balloc+0x7c>
8010119d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
801011a0:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011a2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
801011a5:	bb 01 00 00 00       	mov    $0x1,%ebx
801011aa:	83 e1 07             	and    $0x7,%ecx
801011ad:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011af:	89 c1                	mov    %eax,%ecx
801011b1:	c1 f9 03             	sar    $0x3,%ecx
801011b4:	0f b6 7c 0a 18       	movzbl 0x18(%edx,%ecx,1),%edi
801011b9:	85 df                	test   %ebx,%edi
801011bb:	89 fa                	mov    %edi,%edx
801011bd:	74 41                	je     80101200 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801011bf:	83 c0 01             	add    $0x1,%eax
801011c2:	83 c6 01             	add    $0x1,%esi
801011c5:	3d 00 10 00 00       	cmp    $0x1000,%eax
801011ca:	74 05                	je     801011d1 <balloc+0x81>
801011cc:	39 75 e0             	cmp    %esi,-0x20(%ebp)
801011cf:	77 cf                	ja     801011a0 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
801011d1:	83 ec 0c             	sub    $0xc,%esp
801011d4:	ff 75 e4             	pushl  -0x1c(%ebp)
801011d7:	e8 f4 ef ff ff       	call   801001d0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
801011dc:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
801011e3:	83 c4 10             	add    $0x10,%esp
801011e6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801011e9:	39 05 a0 11 11 80    	cmp    %eax,0x801111a0
801011ef:	77 80                	ja     80101171 <balloc+0x21>
  }
  panic("balloc: out of blocks");
801011f1:	83 ec 0c             	sub    $0xc,%esp
801011f4:	68 d7 7b 10 80       	push   $0x80107bd7
801011f9:	e8 72 f1 ff ff       	call   80100370 <panic>
801011fe:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
80101200:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101203:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80101206:	09 da                	or     %ebx,%edx
80101208:	88 54 0f 18          	mov    %dl,0x18(%edi,%ecx,1)
        log_write(bp);
8010120c:	57                   	push   %edi
8010120d:	e8 4e 1c 00 00       	call   80102e60 <log_write>
        brelse(bp);
80101212:	89 3c 24             	mov    %edi,(%esp)
80101215:	e8 b6 ef ff ff       	call   801001d0 <brelse>
  bp = bread(dev, bno);
8010121a:	58                   	pop    %eax
8010121b:	5a                   	pop    %edx
8010121c:	56                   	push   %esi
8010121d:	ff 75 d8             	pushl  -0x28(%ebp)
80101220:	e8 9b ee ff ff       	call   801000c0 <bread>
80101225:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101227:	8d 40 18             	lea    0x18(%eax),%eax
8010122a:	83 c4 0c             	add    $0xc,%esp
8010122d:	68 00 02 00 00       	push   $0x200
80101232:	6a 00                	push   $0x0
80101234:	50                   	push   %eax
80101235:	e8 d6 3a 00 00       	call   80104d10 <memset>
  log_write(bp);
8010123a:	89 1c 24             	mov    %ebx,(%esp)
8010123d:	e8 1e 1c 00 00       	call   80102e60 <log_write>
  brelse(bp);
80101242:	89 1c 24             	mov    %ebx,(%esp)
80101245:	e8 86 ef ff ff       	call   801001d0 <brelse>
}
8010124a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010124d:	89 f0                	mov    %esi,%eax
8010124f:	5b                   	pop    %ebx
80101250:	5e                   	pop    %esi
80101251:	5f                   	pop    %edi
80101252:	5d                   	pop    %ebp
80101253:	c3                   	ret    
80101254:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010125a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101260 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101260:	55                   	push   %ebp
80101261:	89 e5                	mov    %esp,%ebp
80101263:	57                   	push   %edi
80101264:	56                   	push   %esi
80101265:	53                   	push   %ebx
80101266:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101268:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010126a:	bb f4 11 11 80       	mov    $0x801111f4,%ebx
{
8010126f:	83 ec 28             	sub    $0x28,%esp
80101272:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101275:	68 c0 11 11 80       	push   $0x801111c0
8010127a:	e8 81 38 00 00       	call   80104b00 <acquire>
8010127f:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101282:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101285:	eb 14                	jmp    8010129b <iget+0x3b>
80101287:	89 f6                	mov    %esi,%esi
80101289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101290:	83 c3 50             	add    $0x50,%ebx
80101293:	81 fb 94 21 11 80    	cmp    $0x80112194,%ebx
80101299:	73 1f                	jae    801012ba <iget+0x5a>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010129b:	8b 4b 08             	mov    0x8(%ebx),%ecx
8010129e:	85 c9                	test   %ecx,%ecx
801012a0:	7e 04                	jle    801012a6 <iget+0x46>
801012a2:	39 3b                	cmp    %edi,(%ebx)
801012a4:	74 4a                	je     801012f0 <iget+0x90>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801012a6:	85 f6                	test   %esi,%esi
801012a8:	75 e6                	jne    80101290 <iget+0x30>
801012aa:	85 c9                	test   %ecx,%ecx
801012ac:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012af:	83 c3 50             	add    $0x50,%ebx
801012b2:	81 fb 94 21 11 80    	cmp    $0x80112194,%ebx
801012b8:	72 e1                	jb     8010129b <iget+0x3b>
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801012ba:	85 f6                	test   %esi,%esi
801012bc:	74 59                	je     80101317 <iget+0xb7>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);
801012be:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
801012c1:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
801012c3:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
801012c6:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->flags = 0;
801012cd:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
  release(&icache.lock);
801012d4:	68 c0 11 11 80       	push   $0x801111c0
801012d9:	e8 e2 39 00 00       	call   80104cc0 <release>

  return ip;
801012de:	83 c4 10             	add    $0x10,%esp
}
801012e1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012e4:	89 f0                	mov    %esi,%eax
801012e6:	5b                   	pop    %ebx
801012e7:	5e                   	pop    %esi
801012e8:	5f                   	pop    %edi
801012e9:	5d                   	pop    %ebp
801012ea:	c3                   	ret    
801012eb:	90                   	nop
801012ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801012f0:	39 53 04             	cmp    %edx,0x4(%ebx)
801012f3:	75 b1                	jne    801012a6 <iget+0x46>
      release(&icache.lock);
801012f5:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
801012f8:	83 c1 01             	add    $0x1,%ecx
      return ip;
801012fb:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
801012fd:	68 c0 11 11 80       	push   $0x801111c0
      ip->ref++;
80101302:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
80101305:	e8 b6 39 00 00       	call   80104cc0 <release>
      return ip;
8010130a:	83 c4 10             	add    $0x10,%esp
}
8010130d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101310:	89 f0                	mov    %esi,%eax
80101312:	5b                   	pop    %ebx
80101313:	5e                   	pop    %esi
80101314:	5f                   	pop    %edi
80101315:	5d                   	pop    %ebp
80101316:	c3                   	ret    
    panic("iget: no inodes");
80101317:	83 ec 0c             	sub    $0xc,%esp
8010131a:	68 ed 7b 10 80       	push   $0x80107bed
8010131f:	e8 4c f0 ff ff       	call   80100370 <panic>
80101324:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010132a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101330 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101330:	55                   	push   %ebp
80101331:	89 e5                	mov    %esp,%ebp
80101333:	57                   	push   %edi
80101334:	56                   	push   %esi
80101335:	53                   	push   %ebx
80101336:	89 c6                	mov    %eax,%esi
80101338:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010133b:	83 fa 0b             	cmp    $0xb,%edx
8010133e:	77 18                	ja     80101358 <bmap+0x28>
80101340:	8d 3c 90             	lea    (%eax,%edx,4),%edi
    if((addr = ip->addrs[bn]) == 0)
80101343:	8b 5f 1c             	mov    0x1c(%edi),%ebx
80101346:	85 db                	test   %ebx,%ebx
80101348:	74 6e                	je     801013b8 <bmap+0x88>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010134a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010134d:	89 d8                	mov    %ebx,%eax
8010134f:	5b                   	pop    %ebx
80101350:	5e                   	pop    %esi
80101351:	5f                   	pop    %edi
80101352:	5d                   	pop    %ebp
80101353:	c3                   	ret    
80101354:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bn -= NDIRECT;
80101358:	8d 5a f4             	lea    -0xc(%edx),%ebx
  if(bn < NINDIRECT){
8010135b:	83 fb 7f             	cmp    $0x7f,%ebx
8010135e:	77 7e                	ja     801013de <bmap+0xae>
    if((addr = ip->addrs[NDIRECT]) == 0)
80101360:	8b 50 4c             	mov    0x4c(%eax),%edx
80101363:	8b 00                	mov    (%eax),%eax
80101365:	85 d2                	test   %edx,%edx
80101367:	74 67                	je     801013d0 <bmap+0xa0>
    bp = bread(ip->dev, addr);
80101369:	83 ec 08             	sub    $0x8,%esp
8010136c:	52                   	push   %edx
8010136d:	50                   	push   %eax
8010136e:	e8 4d ed ff ff       	call   801000c0 <bread>
    if((addr = a[bn]) == 0){
80101373:	8d 54 98 18          	lea    0x18(%eax,%ebx,4),%edx
80101377:	83 c4 10             	add    $0x10,%esp
    bp = bread(ip->dev, addr);
8010137a:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
8010137c:	8b 1a                	mov    (%edx),%ebx
8010137e:	85 db                	test   %ebx,%ebx
80101380:	75 1d                	jne    8010139f <bmap+0x6f>
      a[bn] = addr = balloc(ip->dev);
80101382:	8b 06                	mov    (%esi),%eax
80101384:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101387:	e8 c4 fd ff ff       	call   80101150 <balloc>
8010138c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
8010138f:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101392:	89 c3                	mov    %eax,%ebx
80101394:	89 02                	mov    %eax,(%edx)
      log_write(bp);
80101396:	57                   	push   %edi
80101397:	e8 c4 1a 00 00       	call   80102e60 <log_write>
8010139c:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
8010139f:	83 ec 0c             	sub    $0xc,%esp
801013a2:	57                   	push   %edi
801013a3:	e8 28 ee ff ff       	call   801001d0 <brelse>
801013a8:	83 c4 10             	add    $0x10,%esp
}
801013ab:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013ae:	89 d8                	mov    %ebx,%eax
801013b0:	5b                   	pop    %ebx
801013b1:	5e                   	pop    %esi
801013b2:	5f                   	pop    %edi
801013b3:	5d                   	pop    %ebp
801013b4:	c3                   	ret    
801013b5:	8d 76 00             	lea    0x0(%esi),%esi
      ip->addrs[bn] = addr = balloc(ip->dev);
801013b8:	8b 00                	mov    (%eax),%eax
801013ba:	e8 91 fd ff ff       	call   80101150 <balloc>
801013bf:	89 47 1c             	mov    %eax,0x1c(%edi)
}
801013c2:	8d 65 f4             	lea    -0xc(%ebp),%esp
      ip->addrs[bn] = addr = balloc(ip->dev);
801013c5:	89 c3                	mov    %eax,%ebx
}
801013c7:	89 d8                	mov    %ebx,%eax
801013c9:	5b                   	pop    %ebx
801013ca:	5e                   	pop    %esi
801013cb:	5f                   	pop    %edi
801013cc:	5d                   	pop    %ebp
801013cd:	c3                   	ret    
801013ce:	66 90                	xchg   %ax,%ax
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801013d0:	e8 7b fd ff ff       	call   80101150 <balloc>
801013d5:	89 c2                	mov    %eax,%edx
801013d7:	89 46 4c             	mov    %eax,0x4c(%esi)
801013da:	8b 06                	mov    (%esi),%eax
801013dc:	eb 8b                	jmp    80101369 <bmap+0x39>
  panic("bmap: out of range");
801013de:	83 ec 0c             	sub    $0xc,%esp
801013e1:	68 fd 7b 10 80       	push   $0x80107bfd
801013e6:	e8 85 ef ff ff       	call   80100370 <panic>
801013eb:	90                   	nop
801013ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801013f0 <readsb>:
{
801013f0:	55                   	push   %ebp
801013f1:	89 e5                	mov    %esp,%ebp
801013f3:	56                   	push   %esi
801013f4:	53                   	push   %ebx
801013f5:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
801013f8:	83 ec 08             	sub    $0x8,%esp
801013fb:	6a 01                	push   $0x1
801013fd:	ff 75 08             	pushl  0x8(%ebp)
80101400:	e8 bb ec ff ff       	call   801000c0 <bread>
80101405:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101407:	8d 40 18             	lea    0x18(%eax),%eax
8010140a:	83 c4 0c             	add    $0xc,%esp
8010140d:	6a 1c                	push   $0x1c
8010140f:	50                   	push   %eax
80101410:	56                   	push   %esi
80101411:	e8 aa 39 00 00       	call   80104dc0 <memmove>
  brelse(bp);
80101416:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101419:	83 c4 10             	add    $0x10,%esp
}
8010141c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010141f:	5b                   	pop    %ebx
80101420:	5e                   	pop    %esi
80101421:	5d                   	pop    %ebp
  brelse(bp);
80101422:	e9 a9 ed ff ff       	jmp    801001d0 <brelse>
80101427:	89 f6                	mov    %esi,%esi
80101429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101430 <bfree>:
{
80101430:	55                   	push   %ebp
80101431:	89 e5                	mov    %esp,%ebp
80101433:	56                   	push   %esi
80101434:	53                   	push   %ebx
80101435:	89 d3                	mov    %edx,%ebx
80101437:	89 c6                	mov    %eax,%esi
  readsb(dev, &sb);
80101439:	83 ec 08             	sub    $0x8,%esp
8010143c:	68 a0 11 11 80       	push   $0x801111a0
80101441:	50                   	push   %eax
80101442:	e8 a9 ff ff ff       	call   801013f0 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
80101447:	58                   	pop    %eax
80101448:	5a                   	pop    %edx
80101449:	89 da                	mov    %ebx,%edx
8010144b:	c1 ea 0c             	shr    $0xc,%edx
8010144e:	03 15 b8 11 11 80    	add    0x801111b8,%edx
80101454:	52                   	push   %edx
80101455:	56                   	push   %esi
80101456:	e8 65 ec ff ff       	call   801000c0 <bread>
  m = 1 << (bi % 8);
8010145b:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010145d:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
80101460:	ba 01 00 00 00       	mov    $0x1,%edx
80101465:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
80101468:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
8010146e:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
80101471:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101473:	0f b6 4c 18 18       	movzbl 0x18(%eax,%ebx,1),%ecx
80101478:	85 d1                	test   %edx,%ecx
8010147a:	74 25                	je     801014a1 <bfree+0x71>
  bp->data[bi/8] &= ~m;
8010147c:	f7 d2                	not    %edx
8010147e:	89 c6                	mov    %eax,%esi
  log_write(bp);
80101480:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101483:	21 ca                	and    %ecx,%edx
80101485:	88 54 1e 18          	mov    %dl,0x18(%esi,%ebx,1)
  log_write(bp);
80101489:	56                   	push   %esi
8010148a:	e8 d1 19 00 00       	call   80102e60 <log_write>
  brelse(bp);
8010148f:	89 34 24             	mov    %esi,(%esp)
80101492:	e8 39 ed ff ff       	call   801001d0 <brelse>
}
80101497:	83 c4 10             	add    $0x10,%esp
8010149a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010149d:	5b                   	pop    %ebx
8010149e:	5e                   	pop    %esi
8010149f:	5d                   	pop    %ebp
801014a0:	c3                   	ret    
    panic("freeing free block");
801014a1:	83 ec 0c             	sub    $0xc,%esp
801014a4:	68 10 7c 10 80       	push   $0x80107c10
801014a9:	e8 c2 ee ff ff       	call   80100370 <panic>
801014ae:	66 90                	xchg   %ax,%ax

801014b0 <iinit>:
{
801014b0:	55                   	push   %ebp
801014b1:	89 e5                	mov    %esp,%ebp
801014b3:	83 ec 10             	sub    $0x10,%esp
  initlock(&icache.lock, "icache");
801014b6:	68 23 7c 10 80       	push   $0x80107c23
801014bb:	68 c0 11 11 80       	push   $0x801111c0
801014c0:	e8 1b 36 00 00       	call   80104ae0 <initlock>
  readsb(dev, &sb);
801014c5:	58                   	pop    %eax
801014c6:	5a                   	pop    %edx
801014c7:	68 a0 11 11 80       	push   $0x801111a0
801014cc:	ff 75 08             	pushl  0x8(%ebp)
801014cf:	e8 1c ff ff ff       	call   801013f0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801014d4:	ff 35 b8 11 11 80    	pushl  0x801111b8
801014da:	ff 35 b4 11 11 80    	pushl  0x801111b4
801014e0:	ff 35 b0 11 11 80    	pushl  0x801111b0
801014e6:	ff 35 ac 11 11 80    	pushl  0x801111ac
801014ec:	ff 35 a8 11 11 80    	pushl  0x801111a8
801014f2:	ff 35 a4 11 11 80    	pushl  0x801111a4
801014f8:	ff 35 a0 11 11 80    	pushl  0x801111a0
801014fe:	68 84 7c 10 80       	push   $0x80107c84
80101503:	e8 38 f1 ff ff       	call   80100640 <cprintf>
}
80101508:	83 c4 30             	add    $0x30,%esp
8010150b:	c9                   	leave  
8010150c:	c3                   	ret    
8010150d:	8d 76 00             	lea    0x0(%esi),%esi

80101510 <ialloc>:
{
80101510:	55                   	push   %ebp
80101511:	89 e5                	mov    %esp,%ebp
80101513:	57                   	push   %edi
80101514:	56                   	push   %esi
80101515:	53                   	push   %ebx
80101516:	83 ec 1c             	sub    $0x1c,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101519:	83 3d a8 11 11 80 01 	cmpl   $0x1,0x801111a8
{
80101520:	8b 45 0c             	mov    0xc(%ebp),%eax
80101523:	8b 75 08             	mov    0x8(%ebp),%esi
80101526:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101529:	0f 86 91 00 00 00    	jbe    801015c0 <ialloc+0xb0>
8010152f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101534:	eb 21                	jmp    80101557 <ialloc+0x47>
80101536:	8d 76 00             	lea    0x0(%esi),%esi
80101539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    brelse(bp);
80101540:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101543:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
80101546:	57                   	push   %edi
80101547:	e8 84 ec ff ff       	call   801001d0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010154c:	83 c4 10             	add    $0x10,%esp
8010154f:	39 1d a8 11 11 80    	cmp    %ebx,0x801111a8
80101555:	76 69                	jbe    801015c0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101557:	89 d8                	mov    %ebx,%eax
80101559:	83 ec 08             	sub    $0x8,%esp
8010155c:	c1 e8 03             	shr    $0x3,%eax
8010155f:	03 05 b4 11 11 80    	add    0x801111b4,%eax
80101565:	50                   	push   %eax
80101566:	56                   	push   %esi
80101567:	e8 54 eb ff ff       	call   801000c0 <bread>
8010156c:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
8010156e:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
80101570:	83 c4 10             	add    $0x10,%esp
    dip = (struct dinode*)bp->data + inum%IPB;
80101573:	83 e0 07             	and    $0x7,%eax
80101576:	c1 e0 06             	shl    $0x6,%eax
80101579:	8d 4c 07 18          	lea    0x18(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010157d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101581:	75 bd                	jne    80101540 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101583:	83 ec 04             	sub    $0x4,%esp
80101586:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101589:	6a 40                	push   $0x40
8010158b:	6a 00                	push   $0x0
8010158d:	51                   	push   %ecx
8010158e:	e8 7d 37 00 00       	call   80104d10 <memset>
      dip->type = type;
80101593:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101597:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010159a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010159d:	89 3c 24             	mov    %edi,(%esp)
801015a0:	e8 bb 18 00 00       	call   80102e60 <log_write>
      brelse(bp);
801015a5:	89 3c 24             	mov    %edi,(%esp)
801015a8:	e8 23 ec ff ff       	call   801001d0 <brelse>
      return iget(dev, inum);
801015ad:	83 c4 10             	add    $0x10,%esp
}
801015b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801015b3:	89 da                	mov    %ebx,%edx
801015b5:	89 f0                	mov    %esi,%eax
}
801015b7:	5b                   	pop    %ebx
801015b8:	5e                   	pop    %esi
801015b9:	5f                   	pop    %edi
801015ba:	5d                   	pop    %ebp
      return iget(dev, inum);
801015bb:	e9 a0 fc ff ff       	jmp    80101260 <iget>
  panic("ialloc: no inodes");
801015c0:	83 ec 0c             	sub    $0xc,%esp
801015c3:	68 2a 7c 10 80       	push   $0x80107c2a
801015c8:	e8 a3 ed ff ff       	call   80100370 <panic>
801015cd:	8d 76 00             	lea    0x0(%esi),%esi

801015d0 <iupdate>:
{
801015d0:	55                   	push   %ebp
801015d1:	89 e5                	mov    %esp,%ebp
801015d3:	56                   	push   %esi
801015d4:	53                   	push   %ebx
801015d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015d8:	83 ec 08             	sub    $0x8,%esp
801015db:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015de:	83 c3 1c             	add    $0x1c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015e1:	c1 e8 03             	shr    $0x3,%eax
801015e4:	03 05 b4 11 11 80    	add    0x801111b4,%eax
801015ea:	50                   	push   %eax
801015eb:	ff 73 e4             	pushl  -0x1c(%ebx)
801015ee:	e8 cd ea ff ff       	call   801000c0 <bread>
801015f3:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801015f5:	8b 43 e8             	mov    -0x18(%ebx),%eax
  dip->type = ip->type;
801015f8:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015fc:	83 c4 0c             	add    $0xc,%esp
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801015ff:	83 e0 07             	and    $0x7,%eax
80101602:	c1 e0 06             	shl    $0x6,%eax
80101605:	8d 44 06 18          	lea    0x18(%esi,%eax,1),%eax
  dip->type = ip->type;
80101609:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010160c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101610:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101613:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101617:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010161b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010161f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101623:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101627:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010162a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010162d:	6a 34                	push   $0x34
8010162f:	53                   	push   %ebx
80101630:	50                   	push   %eax
80101631:	e8 8a 37 00 00       	call   80104dc0 <memmove>
  log_write(bp);
80101636:	89 34 24             	mov    %esi,(%esp)
80101639:	e8 22 18 00 00       	call   80102e60 <log_write>
  brelse(bp);
8010163e:	89 75 08             	mov    %esi,0x8(%ebp)
80101641:	83 c4 10             	add    $0x10,%esp
}
80101644:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101647:	5b                   	pop    %ebx
80101648:	5e                   	pop    %esi
80101649:	5d                   	pop    %ebp
  brelse(bp);
8010164a:	e9 81 eb ff ff       	jmp    801001d0 <brelse>
8010164f:	90                   	nop

80101650 <idup>:
{
80101650:	55                   	push   %ebp
80101651:	89 e5                	mov    %esp,%ebp
80101653:	53                   	push   %ebx
80101654:	83 ec 10             	sub    $0x10,%esp
80101657:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010165a:	68 c0 11 11 80       	push   $0x801111c0
8010165f:	e8 9c 34 00 00       	call   80104b00 <acquire>
  ip->ref++;
80101664:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101668:	c7 04 24 c0 11 11 80 	movl   $0x801111c0,(%esp)
8010166f:	e8 4c 36 00 00       	call   80104cc0 <release>
}
80101674:	89 d8                	mov    %ebx,%eax
80101676:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101679:	c9                   	leave  
8010167a:	c3                   	ret    
8010167b:	90                   	nop
8010167c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101680 <ilock>:
{
80101680:	55                   	push   %ebp
80101681:	89 e5                	mov    %esp,%ebp
80101683:	56                   	push   %esi
80101684:	53                   	push   %ebx
80101685:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101688:	85 db                	test   %ebx,%ebx
8010168a:	0f 84 e8 00 00 00    	je     80101778 <ilock+0xf8>
80101690:	8b 43 08             	mov    0x8(%ebx),%eax
80101693:	85 c0                	test   %eax,%eax
80101695:	0f 8e dd 00 00 00    	jle    80101778 <ilock+0xf8>
  acquire(&icache.lock);
8010169b:	83 ec 0c             	sub    $0xc,%esp
8010169e:	68 c0 11 11 80       	push   $0x801111c0
801016a3:	e8 58 34 00 00       	call   80104b00 <acquire>
  while(ip->flags & I_BUSY)
801016a8:	8b 43 0c             	mov    0xc(%ebx),%eax
801016ab:	83 c4 10             	add    $0x10,%esp
801016ae:	a8 01                	test   $0x1,%al
801016b0:	74 1e                	je     801016d0 <ilock+0x50>
801016b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sleep(ip, &icache.lock);
801016b8:	83 ec 08             	sub    $0x8,%esp
801016bb:	68 c0 11 11 80       	push   $0x801111c0
801016c0:	53                   	push   %ebx
801016c1:	e8 5a 2a 00 00       	call   80104120 <sleep>
  while(ip->flags & I_BUSY)
801016c6:	8b 43 0c             	mov    0xc(%ebx),%eax
801016c9:	83 c4 10             	add    $0x10,%esp
801016cc:	a8 01                	test   $0x1,%al
801016ce:	75 e8                	jne    801016b8 <ilock+0x38>
  release(&icache.lock);
801016d0:	83 ec 0c             	sub    $0xc,%esp
  ip->flags |= I_BUSY;
801016d3:	83 c8 01             	or     $0x1,%eax
801016d6:	89 43 0c             	mov    %eax,0xc(%ebx)
  release(&icache.lock);
801016d9:	68 c0 11 11 80       	push   $0x801111c0
801016de:	e8 dd 35 00 00       	call   80104cc0 <release>
  if(!(ip->flags & I_VALID)){
801016e3:	83 c4 10             	add    $0x10,%esp
801016e6:	f6 43 0c 02          	testb  $0x2,0xc(%ebx)
801016ea:	74 0c                	je     801016f8 <ilock+0x78>
}
801016ec:	8d 65 f8             	lea    -0x8(%ebp),%esp
801016ef:	5b                   	pop    %ebx
801016f0:	5e                   	pop    %esi
801016f1:	5d                   	pop    %ebp
801016f2:	c3                   	ret    
801016f3:	90                   	nop
801016f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016f8:	8b 43 04             	mov    0x4(%ebx),%eax
801016fb:	83 ec 08             	sub    $0x8,%esp
801016fe:	c1 e8 03             	shr    $0x3,%eax
80101701:	03 05 b4 11 11 80    	add    0x801111b4,%eax
80101707:	50                   	push   %eax
80101708:	ff 33                	pushl  (%ebx)
8010170a:	e8 b1 e9 ff ff       	call   801000c0 <bread>
8010170f:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101711:	8b 43 04             	mov    0x4(%ebx),%eax
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101714:	83 c4 0c             	add    $0xc,%esp
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101717:	83 e0 07             	and    $0x7,%eax
8010171a:	c1 e0 06             	shl    $0x6,%eax
8010171d:	8d 44 06 18          	lea    0x18(%esi,%eax,1),%eax
    ip->type = dip->type;
80101721:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101724:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
80101727:	66 89 53 10          	mov    %dx,0x10(%ebx)
    ip->major = dip->major;
8010172b:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
8010172f:	66 89 53 12          	mov    %dx,0x12(%ebx)
    ip->minor = dip->minor;
80101733:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
80101737:	66 89 53 14          	mov    %dx,0x14(%ebx)
    ip->nlink = dip->nlink;
8010173b:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
8010173f:	66 89 53 16          	mov    %dx,0x16(%ebx)
    ip->size = dip->size;
80101743:	8b 50 fc             	mov    -0x4(%eax),%edx
80101746:	89 53 18             	mov    %edx,0x18(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101749:	6a 34                	push   $0x34
8010174b:	50                   	push   %eax
8010174c:	8d 43 1c             	lea    0x1c(%ebx),%eax
8010174f:	50                   	push   %eax
80101750:	e8 6b 36 00 00       	call   80104dc0 <memmove>
    brelse(bp);
80101755:	89 34 24             	mov    %esi,(%esp)
80101758:	e8 73 ea ff ff       	call   801001d0 <brelse>
    ip->flags |= I_VALID;
8010175d:	83 4b 0c 02          	orl    $0x2,0xc(%ebx)
    if(ip->type == 0)
80101761:	83 c4 10             	add    $0x10,%esp
80101764:	66 83 7b 10 00       	cmpw   $0x0,0x10(%ebx)
80101769:	75 81                	jne    801016ec <ilock+0x6c>
      panic("ilock: no type");
8010176b:	83 ec 0c             	sub    $0xc,%esp
8010176e:	68 42 7c 10 80       	push   $0x80107c42
80101773:	e8 f8 eb ff ff       	call   80100370 <panic>
    panic("ilock");
80101778:	83 ec 0c             	sub    $0xc,%esp
8010177b:	68 3c 7c 10 80       	push   $0x80107c3c
80101780:	e8 eb eb ff ff       	call   80100370 <panic>
80101785:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101790 <iunlock>:
{
80101790:	55                   	push   %ebp
80101791:	89 e5                	mov    %esp,%ebp
80101793:	53                   	push   %ebx
80101794:	83 ec 04             	sub    $0x4,%esp
80101797:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
8010179a:	85 db                	test   %ebx,%ebx
8010179c:	74 39                	je     801017d7 <iunlock+0x47>
8010179e:	f6 43 0c 01          	testb  $0x1,0xc(%ebx)
801017a2:	74 33                	je     801017d7 <iunlock+0x47>
801017a4:	8b 43 08             	mov    0x8(%ebx),%eax
801017a7:	85 c0                	test   %eax,%eax
801017a9:	7e 2c                	jle    801017d7 <iunlock+0x47>
  acquire(&icache.lock);
801017ab:	83 ec 0c             	sub    $0xc,%esp
801017ae:	68 c0 11 11 80       	push   $0x801111c0
801017b3:	e8 48 33 00 00       	call   80104b00 <acquire>
  ip->flags &= ~I_BUSY;
801017b8:	83 63 0c fe          	andl   $0xfffffffe,0xc(%ebx)
  wakeup(ip);
801017bc:	89 1c 24             	mov    %ebx,(%esp)
801017bf:	e8 6c 2b 00 00       	call   80104330 <wakeup>
  release(&icache.lock);
801017c4:	83 c4 10             	add    $0x10,%esp
801017c7:	c7 45 08 c0 11 11 80 	movl   $0x801111c0,0x8(%ebp)
}
801017ce:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801017d1:	c9                   	leave  
  release(&icache.lock);
801017d2:	e9 e9 34 00 00       	jmp    80104cc0 <release>
    panic("iunlock");
801017d7:	83 ec 0c             	sub    $0xc,%esp
801017da:	68 51 7c 10 80       	push   $0x80107c51
801017df:	e8 8c eb ff ff       	call   80100370 <panic>
801017e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801017ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801017f0 <iput>:
{
801017f0:	55                   	push   %ebp
801017f1:	89 e5                	mov    %esp,%ebp
801017f3:	57                   	push   %edi
801017f4:	56                   	push   %esi
801017f5:	53                   	push   %ebx
801017f6:	83 ec 28             	sub    $0x28,%esp
801017f9:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&icache.lock);
801017fc:	68 c0 11 11 80       	push   $0x801111c0
80101801:	e8 fa 32 00 00       	call   80104b00 <acquire>
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
80101806:	8b 46 08             	mov    0x8(%esi),%eax
80101809:	83 c4 10             	add    $0x10,%esp
8010180c:	83 f8 01             	cmp    $0x1,%eax
8010180f:	0f 85 ab 00 00 00    	jne    801018c0 <iput+0xd0>
80101815:	8b 56 0c             	mov    0xc(%esi),%edx
80101818:	f6 c2 02             	test   $0x2,%dl
8010181b:	0f 84 9f 00 00 00    	je     801018c0 <iput+0xd0>
80101821:	66 83 7e 16 00       	cmpw   $0x0,0x16(%esi)
80101826:	0f 85 94 00 00 00    	jne    801018c0 <iput+0xd0>
    if(ip->flags & I_BUSY)
8010182c:	f6 c2 01             	test   $0x1,%dl
8010182f:	0f 85 05 01 00 00    	jne    8010193a <iput+0x14a>
    release(&icache.lock);
80101835:	83 ec 0c             	sub    $0xc,%esp
    ip->flags |= I_BUSY;
80101838:	83 ca 01             	or     $0x1,%edx
8010183b:	8d 5e 1c             	lea    0x1c(%esi),%ebx
8010183e:	89 56 0c             	mov    %edx,0xc(%esi)
    release(&icache.lock);
80101841:	68 c0 11 11 80       	push   $0x801111c0
80101846:	8d 7e 4c             	lea    0x4c(%esi),%edi
80101849:	e8 72 34 00 00       	call   80104cc0 <release>
8010184e:	83 c4 10             	add    $0x10,%esp
80101851:	eb 0c                	jmp    8010185f <iput+0x6f>
80101853:	90                   	nop
80101854:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101858:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
8010185b:	39 fb                	cmp    %edi,%ebx
8010185d:	74 1b                	je     8010187a <iput+0x8a>
    if(ip->addrs[i]){
8010185f:	8b 13                	mov    (%ebx),%edx
80101861:	85 d2                	test   %edx,%edx
80101863:	74 f3                	je     80101858 <iput+0x68>
      bfree(ip->dev, ip->addrs[i]);
80101865:	8b 06                	mov    (%esi),%eax
80101867:	83 c3 04             	add    $0x4,%ebx
8010186a:	e8 c1 fb ff ff       	call   80101430 <bfree>
      ip->addrs[i] = 0;
8010186f:	c7 43 fc 00 00 00 00 	movl   $0x0,-0x4(%ebx)
  for(i = 0; i < NDIRECT; i++){
80101876:	39 fb                	cmp    %edi,%ebx
80101878:	75 e5                	jne    8010185f <iput+0x6f>
    }
  }

  if(ip->addrs[NDIRECT]){
8010187a:	8b 46 4c             	mov    0x4c(%esi),%eax
8010187d:	85 c0                	test   %eax,%eax
8010187f:	75 5f                	jne    801018e0 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
80101881:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101884:	c7 46 18 00 00 00 00 	movl   $0x0,0x18(%esi)
  iupdate(ip);
8010188b:	56                   	push   %esi
8010188c:	e8 3f fd ff ff       	call   801015d0 <iupdate>
    ip->type = 0;
80101891:	31 c0                	xor    %eax,%eax
80101893:	66 89 46 10          	mov    %ax,0x10(%esi)
    iupdate(ip);
80101897:	89 34 24             	mov    %esi,(%esp)
8010189a:	e8 31 fd ff ff       	call   801015d0 <iupdate>
    acquire(&icache.lock);
8010189f:	c7 04 24 c0 11 11 80 	movl   $0x801111c0,(%esp)
801018a6:	e8 55 32 00 00       	call   80104b00 <acquire>
    ip->flags = 0;
801018ab:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
    wakeup(ip);
801018b2:	89 34 24             	mov    %esi,(%esp)
801018b5:	e8 76 2a 00 00       	call   80104330 <wakeup>
801018ba:	8b 46 08             	mov    0x8(%esi),%eax
801018bd:	83 c4 10             	add    $0x10,%esp
  ip->ref--;
801018c0:	83 e8 01             	sub    $0x1,%eax
801018c3:	89 46 08             	mov    %eax,0x8(%esi)
  release(&icache.lock);
801018c6:	c7 45 08 c0 11 11 80 	movl   $0x801111c0,0x8(%ebp)
}
801018cd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801018d0:	5b                   	pop    %ebx
801018d1:	5e                   	pop    %esi
801018d2:	5f                   	pop    %edi
801018d3:	5d                   	pop    %ebp
  release(&icache.lock);
801018d4:	e9 e7 33 00 00       	jmp    80104cc0 <release>
801018d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801018e0:	83 ec 08             	sub    $0x8,%esp
801018e3:	50                   	push   %eax
801018e4:	ff 36                	pushl  (%esi)
801018e6:	e8 d5 e7 ff ff       	call   801000c0 <bread>
801018eb:	83 c4 10             	add    $0x10,%esp
801018ee:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
801018f1:	8d 58 18             	lea    0x18(%eax),%ebx
801018f4:	8d b8 18 02 00 00    	lea    0x218(%eax),%edi
801018fa:	eb 0b                	jmp    80101907 <iput+0x117>
801018fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101900:	83 c3 04             	add    $0x4,%ebx
    for(j = 0; j < NINDIRECT; j++){
80101903:	39 df                	cmp    %ebx,%edi
80101905:	74 0f                	je     80101916 <iput+0x126>
      if(a[j])
80101907:	8b 13                	mov    (%ebx),%edx
80101909:	85 d2                	test   %edx,%edx
8010190b:	74 f3                	je     80101900 <iput+0x110>
        bfree(ip->dev, a[j]);
8010190d:	8b 06                	mov    (%esi),%eax
8010190f:	e8 1c fb ff ff       	call   80101430 <bfree>
80101914:	eb ea                	jmp    80101900 <iput+0x110>
    brelse(bp);
80101916:	83 ec 0c             	sub    $0xc,%esp
80101919:	ff 75 e4             	pushl  -0x1c(%ebp)
8010191c:	e8 af e8 ff ff       	call   801001d0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101921:	8b 56 4c             	mov    0x4c(%esi),%edx
80101924:	8b 06                	mov    (%esi),%eax
80101926:	e8 05 fb ff ff       	call   80101430 <bfree>
    ip->addrs[NDIRECT] = 0;
8010192b:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
80101932:	83 c4 10             	add    $0x10,%esp
80101935:	e9 47 ff ff ff       	jmp    80101881 <iput+0x91>
      panic("iput busy");
8010193a:	83 ec 0c             	sub    $0xc,%esp
8010193d:	68 59 7c 10 80       	push   $0x80107c59
80101942:	e8 29 ea ff ff       	call   80100370 <panic>
80101947:	89 f6                	mov    %esi,%esi
80101949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101950 <iunlockput>:
{
80101950:	55                   	push   %ebp
80101951:	89 e5                	mov    %esp,%ebp
80101953:	53                   	push   %ebx
80101954:	83 ec 10             	sub    $0x10,%esp
80101957:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
8010195a:	53                   	push   %ebx
8010195b:	e8 30 fe ff ff       	call   80101790 <iunlock>
  iput(ip);
80101960:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101963:	83 c4 10             	add    $0x10,%esp
}
80101966:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101969:	c9                   	leave  
  iput(ip);
8010196a:	e9 81 fe ff ff       	jmp    801017f0 <iput>
8010196f:	90                   	nop

80101970 <stati>:
}

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
80101970:	55                   	push   %ebp
80101971:	89 e5                	mov    %esp,%ebp
80101973:	8b 55 08             	mov    0x8(%ebp),%edx
80101976:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101979:	8b 0a                	mov    (%edx),%ecx
8010197b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010197e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101981:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101984:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
80101988:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010198b:	0f b7 4a 16          	movzwl 0x16(%edx),%ecx
8010198f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101993:	8b 52 18             	mov    0x18(%edx),%edx
80101996:	89 50 10             	mov    %edx,0x10(%eax)
}
80101999:	5d                   	pop    %ebp
8010199a:	c3                   	ret    
8010199b:	90                   	nop
8010199c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801019a0 <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
801019a0:	55                   	push   %ebp
801019a1:	89 e5                	mov    %esp,%ebp
801019a3:	57                   	push   %edi
801019a4:	56                   	push   %esi
801019a5:	53                   	push   %ebx
801019a6:	83 ec 1c             	sub    $0x1c,%esp
801019a9:	8b 45 08             	mov    0x8(%ebp),%eax
801019ac:	8b 75 0c             	mov    0xc(%ebp),%esi
801019af:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801019b2:	66 83 78 10 03       	cmpw   $0x3,0x10(%eax)
{
801019b7:	89 75 e0             	mov    %esi,-0x20(%ebp)
801019ba:	89 45 d8             	mov    %eax,-0x28(%ebp)
801019bd:	8b 75 10             	mov    0x10(%ebp),%esi
801019c0:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
801019c3:	0f 84 a7 00 00 00    	je     80101a70 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
801019c9:	8b 45 d8             	mov    -0x28(%ebp),%eax
801019cc:	8b 40 18             	mov    0x18(%eax),%eax
801019cf:	39 c6                	cmp    %eax,%esi
801019d1:	0f 87 ba 00 00 00    	ja     80101a91 <readi+0xf1>
801019d7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801019da:	89 f9                	mov    %edi,%ecx
801019dc:	01 f1                	add    %esi,%ecx
801019de:	0f 82 ad 00 00 00    	jb     80101a91 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
801019e4:	89 c2                	mov    %eax,%edx
801019e6:	29 f2                	sub    %esi,%edx
801019e8:	39 c8                	cmp    %ecx,%eax
801019ea:	0f 43 d7             	cmovae %edi,%edx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019ed:	31 ff                	xor    %edi,%edi
801019ef:	85 d2                	test   %edx,%edx
    n = ip->size - off;
801019f1:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019f4:	74 6c                	je     80101a62 <readi+0xc2>
801019f6:	8d 76 00             	lea    0x0(%esi),%esi
801019f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a00:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101a03:	89 f2                	mov    %esi,%edx
80101a05:	c1 ea 09             	shr    $0x9,%edx
80101a08:	89 d8                	mov    %ebx,%eax
80101a0a:	e8 21 f9 ff ff       	call   80101330 <bmap>
80101a0f:	83 ec 08             	sub    $0x8,%esp
80101a12:	50                   	push   %eax
80101a13:	ff 33                	pushl  (%ebx)
80101a15:	e8 a6 e6 ff ff       	call   801000c0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101a1a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a1d:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101a1f:	89 f0                	mov    %esi,%eax
80101a21:	25 ff 01 00 00       	and    $0x1ff,%eax
80101a26:	b9 00 02 00 00       	mov    $0x200,%ecx
80101a2b:	83 c4 0c             	add    $0xc,%esp
80101a2e:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101a30:	8d 44 02 18          	lea    0x18(%edx,%eax,1),%eax
80101a34:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101a37:	29 fb                	sub    %edi,%ebx
80101a39:	39 d9                	cmp    %ebx,%ecx
80101a3b:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101a3e:	53                   	push   %ebx
80101a3f:	50                   	push   %eax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a40:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101a42:	ff 75 e0             	pushl  -0x20(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a45:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101a47:	e8 74 33 00 00       	call   80104dc0 <memmove>
    brelse(bp);
80101a4c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101a4f:	89 14 24             	mov    %edx,(%esp)
80101a52:	e8 79 e7 ff ff       	call   801001d0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a57:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101a5a:	83 c4 10             	add    $0x10,%esp
80101a5d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101a60:	77 9e                	ja     80101a00 <readi+0x60>
  }
  return n;
80101a62:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101a65:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a68:	5b                   	pop    %ebx
80101a69:	5e                   	pop    %esi
80101a6a:	5f                   	pop    %edi
80101a6b:	5d                   	pop    %ebp
80101a6c:	c3                   	ret    
80101a6d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101a70:	0f bf 40 12          	movswl 0x12(%eax),%eax
80101a74:	66 83 f8 09          	cmp    $0x9,%ax
80101a78:	77 17                	ja     80101a91 <readi+0xf1>
80101a7a:	8b 04 c5 40 11 11 80 	mov    -0x7feeeec0(,%eax,8),%eax
80101a81:	85 c0                	test   %eax,%eax
80101a83:	74 0c                	je     80101a91 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101a85:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101a88:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a8b:	5b                   	pop    %ebx
80101a8c:	5e                   	pop    %esi
80101a8d:	5f                   	pop    %edi
80101a8e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101a8f:	ff e0                	jmp    *%eax
      return -1;
80101a91:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101a96:	eb cd                	jmp    80101a65 <readi+0xc5>
80101a98:	90                   	nop
80101a99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101aa0 <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101aa0:	55                   	push   %ebp
80101aa1:	89 e5                	mov    %esp,%ebp
80101aa3:	57                   	push   %edi
80101aa4:	56                   	push   %esi
80101aa5:	53                   	push   %ebx
80101aa6:	83 ec 1c             	sub    $0x1c,%esp
80101aa9:	8b 45 08             	mov    0x8(%ebp),%eax
80101aac:	8b 75 0c             	mov    0xc(%ebp),%esi
80101aaf:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101ab2:	66 83 78 10 03       	cmpw   $0x3,0x10(%eax)
{
80101ab7:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101aba:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101abd:	8b 75 10             	mov    0x10(%ebp),%esi
80101ac0:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80101ac3:	0f 84 b7 00 00 00    	je     80101b80 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101ac9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101acc:	39 70 18             	cmp    %esi,0x18(%eax)
80101acf:	0f 82 eb 00 00 00    	jb     80101bc0 <writei+0x120>
80101ad5:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101ad8:	31 d2                	xor    %edx,%edx
80101ada:	89 f8                	mov    %edi,%eax
80101adc:	01 f0                	add    %esi,%eax
80101ade:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101ae1:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101ae6:	0f 87 d4 00 00 00    	ja     80101bc0 <writei+0x120>
80101aec:	85 d2                	test   %edx,%edx
80101aee:	0f 85 cc 00 00 00    	jne    80101bc0 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101af4:	85 ff                	test   %edi,%edi
80101af6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101afd:	74 72                	je     80101b71 <writei+0xd1>
80101aff:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b00:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101b03:	89 f2                	mov    %esi,%edx
80101b05:	c1 ea 09             	shr    $0x9,%edx
80101b08:	89 f8                	mov    %edi,%eax
80101b0a:	e8 21 f8 ff ff       	call   80101330 <bmap>
80101b0f:	83 ec 08             	sub    $0x8,%esp
80101b12:	50                   	push   %eax
80101b13:	ff 37                	pushl  (%edi)
80101b15:	e8 a6 e5 ff ff       	call   801000c0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101b1a:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101b1d:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b20:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101b22:	89 f0                	mov    %esi,%eax
80101b24:	b9 00 02 00 00       	mov    $0x200,%ecx
80101b29:	83 c4 0c             	add    $0xc,%esp
80101b2c:	25 ff 01 00 00       	and    $0x1ff,%eax
80101b31:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101b33:	8d 44 07 18          	lea    0x18(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101b37:	39 d9                	cmp    %ebx,%ecx
80101b39:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101b3c:	53                   	push   %ebx
80101b3d:	ff 75 dc             	pushl  -0x24(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b40:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101b42:	50                   	push   %eax
80101b43:	e8 78 32 00 00       	call   80104dc0 <memmove>
    log_write(bp);
80101b48:	89 3c 24             	mov    %edi,(%esp)
80101b4b:	e8 10 13 00 00       	call   80102e60 <log_write>
    brelse(bp);
80101b50:	89 3c 24             	mov    %edi,(%esp)
80101b53:	e8 78 e6 ff ff       	call   801001d0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b58:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101b5b:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101b5e:	83 c4 10             	add    $0x10,%esp
80101b61:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101b64:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101b67:	77 97                	ja     80101b00 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101b69:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b6c:	3b 70 18             	cmp    0x18(%eax),%esi
80101b6f:	77 37                	ja     80101ba8 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101b71:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101b74:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b77:	5b                   	pop    %ebx
80101b78:	5e                   	pop    %esi
80101b79:	5f                   	pop    %edi
80101b7a:	5d                   	pop    %ebp
80101b7b:	c3                   	ret    
80101b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101b80:	0f bf 40 12          	movswl 0x12(%eax),%eax
80101b84:	66 83 f8 09          	cmp    $0x9,%ax
80101b88:	77 36                	ja     80101bc0 <writei+0x120>
80101b8a:	8b 04 c5 44 11 11 80 	mov    -0x7feeeebc(,%eax,8),%eax
80101b91:	85 c0                	test   %eax,%eax
80101b93:	74 2b                	je     80101bc0 <writei+0x120>
    return devsw[ip->major].write(ip, src, n);
80101b95:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101b98:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b9b:	5b                   	pop    %ebx
80101b9c:	5e                   	pop    %esi
80101b9d:	5f                   	pop    %edi
80101b9e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101b9f:	ff e0                	jmp    *%eax
80101ba1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101ba8:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101bab:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101bae:	89 70 18             	mov    %esi,0x18(%eax)
    iupdate(ip);
80101bb1:	50                   	push   %eax
80101bb2:	e8 19 fa ff ff       	call   801015d0 <iupdate>
80101bb7:	83 c4 10             	add    $0x10,%esp
80101bba:	eb b5                	jmp    80101b71 <writei+0xd1>
80101bbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80101bc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101bc5:	eb ad                	jmp    80101b74 <writei+0xd4>
80101bc7:	89 f6                	mov    %esi,%esi
80101bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101bd0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101bd0:	55                   	push   %ebp
80101bd1:	89 e5                	mov    %esp,%ebp
80101bd3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101bd6:	6a 0e                	push   $0xe
80101bd8:	ff 75 0c             	pushl  0xc(%ebp)
80101bdb:	ff 75 08             	pushl  0x8(%ebp)
80101bde:	e8 4d 32 00 00       	call   80104e30 <strncmp>
}
80101be3:	c9                   	leave  
80101be4:	c3                   	ret    
80101be5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101bf0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101bf0:	55                   	push   %ebp
80101bf1:	89 e5                	mov    %esp,%ebp
80101bf3:	57                   	push   %edi
80101bf4:	56                   	push   %esi
80101bf5:	53                   	push   %ebx
80101bf6:	83 ec 1c             	sub    $0x1c,%esp
80101bf9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101bfc:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
80101c01:	0f 85 85 00 00 00    	jne    80101c8c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101c07:	8b 53 18             	mov    0x18(%ebx),%edx
80101c0a:	31 ff                	xor    %edi,%edi
80101c0c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101c0f:	85 d2                	test   %edx,%edx
80101c11:	74 3e                	je     80101c51 <dirlookup+0x61>
80101c13:	90                   	nop
80101c14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101c18:	6a 10                	push   $0x10
80101c1a:	57                   	push   %edi
80101c1b:	56                   	push   %esi
80101c1c:	53                   	push   %ebx
80101c1d:	e8 7e fd ff ff       	call   801019a0 <readi>
80101c22:	83 c4 10             	add    $0x10,%esp
80101c25:	83 f8 10             	cmp    $0x10,%eax
80101c28:	75 55                	jne    80101c7f <dirlookup+0x8f>
      panic("dirlink read");
    if(de.inum == 0)
80101c2a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101c2f:	74 18                	je     80101c49 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101c31:	8d 45 da             	lea    -0x26(%ebp),%eax
80101c34:	83 ec 04             	sub    $0x4,%esp
80101c37:	6a 0e                	push   $0xe
80101c39:	50                   	push   %eax
80101c3a:	ff 75 0c             	pushl  0xc(%ebp)
80101c3d:	e8 ee 31 00 00       	call   80104e30 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101c42:	83 c4 10             	add    $0x10,%esp
80101c45:	85 c0                	test   %eax,%eax
80101c47:	74 17                	je     80101c60 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101c49:	83 c7 10             	add    $0x10,%edi
80101c4c:	3b 7b 18             	cmp    0x18(%ebx),%edi
80101c4f:	72 c7                	jb     80101c18 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101c51:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101c54:	31 c0                	xor    %eax,%eax
}
80101c56:	5b                   	pop    %ebx
80101c57:	5e                   	pop    %esi
80101c58:	5f                   	pop    %edi
80101c59:	5d                   	pop    %ebp
80101c5a:	c3                   	ret    
80101c5b:	90                   	nop
80101c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(poff)
80101c60:	8b 45 10             	mov    0x10(%ebp),%eax
80101c63:	85 c0                	test   %eax,%eax
80101c65:	74 05                	je     80101c6c <dirlookup+0x7c>
        *poff = off;
80101c67:	8b 45 10             	mov    0x10(%ebp),%eax
80101c6a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101c6c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101c70:	8b 03                	mov    (%ebx),%eax
80101c72:	e8 e9 f5 ff ff       	call   80101260 <iget>
}
80101c77:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c7a:	5b                   	pop    %ebx
80101c7b:	5e                   	pop    %esi
80101c7c:	5f                   	pop    %edi
80101c7d:	5d                   	pop    %ebp
80101c7e:	c3                   	ret    
      panic("dirlink read");
80101c7f:	83 ec 0c             	sub    $0xc,%esp
80101c82:	68 75 7c 10 80       	push   $0x80107c75
80101c87:	e8 e4 e6 ff ff       	call   80100370 <panic>
    panic("dirlookup not DIR");
80101c8c:	83 ec 0c             	sub    $0xc,%esp
80101c8f:	68 63 7c 10 80       	push   $0x80107c63
80101c94:	e8 d7 e6 ff ff       	call   80100370 <panic>
80101c99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101ca0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101ca0:	55                   	push   %ebp
80101ca1:	89 e5                	mov    %esp,%ebp
80101ca3:	57                   	push   %edi
80101ca4:	56                   	push   %esi
80101ca5:	53                   	push   %ebx
80101ca6:	89 cf                	mov    %ecx,%edi
80101ca8:	89 c3                	mov    %eax,%ebx
80101caa:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101cad:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101cb0:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80101cb3:	0f 84 67 01 00 00    	je     80101e20 <namex+0x180>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);
80101cb9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  acquire(&icache.lock);
80101cbf:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(proc->cwd);
80101cc2:	8b 70 58             	mov    0x58(%eax),%esi
  acquire(&icache.lock);
80101cc5:	68 c0 11 11 80       	push   $0x801111c0
80101cca:	e8 31 2e 00 00       	call   80104b00 <acquire>
  ip->ref++;
80101ccf:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101cd3:	c7 04 24 c0 11 11 80 	movl   $0x801111c0,(%esp)
80101cda:	e8 e1 2f 00 00       	call   80104cc0 <release>
80101cdf:	83 c4 10             	add    $0x10,%esp
80101ce2:	eb 07                	jmp    80101ceb <namex+0x4b>
80101ce4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101ce8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101ceb:	0f b6 03             	movzbl (%ebx),%eax
80101cee:	3c 2f                	cmp    $0x2f,%al
80101cf0:	74 f6                	je     80101ce8 <namex+0x48>
  if(*path == 0)
80101cf2:	84 c0                	test   %al,%al
80101cf4:	0f 84 ee 00 00 00    	je     80101de8 <namex+0x148>
  while(*path != '/' && *path != 0)
80101cfa:	0f b6 03             	movzbl (%ebx),%eax
80101cfd:	3c 2f                	cmp    $0x2f,%al
80101cff:	0f 84 b3 00 00 00    	je     80101db8 <namex+0x118>
80101d05:	84 c0                	test   %al,%al
80101d07:	89 da                	mov    %ebx,%edx
80101d09:	75 09                	jne    80101d14 <namex+0x74>
80101d0b:	e9 a8 00 00 00       	jmp    80101db8 <namex+0x118>
80101d10:	84 c0                	test   %al,%al
80101d12:	74 0a                	je     80101d1e <namex+0x7e>
    path++;
80101d14:	83 c2 01             	add    $0x1,%edx
  while(*path != '/' && *path != 0)
80101d17:	0f b6 02             	movzbl (%edx),%eax
80101d1a:	3c 2f                	cmp    $0x2f,%al
80101d1c:	75 f2                	jne    80101d10 <namex+0x70>
80101d1e:	89 d1                	mov    %edx,%ecx
80101d20:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80101d22:	83 f9 0d             	cmp    $0xd,%ecx
80101d25:	0f 8e 91 00 00 00    	jle    80101dbc <namex+0x11c>
    memmove(name, s, DIRSIZ);
80101d2b:	83 ec 04             	sub    $0x4,%esp
80101d2e:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101d31:	6a 0e                	push   $0xe
80101d33:	53                   	push   %ebx
80101d34:	57                   	push   %edi
80101d35:	e8 86 30 00 00       	call   80104dc0 <memmove>
    path++;
80101d3a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    memmove(name, s, DIRSIZ);
80101d3d:	83 c4 10             	add    $0x10,%esp
    path++;
80101d40:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80101d42:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101d45:	75 11                	jne    80101d58 <namex+0xb8>
80101d47:	89 f6                	mov    %esi,%esi
80101d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101d50:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101d53:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101d56:	74 f8                	je     80101d50 <namex+0xb0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101d58:	83 ec 0c             	sub    $0xc,%esp
80101d5b:	56                   	push   %esi
80101d5c:	e8 1f f9 ff ff       	call   80101680 <ilock>
    if(ip->type != T_DIR){
80101d61:	83 c4 10             	add    $0x10,%esp
80101d64:	66 83 7e 10 01       	cmpw   $0x1,0x10(%esi)
80101d69:	0f 85 91 00 00 00    	jne    80101e00 <namex+0x160>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101d6f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101d72:	85 d2                	test   %edx,%edx
80101d74:	74 09                	je     80101d7f <namex+0xdf>
80101d76:	80 3b 00             	cmpb   $0x0,(%ebx)
80101d79:	0f 84 b7 00 00 00    	je     80101e36 <namex+0x196>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101d7f:	83 ec 04             	sub    $0x4,%esp
80101d82:	6a 00                	push   $0x0
80101d84:	57                   	push   %edi
80101d85:	56                   	push   %esi
80101d86:	e8 65 fe ff ff       	call   80101bf0 <dirlookup>
80101d8b:	83 c4 10             	add    $0x10,%esp
80101d8e:	85 c0                	test   %eax,%eax
80101d90:	74 6e                	je     80101e00 <namex+0x160>
  iunlock(ip);
80101d92:	83 ec 0c             	sub    $0xc,%esp
80101d95:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101d98:	56                   	push   %esi
80101d99:	e8 f2 f9 ff ff       	call   80101790 <iunlock>
  iput(ip);
80101d9e:	89 34 24             	mov    %esi,(%esp)
80101da1:	e8 4a fa ff ff       	call   801017f0 <iput>
80101da6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101da9:	83 c4 10             	add    $0x10,%esp
80101dac:	89 c6                	mov    %eax,%esi
80101dae:	e9 38 ff ff ff       	jmp    80101ceb <namex+0x4b>
80101db3:	90                   	nop
80101db4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path != '/' && *path != 0)
80101db8:	89 da                	mov    %ebx,%edx
80101dba:	31 c9                	xor    %ecx,%ecx
    memmove(name, s, len);
80101dbc:	83 ec 04             	sub    $0x4,%esp
80101dbf:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101dc2:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101dc5:	51                   	push   %ecx
80101dc6:	53                   	push   %ebx
80101dc7:	57                   	push   %edi
80101dc8:	e8 f3 2f 00 00       	call   80104dc0 <memmove>
    name[len] = 0;
80101dcd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101dd0:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101dd3:	83 c4 10             	add    $0x10,%esp
80101dd6:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101dda:	89 d3                	mov    %edx,%ebx
80101ddc:	e9 61 ff ff ff       	jmp    80101d42 <namex+0xa2>
80101de1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101de8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101deb:	85 c0                	test   %eax,%eax
80101ded:	75 5d                	jne    80101e4c <namex+0x1ac>
    iput(ip);
    return 0;
  }
  return ip;
}
80101def:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101df2:	89 f0                	mov    %esi,%eax
80101df4:	5b                   	pop    %ebx
80101df5:	5e                   	pop    %esi
80101df6:	5f                   	pop    %edi
80101df7:	5d                   	pop    %ebp
80101df8:	c3                   	ret    
80101df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80101e00:	83 ec 0c             	sub    $0xc,%esp
80101e03:	56                   	push   %esi
80101e04:	e8 87 f9 ff ff       	call   80101790 <iunlock>
  iput(ip);
80101e09:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101e0c:	31 f6                	xor    %esi,%esi
  iput(ip);
80101e0e:	e8 dd f9 ff ff       	call   801017f0 <iput>
      return 0;
80101e13:	83 c4 10             	add    $0x10,%esp
}
80101e16:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e19:	89 f0                	mov    %esi,%eax
80101e1b:	5b                   	pop    %ebx
80101e1c:	5e                   	pop    %esi
80101e1d:	5f                   	pop    %edi
80101e1e:	5d                   	pop    %ebp
80101e1f:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
80101e20:	ba 01 00 00 00       	mov    $0x1,%edx
80101e25:	b8 01 00 00 00       	mov    $0x1,%eax
80101e2a:	e8 31 f4 ff ff       	call   80101260 <iget>
80101e2f:	89 c6                	mov    %eax,%esi
80101e31:	e9 b5 fe ff ff       	jmp    80101ceb <namex+0x4b>
      iunlock(ip);
80101e36:	83 ec 0c             	sub    $0xc,%esp
80101e39:	56                   	push   %esi
80101e3a:	e8 51 f9 ff ff       	call   80101790 <iunlock>
      return ip;
80101e3f:	83 c4 10             	add    $0x10,%esp
}
80101e42:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e45:	89 f0                	mov    %esi,%eax
80101e47:	5b                   	pop    %ebx
80101e48:	5e                   	pop    %esi
80101e49:	5f                   	pop    %edi
80101e4a:	5d                   	pop    %ebp
80101e4b:	c3                   	ret    
    iput(ip);
80101e4c:	83 ec 0c             	sub    $0xc,%esp
80101e4f:	56                   	push   %esi
    return 0;
80101e50:	31 f6                	xor    %esi,%esi
    iput(ip);
80101e52:	e8 99 f9 ff ff       	call   801017f0 <iput>
    return 0;
80101e57:	83 c4 10             	add    $0x10,%esp
80101e5a:	eb 93                	jmp    80101def <namex+0x14f>
80101e5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101e60 <dirlink>:
{
80101e60:	55                   	push   %ebp
80101e61:	89 e5                	mov    %esp,%ebp
80101e63:	57                   	push   %edi
80101e64:	56                   	push   %esi
80101e65:	53                   	push   %ebx
80101e66:	83 ec 20             	sub    $0x20,%esp
80101e69:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101e6c:	6a 00                	push   $0x0
80101e6e:	ff 75 0c             	pushl  0xc(%ebp)
80101e71:	53                   	push   %ebx
80101e72:	e8 79 fd ff ff       	call   80101bf0 <dirlookup>
80101e77:	83 c4 10             	add    $0x10,%esp
80101e7a:	85 c0                	test   %eax,%eax
80101e7c:	75 67                	jne    80101ee5 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101e7e:	8b 7b 18             	mov    0x18(%ebx),%edi
80101e81:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e84:	85 ff                	test   %edi,%edi
80101e86:	74 29                	je     80101eb1 <dirlink+0x51>
80101e88:	31 ff                	xor    %edi,%edi
80101e8a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e8d:	eb 09                	jmp    80101e98 <dirlink+0x38>
80101e8f:	90                   	nop
80101e90:	83 c7 10             	add    $0x10,%edi
80101e93:	3b 7b 18             	cmp    0x18(%ebx),%edi
80101e96:	73 19                	jae    80101eb1 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e98:	6a 10                	push   $0x10
80101e9a:	57                   	push   %edi
80101e9b:	56                   	push   %esi
80101e9c:	53                   	push   %ebx
80101e9d:	e8 fe fa ff ff       	call   801019a0 <readi>
80101ea2:	83 c4 10             	add    $0x10,%esp
80101ea5:	83 f8 10             	cmp    $0x10,%eax
80101ea8:	75 4e                	jne    80101ef8 <dirlink+0x98>
    if(de.inum == 0)
80101eaa:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101eaf:	75 df                	jne    80101e90 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80101eb1:	8d 45 da             	lea    -0x26(%ebp),%eax
80101eb4:	83 ec 04             	sub    $0x4,%esp
80101eb7:	6a 0e                	push   $0xe
80101eb9:	ff 75 0c             	pushl  0xc(%ebp)
80101ebc:	50                   	push   %eax
80101ebd:	e8 ce 2f 00 00       	call   80104e90 <strncpy>
  de.inum = inum;
80101ec2:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ec5:	6a 10                	push   $0x10
80101ec7:	57                   	push   %edi
80101ec8:	56                   	push   %esi
80101ec9:	53                   	push   %ebx
  de.inum = inum;
80101eca:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ece:	e8 cd fb ff ff       	call   80101aa0 <writei>
80101ed3:	83 c4 20             	add    $0x20,%esp
80101ed6:	83 f8 10             	cmp    $0x10,%eax
80101ed9:	75 2a                	jne    80101f05 <dirlink+0xa5>
  return 0;
80101edb:	31 c0                	xor    %eax,%eax
}
80101edd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ee0:	5b                   	pop    %ebx
80101ee1:	5e                   	pop    %esi
80101ee2:	5f                   	pop    %edi
80101ee3:	5d                   	pop    %ebp
80101ee4:	c3                   	ret    
    iput(ip);
80101ee5:	83 ec 0c             	sub    $0xc,%esp
80101ee8:	50                   	push   %eax
80101ee9:	e8 02 f9 ff ff       	call   801017f0 <iput>
    return -1;
80101eee:	83 c4 10             	add    $0x10,%esp
80101ef1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ef6:	eb e5                	jmp    80101edd <dirlink+0x7d>
      panic("dirlink read");
80101ef8:	83 ec 0c             	sub    $0xc,%esp
80101efb:	68 75 7c 10 80       	push   $0x80107c75
80101f00:	e8 6b e4 ff ff       	call   80100370 <panic>
    panic("dirlink");
80101f05:	83 ec 0c             	sub    $0xc,%esp
80101f08:	68 42 82 10 80       	push   $0x80108242
80101f0d:	e8 5e e4 ff ff       	call   80100370 <panic>
80101f12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f20 <namei>:

struct inode*
namei(char *path)
{
80101f20:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101f21:	31 d2                	xor    %edx,%edx
{
80101f23:	89 e5                	mov    %esp,%ebp
80101f25:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80101f28:	8b 45 08             	mov    0x8(%ebp),%eax
80101f2b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101f2e:	e8 6d fd ff ff       	call   80101ca0 <namex>
}
80101f33:	c9                   	leave  
80101f34:	c3                   	ret    
80101f35:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f40 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101f40:	55                   	push   %ebp
  return namex(path, 1, name);
80101f41:	ba 01 00 00 00       	mov    $0x1,%edx
{
80101f46:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101f48:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101f4b:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101f4e:	5d                   	pop    %ebp
  return namex(path, 1, name);
80101f4f:	e9 4c fd ff ff       	jmp    80101ca0 <namex>
80101f54:	66 90                	xchg   %ax,%ax
80101f56:	66 90                	xchg   %ax,%ax
80101f58:	66 90                	xchg   %ax,%ax
80101f5a:	66 90                	xchg   %ax,%ax
80101f5c:	66 90                	xchg   %ax,%ax
80101f5e:	66 90                	xchg   %ax,%ax

80101f60 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101f60:	55                   	push   %ebp
80101f61:	89 e5                	mov    %esp,%ebp
80101f63:	57                   	push   %edi
80101f64:	56                   	push   %esi
80101f65:	53                   	push   %ebx
80101f66:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80101f69:	85 c0                	test   %eax,%eax
80101f6b:	0f 84 b4 00 00 00    	je     80102025 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101f71:	8b 58 08             	mov    0x8(%eax),%ebx
80101f74:	89 c6                	mov    %eax,%esi
80101f76:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80101f7c:	0f 87 96 00 00 00    	ja     80102018 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101f82:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80101f87:	89 f6                	mov    %esi,%esi
80101f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101f90:	89 ca                	mov    %ecx,%edx
80101f92:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101f93:	83 e0 c0             	and    $0xffffffc0,%eax
80101f96:	3c 40                	cmp    $0x40,%al
80101f98:	75 f6                	jne    80101f90 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101f9a:	31 ff                	xor    %edi,%edi
80101f9c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101fa1:	89 f8                	mov    %edi,%eax
80101fa3:	ee                   	out    %al,(%dx)
80101fa4:	b8 01 00 00 00       	mov    $0x1,%eax
80101fa9:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101fae:	ee                   	out    %al,(%dx)
80101faf:	ba f3 01 00 00       	mov    $0x1f3,%edx
80101fb4:	89 d8                	mov    %ebx,%eax
80101fb6:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80101fb7:	89 d8                	mov    %ebx,%eax
80101fb9:	ba f4 01 00 00       	mov    $0x1f4,%edx
80101fbe:	c1 f8 08             	sar    $0x8,%eax
80101fc1:	ee                   	out    %al,(%dx)
80101fc2:	ba f5 01 00 00       	mov    $0x1f5,%edx
80101fc7:	89 f8                	mov    %edi,%eax
80101fc9:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80101fca:	0f b6 46 04          	movzbl 0x4(%esi),%eax
80101fce:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101fd3:	c1 e0 04             	shl    $0x4,%eax
80101fd6:	83 e0 10             	and    $0x10,%eax
80101fd9:	83 c8 e0             	or     $0xffffffe0,%eax
80101fdc:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80101fdd:	f6 06 04             	testb  $0x4,(%esi)
80101fe0:	75 16                	jne    80101ff8 <idestart+0x98>
80101fe2:	b8 20 00 00 00       	mov    $0x20,%eax
80101fe7:	89 ca                	mov    %ecx,%edx
80101fe9:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101fea:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fed:	5b                   	pop    %ebx
80101fee:	5e                   	pop    %esi
80101fef:	5f                   	pop    %edi
80101ff0:	5d                   	pop    %ebp
80101ff1:	c3                   	ret    
80101ff2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101ff8:	b8 30 00 00 00       	mov    $0x30,%eax
80101ffd:	89 ca                	mov    %ecx,%edx
80101fff:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102000:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102005:	83 c6 18             	add    $0x18,%esi
80102008:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010200d:	fc                   	cld    
8010200e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102010:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102013:	5b                   	pop    %ebx
80102014:	5e                   	pop    %esi
80102015:	5f                   	pop    %edi
80102016:	5d                   	pop    %ebp
80102017:	c3                   	ret    
    panic("incorrect blockno");
80102018:	83 ec 0c             	sub    $0xc,%esp
8010201b:	68 e9 7c 10 80       	push   $0x80107ce9
80102020:	e8 4b e3 ff ff       	call   80100370 <panic>
    panic("idestart");
80102025:	83 ec 0c             	sub    $0xc,%esp
80102028:	68 e0 7c 10 80       	push   $0x80107ce0
8010202d:	e8 3e e3 ff ff       	call   80100370 <panic>
80102032:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102040 <ideinit>:
{
80102040:	55                   	push   %ebp
80102041:	89 e5                	mov    %esp,%ebp
80102043:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102046:	68 fb 7c 10 80       	push   $0x80107cfb
8010204b:	68 80 b5 10 80       	push   $0x8010b580
80102050:	e8 8b 2a 00 00       	call   80104ae0 <initlock>
  picenable(IRQ_IDE);
80102055:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
8010205c:	e8 ff 12 00 00       	call   80103360 <picenable>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102061:	58                   	pop    %eax
80102062:	a1 e0 28 11 80       	mov    0x801128e0,%eax
80102067:	5a                   	pop    %edx
80102068:	83 e8 01             	sub    $0x1,%eax
8010206b:	50                   	push   %eax
8010206c:	6a 0e                	push   $0xe
8010206e:	e8 bd 02 00 00       	call   80102330 <ioapicenable>
80102073:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102076:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010207b:	90                   	nop
8010207c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102080:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102081:	83 e0 c0             	and    $0xffffffc0,%eax
80102084:	3c 40                	cmp    $0x40,%al
80102086:	75 f8                	jne    80102080 <ideinit+0x40>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102088:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010208d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102092:	ee                   	out    %al,(%dx)
80102093:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102098:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010209d:	eb 06                	jmp    801020a5 <ideinit+0x65>
8010209f:	90                   	nop
  for(i=0; i<1000; i++){
801020a0:	83 e9 01             	sub    $0x1,%ecx
801020a3:	74 0f                	je     801020b4 <ideinit+0x74>
801020a5:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
801020a6:	84 c0                	test   %al,%al
801020a8:	74 f6                	je     801020a0 <ideinit+0x60>
      havedisk1 = 1;
801020aa:	c7 05 60 b5 10 80 01 	movl   $0x1,0x8010b560
801020b1:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801020b4:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
801020b9:	ba f6 01 00 00       	mov    $0x1f6,%edx
801020be:	ee                   	out    %al,(%dx)
}
801020bf:	c9                   	leave  
801020c0:	c3                   	ret    
801020c1:	eb 0d                	jmp    801020d0 <ideintr>
801020c3:	90                   	nop
801020c4:	90                   	nop
801020c5:	90                   	nop
801020c6:	90                   	nop
801020c7:	90                   	nop
801020c8:	90                   	nop
801020c9:	90                   	nop
801020ca:	90                   	nop
801020cb:	90                   	nop
801020cc:	90                   	nop
801020cd:	90                   	nop
801020ce:	90                   	nop
801020cf:	90                   	nop

801020d0 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
801020d0:	55                   	push   %ebp
801020d1:	89 e5                	mov    %esp,%ebp
801020d3:	57                   	push   %edi
801020d4:	56                   	push   %esi
801020d5:	53                   	push   %ebx
801020d6:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801020d9:	68 80 b5 10 80       	push   $0x8010b580
801020de:	e8 1d 2a 00 00       	call   80104b00 <acquire>
  if((b = idequeue) == 0){
801020e3:	8b 1d 64 b5 10 80    	mov    0x8010b564,%ebx
801020e9:	83 c4 10             	add    $0x10,%esp
801020ec:	85 db                	test   %ebx,%ebx
801020ee:	74 67                	je     80102157 <ideintr+0x87>
    release(&idelock);
    // cprintf("spurious IDE interrupt\n");
    return;
  }
  idequeue = b->qnext;
801020f0:	8b 43 14             	mov    0x14(%ebx),%eax
801020f3:	a3 64 b5 10 80       	mov    %eax,0x8010b564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801020f8:	8b 3b                	mov    (%ebx),%edi
801020fa:	f7 c7 04 00 00 00    	test   $0x4,%edi
80102100:	75 31                	jne    80102133 <ideintr+0x63>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102102:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102107:	89 f6                	mov    %esi,%esi
80102109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80102110:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102111:	89 c6                	mov    %eax,%esi
80102113:	83 e6 c0             	and    $0xffffffc0,%esi
80102116:	89 f1                	mov    %esi,%ecx
80102118:	80 f9 40             	cmp    $0x40,%cl
8010211b:	75 f3                	jne    80102110 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010211d:	a8 21                	test   $0x21,%al
8010211f:	75 12                	jne    80102133 <ideintr+0x63>
    insl(0x1f0, b->data, BSIZE/4);
80102121:	8d 7b 18             	lea    0x18(%ebx),%edi
  asm volatile("cld; rep insl" :
80102124:	b9 80 00 00 00       	mov    $0x80,%ecx
80102129:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010212e:	fc                   	cld    
8010212f:	f3 6d                	rep insl (%dx),%es:(%edi)
80102131:	8b 3b                	mov    (%ebx),%edi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102133:	83 e7 fb             	and    $0xfffffffb,%edi
  wakeup(b);
80102136:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102139:	89 f9                	mov    %edi,%ecx
8010213b:	83 c9 02             	or     $0x2,%ecx
8010213e:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
80102140:	53                   	push   %ebx
80102141:	e8 ea 21 00 00       	call   80104330 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102146:	a1 64 b5 10 80       	mov    0x8010b564,%eax
8010214b:	83 c4 10             	add    $0x10,%esp
8010214e:	85 c0                	test   %eax,%eax
80102150:	74 05                	je     80102157 <ideintr+0x87>
    idestart(idequeue);
80102152:	e8 09 fe ff ff       	call   80101f60 <idestart>
    release(&idelock);
80102157:	83 ec 0c             	sub    $0xc,%esp
8010215a:	68 80 b5 10 80       	push   $0x8010b580
8010215f:	e8 5c 2b 00 00       	call   80104cc0 <release>

  release(&idelock);
}
80102164:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102167:	5b                   	pop    %ebx
80102168:	5e                   	pop    %esi
80102169:	5f                   	pop    %edi
8010216a:	5d                   	pop    %ebp
8010216b:	c3                   	ret    
8010216c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102170 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102170:	55                   	push   %ebp
80102171:	89 e5                	mov    %esp,%ebp
80102173:	53                   	push   %ebx
80102174:	83 ec 04             	sub    $0x4,%esp
80102177:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!(b->flags & B_BUSY))
8010217a:	8b 03                	mov    (%ebx),%eax
8010217c:	a8 01                	test   $0x1,%al
8010217e:	0f 84 c0 00 00 00    	je     80102244 <iderw+0xd4>
    panic("iderw: buf not busy");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
80102184:	83 e0 06             	and    $0x6,%eax
80102187:	83 f8 02             	cmp    $0x2,%eax
8010218a:	0f 84 a7 00 00 00    	je     80102237 <iderw+0xc7>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
80102190:	8b 53 04             	mov    0x4(%ebx),%edx
80102193:	85 d2                	test   %edx,%edx
80102195:	74 0d                	je     801021a4 <iderw+0x34>
80102197:	a1 60 b5 10 80       	mov    0x8010b560,%eax
8010219c:	85 c0                	test   %eax,%eax
8010219e:	0f 84 ad 00 00 00    	je     80102251 <iderw+0xe1>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
801021a4:	83 ec 0c             	sub    $0xc,%esp
801021a7:	68 80 b5 10 80       	push   $0x8010b580
801021ac:	e8 4f 29 00 00       	call   80104b00 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801021b1:	8b 15 64 b5 10 80    	mov    0x8010b564,%edx
801021b7:	83 c4 10             	add    $0x10,%esp
  b->qnext = 0;
801021ba:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801021c1:	85 d2                	test   %edx,%edx
801021c3:	75 0d                	jne    801021d2 <iderw+0x62>
801021c5:	eb 69                	jmp    80102230 <iderw+0xc0>
801021c7:	89 f6                	mov    %esi,%esi
801021c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801021d0:	89 c2                	mov    %eax,%edx
801021d2:	8b 42 14             	mov    0x14(%edx),%eax
801021d5:	85 c0                	test   %eax,%eax
801021d7:	75 f7                	jne    801021d0 <iderw+0x60>
801021d9:	83 c2 14             	add    $0x14,%edx
    ;
  *pp = b;
801021dc:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
801021de:	39 1d 64 b5 10 80    	cmp    %ebx,0x8010b564
801021e4:	74 3a                	je     80102220 <iderw+0xb0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021e6:	8b 03                	mov    (%ebx),%eax
801021e8:	83 e0 06             	and    $0x6,%eax
801021eb:	83 f8 02             	cmp    $0x2,%eax
801021ee:	74 1b                	je     8010220b <iderw+0x9b>
    sleep(b, &idelock);
801021f0:	83 ec 08             	sub    $0x8,%esp
801021f3:	68 80 b5 10 80       	push   $0x8010b580
801021f8:	53                   	push   %ebx
801021f9:	e8 22 1f 00 00       	call   80104120 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021fe:	8b 03                	mov    (%ebx),%eax
80102200:	83 c4 10             	add    $0x10,%esp
80102203:	83 e0 06             	and    $0x6,%eax
80102206:	83 f8 02             	cmp    $0x2,%eax
80102209:	75 e5                	jne    801021f0 <iderw+0x80>
  }

  release(&idelock);
8010220b:	c7 45 08 80 b5 10 80 	movl   $0x8010b580,0x8(%ebp)
}
80102212:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102215:	c9                   	leave  
  release(&idelock);
80102216:	e9 a5 2a 00 00       	jmp    80104cc0 <release>
8010221b:	90                   	nop
8010221c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
80102220:	89 d8                	mov    %ebx,%eax
80102222:	e8 39 fd ff ff       	call   80101f60 <idestart>
80102227:	eb bd                	jmp    801021e6 <iderw+0x76>
80102229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102230:	ba 64 b5 10 80       	mov    $0x8010b564,%edx
80102235:	eb a5                	jmp    801021dc <iderw+0x6c>
    panic("iderw: nothing to do");
80102237:	83 ec 0c             	sub    $0xc,%esp
8010223a:	68 13 7d 10 80       	push   $0x80107d13
8010223f:	e8 2c e1 ff ff       	call   80100370 <panic>
    panic("iderw: buf not busy");
80102244:	83 ec 0c             	sub    $0xc,%esp
80102247:	68 ff 7c 10 80       	push   $0x80107cff
8010224c:	e8 1f e1 ff ff       	call   80100370 <panic>
    panic("iderw: ide disk 1 not present");
80102251:	83 ec 0c             	sub    $0xc,%esp
80102254:	68 28 7d 10 80       	push   $0x80107d28
80102259:	e8 12 e1 ff ff       	call   80100370 <panic>
8010225e:	66 90                	xchg   %ax,%ax

80102260 <ioapicinit>:
void
ioapicinit(void)
{
  int i, id, maxintr;

  if(!ismp)
80102260:	a1 c4 22 11 80       	mov    0x801122c4,%eax
80102265:	85 c0                	test   %eax,%eax
80102267:	0f 84 b3 00 00 00    	je     80102320 <ioapicinit+0xc0>
{
8010226d:	55                   	push   %ebp
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
8010226e:	c7 05 94 21 11 80 00 	movl   $0xfec00000,0x80112194
80102275:	00 c0 fe 
{
80102278:	89 e5                	mov    %esp,%ebp
8010227a:	56                   	push   %esi
8010227b:	53                   	push   %ebx
  ioapic->reg = reg;
8010227c:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102283:	00 00 00 
  return ioapic->data;
80102286:	a1 94 21 11 80       	mov    0x80112194,%eax
8010228b:	8b 58 10             	mov    0x10(%eax),%ebx
  ioapic->reg = reg;
8010228e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return ioapic->data;
80102294:	8b 0d 94 21 11 80    	mov    0x80112194,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010229a:	0f b6 15 c0 22 11 80 	movzbl 0x801122c0,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801022a1:	c1 eb 10             	shr    $0x10,%ebx
  return ioapic->data;
801022a4:	8b 41 10             	mov    0x10(%ecx),%eax
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801022a7:	0f b6 db             	movzbl %bl,%ebx
  id = ioapicread(REG_ID) >> 24;
801022aa:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
801022ad:	39 c2                	cmp    %eax,%edx
801022af:	75 4f                	jne    80102300 <ioapicinit+0xa0>
801022b1:	83 c3 21             	add    $0x21,%ebx
{
801022b4:	ba 10 00 00 00       	mov    $0x10,%edx
801022b9:	b8 20 00 00 00       	mov    $0x20,%eax
801022be:	66 90                	xchg   %ax,%ax
  ioapic->reg = reg;
801022c0:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
801022c2:	8b 0d 94 21 11 80    	mov    0x80112194,%ecx
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
801022c8:	89 c6                	mov    %eax,%esi
801022ca:	81 ce 00 00 01 00    	or     $0x10000,%esi
801022d0:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801022d3:	89 71 10             	mov    %esi,0x10(%ecx)
801022d6:	8d 72 01             	lea    0x1(%edx),%esi
801022d9:	83 c2 02             	add    $0x2,%edx
  for(i = 0; i <= maxintr; i++){
801022dc:	39 d8                	cmp    %ebx,%eax
  ioapic->reg = reg;
801022de:	89 31                	mov    %esi,(%ecx)
  ioapic->data = data;
801022e0:	8b 0d 94 21 11 80    	mov    0x80112194,%ecx
801022e6:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
801022ed:	75 d1                	jne    801022c0 <ioapicinit+0x60>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801022ef:	8d 65 f8             	lea    -0x8(%ebp),%esp
801022f2:	5b                   	pop    %ebx
801022f3:	5e                   	pop    %esi
801022f4:	5d                   	pop    %ebp
801022f5:	c3                   	ret    
801022f6:	8d 76 00             	lea    0x0(%esi),%esi
801022f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102300:	83 ec 0c             	sub    $0xc,%esp
80102303:	68 48 7d 10 80       	push   $0x80107d48
80102308:	e8 33 e3 ff ff       	call   80100640 <cprintf>
8010230d:	8b 0d 94 21 11 80    	mov    0x80112194,%ecx
80102313:	83 c4 10             	add    $0x10,%esp
80102316:	eb 99                	jmp    801022b1 <ioapicinit+0x51>
80102318:	90                   	nop
80102319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102320:	f3 c3                	repz ret 
80102322:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102329:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102330 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
  if(!ismp)
80102330:	8b 15 c4 22 11 80    	mov    0x801122c4,%edx
{
80102336:	55                   	push   %ebp
80102337:	89 e5                	mov    %esp,%ebp
  if(!ismp)
80102339:	85 d2                	test   %edx,%edx
{
8010233b:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!ismp)
8010233e:	74 2b                	je     8010236b <ioapicenable+0x3b>
  ioapic->reg = reg;
80102340:	8b 0d 94 21 11 80    	mov    0x80112194,%ecx
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102346:	8d 50 20             	lea    0x20(%eax),%edx
80102349:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
8010234d:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
8010234f:	8b 0d 94 21 11 80    	mov    0x80112194,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102355:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
80102358:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010235b:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
8010235e:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102360:	a1 94 21 11 80       	mov    0x80112194,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102365:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
80102368:	89 50 10             	mov    %edx,0x10(%eax)
}
8010236b:	5d                   	pop    %ebp
8010236c:	c3                   	ret    
8010236d:	66 90                	xchg   %ax,%ax
8010236f:	90                   	nop

80102370 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102370:	55                   	push   %ebp
80102371:	89 e5                	mov    %esp,%ebp
80102373:	53                   	push   %ebx
80102374:	83 ec 04             	sub    $0x4,%esp
80102377:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010237a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102380:	75 70                	jne    801023f2 <kfree+0x82>
80102382:	81 fb 40 bf 12 80    	cmp    $0x8012bf40,%ebx
80102388:	72 68                	jb     801023f2 <kfree+0x82>
8010238a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102390:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102395:	77 5b                	ja     801023f2 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102397:	83 ec 04             	sub    $0x4,%esp
8010239a:	68 00 10 00 00       	push   $0x1000
8010239f:	6a 01                	push   $0x1
801023a1:	53                   	push   %ebx
801023a2:	e8 69 29 00 00       	call   80104d10 <memset>

  if(kmem.use_lock)
801023a7:	8b 15 d4 21 11 80    	mov    0x801121d4,%edx
801023ad:	83 c4 10             	add    $0x10,%esp
801023b0:	85 d2                	test   %edx,%edx
801023b2:	75 2c                	jne    801023e0 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
801023b4:	a1 d8 21 11 80       	mov    0x801121d8,%eax
801023b9:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
801023bb:	a1 d4 21 11 80       	mov    0x801121d4,%eax
  kmem.freelist = r;
801023c0:	89 1d d8 21 11 80    	mov    %ebx,0x801121d8
  if(kmem.use_lock)
801023c6:	85 c0                	test   %eax,%eax
801023c8:	75 06                	jne    801023d0 <kfree+0x60>
    release(&kmem.lock);
}
801023ca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801023cd:	c9                   	leave  
801023ce:	c3                   	ret    
801023cf:	90                   	nop
    release(&kmem.lock);
801023d0:	c7 45 08 a0 21 11 80 	movl   $0x801121a0,0x8(%ebp)
}
801023d7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801023da:	c9                   	leave  
    release(&kmem.lock);
801023db:	e9 e0 28 00 00       	jmp    80104cc0 <release>
    acquire(&kmem.lock);
801023e0:	83 ec 0c             	sub    $0xc,%esp
801023e3:	68 a0 21 11 80       	push   $0x801121a0
801023e8:	e8 13 27 00 00       	call   80104b00 <acquire>
801023ed:	83 c4 10             	add    $0x10,%esp
801023f0:	eb c2                	jmp    801023b4 <kfree+0x44>
    panic("kfree");
801023f2:	83 ec 0c             	sub    $0xc,%esp
801023f5:	68 7a 7d 10 80       	push   $0x80107d7a
801023fa:	e8 71 df ff ff       	call   80100370 <panic>
801023ff:	90                   	nop

80102400 <freerange>:
{
80102400:	55                   	push   %ebp
80102401:	89 e5                	mov    %esp,%ebp
80102403:	56                   	push   %esi
80102404:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102405:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102408:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010240b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102411:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102417:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010241d:	39 de                	cmp    %ebx,%esi
8010241f:	72 23                	jb     80102444 <freerange+0x44>
80102421:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102428:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010242e:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102431:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102437:	50                   	push   %eax
80102438:	e8 33 ff ff ff       	call   80102370 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010243d:	83 c4 10             	add    $0x10,%esp
80102440:	39 f3                	cmp    %esi,%ebx
80102442:	76 e4                	jbe    80102428 <freerange+0x28>
}
80102444:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102447:	5b                   	pop    %ebx
80102448:	5e                   	pop    %esi
80102449:	5d                   	pop    %ebp
8010244a:	c3                   	ret    
8010244b:	90                   	nop
8010244c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102450 <kinit1>:
{
80102450:	55                   	push   %ebp
80102451:	89 e5                	mov    %esp,%ebp
80102453:	56                   	push   %esi
80102454:	53                   	push   %ebx
80102455:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102458:	83 ec 08             	sub    $0x8,%esp
8010245b:	68 80 7d 10 80       	push   $0x80107d80
80102460:	68 a0 21 11 80       	push   $0x801121a0
80102465:	e8 76 26 00 00       	call   80104ae0 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010246a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010246d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102470:	c7 05 d4 21 11 80 00 	movl   $0x0,0x801121d4
80102477:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010247a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102480:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102486:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010248c:	39 de                	cmp    %ebx,%esi
8010248e:	72 1c                	jb     801024ac <kinit1+0x5c>
    kfree(p);
80102490:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102496:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102499:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010249f:	50                   	push   %eax
801024a0:	e8 cb fe ff ff       	call   80102370 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024a5:	83 c4 10             	add    $0x10,%esp
801024a8:	39 de                	cmp    %ebx,%esi
801024aa:	73 e4                	jae    80102490 <kinit1+0x40>
}
801024ac:	8d 65 f8             	lea    -0x8(%ebp),%esp
801024af:	5b                   	pop    %ebx
801024b0:	5e                   	pop    %esi
801024b1:	5d                   	pop    %ebp
801024b2:	c3                   	ret    
801024b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801024b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801024c0 <kinit2>:
{
801024c0:	55                   	push   %ebp
801024c1:	89 e5                	mov    %esp,%ebp
801024c3:	56                   	push   %esi
801024c4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801024c5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801024c8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801024cb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801024d1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024d7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801024dd:	39 de                	cmp    %ebx,%esi
801024df:	72 23                	jb     80102504 <kinit2+0x44>
801024e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801024e8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801024ee:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024f1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801024f7:	50                   	push   %eax
801024f8:	e8 73 fe ff ff       	call   80102370 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024fd:	83 c4 10             	add    $0x10,%esp
80102500:	39 de                	cmp    %ebx,%esi
80102502:	73 e4                	jae    801024e8 <kinit2+0x28>
  kmem.use_lock = 1;
80102504:	c7 05 d4 21 11 80 01 	movl   $0x1,0x801121d4
8010250b:	00 00 00 
}
8010250e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102511:	5b                   	pop    %ebx
80102512:	5e                   	pop    %esi
80102513:	5d                   	pop    %ebp
80102514:	c3                   	ret    
80102515:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102520 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
80102520:	a1 d4 21 11 80       	mov    0x801121d4,%eax
80102525:	85 c0                	test   %eax,%eax
80102527:	75 1f                	jne    80102548 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102529:	a1 d8 21 11 80       	mov    0x801121d8,%eax
  if(r)
8010252e:	85 c0                	test   %eax,%eax
80102530:	74 0e                	je     80102540 <kalloc+0x20>
    kmem.freelist = r->next;
80102532:	8b 10                	mov    (%eax),%edx
80102534:	89 15 d8 21 11 80    	mov    %edx,0x801121d8
8010253a:	c3                   	ret    
8010253b:	90                   	nop
8010253c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
80102540:	f3 c3                	repz ret 
80102542:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
80102548:	55                   	push   %ebp
80102549:	89 e5                	mov    %esp,%ebp
8010254b:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
8010254e:	68 a0 21 11 80       	push   $0x801121a0
80102553:	e8 a8 25 00 00       	call   80104b00 <acquire>
  r = kmem.freelist;
80102558:	a1 d8 21 11 80       	mov    0x801121d8,%eax
  if(r)
8010255d:	83 c4 10             	add    $0x10,%esp
80102560:	8b 15 d4 21 11 80    	mov    0x801121d4,%edx
80102566:	85 c0                	test   %eax,%eax
80102568:	74 08                	je     80102572 <kalloc+0x52>
    kmem.freelist = r->next;
8010256a:	8b 08                	mov    (%eax),%ecx
8010256c:	89 0d d8 21 11 80    	mov    %ecx,0x801121d8
  if(kmem.use_lock)
80102572:	85 d2                	test   %edx,%edx
80102574:	74 16                	je     8010258c <kalloc+0x6c>
    release(&kmem.lock);
80102576:	83 ec 0c             	sub    $0xc,%esp
80102579:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010257c:	68 a0 21 11 80       	push   $0x801121a0
80102581:	e8 3a 27 00 00       	call   80104cc0 <release>
  return (char*)r;
80102586:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102589:	83 c4 10             	add    $0x10,%esp
}
8010258c:	c9                   	leave  
8010258d:	c3                   	ret    
8010258e:	66 90                	xchg   %ax,%ax

80102590 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102590:	ba 64 00 00 00       	mov    $0x64,%edx
80102595:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102596:	a8 01                	test   $0x1,%al
80102598:	0f 84 c2 00 00 00    	je     80102660 <kbdgetc+0xd0>
8010259e:	ba 60 00 00 00       	mov    $0x60,%edx
801025a3:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
801025a4:	0f b6 d0             	movzbl %al,%edx
801025a7:	8b 0d b4 b5 10 80    	mov    0x8010b5b4,%ecx

  if(data == 0xE0){
801025ad:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
801025b3:	0f 84 7f 00 00 00    	je     80102638 <kbdgetc+0xa8>
{
801025b9:	55                   	push   %ebp
801025ba:	89 e5                	mov    %esp,%ebp
801025bc:	53                   	push   %ebx
801025bd:	89 cb                	mov    %ecx,%ebx
801025bf:	83 e3 40             	and    $0x40,%ebx
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
801025c2:	84 c0                	test   %al,%al
801025c4:	78 4a                	js     80102610 <kbdgetc+0x80>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
801025c6:	85 db                	test   %ebx,%ebx
801025c8:	74 09                	je     801025d3 <kbdgetc+0x43>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
801025ca:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
801025cd:	83 e1 bf             	and    $0xffffffbf,%ecx
    data |= 0x80;
801025d0:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
801025d3:	0f b6 82 c0 7e 10 80 	movzbl -0x7fef8140(%edx),%eax
801025da:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
801025dc:	0f b6 82 c0 7d 10 80 	movzbl -0x7fef8240(%edx),%eax
801025e3:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
801025e5:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
801025e7:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
  c = charcode[shift & (CTL | SHIFT)][data];
801025ed:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
801025f0:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
801025f3:	8b 04 85 a0 7d 10 80 	mov    -0x7fef8260(,%eax,4),%eax
801025fa:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
801025fe:	74 31                	je     80102631 <kbdgetc+0xa1>
    if('a' <= c && c <= 'z')
80102600:	8d 50 9f             	lea    -0x61(%eax),%edx
80102603:	83 fa 19             	cmp    $0x19,%edx
80102606:	77 40                	ja     80102648 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102608:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
8010260b:	5b                   	pop    %ebx
8010260c:	5d                   	pop    %ebp
8010260d:	c3                   	ret    
8010260e:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
80102610:	83 e0 7f             	and    $0x7f,%eax
80102613:	85 db                	test   %ebx,%ebx
80102615:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
80102618:	0f b6 82 c0 7e 10 80 	movzbl -0x7fef8140(%edx),%eax
8010261f:	83 c8 40             	or     $0x40,%eax
80102622:	0f b6 c0             	movzbl %al,%eax
80102625:	f7 d0                	not    %eax
80102627:	21 c1                	and    %eax,%ecx
    return 0;
80102629:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
8010262b:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
}
80102631:	5b                   	pop    %ebx
80102632:	5d                   	pop    %ebp
80102633:	c3                   	ret    
80102634:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
80102638:	83 c9 40             	or     $0x40,%ecx
    return 0;
8010263b:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
8010263d:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
    return 0;
80102643:	c3                   	ret    
80102644:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
80102648:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
8010264b:	8d 50 20             	lea    0x20(%eax),%edx
}
8010264e:	5b                   	pop    %ebx
      c += 'a' - 'A';
8010264f:	83 f9 1a             	cmp    $0x1a,%ecx
80102652:	0f 42 c2             	cmovb  %edx,%eax
}
80102655:	5d                   	pop    %ebp
80102656:	c3                   	ret    
80102657:	89 f6                	mov    %esi,%esi
80102659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80102660:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102665:	c3                   	ret    
80102666:	8d 76 00             	lea    0x0(%esi),%esi
80102669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102670 <kbdintr>:

void
kbdintr(void)
{
80102670:	55                   	push   %ebp
80102671:	89 e5                	mov    %esp,%ebp
80102673:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102676:	68 90 25 10 80       	push   $0x80102590
8010267b:	e8 70 e1 ff ff       	call   801007f0 <consoleintr>
}
80102680:	83 c4 10             	add    $0x10,%esp
80102683:	c9                   	leave  
80102684:	c3                   	ret    
80102685:	66 90                	xchg   %ax,%ax
80102687:	66 90                	xchg   %ax,%ax
80102689:	66 90                	xchg   %ax,%ax
8010268b:	66 90                	xchg   %ax,%ax
8010268d:	66 90                	xchg   %ax,%ax
8010268f:	90                   	nop

80102690 <lapicinit>:
//PAGEBREAK!

void
lapicinit(void)
{
  if(!lapic)
80102690:	a1 dc 21 11 80       	mov    0x801121dc,%eax
{
80102695:	55                   	push   %ebp
80102696:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102698:	85 c0                	test   %eax,%eax
8010269a:	0f 84 c8 00 00 00    	je     80102768 <lapicinit+0xd8>
  lapic[index] = value;
801026a0:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
801026a7:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026aa:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026ad:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
801026b4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026b7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026ba:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
801026c1:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
801026c4:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026c7:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
801026ce:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
801026d1:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026d4:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
801026db:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801026de:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026e1:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
801026e8:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801026eb:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
801026ee:	8b 50 30             	mov    0x30(%eax),%edx
801026f1:	c1 ea 10             	shr    $0x10,%edx
801026f4:	80 fa 03             	cmp    $0x3,%dl
801026f7:	77 77                	ja     80102770 <lapicinit+0xe0>
  lapic[index] = value;
801026f9:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102700:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102703:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102706:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010270d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102710:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102713:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010271a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010271d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102720:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102727:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010272a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010272d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102734:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102737:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010273a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102741:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102744:	8b 50 20             	mov    0x20(%eax),%edx
80102747:	89 f6                	mov    %esi,%esi
80102749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102750:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102756:	80 e6 10             	and    $0x10,%dh
80102759:	75 f5                	jne    80102750 <lapicinit+0xc0>
  lapic[index] = value;
8010275b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102762:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102765:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102768:	5d                   	pop    %ebp
80102769:	c3                   	ret    
8010276a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
80102770:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102777:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010277a:	8b 50 20             	mov    0x20(%eax),%edx
8010277d:	e9 77 ff ff ff       	jmp    801026f9 <lapicinit+0x69>
80102782:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102790 <cpunum>:

int
cpunum(void)
{
80102790:	55                   	push   %ebp
80102791:	89 e5                	mov    %esp,%ebp
80102793:	56                   	push   %esi
80102794:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80102795:	9c                   	pushf  
80102796:	58                   	pop    %eax
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
80102797:	f6 c4 02             	test   $0x2,%ah
8010279a:	74 12                	je     801027ae <cpunum+0x1e>
    static int n;
    if(n++ == 0)
8010279c:	a1 b8 b5 10 80       	mov    0x8010b5b8,%eax
801027a1:	8d 50 01             	lea    0x1(%eax),%edx
801027a4:	85 c0                	test   %eax,%eax
801027a6:	89 15 b8 b5 10 80    	mov    %edx,0x8010b5b8
801027ac:	74 62                	je     80102810 <cpunum+0x80>
      cprintf("cpu called from %x with interrupts enabled\n",
        __builtin_return_address(0));
  }

  if (!lapic)
801027ae:	a1 dc 21 11 80       	mov    0x801121dc,%eax
801027b3:	85 c0                	test   %eax,%eax
801027b5:	74 49                	je     80102800 <cpunum+0x70>
    return 0;

  apicid = lapic[ID] >> 24;
801027b7:	8b 58 20             	mov    0x20(%eax),%ebx
  for (i = 0; i < ncpu; ++i) {
801027ba:	8b 35 e0 28 11 80    	mov    0x801128e0,%esi
  apicid = lapic[ID] >> 24;
801027c0:	c1 eb 18             	shr    $0x18,%ebx
  for (i = 0; i < ncpu; ++i) {
801027c3:	85 f6                	test   %esi,%esi
801027c5:	7e 5e                	jle    80102825 <cpunum+0x95>
    if (cpus[i].apicid == apicid)
801027c7:	0f b6 05 e0 22 11 80 	movzbl 0x801122e0,%eax
801027ce:	39 c3                	cmp    %eax,%ebx
801027d0:	74 2e                	je     80102800 <cpunum+0x70>
801027d2:	ba a0 23 11 80       	mov    $0x801123a0,%edx
  for (i = 0; i < ncpu; ++i) {
801027d7:	31 c0                	xor    %eax,%eax
801027d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801027e0:	83 c0 01             	add    $0x1,%eax
801027e3:	39 f0                	cmp    %esi,%eax
801027e5:	74 3e                	je     80102825 <cpunum+0x95>
    if (cpus[i].apicid == apicid)
801027e7:	0f b6 0a             	movzbl (%edx),%ecx
801027ea:	81 c2 c0 00 00 00    	add    $0xc0,%edx
801027f0:	39 d9                	cmp    %ebx,%ecx
801027f2:	75 ec                	jne    801027e0 <cpunum+0x50>
      return i;
  }
  panic("unknown apicid\n");
}
801027f4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801027f7:	5b                   	pop    %ebx
801027f8:	5e                   	pop    %esi
801027f9:	5d                   	pop    %ebp
801027fa:	c3                   	ret    
801027fb:	90                   	nop
801027fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102800:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return 0;
80102803:	31 c0                	xor    %eax,%eax
}
80102805:	5b                   	pop    %ebx
80102806:	5e                   	pop    %esi
80102807:	5d                   	pop    %ebp
80102808:	c3                   	ret    
80102809:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      cprintf("cpu called from %x with interrupts enabled\n",
80102810:	83 ec 08             	sub    $0x8,%esp
80102813:	ff 75 04             	pushl  0x4(%ebp)
80102816:	68 c0 7f 10 80       	push   $0x80107fc0
8010281b:	e8 20 de ff ff       	call   80100640 <cprintf>
80102820:	83 c4 10             	add    $0x10,%esp
80102823:	eb 89                	jmp    801027ae <cpunum+0x1e>
  panic("unknown apicid\n");
80102825:	83 ec 0c             	sub    $0xc,%esp
80102828:	68 ec 7f 10 80       	push   $0x80107fec
8010282d:	e8 3e db ff ff       	call   80100370 <panic>
80102832:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102840 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102840:	a1 dc 21 11 80       	mov    0x801121dc,%eax
{
80102845:	55                   	push   %ebp
80102846:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102848:	85 c0                	test   %eax,%eax
8010284a:	74 0d                	je     80102859 <lapiceoi+0x19>
  lapic[index] = value;
8010284c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102853:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102856:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102859:	5d                   	pop    %ebp
8010285a:	c3                   	ret    
8010285b:	90                   	nop
8010285c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102860 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102860:	55                   	push   %ebp
80102861:	89 e5                	mov    %esp,%ebp
}
80102863:	5d                   	pop    %ebp
80102864:	c3                   	ret    
80102865:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102870 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102870:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102871:	b8 0f 00 00 00       	mov    $0xf,%eax
80102876:	ba 70 00 00 00       	mov    $0x70,%edx
8010287b:	89 e5                	mov    %esp,%ebp
8010287d:	53                   	push   %ebx
8010287e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102881:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102884:	ee                   	out    %al,(%dx)
80102885:	b8 0a 00 00 00       	mov    $0xa,%eax
8010288a:	ba 71 00 00 00       	mov    $0x71,%edx
8010288f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102890:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102892:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102895:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010289b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010289d:	c1 e9 0c             	shr    $0xc,%ecx
  wrv[1] = addr >> 4;
801028a0:	c1 e8 04             	shr    $0x4,%eax
  lapicw(ICRHI, apicid<<24);
801028a3:	89 da                	mov    %ebx,%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
801028a5:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
801028a8:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
801028ae:	a1 dc 21 11 80       	mov    0x801121dc,%eax
801028b3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028b9:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028bc:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801028c3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028c6:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028c9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801028d0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028d3:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028d6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028dc:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028df:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028e5:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801028e8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028ee:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028f1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028f7:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
801028fa:	5b                   	pop    %ebx
801028fb:	5d                   	pop    %ebp
801028fc:	c3                   	ret    
801028fd:	8d 76 00             	lea    0x0(%esi),%esi

80102900 <cmostime>:
  r->year   = cmos_read(YEAR);
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
80102900:	55                   	push   %ebp
80102901:	b8 0b 00 00 00       	mov    $0xb,%eax
80102906:	ba 70 00 00 00       	mov    $0x70,%edx
8010290b:	89 e5                	mov    %esp,%ebp
8010290d:	57                   	push   %edi
8010290e:	56                   	push   %esi
8010290f:	53                   	push   %ebx
80102910:	83 ec 4c             	sub    $0x4c,%esp
80102913:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102914:	ba 71 00 00 00       	mov    $0x71,%edx
80102919:	ec                   	in     (%dx),%al
8010291a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010291d:	bb 70 00 00 00       	mov    $0x70,%ebx
80102922:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102925:	8d 76 00             	lea    0x0(%esi),%esi
80102928:	31 c0                	xor    %eax,%eax
8010292a:	89 da                	mov    %ebx,%edx
8010292c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010292d:	b9 71 00 00 00       	mov    $0x71,%ecx
80102932:	89 ca                	mov    %ecx,%edx
80102934:	ec                   	in     (%dx),%al
80102935:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102938:	89 da                	mov    %ebx,%edx
8010293a:	b8 02 00 00 00       	mov    $0x2,%eax
8010293f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102940:	89 ca                	mov    %ecx,%edx
80102942:	ec                   	in     (%dx),%al
80102943:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102946:	89 da                	mov    %ebx,%edx
80102948:	b8 04 00 00 00       	mov    $0x4,%eax
8010294d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010294e:	89 ca                	mov    %ecx,%edx
80102950:	ec                   	in     (%dx),%al
80102951:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102954:	89 da                	mov    %ebx,%edx
80102956:	b8 07 00 00 00       	mov    $0x7,%eax
8010295b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010295c:	89 ca                	mov    %ecx,%edx
8010295e:	ec                   	in     (%dx),%al
8010295f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102962:	89 da                	mov    %ebx,%edx
80102964:	b8 08 00 00 00       	mov    $0x8,%eax
80102969:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010296a:	89 ca                	mov    %ecx,%edx
8010296c:	ec                   	in     (%dx),%al
8010296d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010296f:	89 da                	mov    %ebx,%edx
80102971:	b8 09 00 00 00       	mov    $0x9,%eax
80102976:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102977:	89 ca                	mov    %ecx,%edx
80102979:	ec                   	in     (%dx),%al
8010297a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010297c:	89 da                	mov    %ebx,%edx
8010297e:	b8 0a 00 00 00       	mov    $0xa,%eax
80102983:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102984:	89 ca                	mov    %ecx,%edx
80102986:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102987:	84 c0                	test   %al,%al
80102989:	78 9d                	js     80102928 <cmostime+0x28>
  return inb(CMOS_RETURN);
8010298b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
8010298f:	89 fa                	mov    %edi,%edx
80102991:	0f b6 fa             	movzbl %dl,%edi
80102994:	89 f2                	mov    %esi,%edx
80102996:	0f b6 f2             	movzbl %dl,%esi
80102999:	89 7d c8             	mov    %edi,-0x38(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010299c:	89 da                	mov    %ebx,%edx
8010299e:	89 75 cc             	mov    %esi,-0x34(%ebp)
801029a1:	89 45 b8             	mov    %eax,-0x48(%ebp)
801029a4:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
801029a8:	89 45 bc             	mov    %eax,-0x44(%ebp)
801029ab:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
801029af:	89 45 c0             	mov    %eax,-0x40(%ebp)
801029b2:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
801029b6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
801029b9:	31 c0                	xor    %eax,%eax
801029bb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029bc:	89 ca                	mov    %ecx,%edx
801029be:	ec                   	in     (%dx),%al
801029bf:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029c2:	89 da                	mov    %ebx,%edx
801029c4:	89 45 d0             	mov    %eax,-0x30(%ebp)
801029c7:	b8 02 00 00 00       	mov    $0x2,%eax
801029cc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029cd:	89 ca                	mov    %ecx,%edx
801029cf:	ec                   	in     (%dx),%al
801029d0:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029d3:	89 da                	mov    %ebx,%edx
801029d5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801029d8:	b8 04 00 00 00       	mov    $0x4,%eax
801029dd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029de:	89 ca                	mov    %ecx,%edx
801029e0:	ec                   	in     (%dx),%al
801029e1:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029e4:	89 da                	mov    %ebx,%edx
801029e6:	89 45 d8             	mov    %eax,-0x28(%ebp)
801029e9:	b8 07 00 00 00       	mov    $0x7,%eax
801029ee:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029ef:	89 ca                	mov    %ecx,%edx
801029f1:	ec                   	in     (%dx),%al
801029f2:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029f5:	89 da                	mov    %ebx,%edx
801029f7:	89 45 dc             	mov    %eax,-0x24(%ebp)
801029fa:	b8 08 00 00 00       	mov    $0x8,%eax
801029ff:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a00:	89 ca                	mov    %ecx,%edx
80102a02:	ec                   	in     (%dx),%al
80102a03:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a06:	89 da                	mov    %ebx,%edx
80102a08:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102a0b:	b8 09 00 00 00       	mov    $0x9,%eax
80102a10:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a11:	89 ca                	mov    %ecx,%edx
80102a13:	ec                   	in     (%dx),%al
80102a14:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102a17:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102a1a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102a1d:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102a20:	6a 18                	push   $0x18
80102a22:	50                   	push   %eax
80102a23:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102a26:	50                   	push   %eax
80102a27:	e8 34 23 00 00       	call   80104d60 <memcmp>
80102a2c:	83 c4 10             	add    $0x10,%esp
80102a2f:	85 c0                	test   %eax,%eax
80102a31:	0f 85 f1 fe ff ff    	jne    80102928 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102a37:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102a3b:	75 78                	jne    80102ab5 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102a3d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102a40:	89 c2                	mov    %eax,%edx
80102a42:	83 e0 0f             	and    $0xf,%eax
80102a45:	c1 ea 04             	shr    $0x4,%edx
80102a48:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a4b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a4e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102a51:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102a54:	89 c2                	mov    %eax,%edx
80102a56:	83 e0 0f             	and    $0xf,%eax
80102a59:	c1 ea 04             	shr    $0x4,%edx
80102a5c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a5f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a62:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102a65:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102a68:	89 c2                	mov    %eax,%edx
80102a6a:	83 e0 0f             	and    $0xf,%eax
80102a6d:	c1 ea 04             	shr    $0x4,%edx
80102a70:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a73:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a76:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102a79:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102a7c:	89 c2                	mov    %eax,%edx
80102a7e:	83 e0 0f             	and    $0xf,%eax
80102a81:	c1 ea 04             	shr    $0x4,%edx
80102a84:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a87:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a8a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102a8d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102a90:	89 c2                	mov    %eax,%edx
80102a92:	83 e0 0f             	and    $0xf,%eax
80102a95:	c1 ea 04             	shr    $0x4,%edx
80102a98:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a9b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a9e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102aa1:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102aa4:	89 c2                	mov    %eax,%edx
80102aa6:	83 e0 0f             	and    $0xf,%eax
80102aa9:	c1 ea 04             	shr    $0x4,%edx
80102aac:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102aaf:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102ab2:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102ab5:	8b 75 08             	mov    0x8(%ebp),%esi
80102ab8:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102abb:	89 06                	mov    %eax,(%esi)
80102abd:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102ac0:	89 46 04             	mov    %eax,0x4(%esi)
80102ac3:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102ac6:	89 46 08             	mov    %eax,0x8(%esi)
80102ac9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102acc:	89 46 0c             	mov    %eax,0xc(%esi)
80102acf:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102ad2:	89 46 10             	mov    %eax,0x10(%esi)
80102ad5:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102ad8:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102adb:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102ae2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102ae5:	5b                   	pop    %ebx
80102ae6:	5e                   	pop    %esi
80102ae7:	5f                   	pop    %edi
80102ae8:	5d                   	pop    %ebp
80102ae9:	c3                   	ret    
80102aea:	66 90                	xchg   %ax,%ax
80102aec:	66 90                	xchg   %ax,%ax
80102aee:	66 90                	xchg   %ax,%ax

80102af0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102af0:	8b 0d 28 22 11 80    	mov    0x80112228,%ecx
80102af6:	85 c9                	test   %ecx,%ecx
80102af8:	0f 8e 8a 00 00 00    	jle    80102b88 <install_trans+0x98>
{
80102afe:	55                   	push   %ebp
80102aff:	89 e5                	mov    %esp,%ebp
80102b01:	57                   	push   %edi
80102b02:	56                   	push   %esi
80102b03:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
80102b04:	31 db                	xor    %ebx,%ebx
{
80102b06:	83 ec 0c             	sub    $0xc,%esp
80102b09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102b10:	a1 14 22 11 80       	mov    0x80112214,%eax
80102b15:	83 ec 08             	sub    $0x8,%esp
80102b18:	01 d8                	add    %ebx,%eax
80102b1a:	83 c0 01             	add    $0x1,%eax
80102b1d:	50                   	push   %eax
80102b1e:	ff 35 24 22 11 80    	pushl  0x80112224
80102b24:	e8 97 d5 ff ff       	call   801000c0 <bread>
80102b29:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102b2b:	58                   	pop    %eax
80102b2c:	5a                   	pop    %edx
80102b2d:	ff 34 9d 2c 22 11 80 	pushl  -0x7feeddd4(,%ebx,4)
80102b34:	ff 35 24 22 11 80    	pushl  0x80112224
  for (tail = 0; tail < log.lh.n; tail++) {
80102b3a:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102b3d:	e8 7e d5 ff ff       	call   801000c0 <bread>
80102b42:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102b44:	8d 47 18             	lea    0x18(%edi),%eax
80102b47:	83 c4 0c             	add    $0xc,%esp
80102b4a:	68 00 02 00 00       	push   $0x200
80102b4f:	50                   	push   %eax
80102b50:	8d 46 18             	lea    0x18(%esi),%eax
80102b53:	50                   	push   %eax
80102b54:	e8 67 22 00 00       	call   80104dc0 <memmove>
    bwrite(dbuf);  // write dst to disk
80102b59:	89 34 24             	mov    %esi,(%esp)
80102b5c:	e8 3f d6 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102b61:	89 3c 24             	mov    %edi,(%esp)
80102b64:	e8 67 d6 ff ff       	call   801001d0 <brelse>
    brelse(dbuf);
80102b69:	89 34 24             	mov    %esi,(%esp)
80102b6c:	e8 5f d6 ff ff       	call   801001d0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102b71:	83 c4 10             	add    $0x10,%esp
80102b74:	39 1d 28 22 11 80    	cmp    %ebx,0x80112228
80102b7a:	7f 94                	jg     80102b10 <install_trans+0x20>
  }
}
80102b7c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b7f:	5b                   	pop    %ebx
80102b80:	5e                   	pop    %esi
80102b81:	5f                   	pop    %edi
80102b82:	5d                   	pop    %ebp
80102b83:	c3                   	ret    
80102b84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102b88:	f3 c3                	repz ret 
80102b8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102b90 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102b90:	55                   	push   %ebp
80102b91:	89 e5                	mov    %esp,%ebp
80102b93:	53                   	push   %ebx
80102b94:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102b97:	ff 35 14 22 11 80    	pushl  0x80112214
80102b9d:	ff 35 24 22 11 80    	pushl  0x80112224
80102ba3:	e8 18 d5 ff ff       	call   801000c0 <bread>
80102ba8:	89 c3                	mov    %eax,%ebx
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102baa:	a1 28 22 11 80       	mov    0x80112228,%eax
  for (i = 0; i < log.lh.n; i++) {
80102baf:	83 c4 10             	add    $0x10,%esp
  hb->n = log.lh.n;
80102bb2:	89 43 18             	mov    %eax,0x18(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80102bb5:	a1 28 22 11 80       	mov    0x80112228,%eax
80102bba:	85 c0                	test   %eax,%eax
80102bbc:	7e 18                	jle    80102bd6 <write_head+0x46>
80102bbe:	31 d2                	xor    %edx,%edx
    hb->block[i] = log.lh.block[i];
80102bc0:	8b 0c 95 2c 22 11 80 	mov    -0x7feeddd4(,%edx,4),%ecx
80102bc7:	89 4c 93 1c          	mov    %ecx,0x1c(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102bcb:	83 c2 01             	add    $0x1,%edx
80102bce:	39 15 28 22 11 80    	cmp    %edx,0x80112228
80102bd4:	7f ea                	jg     80102bc0 <write_head+0x30>
  }
  bwrite(buf);
80102bd6:	83 ec 0c             	sub    $0xc,%esp
80102bd9:	53                   	push   %ebx
80102bda:	e8 c1 d5 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102bdf:	89 1c 24             	mov    %ebx,(%esp)
80102be2:	e8 e9 d5 ff ff       	call   801001d0 <brelse>
}
80102be7:	83 c4 10             	add    $0x10,%esp
80102bea:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102bed:	c9                   	leave  
80102bee:	c3                   	ret    
80102bef:	90                   	nop

80102bf0 <initlog>:
{
80102bf0:	55                   	push   %ebp
80102bf1:	89 e5                	mov    %esp,%ebp
80102bf3:	53                   	push   %ebx
80102bf4:	83 ec 2c             	sub    $0x2c,%esp
80102bf7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102bfa:	68 fc 7f 10 80       	push   $0x80107ffc
80102bff:	68 e0 21 11 80       	push   $0x801121e0
80102c04:	e8 d7 1e 00 00       	call   80104ae0 <initlock>
  readsb(dev, &sb);
80102c09:	58                   	pop    %eax
80102c0a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102c0d:	5a                   	pop    %edx
80102c0e:	50                   	push   %eax
80102c0f:	53                   	push   %ebx
80102c10:	e8 db e7 ff ff       	call   801013f0 <readsb>
  log.size = sb.nlog;
80102c15:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102c18:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102c1b:	59                   	pop    %ecx
  log.dev = dev;
80102c1c:	89 1d 24 22 11 80    	mov    %ebx,0x80112224
  log.size = sb.nlog;
80102c22:	89 15 18 22 11 80    	mov    %edx,0x80112218
  log.start = sb.logstart;
80102c28:	a3 14 22 11 80       	mov    %eax,0x80112214
  struct buf *buf = bread(log.dev, log.start);
80102c2d:	5a                   	pop    %edx
80102c2e:	50                   	push   %eax
80102c2f:	53                   	push   %ebx
80102c30:	e8 8b d4 ff ff       	call   801000c0 <bread>
  log.lh.n = lh->n;
80102c35:	8b 58 18             	mov    0x18(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
80102c38:	83 c4 10             	add    $0x10,%esp
80102c3b:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
80102c3d:	89 1d 28 22 11 80    	mov    %ebx,0x80112228
  for (i = 0; i < log.lh.n; i++) {
80102c43:	7e 1c                	jle    80102c61 <initlog+0x71>
80102c45:	c1 e3 02             	shl    $0x2,%ebx
80102c48:	31 d2                	xor    %edx,%edx
80102c4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    log.lh.block[i] = lh->block[i];
80102c50:	8b 4c 10 1c          	mov    0x1c(%eax,%edx,1),%ecx
80102c54:	83 c2 04             	add    $0x4,%edx
80102c57:	89 8a 28 22 11 80    	mov    %ecx,-0x7feeddd8(%edx)
  for (i = 0; i < log.lh.n; i++) {
80102c5d:	39 d3                	cmp    %edx,%ebx
80102c5f:	75 ef                	jne    80102c50 <initlog+0x60>
  brelse(buf);
80102c61:	83 ec 0c             	sub    $0xc,%esp
80102c64:	50                   	push   %eax
80102c65:	e8 66 d5 ff ff       	call   801001d0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102c6a:	e8 81 fe ff ff       	call   80102af0 <install_trans>
  log.lh.n = 0;
80102c6f:	c7 05 28 22 11 80 00 	movl   $0x0,0x80112228
80102c76:	00 00 00 
  write_head(); // clear the log
80102c79:	e8 12 ff ff ff       	call   80102b90 <write_head>
}
80102c7e:	83 c4 10             	add    $0x10,%esp
80102c81:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102c84:	c9                   	leave  
80102c85:	c3                   	ret    
80102c86:	8d 76 00             	lea    0x0(%esi),%esi
80102c89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c90 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102c90:	55                   	push   %ebp
80102c91:	89 e5                	mov    %esp,%ebp
80102c93:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102c96:	68 e0 21 11 80       	push   $0x801121e0
80102c9b:	e8 60 1e 00 00       	call   80104b00 <acquire>
80102ca0:	83 c4 10             	add    $0x10,%esp
80102ca3:	eb 18                	jmp    80102cbd <begin_op+0x2d>
80102ca5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102ca8:	83 ec 08             	sub    $0x8,%esp
80102cab:	68 e0 21 11 80       	push   $0x801121e0
80102cb0:	68 e0 21 11 80       	push   $0x801121e0
80102cb5:	e8 66 14 00 00       	call   80104120 <sleep>
80102cba:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102cbd:	a1 20 22 11 80       	mov    0x80112220,%eax
80102cc2:	85 c0                	test   %eax,%eax
80102cc4:	75 e2                	jne    80102ca8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102cc6:	a1 1c 22 11 80       	mov    0x8011221c,%eax
80102ccb:	8b 15 28 22 11 80    	mov    0x80112228,%edx
80102cd1:	83 c0 01             	add    $0x1,%eax
80102cd4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102cd7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102cda:	83 fa 1e             	cmp    $0x1e,%edx
80102cdd:	7f c9                	jg     80102ca8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102cdf:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102ce2:	a3 1c 22 11 80       	mov    %eax,0x8011221c
      release(&log.lock);
80102ce7:	68 e0 21 11 80       	push   $0x801121e0
80102cec:	e8 cf 1f 00 00       	call   80104cc0 <release>
      break;
    }
  }
}
80102cf1:	83 c4 10             	add    $0x10,%esp
80102cf4:	c9                   	leave  
80102cf5:	c3                   	ret    
80102cf6:	8d 76 00             	lea    0x0(%esi),%esi
80102cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102d00 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102d00:	55                   	push   %ebp
80102d01:	89 e5                	mov    %esp,%ebp
80102d03:	57                   	push   %edi
80102d04:	56                   	push   %esi
80102d05:	53                   	push   %ebx
80102d06:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102d09:	68 e0 21 11 80       	push   $0x801121e0
80102d0e:	e8 ed 1d 00 00       	call   80104b00 <acquire>
  log.outstanding -= 1;
80102d13:	a1 1c 22 11 80       	mov    0x8011221c,%eax
  if(log.committing)
80102d18:	8b 35 20 22 11 80    	mov    0x80112220,%esi
80102d1e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102d21:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80102d24:	85 f6                	test   %esi,%esi
  log.outstanding -= 1;
80102d26:	89 1d 1c 22 11 80    	mov    %ebx,0x8011221c
  if(log.committing)
80102d2c:	0f 85 1a 01 00 00    	jne    80102e4c <end_op+0x14c>
    panic("log.committing");
  if(log.outstanding == 0){
80102d32:	85 db                	test   %ebx,%ebx
80102d34:	0f 85 ee 00 00 00    	jne    80102e28 <end_op+0x128>
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
  }
  release(&log.lock);
80102d3a:	83 ec 0c             	sub    $0xc,%esp
    log.committing = 1;
80102d3d:	c7 05 20 22 11 80 01 	movl   $0x1,0x80112220
80102d44:	00 00 00 
  release(&log.lock);
80102d47:	68 e0 21 11 80       	push   $0x801121e0
80102d4c:	e8 6f 1f 00 00       	call   80104cc0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102d51:	8b 0d 28 22 11 80    	mov    0x80112228,%ecx
80102d57:	83 c4 10             	add    $0x10,%esp
80102d5a:	85 c9                	test   %ecx,%ecx
80102d5c:	0f 8e 85 00 00 00    	jle    80102de7 <end_op+0xe7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102d62:	a1 14 22 11 80       	mov    0x80112214,%eax
80102d67:	83 ec 08             	sub    $0x8,%esp
80102d6a:	01 d8                	add    %ebx,%eax
80102d6c:	83 c0 01             	add    $0x1,%eax
80102d6f:	50                   	push   %eax
80102d70:	ff 35 24 22 11 80    	pushl  0x80112224
80102d76:	e8 45 d3 ff ff       	call   801000c0 <bread>
80102d7b:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d7d:	58                   	pop    %eax
80102d7e:	5a                   	pop    %edx
80102d7f:	ff 34 9d 2c 22 11 80 	pushl  -0x7feeddd4(,%ebx,4)
80102d86:	ff 35 24 22 11 80    	pushl  0x80112224
  for (tail = 0; tail < log.lh.n; tail++) {
80102d8c:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d8f:	e8 2c d3 ff ff       	call   801000c0 <bread>
80102d94:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102d96:	8d 40 18             	lea    0x18(%eax),%eax
80102d99:	83 c4 0c             	add    $0xc,%esp
80102d9c:	68 00 02 00 00       	push   $0x200
80102da1:	50                   	push   %eax
80102da2:	8d 46 18             	lea    0x18(%esi),%eax
80102da5:	50                   	push   %eax
80102da6:	e8 15 20 00 00       	call   80104dc0 <memmove>
    bwrite(to);  // write the log
80102dab:	89 34 24             	mov    %esi,(%esp)
80102dae:	e8 ed d3 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102db3:	89 3c 24             	mov    %edi,(%esp)
80102db6:	e8 15 d4 ff ff       	call   801001d0 <brelse>
    brelse(to);
80102dbb:	89 34 24             	mov    %esi,(%esp)
80102dbe:	e8 0d d4 ff ff       	call   801001d0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102dc3:	83 c4 10             	add    $0x10,%esp
80102dc6:	3b 1d 28 22 11 80    	cmp    0x80112228,%ebx
80102dcc:	7c 94                	jl     80102d62 <end_op+0x62>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102dce:	e8 bd fd ff ff       	call   80102b90 <write_head>
    install_trans(); // Now install writes to home locations
80102dd3:	e8 18 fd ff ff       	call   80102af0 <install_trans>
    log.lh.n = 0;
80102dd8:	c7 05 28 22 11 80 00 	movl   $0x0,0x80112228
80102ddf:	00 00 00 
    write_head();    // Erase the transaction from the log
80102de2:	e8 a9 fd ff ff       	call   80102b90 <write_head>
    acquire(&log.lock);
80102de7:	83 ec 0c             	sub    $0xc,%esp
80102dea:	68 e0 21 11 80       	push   $0x801121e0
80102def:	e8 0c 1d 00 00       	call   80104b00 <acquire>
    wakeup(&log);
80102df4:	c7 04 24 e0 21 11 80 	movl   $0x801121e0,(%esp)
    log.committing = 0;
80102dfb:	c7 05 20 22 11 80 00 	movl   $0x0,0x80112220
80102e02:	00 00 00 
    wakeup(&log);
80102e05:	e8 26 15 00 00       	call   80104330 <wakeup>
    release(&log.lock);
80102e0a:	c7 04 24 e0 21 11 80 	movl   $0x801121e0,(%esp)
80102e11:	e8 aa 1e 00 00       	call   80104cc0 <release>
80102e16:	83 c4 10             	add    $0x10,%esp
}
80102e19:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e1c:	5b                   	pop    %ebx
80102e1d:	5e                   	pop    %esi
80102e1e:	5f                   	pop    %edi
80102e1f:	5d                   	pop    %ebp
80102e20:	c3                   	ret    
80102e21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&log);
80102e28:	83 ec 0c             	sub    $0xc,%esp
80102e2b:	68 e0 21 11 80       	push   $0x801121e0
80102e30:	e8 fb 14 00 00       	call   80104330 <wakeup>
  release(&log.lock);
80102e35:	c7 04 24 e0 21 11 80 	movl   $0x801121e0,(%esp)
80102e3c:	e8 7f 1e 00 00       	call   80104cc0 <release>
80102e41:	83 c4 10             	add    $0x10,%esp
}
80102e44:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e47:	5b                   	pop    %ebx
80102e48:	5e                   	pop    %esi
80102e49:	5f                   	pop    %edi
80102e4a:	5d                   	pop    %ebp
80102e4b:	c3                   	ret    
    panic("log.committing");
80102e4c:	83 ec 0c             	sub    $0xc,%esp
80102e4f:	68 00 80 10 80       	push   $0x80108000
80102e54:	e8 17 d5 ff ff       	call   80100370 <panic>
80102e59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102e60 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102e60:	55                   	push   %ebp
80102e61:	89 e5                	mov    %esp,%ebp
80102e63:	53                   	push   %ebx
80102e64:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102e67:	8b 15 28 22 11 80    	mov    0x80112228,%edx
{
80102e6d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102e70:	83 fa 1d             	cmp    $0x1d,%edx
80102e73:	0f 8f 9d 00 00 00    	jg     80102f16 <log_write+0xb6>
80102e79:	a1 18 22 11 80       	mov    0x80112218,%eax
80102e7e:	83 e8 01             	sub    $0x1,%eax
80102e81:	39 c2                	cmp    %eax,%edx
80102e83:	0f 8d 8d 00 00 00    	jge    80102f16 <log_write+0xb6>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102e89:	a1 1c 22 11 80       	mov    0x8011221c,%eax
80102e8e:	85 c0                	test   %eax,%eax
80102e90:	0f 8e 8d 00 00 00    	jle    80102f23 <log_write+0xc3>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102e96:	83 ec 0c             	sub    $0xc,%esp
80102e99:	68 e0 21 11 80       	push   $0x801121e0
80102e9e:	e8 5d 1c 00 00       	call   80104b00 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102ea3:	8b 0d 28 22 11 80    	mov    0x80112228,%ecx
80102ea9:	83 c4 10             	add    $0x10,%esp
80102eac:	83 f9 00             	cmp    $0x0,%ecx
80102eaf:	7e 57                	jle    80102f08 <log_write+0xa8>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102eb1:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
80102eb4:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102eb6:	3b 15 2c 22 11 80    	cmp    0x8011222c,%edx
80102ebc:	75 0b                	jne    80102ec9 <log_write+0x69>
80102ebe:	eb 38                	jmp    80102ef8 <log_write+0x98>
80102ec0:	39 14 85 2c 22 11 80 	cmp    %edx,-0x7feeddd4(,%eax,4)
80102ec7:	74 2f                	je     80102ef8 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
80102ec9:	83 c0 01             	add    $0x1,%eax
80102ecc:	39 c1                	cmp    %eax,%ecx
80102ece:	75 f0                	jne    80102ec0 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80102ed0:	89 14 85 2c 22 11 80 	mov    %edx,-0x7feeddd4(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
80102ed7:	83 c0 01             	add    $0x1,%eax
80102eda:	a3 28 22 11 80       	mov    %eax,0x80112228
  b->flags |= B_DIRTY; // prevent eviction
80102edf:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102ee2:	c7 45 08 e0 21 11 80 	movl   $0x801121e0,0x8(%ebp)
}
80102ee9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102eec:	c9                   	leave  
  release(&log.lock);
80102eed:	e9 ce 1d 00 00       	jmp    80104cc0 <release>
80102ef2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80102ef8:	89 14 85 2c 22 11 80 	mov    %edx,-0x7feeddd4(,%eax,4)
80102eff:	eb de                	jmp    80102edf <log_write+0x7f>
80102f01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f08:	8b 43 08             	mov    0x8(%ebx),%eax
80102f0b:	a3 2c 22 11 80       	mov    %eax,0x8011222c
  if (i == log.lh.n)
80102f10:	75 cd                	jne    80102edf <log_write+0x7f>
80102f12:	31 c0                	xor    %eax,%eax
80102f14:	eb c1                	jmp    80102ed7 <log_write+0x77>
    panic("too big a transaction");
80102f16:	83 ec 0c             	sub    $0xc,%esp
80102f19:	68 0f 80 10 80       	push   $0x8010800f
80102f1e:	e8 4d d4 ff ff       	call   80100370 <panic>
    panic("log_write outside of trans");
80102f23:	83 ec 0c             	sub    $0xc,%esp
80102f26:	68 25 80 10 80       	push   $0x80108025
80102f2b:	e8 40 d4 ff ff       	call   80100370 <panic>

80102f30 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102f30:	55                   	push   %ebp
80102f31:	89 e5                	mov    %esp,%ebp
80102f33:	83 ec 08             	sub    $0x8,%esp
  cprintf("cpu%d: starting\n", cpunum());
80102f36:	e8 55 f8 ff ff       	call   80102790 <cpunum>
80102f3b:	83 ec 08             	sub    $0x8,%esp
80102f3e:	50                   	push   %eax
80102f3f:	68 40 80 10 80       	push   $0x80108040
80102f44:	e8 f7 d6 ff ff       	call   80100640 <cprintf>
  idtinit();       // load idt register
80102f49:	e8 a2 31 00 00       	call   801060f0 <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
80102f4e:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102f55:	b8 01 00 00 00       	mov    $0x1,%eax
80102f5a:	f0 87 82 a8 00 00 00 	lock xchg %eax,0xa8(%edx)
  scheduler();     // start running processes
80102f61:	e8 6a 0e 00 00       	call   80103dd0 <scheduler>
80102f66:	8d 76 00             	lea    0x0(%esi),%esi
80102f69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102f70 <mpenter>:
{
80102f70:	55                   	push   %ebp
80102f71:	89 e5                	mov    %esp,%ebp
80102f73:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102f76:	e8 45 43 00 00       	call   801072c0 <switchkvm>
  seginit();
80102f7b:	e8 d0 41 00 00       	call   80107150 <seginit>
  lapicinit();
80102f80:	e8 0b f7 ff ff       	call   80102690 <lapicinit>
  mpmain();
80102f85:	e8 a6 ff ff ff       	call   80102f30 <mpmain>
80102f8a:	66 90                	xchg   %ax,%ax
80102f8c:	66 90                	xchg   %ax,%ax
80102f8e:	66 90                	xchg   %ax,%ax

80102f90 <main>:
{
80102f90:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102f94:	83 e4 f0             	and    $0xfffffff0,%esp
80102f97:	ff 71 fc             	pushl  -0x4(%ecx)
80102f9a:	55                   	push   %ebp
80102f9b:	89 e5                	mov    %esp,%ebp
80102f9d:	53                   	push   %ebx
80102f9e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102f9f:	83 ec 08             	sub    $0x8,%esp
80102fa2:	68 00 00 40 80       	push   $0x80400000
80102fa7:	68 40 bf 12 80       	push   $0x8012bf40
80102fac:	e8 9f f4 ff ff       	call   80102450 <kinit1>
  kvmalloc();      // kernel page table
80102fb1:	e8 ea 42 00 00       	call   801072a0 <kvmalloc>
  mpinit();        // detect other processors
80102fb6:	e8 b5 01 00 00       	call   80103170 <mpinit>
  lapicinit();     // interrupt controller
80102fbb:	e8 d0 f6 ff ff       	call   80102690 <lapicinit>
  seginit();       // segment descriptors
80102fc0:	e8 8b 41 00 00       	call   80107150 <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpunum());
80102fc5:	e8 c6 f7 ff ff       	call   80102790 <cpunum>
80102fca:	5a                   	pop    %edx
80102fcb:	59                   	pop    %ecx
80102fcc:	50                   	push   %eax
80102fcd:	68 51 80 10 80       	push   $0x80108051
80102fd2:	e8 69 d6 ff ff       	call   80100640 <cprintf>
  picinit();       // another interrupt controller
80102fd7:	e8 b4 03 00 00       	call   80103390 <picinit>
  ioapicinit();    // another interrupt controller
80102fdc:	e8 7f f2 ff ff       	call   80102260 <ioapicinit>
  consoleinit();   // console hardware
80102fe1:	e8 ba d9 ff ff       	call   801009a0 <consoleinit>
  uartinit();      // serial port
80102fe6:	e8 b5 34 00 00       	call   801064a0 <uartinit>
  pinit();         // process table
80102feb:	e8 90 08 00 00       	call   80103880 <pinit>
  tvinit();        // trap vectors
80102ff0:	e8 7b 30 00 00       	call   80106070 <tvinit>
  binit();         // buffer cache
80102ff5:	e8 46 d0 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80102ffa:	e8 a1 dd ff ff       	call   80100da0 <fileinit>
  ideinit();       // disk
80102fff:	e8 3c f0 ff ff       	call   80102040 <ideinit>
  if(!ismp)
80103004:	8b 1d c4 22 11 80    	mov    0x801122c4,%ebx
8010300a:	83 c4 10             	add    $0x10,%esp
8010300d:	85 db                	test   %ebx,%ebx
8010300f:	0f 84 cb 00 00 00    	je     801030e0 <main+0x150>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103015:	83 ec 04             	sub    $0x4,%esp
80103018:	68 8a 00 00 00       	push   $0x8a
8010301d:	68 8c b4 10 80       	push   $0x8010b48c
80103022:	68 00 70 00 80       	push   $0x80007000
80103027:	e8 94 1d 00 00       	call   80104dc0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
8010302c:	a1 e0 28 11 80       	mov    0x801128e0,%eax
80103031:	83 c4 10             	add    $0x10,%esp
80103034:	8d 04 40             	lea    (%eax,%eax,2),%eax
80103037:	c1 e0 06             	shl    $0x6,%eax
8010303a:	05 e0 22 11 80       	add    $0x801122e0,%eax
8010303f:	3d e0 22 11 80       	cmp    $0x801122e0,%eax
80103044:	76 7e                	jbe    801030c4 <main+0x134>
80103046:	bb e0 22 11 80       	mov    $0x801122e0,%ebx
8010304b:	90                   	nop
8010304c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(c == cpus+cpunum())  // We've started already.
80103050:	e8 3b f7 ff ff       	call   80102790 <cpunum>
80103055:	8d 04 40             	lea    (%eax,%eax,2),%eax
80103058:	c1 e0 06             	shl    $0x6,%eax
8010305b:	05 e0 22 11 80       	add    $0x801122e0,%eax
80103060:	39 c3                	cmp    %eax,%ebx
80103062:	74 46                	je     801030aa <main+0x11a>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103064:	e8 b7 f4 ff ff       	call   80102520 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void**)(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103069:	83 ec 08             	sub    $0x8,%esp
    *(void**)(code-4) = stack + KSTACKSIZE;
8010306c:	05 00 10 00 00       	add    $0x1000,%eax
    *(void**)(code-8) = mpenter;
80103071:	c7 05 f8 6f 00 80 70 	movl   $0x80102f70,0x80006ff8
80103078:	2f 10 80 
    *(void**)(code-4) = stack + KSTACKSIZE;
8010307b:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103080:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
80103087:	a0 10 00 
    lapicstartap(c->apicid, V2P(code));
8010308a:	68 00 70 00 00       	push   $0x7000
8010308f:	0f b6 03             	movzbl (%ebx),%eax
80103092:	50                   	push   %eax
80103093:	e8 d8 f7 ff ff       	call   80102870 <lapicstartap>
80103098:	83 c4 10             	add    $0x10,%esp
8010309b:	90                   	nop
8010309c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

    // wait for cpu to finish mpmain()
    while(c->started == 0)
801030a0:	8b 83 a8 00 00 00    	mov    0xa8(%ebx),%eax
801030a6:	85 c0                	test   %eax,%eax
801030a8:	74 f6                	je     801030a0 <main+0x110>
  for(c = cpus; c < cpus+ncpu; c++){
801030aa:	a1 e0 28 11 80       	mov    0x801128e0,%eax
801030af:	81 c3 c0 00 00 00    	add    $0xc0,%ebx
801030b5:	8d 04 40             	lea    (%eax,%eax,2),%eax
801030b8:	c1 e0 06             	shl    $0x6,%eax
801030bb:	05 e0 22 11 80       	add    $0x801122e0,%eax
801030c0:	39 c3                	cmp    %eax,%ebx
801030c2:	72 8c                	jb     80103050 <main+0xc0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
801030c4:	83 ec 08             	sub    $0x8,%esp
801030c7:	68 00 00 00 8e       	push   $0x8e000000
801030cc:	68 00 00 40 80       	push   $0x80400000
801030d1:	e8 ea f3 ff ff       	call   801024c0 <kinit2>
  userinit();      // first user process
801030d6:	e8 85 09 00 00       	call   80103a60 <userinit>
  mpmain();        // finish this processor's setup
801030db:	e8 50 fe ff ff       	call   80102f30 <mpmain>
    timerinit();   // uniprocessor timer
801030e0:	e8 2b 2f 00 00       	call   80106010 <timerinit>
801030e5:	e9 2b ff ff ff       	jmp    80103015 <main+0x85>
801030ea:	66 90                	xchg   %ax,%ax
801030ec:	66 90                	xchg   %ax,%ax
801030ee:	66 90                	xchg   %ax,%ax

801030f0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801030f0:	55                   	push   %ebp
801030f1:	89 e5                	mov    %esp,%ebp
801030f3:	57                   	push   %edi
801030f4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
801030f5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
801030fb:	53                   	push   %ebx
  e = addr+len;
801030fc:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
801030ff:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103102:	39 de                	cmp    %ebx,%esi
80103104:	72 10                	jb     80103116 <mpsearch1+0x26>
80103106:	eb 50                	jmp    80103158 <mpsearch1+0x68>
80103108:	90                   	nop
80103109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103110:	39 fb                	cmp    %edi,%ebx
80103112:	89 fe                	mov    %edi,%esi
80103114:	76 42                	jbe    80103158 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103116:	83 ec 04             	sub    $0x4,%esp
80103119:	8d 7e 10             	lea    0x10(%esi),%edi
8010311c:	6a 04                	push   $0x4
8010311e:	68 68 80 10 80       	push   $0x80108068
80103123:	56                   	push   %esi
80103124:	e8 37 1c 00 00       	call   80104d60 <memcmp>
80103129:	83 c4 10             	add    $0x10,%esp
8010312c:	85 c0                	test   %eax,%eax
8010312e:	75 e0                	jne    80103110 <mpsearch1+0x20>
80103130:	89 f1                	mov    %esi,%ecx
80103132:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103138:	0f b6 11             	movzbl (%ecx),%edx
8010313b:	83 c1 01             	add    $0x1,%ecx
8010313e:	01 d0                	add    %edx,%eax
  for(i=0; i<len; i++)
80103140:	39 f9                	cmp    %edi,%ecx
80103142:	75 f4                	jne    80103138 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103144:	84 c0                	test   %al,%al
80103146:	75 c8                	jne    80103110 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103148:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010314b:	89 f0                	mov    %esi,%eax
8010314d:	5b                   	pop    %ebx
8010314e:	5e                   	pop    %esi
8010314f:	5f                   	pop    %edi
80103150:	5d                   	pop    %ebp
80103151:	c3                   	ret    
80103152:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103158:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010315b:	31 f6                	xor    %esi,%esi
}
8010315d:	89 f0                	mov    %esi,%eax
8010315f:	5b                   	pop    %ebx
80103160:	5e                   	pop    %esi
80103161:	5f                   	pop    %edi
80103162:	5d                   	pop    %ebp
80103163:	c3                   	ret    
80103164:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010316a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103170 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103170:	55                   	push   %ebp
80103171:	89 e5                	mov    %esp,%ebp
80103173:	57                   	push   %edi
80103174:	56                   	push   %esi
80103175:	53                   	push   %ebx
80103176:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103179:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103180:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103187:	c1 e0 08             	shl    $0x8,%eax
8010318a:	09 d0                	or     %edx,%eax
8010318c:	c1 e0 04             	shl    $0x4,%eax
8010318f:	85 c0                	test   %eax,%eax
80103191:	75 1b                	jne    801031ae <mpinit+0x3e>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103193:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010319a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
801031a1:	c1 e0 08             	shl    $0x8,%eax
801031a4:	09 d0                	or     %edx,%eax
801031a6:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
801031a9:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
801031ae:	ba 00 04 00 00       	mov    $0x400,%edx
801031b3:	e8 38 ff ff ff       	call   801030f0 <mpsearch1>
801031b8:	85 c0                	test   %eax,%eax
801031ba:	89 c7                	mov    %eax,%edi
801031bc:	0f 84 76 01 00 00    	je     80103338 <mpinit+0x1c8>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801031c2:	8b 5f 04             	mov    0x4(%edi),%ebx
801031c5:	85 db                	test   %ebx,%ebx
801031c7:	0f 84 e6 00 00 00    	je     801032b3 <mpinit+0x143>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801031cd:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
801031d3:	83 ec 04             	sub    $0x4,%esp
801031d6:	6a 04                	push   $0x4
801031d8:	68 6d 80 10 80       	push   $0x8010806d
801031dd:	56                   	push   %esi
801031de:	e8 7d 1b 00 00       	call   80104d60 <memcmp>
801031e3:	83 c4 10             	add    $0x10,%esp
801031e6:	85 c0                	test   %eax,%eax
801031e8:	0f 85 c5 00 00 00    	jne    801032b3 <mpinit+0x143>
  if(conf->version != 1 && conf->version != 4)
801031ee:	0f b6 93 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%edx
801031f5:	80 fa 01             	cmp    $0x1,%dl
801031f8:	0f 95 c1             	setne  %cl
801031fb:	80 fa 04             	cmp    $0x4,%dl
801031fe:	0f 95 c2             	setne  %dl
80103201:	20 ca                	and    %cl,%dl
80103203:	0f 85 aa 00 00 00    	jne    801032b3 <mpinit+0x143>
  if(sum((uchar*)conf, conf->length) != 0)
80103209:	0f b7 8b 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%ecx
  for(i=0; i<len; i++)
80103210:	66 85 c9             	test   %cx,%cx
80103213:	74 1f                	je     80103234 <mpinit+0xc4>
80103215:	01 f1                	add    %esi,%ecx
80103217:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
8010321a:	89 f2                	mov    %esi,%edx
8010321c:	89 cb                	mov    %ecx,%ebx
8010321e:	66 90                	xchg   %ax,%ax
    sum += addr[i];
80103220:	0f b6 0a             	movzbl (%edx),%ecx
80103223:	83 c2 01             	add    $0x1,%edx
80103226:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103228:	39 da                	cmp    %ebx,%edx
8010322a:	75 f4                	jne    80103220 <mpinit+0xb0>
8010322c:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010322f:	84 c0                	test   %al,%al
80103231:	0f 95 c2             	setne  %dl
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103234:	85 f6                	test   %esi,%esi
80103236:	74 7b                	je     801032b3 <mpinit+0x143>
80103238:	84 d2                	test   %dl,%dl
8010323a:	75 77                	jne    801032b3 <mpinit+0x143>
    return;
  ismp = 1;
8010323c:	c7 05 c4 22 11 80 01 	movl   $0x1,0x801122c4
80103243:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
80103246:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
8010324c:	a3 dc 21 11 80       	mov    %eax,0x801121dc
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103251:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
80103258:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
8010325e:	01 d6                	add    %edx,%esi
80103260:	39 f0                	cmp    %esi,%eax
80103262:	0f 83 a8 00 00 00    	jae    80103310 <mpinit+0x1a0>
80103268:	90                   	nop
80103269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(*p){
80103270:	80 38 04             	cmpb   $0x4,(%eax)
80103273:	0f 87 87 00 00 00    	ja     80103300 <mpinit+0x190>
80103279:	0f b6 10             	movzbl (%eax),%edx
8010327c:	ff 24 95 74 80 10 80 	jmp    *-0x7fef7f8c(,%edx,4)
80103283:	90                   	nop
80103284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103288:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010328b:	39 c6                	cmp    %eax,%esi
8010328d:	77 e1                	ja     80103270 <mpinit+0x100>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp){
8010328f:	a1 c4 22 11 80       	mov    0x801122c4,%eax
80103294:	85 c0                	test   %eax,%eax
80103296:	75 78                	jne    80103310 <mpinit+0x1a0>
    // Didn't like what we found; fall back to no MP.
    ncpu = 1;
80103298:	c7 05 e0 28 11 80 01 	movl   $0x1,0x801128e0
8010329f:	00 00 00 
    lapic = 0;
801032a2:	c7 05 dc 21 11 80 00 	movl   $0x0,0x801121dc
801032a9:	00 00 00 
    ioapicid = 0;
801032ac:	c6 05 c0 22 11 80 00 	movb   $0x0,0x801122c0
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
801032b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801032b6:	5b                   	pop    %ebx
801032b7:	5e                   	pop    %esi
801032b8:	5f                   	pop    %edi
801032b9:	5d                   	pop    %ebp
801032ba:	c3                   	ret    
801032bb:	90                   	nop
801032bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(ncpu < NCPU) {
801032c0:	8b 15 e0 28 11 80    	mov    0x801128e0,%edx
801032c6:	83 fa 07             	cmp    $0x7,%edx
801032c9:	7f 19                	jg     801032e4 <mpinit+0x174>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801032cb:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
801032cf:	8d 1c 52             	lea    (%edx,%edx,2),%ebx
        ncpu++;
801032d2:	83 c2 01             	add    $0x1,%edx
801032d5:	89 15 e0 28 11 80    	mov    %edx,0x801128e0
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801032db:	c1 e3 06             	shl    $0x6,%ebx
801032de:	88 8b e0 22 11 80    	mov    %cl,-0x7feedd20(%ebx)
      p += sizeof(struct mpproc);
801032e4:	83 c0 14             	add    $0x14,%eax
      continue;
801032e7:	eb a2                	jmp    8010328b <mpinit+0x11b>
801032e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
801032f0:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
801032f4:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
801032f7:	88 15 c0 22 11 80    	mov    %dl,0x801122c0
      continue;
801032fd:	eb 8c                	jmp    8010328b <mpinit+0x11b>
801032ff:	90                   	nop
      ismp = 0;
80103300:	c7 05 c4 22 11 80 00 	movl   $0x0,0x801122c4
80103307:	00 00 00 
      break;
8010330a:	e9 7c ff ff ff       	jmp    8010328b <mpinit+0x11b>
8010330f:	90                   	nop
  if(mp->imcrp){
80103310:	80 7f 0c 00          	cmpb   $0x0,0xc(%edi)
80103314:	74 9d                	je     801032b3 <mpinit+0x143>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103316:	b8 70 00 00 00       	mov    $0x70,%eax
8010331b:	ba 22 00 00 00       	mov    $0x22,%edx
80103320:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103321:	ba 23 00 00 00       	mov    $0x23,%edx
80103326:	ec                   	in     (%dx),%al
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103327:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010332a:	ee                   	out    %al,(%dx)
}
8010332b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010332e:	5b                   	pop    %ebx
8010332f:	5e                   	pop    %esi
80103330:	5f                   	pop    %edi
80103331:	5d                   	pop    %ebp
80103332:	c3                   	ret    
80103333:	90                   	nop
80103334:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return mpsearch1(0xF0000, 0x10000);
80103338:	ba 00 00 01 00       	mov    $0x10000,%edx
8010333d:	b8 00 00 0f 00       	mov    $0xf0000,%eax
80103342:	e8 a9 fd ff ff       	call   801030f0 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103347:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
80103349:	89 c7                	mov    %eax,%edi
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
8010334b:	0f 85 71 fe ff ff    	jne    801031c2 <mpinit+0x52>
80103351:	e9 5d ff ff ff       	jmp    801032b3 <mpinit+0x143>
80103356:	66 90                	xchg   %ax,%ax
80103358:	66 90                	xchg   %ax,%ax
8010335a:	66 90                	xchg   %ax,%ax
8010335c:	66 90                	xchg   %ax,%ax
8010335e:	66 90                	xchg   %ax,%ax

80103360 <picenable>:
  outb(IO_PIC2+1, mask >> 8);
}

void
picenable(int irq)
{
80103360:	55                   	push   %ebp
  picsetmask(irqmask & ~(1<<irq));
80103361:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
80103366:	ba 21 00 00 00       	mov    $0x21,%edx
{
8010336b:	89 e5                	mov    %esp,%ebp
  picsetmask(irqmask & ~(1<<irq));
8010336d:	8b 4d 08             	mov    0x8(%ebp),%ecx
80103370:	d3 c0                	rol    %cl,%eax
80103372:	66 23 05 00 b0 10 80 	and    0x8010b000,%ax
  irqmask = mask;
80103379:	66 a3 00 b0 10 80    	mov    %ax,0x8010b000
8010337f:	ee                   	out    %al,(%dx)
80103380:	ba a1 00 00 00       	mov    $0xa1,%edx
  outb(IO_PIC2+1, mask >> 8);
80103385:	66 c1 e8 08          	shr    $0x8,%ax
80103389:	ee                   	out    %al,(%dx)
}
8010338a:	5d                   	pop    %ebp
8010338b:	c3                   	ret    
8010338c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103390 <picinit>:

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
80103390:	55                   	push   %ebp
80103391:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103396:	89 e5                	mov    %esp,%ebp
80103398:	57                   	push   %edi
80103399:	56                   	push   %esi
8010339a:	53                   	push   %ebx
8010339b:	bb 21 00 00 00       	mov    $0x21,%ebx
801033a0:	89 da                	mov    %ebx,%edx
801033a2:	ee                   	out    %al,(%dx)
801033a3:	b9 a1 00 00 00       	mov    $0xa1,%ecx
801033a8:	89 ca                	mov    %ecx,%edx
801033aa:	ee                   	out    %al,(%dx)
801033ab:	be 11 00 00 00       	mov    $0x11,%esi
801033b0:	ba 20 00 00 00       	mov    $0x20,%edx
801033b5:	89 f0                	mov    %esi,%eax
801033b7:	ee                   	out    %al,(%dx)
801033b8:	b8 20 00 00 00       	mov    $0x20,%eax
801033bd:	89 da                	mov    %ebx,%edx
801033bf:	ee                   	out    %al,(%dx)
801033c0:	b8 04 00 00 00       	mov    $0x4,%eax
801033c5:	ee                   	out    %al,(%dx)
801033c6:	bf 03 00 00 00       	mov    $0x3,%edi
801033cb:	89 f8                	mov    %edi,%eax
801033cd:	ee                   	out    %al,(%dx)
801033ce:	ba a0 00 00 00       	mov    $0xa0,%edx
801033d3:	89 f0                	mov    %esi,%eax
801033d5:	ee                   	out    %al,(%dx)
801033d6:	b8 28 00 00 00       	mov    $0x28,%eax
801033db:	89 ca                	mov    %ecx,%edx
801033dd:	ee                   	out    %al,(%dx)
801033de:	b8 02 00 00 00       	mov    $0x2,%eax
801033e3:	ee                   	out    %al,(%dx)
801033e4:	89 f8                	mov    %edi,%eax
801033e6:	ee                   	out    %al,(%dx)
801033e7:	bf 68 00 00 00       	mov    $0x68,%edi
801033ec:	ba 20 00 00 00       	mov    $0x20,%edx
801033f1:	89 f8                	mov    %edi,%eax
801033f3:	ee                   	out    %al,(%dx)
801033f4:	be 0a 00 00 00       	mov    $0xa,%esi
801033f9:	89 f0                	mov    %esi,%eax
801033fb:	ee                   	out    %al,(%dx)
801033fc:	ba a0 00 00 00       	mov    $0xa0,%edx
80103401:	89 f8                	mov    %edi,%eax
80103403:	ee                   	out    %al,(%dx)
80103404:	89 f0                	mov    %esi,%eax
80103406:	ee                   	out    %al,(%dx)
  outb(IO_PIC1, 0x0a);             // read IRR by default

  outb(IO_PIC2, 0x68);             // OCW3
  outb(IO_PIC2, 0x0a);             // OCW3

  if(irqmask != 0xFFFF)
80103407:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
8010340e:	66 83 f8 ff          	cmp    $0xffff,%ax
80103412:	74 0a                	je     8010341e <picinit+0x8e>
80103414:	89 da                	mov    %ebx,%edx
80103416:	ee                   	out    %al,(%dx)
  outb(IO_PIC2+1, mask >> 8);
80103417:	66 c1 e8 08          	shr    $0x8,%ax
8010341b:	89 ca                	mov    %ecx,%edx
8010341d:	ee                   	out    %al,(%dx)
    picsetmask(irqmask);
}
8010341e:	5b                   	pop    %ebx
8010341f:	5e                   	pop    %esi
80103420:	5f                   	pop    %edi
80103421:	5d                   	pop    %ebp
80103422:	c3                   	ret    
80103423:	66 90                	xchg   %ax,%ax
80103425:	66 90                	xchg   %ax,%ax
80103427:	66 90                	xchg   %ax,%ax
80103429:	66 90                	xchg   %ax,%ax
8010342b:	66 90                	xchg   %ax,%ax
8010342d:	66 90                	xchg   %ax,%ax
8010342f:	90                   	nop

80103430 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103430:	55                   	push   %ebp
80103431:	89 e5                	mov    %esp,%ebp
80103433:	57                   	push   %edi
80103434:	56                   	push   %esi
80103435:	53                   	push   %ebx
80103436:	83 ec 0c             	sub    $0xc,%esp
80103439:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010343c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010343f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103445:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010344b:	e8 70 d9 ff ff       	call   80100dc0 <filealloc>
80103450:	85 c0                	test   %eax,%eax
80103452:	89 03                	mov    %eax,(%ebx)
80103454:	74 22                	je     80103478 <pipealloc+0x48>
80103456:	e8 65 d9 ff ff       	call   80100dc0 <filealloc>
8010345b:	85 c0                	test   %eax,%eax
8010345d:	89 06                	mov    %eax,(%esi)
8010345f:	74 3f                	je     801034a0 <pipealloc+0x70>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103461:	e8 ba f0 ff ff       	call   80102520 <kalloc>
80103466:	85 c0                	test   %eax,%eax
80103468:	89 c7                	mov    %eax,%edi
8010346a:	75 54                	jne    801034c0 <pipealloc+0x90>

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
8010346c:	8b 03                	mov    (%ebx),%eax
8010346e:	85 c0                	test   %eax,%eax
80103470:	75 34                	jne    801034a6 <pipealloc+0x76>
80103472:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fileclose(*f0);
  if(*f1)
80103478:	8b 06                	mov    (%esi),%eax
8010347a:	85 c0                	test   %eax,%eax
8010347c:	74 0c                	je     8010348a <pipealloc+0x5a>
    fileclose(*f1);
8010347e:	83 ec 0c             	sub    $0xc,%esp
80103481:	50                   	push   %eax
80103482:	e8 f9 d9 ff ff       	call   80100e80 <fileclose>
80103487:	83 c4 10             	add    $0x10,%esp
  return -1;
}
8010348a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010348d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103492:	5b                   	pop    %ebx
80103493:	5e                   	pop    %esi
80103494:	5f                   	pop    %edi
80103495:	5d                   	pop    %ebp
80103496:	c3                   	ret    
80103497:	89 f6                	mov    %esi,%esi
80103499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(*f0)
801034a0:	8b 03                	mov    (%ebx),%eax
801034a2:	85 c0                	test   %eax,%eax
801034a4:	74 e4                	je     8010348a <pipealloc+0x5a>
    fileclose(*f0);
801034a6:	83 ec 0c             	sub    $0xc,%esp
801034a9:	50                   	push   %eax
801034aa:	e8 d1 d9 ff ff       	call   80100e80 <fileclose>
  if(*f1)
801034af:	8b 06                	mov    (%esi),%eax
    fileclose(*f0);
801034b1:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801034b4:	85 c0                	test   %eax,%eax
801034b6:	75 c6                	jne    8010347e <pipealloc+0x4e>
801034b8:	eb d0                	jmp    8010348a <pipealloc+0x5a>
801034ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  initlock(&p->lock, "pipe");
801034c0:	83 ec 08             	sub    $0x8,%esp
  p->readopen = 1;
801034c3:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801034ca:	00 00 00 
  p->writeopen = 1;
801034cd:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801034d4:	00 00 00 
  p->nwrite = 0;
801034d7:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801034de:	00 00 00 
  p->nread = 0;
801034e1:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801034e8:	00 00 00 
  initlock(&p->lock, "pipe");
801034eb:	68 88 80 10 80       	push   $0x80108088
801034f0:	50                   	push   %eax
801034f1:	e8 ea 15 00 00       	call   80104ae0 <initlock>
  (*f0)->type = FD_PIPE;
801034f6:	8b 03                	mov    (%ebx),%eax
  return 0;
801034f8:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
801034fb:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103501:	8b 03                	mov    (%ebx),%eax
80103503:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103507:	8b 03                	mov    (%ebx),%eax
80103509:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
8010350d:	8b 03                	mov    (%ebx),%eax
8010350f:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103512:	8b 06                	mov    (%esi),%eax
80103514:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
8010351a:	8b 06                	mov    (%esi),%eax
8010351c:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103520:	8b 06                	mov    (%esi),%eax
80103522:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103526:	8b 06                	mov    (%esi),%eax
80103528:	89 78 0c             	mov    %edi,0xc(%eax)
}
8010352b:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010352e:	31 c0                	xor    %eax,%eax
}
80103530:	5b                   	pop    %ebx
80103531:	5e                   	pop    %esi
80103532:	5f                   	pop    %edi
80103533:	5d                   	pop    %ebp
80103534:	c3                   	ret    
80103535:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103540 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103540:	55                   	push   %ebp
80103541:	89 e5                	mov    %esp,%ebp
80103543:	56                   	push   %esi
80103544:	53                   	push   %ebx
80103545:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103548:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010354b:	83 ec 0c             	sub    $0xc,%esp
8010354e:	53                   	push   %ebx
8010354f:	e8 ac 15 00 00       	call   80104b00 <acquire>
  if(writable){
80103554:	83 c4 10             	add    $0x10,%esp
80103557:	85 f6                	test   %esi,%esi
80103559:	74 45                	je     801035a0 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010355b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103561:	83 ec 0c             	sub    $0xc,%esp
    p->writeopen = 0;
80103564:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010356b:	00 00 00 
    wakeup(&p->nread);
8010356e:	50                   	push   %eax
8010356f:	e8 bc 0d 00 00       	call   80104330 <wakeup>
80103574:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103577:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010357d:	85 d2                	test   %edx,%edx
8010357f:	75 0a                	jne    8010358b <pipeclose+0x4b>
80103581:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103587:	85 c0                	test   %eax,%eax
80103589:	74 35                	je     801035c0 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010358b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010358e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103591:	5b                   	pop    %ebx
80103592:	5e                   	pop    %esi
80103593:	5d                   	pop    %ebp
    release(&p->lock);
80103594:	e9 27 17 00 00       	jmp    80104cc0 <release>
80103599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
801035a0:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
801035a6:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
801035a9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801035b0:	00 00 00 
    wakeup(&p->nwrite);
801035b3:	50                   	push   %eax
801035b4:	e8 77 0d 00 00       	call   80104330 <wakeup>
801035b9:	83 c4 10             	add    $0x10,%esp
801035bc:	eb b9                	jmp    80103577 <pipeclose+0x37>
801035be:	66 90                	xchg   %ax,%ax
    release(&p->lock);
801035c0:	83 ec 0c             	sub    $0xc,%esp
801035c3:	53                   	push   %ebx
801035c4:	e8 f7 16 00 00       	call   80104cc0 <release>
    kfree((char*)p);
801035c9:	89 5d 08             	mov    %ebx,0x8(%ebp)
801035cc:	83 c4 10             	add    $0x10,%esp
}
801035cf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801035d2:	5b                   	pop    %ebx
801035d3:	5e                   	pop    %esi
801035d4:	5d                   	pop    %ebp
    kfree((char*)p);
801035d5:	e9 96 ed ff ff       	jmp    80102370 <kfree>
801035da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801035e0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801035e0:	55                   	push   %ebp
801035e1:	89 e5                	mov    %esp,%ebp
801035e3:	57                   	push   %edi
801035e4:	56                   	push   %esi
801035e5:	53                   	push   %ebx
801035e6:	83 ec 28             	sub    $0x28,%esp
801035e9:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i;

  acquire(&p->lock);
801035ec:	57                   	push   %edi
801035ed:	e8 0e 15 00 00       	call   80104b00 <acquire>
  for(i = 0; i < n; i++){
801035f2:	8b 45 10             	mov    0x10(%ebp),%eax
801035f5:	83 c4 10             	add    $0x10,%esp
801035f8:	85 c0                	test   %eax,%eax
801035fa:	0f 8e c6 00 00 00    	jle    801036c6 <pipewrite+0xe6>
80103600:	8b 45 0c             	mov    0xc(%ebp),%eax
80103603:	8b 8f 38 02 00 00    	mov    0x238(%edi),%ecx
80103609:	8d b7 34 02 00 00    	lea    0x234(%edi),%esi
8010360f:	8d 9f 38 02 00 00    	lea    0x238(%edi),%ebx
80103615:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103618:	03 45 10             	add    0x10(%ebp),%eax
8010361b:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010361e:	8b 87 34 02 00 00    	mov    0x234(%edi),%eax
80103624:	8d 90 00 02 00 00    	lea    0x200(%eax),%edx
8010362a:	39 d1                	cmp    %edx,%ecx
8010362c:	0f 85 cf 00 00 00    	jne    80103701 <pipewrite+0x121>
      if(p->readopen == 0 || proc->killed){
80103632:	8b 97 3c 02 00 00    	mov    0x23c(%edi),%edx
80103638:	85 d2                	test   %edx,%edx
8010363a:	0f 84 a8 00 00 00    	je     801036e8 <pipewrite+0x108>
80103640:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103647:	8b 42 14             	mov    0x14(%edx),%eax
8010364a:	85 c0                	test   %eax,%eax
8010364c:	74 25                	je     80103673 <pipewrite+0x93>
8010364e:	e9 95 00 00 00       	jmp    801036e8 <pipewrite+0x108>
80103653:	90                   	nop
80103654:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103658:	8b 87 3c 02 00 00    	mov    0x23c(%edi),%eax
8010365e:	85 c0                	test   %eax,%eax
80103660:	0f 84 82 00 00 00    	je     801036e8 <pipewrite+0x108>
80103666:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010366c:	8b 40 14             	mov    0x14(%eax),%eax
8010366f:	85 c0                	test   %eax,%eax
80103671:	75 75                	jne    801036e8 <pipewrite+0x108>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103673:	83 ec 0c             	sub    $0xc,%esp
80103676:	56                   	push   %esi
80103677:	e8 b4 0c 00 00       	call   80104330 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010367c:	59                   	pop    %ecx
8010367d:	58                   	pop    %eax
8010367e:	57                   	push   %edi
8010367f:	53                   	push   %ebx
80103680:	e8 9b 0a 00 00       	call   80104120 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103685:	8b 87 34 02 00 00    	mov    0x234(%edi),%eax
8010368b:	8b 97 38 02 00 00    	mov    0x238(%edi),%edx
80103691:	83 c4 10             	add    $0x10,%esp
80103694:	05 00 02 00 00       	add    $0x200,%eax
80103699:	39 c2                	cmp    %eax,%edx
8010369b:	74 bb                	je     80103658 <pipewrite+0x78>
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010369d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801036a0:	8d 4a 01             	lea    0x1(%edx),%ecx
801036a3:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
801036a7:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801036ad:	89 8f 38 02 00 00    	mov    %ecx,0x238(%edi)
801036b3:	0f b6 00             	movzbl (%eax),%eax
801036b6:	88 44 17 34          	mov    %al,0x34(%edi,%edx,1)
801036ba:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  for(i = 0; i < n; i++){
801036bd:	39 45 e0             	cmp    %eax,-0x20(%ebp)
801036c0:	0f 85 58 ff ff ff    	jne    8010361e <pipewrite+0x3e>
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801036c6:	8d 97 34 02 00 00    	lea    0x234(%edi),%edx
801036cc:	83 ec 0c             	sub    $0xc,%esp
801036cf:	52                   	push   %edx
801036d0:	e8 5b 0c 00 00       	call   80104330 <wakeup>
  release(&p->lock);
801036d5:	89 3c 24             	mov    %edi,(%esp)
801036d8:	e8 e3 15 00 00       	call   80104cc0 <release>
  return n;
801036dd:	83 c4 10             	add    $0x10,%esp
801036e0:	8b 45 10             	mov    0x10(%ebp),%eax
801036e3:	eb 14                	jmp    801036f9 <pipewrite+0x119>
801036e5:	8d 76 00             	lea    0x0(%esi),%esi
        release(&p->lock);
801036e8:	83 ec 0c             	sub    $0xc,%esp
801036eb:	57                   	push   %edi
801036ec:	e8 cf 15 00 00       	call   80104cc0 <release>
        return -1;
801036f1:	83 c4 10             	add    $0x10,%esp
801036f4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801036f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801036fc:	5b                   	pop    %ebx
801036fd:	5e                   	pop    %esi
801036fe:	5f                   	pop    %edi
801036ff:	5d                   	pop    %ebp
80103700:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103701:	89 ca                	mov    %ecx,%edx
80103703:	eb 98                	jmp    8010369d <pipewrite+0xbd>
80103705:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103710 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103710:	55                   	push   %ebp
80103711:	89 e5                	mov    %esp,%ebp
80103713:	57                   	push   %edi
80103714:	56                   	push   %esi
80103715:	53                   	push   %ebx
80103716:	83 ec 18             	sub    $0x18,%esp
80103719:	8b 75 08             	mov    0x8(%ebp),%esi
8010371c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010371f:	56                   	push   %esi
80103720:	e8 db 13 00 00       	call   80104b00 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103725:	83 c4 10             	add    $0x10,%esp
80103728:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
8010372e:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103734:	75 64                	jne    8010379a <piperead+0x8a>
80103736:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
8010373c:	85 c0                	test   %eax,%eax
8010373e:	0f 84 bc 00 00 00    	je     80103800 <piperead+0xf0>
    if(proc->killed){
80103744:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010374a:	8b 58 14             	mov    0x14(%eax),%ebx
8010374d:	85 db                	test   %ebx,%ebx
8010374f:	0f 85 b3 00 00 00    	jne    80103808 <piperead+0xf8>
80103755:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
8010375b:	eb 22                	jmp    8010377f <piperead+0x6f>
8010375d:	8d 76 00             	lea    0x0(%esi),%esi
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103760:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103766:	85 d2                	test   %edx,%edx
80103768:	0f 84 92 00 00 00    	je     80103800 <piperead+0xf0>
    if(proc->killed){
8010376e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103774:	8b 48 14             	mov    0x14(%eax),%ecx
80103777:	85 c9                	test   %ecx,%ecx
80103779:	0f 85 89 00 00 00    	jne    80103808 <piperead+0xf8>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
8010377f:	83 ec 08             	sub    $0x8,%esp
80103782:	56                   	push   %esi
80103783:	53                   	push   %ebx
80103784:	e8 97 09 00 00       	call   80104120 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103789:	83 c4 10             	add    $0x10,%esp
8010378c:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103792:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103798:	74 c6                	je     80103760 <piperead+0x50>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010379a:	8b 45 10             	mov    0x10(%ebp),%eax
8010379d:	85 c0                	test   %eax,%eax
8010379f:	7e 5f                	jle    80103800 <piperead+0xf0>
    if(p->nread == p->nwrite)
801037a1:	31 db                	xor    %ebx,%ebx
801037a3:	eb 11                	jmp    801037b6 <piperead+0xa6>
801037a5:	8d 76 00             	lea    0x0(%esi),%esi
801037a8:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801037ae:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801037b4:	74 1f                	je     801037d5 <piperead+0xc5>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
801037b6:	8d 41 01             	lea    0x1(%ecx),%eax
801037b9:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
801037bf:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
801037c5:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
801037ca:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801037cd:	83 c3 01             	add    $0x1,%ebx
801037d0:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801037d3:	75 d3                	jne    801037a8 <piperead+0x98>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801037d5:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
801037db:	83 ec 0c             	sub    $0xc,%esp
801037de:	50                   	push   %eax
801037df:	e8 4c 0b 00 00       	call   80104330 <wakeup>
  release(&p->lock);
801037e4:	89 34 24             	mov    %esi,(%esp)
801037e7:	e8 d4 14 00 00       	call   80104cc0 <release>
  return i;
801037ec:	83 c4 10             	add    $0x10,%esp
}
801037ef:	8d 65 f4             	lea    -0xc(%ebp),%esp
801037f2:	89 d8                	mov    %ebx,%eax
801037f4:	5b                   	pop    %ebx
801037f5:	5e                   	pop    %esi
801037f6:	5f                   	pop    %edi
801037f7:	5d                   	pop    %ebp
801037f8:	c3                   	ret    
801037f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p->nread == p->nwrite)
80103800:	31 db                	xor    %ebx,%ebx
80103802:	eb d1                	jmp    801037d5 <piperead+0xc5>
80103804:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      release(&p->lock);
80103808:	83 ec 0c             	sub    $0xc,%esp
      return -1;
8010380b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80103810:	56                   	push   %esi
80103811:	e8 aa 14 00 00       	call   80104cc0 <release>
      return -1;
80103816:	83 c4 10             	add    $0x10,%esp
}
80103819:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010381c:	89 d8                	mov    %ebx,%eax
8010381e:	5b                   	pop    %ebx
8010381f:	5e                   	pop    %esi
80103820:	5f                   	pop    %edi
80103821:	5d                   	pop    %ebp
80103822:	c3                   	ret    
80103823:	66 90                	xchg   %ax,%ax
80103825:	66 90                	xchg   %ax,%ax
80103827:	66 90                	xchg   %ax,%ax
80103829:	66 90                	xchg   %ax,%ax
8010382b:	66 90                	xchg   %ax,%ax
8010382d:	66 90                	xchg   %ax,%ax
8010382f:	90                   	nop

80103830 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103830:	55                   	push   %ebp
80103831:	89 e5                	mov    %esp,%ebp
80103833:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103836:	68 40 2b 11 80       	push   $0x80112b40
8010383b:	e8 80 14 00 00       	call   80104cc0 <release>

  if (first) {
80103840:	a1 04 b0 10 80       	mov    0x8010b004,%eax
80103845:	83 c4 10             	add    $0x10,%esp
80103848:	85 c0                	test   %eax,%eax
8010384a:	75 04                	jne    80103850 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010384c:	c9                   	leave  
8010384d:	c3                   	ret    
8010384e:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
80103850:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
80103853:	c7 05 04 b0 10 80 00 	movl   $0x0,0x8010b004
8010385a:	00 00 00 
    iinit(ROOTDEV);
8010385d:	6a 01                	push   $0x1
8010385f:	e8 4c dc ff ff       	call   801014b0 <iinit>
    initlog(ROOTDEV);
80103864:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010386b:	e8 80 f3 ff ff       	call   80102bf0 <initlog>
80103870:	83 c4 10             	add    $0x10,%esp
}
80103873:	c9                   	leave  
80103874:	c3                   	ret    
80103875:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103880 <pinit>:
{
80103880:	55                   	push   %ebp
80103881:	89 e5                	mov    %esp,%ebp
80103883:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103886:	68 8d 80 10 80       	push   $0x8010808d
8010388b:	68 40 2b 11 80       	push   $0x80112b40
80103890:	e8 4b 12 00 00       	call   80104ae0 <initlock>
}
80103895:	83 c4 10             	add    $0x10,%esp
80103898:	c9                   	leave  
80103899:	c3                   	ret    
8010389a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801038a0 <allocthread>:
{
801038a0:	55                   	push   %ebp
801038a1:	89 e5                	mov    %esp,%ebp
801038a3:	56                   	push   %esi
801038a4:	53                   	push   %ebx
801038a5:	8b 75 08             	mov    0x8(%ebp),%esi
    if(t->state == TUNUSED)
801038a8:	8b 46 70             	mov    0x70(%esi),%eax
  for(t = p->threads; found != 1 && t < &p->threads[NTHREAD]; t++)
801038ab:	8d 5e 6c             	lea    0x6c(%esi),%ebx
    if(t->state == TUNUSED)
801038ae:	85 c0                	test   %eax,%eax
801038b0:	74 5e                	je     80103910 <allocthread+0x70>
    else if(t->state == TZOMBIE)
801038b2:	83 f8 05             	cmp    $0x5,%eax
  for(t = p->threads; found != 1 && t < &p->threads[NTHREAD]; t++)
801038b5:	8d 96 6c 02 00 00    	lea    0x26c(%esi),%edx
    else if(t->state == TZOMBIE)
801038bb:	74 1a                	je     801038d7 <allocthread+0x37>
801038bd:	8d 76 00             	lea    0x0(%esi),%esi
  for(t = p->threads; found != 1 && t < &p->threads[NTHREAD]; t++)
801038c0:	83 c3 20             	add    $0x20,%ebx
801038c3:	39 d3                	cmp    %edx,%ebx
801038c5:	0f 83 bc 00 00 00    	jae    80103987 <allocthread+0xe7>
    if(t->state == TUNUSED)
801038cb:	8b 43 04             	mov    0x4(%ebx),%eax
801038ce:	85 c0                	test   %eax,%eax
801038d0:	74 3e                	je     80103910 <allocthread+0x70>
    else if(t->state == TZOMBIE)
801038d2:	83 f8 05             	cmp    $0x5,%eax
801038d5:	75 e9                	jne    801038c0 <allocthread+0x20>
    kfree(t->kstack);
801038d7:	83 ec 0c             	sub    $0xc,%esp
801038da:	ff 73 08             	pushl  0x8(%ebx)
801038dd:	e8 8e ea ff ff       	call   80102370 <kfree>
  t->kstack = 0;
801038e2:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  t->tid = 0;
801038e9:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  t->killed = 0;
801038ef:	83 c4 10             	add    $0x10,%esp
  t->state = TUNUSED;
801038f2:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
  t->parent = 0;
801038f9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  t->killed = 0;
80103900:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%ebx)
80103907:	89 f6                	mov    %esi,%esi
80103909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  t->tid = nexttid++;
80103910:	a1 0c b0 10 80       	mov    0x8010b00c,%eax
  t->state = TEMBRYO;
80103915:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
  t->parent = p;
8010391c:	89 73 0c             	mov    %esi,0xc(%ebx)
  t->killed = 0;
8010391f:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%ebx)
  t->tid = nexttid++;
80103926:	8d 50 01             	lea    0x1(%eax),%edx
80103929:	89 15 0c b0 10 80    	mov    %edx,0x8010b00c
8010392f:	89 03                	mov    %eax,(%ebx)
  if((t->kstack = kalloc()) == 0){
80103931:	e8 ea eb ff ff       	call   80102520 <kalloc>
80103936:	85 c0                	test   %eax,%eax
80103938:	89 43 08             	mov    %eax,0x8(%ebx)
8010393b:	74 43                	je     80103980 <allocthread+0xe0>
  sp -= sizeof *t->tf;
8010393d:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  memset(t->context, 0, sizeof *t->context);
80103943:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *t->context;
80103946:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *t->tf;
8010394b:	89 53 10             	mov    %edx,0x10(%ebx)
  *(uint*)sp = (uint)trapret;
8010394e:	c7 40 14 5e 60 10 80 	movl   $0x8010605e,0x14(%eax)
  t->context = (struct context*)sp;
80103955:	89 43 14             	mov    %eax,0x14(%ebx)
  memset(t->context, 0, sizeof *t->context);
80103958:	6a 14                	push   $0x14
8010395a:	6a 00                	push   $0x0
8010395c:	50                   	push   %eax
8010395d:	e8 ae 13 00 00       	call   80104d10 <memset>
  t->context->eip = (uint)forkret;
80103962:	8b 43 14             	mov    0x14(%ebx),%eax
  return t;
80103965:	83 c4 10             	add    $0x10,%esp
  t->context->eip = (uint)forkret;
80103968:	c7 40 10 30 38 10 80 	movl   $0x80103830,0x10(%eax)
}
8010396f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103972:	89 d8                	mov    %ebx,%eax
80103974:	5b                   	pop    %ebx
80103975:	5e                   	pop    %esi
80103976:	5d                   	pop    %ebp
80103977:	c3                   	ret    
80103978:	90                   	nop
80103979:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    t->state = TUNUSED;
80103980:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
}
80103987:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return 0;
8010398a:	31 db                	xor    %ebx,%ebx
}
8010398c:	89 d8                	mov    %ebx,%eax
8010398e:	5b                   	pop    %ebx
8010398f:	5e                   	pop    %esi
80103990:	5d                   	pop    %ebp
80103991:	c3                   	ret    
80103992:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801039a0 <allocproc>:
{
801039a0:	55                   	push   %ebp
801039a1:	89 e5                	mov    %esp,%ebp
801039a3:	53                   	push   %ebx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801039a4:	bb 74 2b 11 80       	mov    $0x80112b74,%ebx
{
801039a9:	83 ec 04             	sub    $0x4,%esp
801039ac:	eb 14                	jmp    801039c2 <allocproc+0x22>
801039ae:	66 90                	xchg   %ax,%ax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801039b0:	81 c3 6c 02 00 00    	add    $0x26c,%ebx
801039b6:	81 fb 74 c6 11 80    	cmp    $0x8011c674,%ebx
801039bc:	0f 83 92 00 00 00    	jae    80103a54 <allocproc+0xb4>
    if(p->state == UNUSED)
801039c2:	8b 43 08             	mov    0x8(%ebx),%eax
801039c5:	85 c0                	test   %eax,%eax
801039c7:	75 e7                	jne    801039b0 <allocproc+0x10>
  p->pid = nextpid++;
801039c9:	a1 10 b0 10 80       	mov    0x8010b010,%eax
  t = allocthread(p);
801039ce:	83 ec 0c             	sub    $0xc,%esp
  p->state = USED;
801039d1:	c7 43 08 01 00 00 00 	movl   $0x1,0x8(%ebx)
  p->pid = nextpid++;
801039d8:	8d 50 01             	lea    0x1(%eax),%edx
801039db:	89 43 0c             	mov    %eax,0xc(%ebx)
  t = allocthread(p);
801039de:	53                   	push   %ebx
  p->pid = nextpid++;
801039df:	89 15 10 b0 10 80    	mov    %edx,0x8010b010
  t = allocthread(p);
801039e5:	e8 b6 fe ff ff       	call   801038a0 <allocthread>
  if(t == 0)
801039ea:	83 c4 10             	add    $0x10,%esp
801039ed:	85 c0                	test   %eax,%eax
801039ef:	74 5c                	je     80103a4d <allocproc+0xad>
  p->threads[0] = *t;
801039f1:	8b 10                	mov    (%eax),%edx
801039f3:	89 53 6c             	mov    %edx,0x6c(%ebx)
801039f6:	8b 50 04             	mov    0x4(%eax),%edx
801039f9:	89 53 70             	mov    %edx,0x70(%ebx)
801039fc:	8b 50 08             	mov    0x8(%eax),%edx
801039ff:	89 53 74             	mov    %edx,0x74(%ebx)
80103a02:	8b 50 0c             	mov    0xc(%eax),%edx
80103a05:	89 53 78             	mov    %edx,0x78(%ebx)
80103a08:	8b 50 10             	mov    0x10(%eax),%edx
80103a0b:	89 53 7c             	mov    %edx,0x7c(%ebx)
80103a0e:	8b 50 14             	mov    0x14(%eax),%edx
80103a11:	89 93 80 00 00 00    	mov    %edx,0x80(%ebx)
80103a17:	8b 50 18             	mov    0x18(%eax),%edx
80103a1a:	89 93 84 00 00 00    	mov    %edx,0x84(%ebx)
80103a20:	8b 40 1c             	mov    0x1c(%eax),%eax
  for(t = p->threads; t < &p->threads[NTHREAD]; t++)
80103a23:	8d 93 6c 02 00 00    	lea    0x26c(%ebx),%edx
  p->threads[0] = *t;
80103a29:	89 83 88 00 00 00    	mov    %eax,0x88(%ebx)
  for(t = p->threads; t < &p->threads[NTHREAD]; t++)
80103a2f:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103a32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    t->state = TUNUSED;
80103a38:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  for(t = p->threads; t < &p->threads[NTHREAD]; t++)
80103a3f:	83 c0 20             	add    $0x20,%eax
80103a42:	39 c2                	cmp    %eax,%edx
80103a44:	77 f2                	ja     80103a38 <allocproc+0x98>
}
80103a46:	89 d8                	mov    %ebx,%eax
80103a48:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a4b:	c9                   	leave  
80103a4c:	c3                   	ret    
    p->state = UNUSED;
80103a4d:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return 0;
80103a54:	31 db                	xor    %ebx,%ebx
}
80103a56:	89 d8                	mov    %ebx,%eax
80103a58:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a5b:	c9                   	leave  
80103a5c:	c3                   	ret    
80103a5d:	8d 76 00             	lea    0x0(%esi),%esi

80103a60 <userinit>:
{
80103a60:	55                   	push   %ebp
80103a61:	89 e5                	mov    %esp,%ebp
80103a63:	53                   	push   %ebx
80103a64:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
80103a67:	68 40 2b 11 80       	push   $0x80112b40
80103a6c:	e8 8f 10 00 00       	call   80104b00 <acquire>
  p = allocproc();
80103a71:	e8 2a ff ff ff       	call   801039a0 <allocproc>
80103a76:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103a78:	a3 bc b5 10 80       	mov    %eax,0x8010b5bc
  if((p->pgdir = setupkvm()) == 0)
80103a7d:	e8 ae 37 00 00       	call   80107230 <setupkvm>
80103a82:	83 c4 10             	add    $0x10,%esp
80103a85:	85 c0                	test   %eax,%eax
80103a87:	89 43 04             	mov    %eax,0x4(%ebx)
80103a8a:	0f 84 b1 00 00 00    	je     80103b41 <userinit+0xe1>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103a90:	83 ec 04             	sub    $0x4,%esp
80103a93:	68 2c 00 00 00       	push   $0x2c
80103a98:	68 60 b4 10 80       	push   $0x8010b460
80103a9d:	50                   	push   %eax
80103a9e:	e8 dd 38 00 00       	call   80107380 <inituvm>
  memset(t->tf, 0, sizeof(*t->tf));
80103aa3:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103aa6:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(t->tf, 0, sizeof(*t->tf));
80103aac:	6a 4c                	push   $0x4c
80103aae:	6a 00                	push   $0x0
80103ab0:	ff 73 7c             	pushl  0x7c(%ebx)
80103ab3:	e8 58 12 00 00       	call   80104d10 <memset>
  t->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103ab8:	8b 43 7c             	mov    0x7c(%ebx),%eax
80103abb:	ba 23 00 00 00       	mov    $0x23,%edx
  t->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103ac0:	b9 2b 00 00 00       	mov    $0x2b,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103ac5:	83 c4 0c             	add    $0xc,%esp
  t->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103ac8:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  t->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103acc:	8b 43 7c             	mov    0x7c(%ebx),%eax
80103acf:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  t->tf->es = t->tf->ds;
80103ad3:	8b 43 7c             	mov    0x7c(%ebx),%eax
80103ad6:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103ada:	66 89 50 28          	mov    %dx,0x28(%eax)
  t->tf->ss = t->tf->ds;
80103ade:	8b 43 7c             	mov    0x7c(%ebx),%eax
80103ae1:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103ae5:	66 89 50 48          	mov    %dx,0x48(%eax)
  t->tf->eflags = FL_IF;
80103ae9:	8b 43 7c             	mov    0x7c(%ebx),%eax
80103aec:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  t->tf->esp = PGSIZE;
80103af3:	8b 43 7c             	mov    0x7c(%ebx),%eax
80103af6:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  t->tf->eip = 0;  // beginning of initcode.S
80103afd:	8b 43 7c             	mov    0x7c(%ebx),%eax
80103b00:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103b07:	8d 43 5c             	lea    0x5c(%ebx),%eax
80103b0a:	6a 10                	push   $0x10
80103b0c:	68 ad 80 10 80       	push   $0x801080ad
80103b11:	50                   	push   %eax
80103b12:	e8 d9 13 00 00       	call   80104ef0 <safestrcpy>
  p->cwd = namei("/");
80103b17:	c7 04 24 b6 80 10 80 	movl   $0x801080b6,(%esp)
80103b1e:	e8 fd e3 ff ff       	call   80101f20 <namei>
  t->state = TRUNNABLE;
80103b23:	c7 43 70 03 00 00 00 	movl   $0x3,0x70(%ebx)
  p->cwd = namei("/");
80103b2a:	89 43 58             	mov    %eax,0x58(%ebx)
  release(&ptable.lock);
80103b2d:	c7 04 24 40 2b 11 80 	movl   $0x80112b40,(%esp)
80103b34:	e8 87 11 00 00       	call   80104cc0 <release>
}
80103b39:	83 c4 10             	add    $0x10,%esp
80103b3c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103b3f:	c9                   	leave  
80103b40:	c3                   	ret    
    panic("userinit: out of memory?");
80103b41:	83 ec 0c             	sub    $0xc,%esp
80103b44:	68 94 80 10 80       	push   $0x80108094
80103b49:	e8 22 c8 ff ff       	call   80100370 <panic>
80103b4e:	66 90                	xchg   %ax,%ax

80103b50 <growproc>:
{
80103b50:	55                   	push   %ebp
80103b51:	89 e5                	mov    %esp,%ebp
80103b53:	53                   	push   %ebx
80103b54:	83 ec 10             	sub    $0x10,%esp
80103b57:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80103b5a:	68 40 2b 11 80       	push   $0x80112b40
80103b5f:	e8 9c 0f 00 00       	call   80104b00 <acquire>
  sz = proc->sz;
80103b64:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  if(n > 0){
80103b6b:	83 c4 10             	add    $0x10,%esp
80103b6e:	83 fb 00             	cmp    $0x0,%ebx
  sz = proc->sz;
80103b71:	8b 02                	mov    (%edx),%eax
  if(n > 0){
80103b73:	7f 2b                	jg     80103ba0 <growproc+0x50>
  } else if(n < 0){
80103b75:	75 49                	jne    80103bc0 <growproc+0x70>
  switchuvm(proc);
80103b77:	83 ec 0c             	sub    $0xc,%esp
  proc->sz = sz;
80103b7a:	89 02                	mov    %eax,(%edx)
  switchuvm(proc);
80103b7c:	65 ff 35 04 00 00 00 	pushl  %gs:0x4
80103b83:	e8 58 37 00 00       	call   801072e0 <switchuvm>
      release(&ptable.lock);
80103b88:	c7 04 24 40 2b 11 80 	movl   $0x80112b40,(%esp)
80103b8f:	e8 2c 11 00 00       	call   80104cc0 <release>
  return 0;
80103b94:	83 c4 10             	add    $0x10,%esp
80103b97:	31 c0                	xor    %eax,%eax
}
80103b99:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103b9c:	c9                   	leave  
80103b9d:	c3                   	ret    
80103b9e:	66 90                	xchg   %ax,%ax
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0){
80103ba0:	83 ec 04             	sub    $0x4,%esp
80103ba3:	01 c3                	add    %eax,%ebx
80103ba5:	53                   	push   %ebx
80103ba6:	50                   	push   %eax
80103ba7:	ff 72 04             	pushl  0x4(%edx)
80103baa:	e8 11 3a 00 00       	call   801075c0 <allocuvm>
80103baf:	83 c4 10             	add    $0x10,%esp
80103bb2:	85 c0                	test   %eax,%eax
80103bb4:	74 20                	je     80103bd6 <growproc+0x86>
80103bb6:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103bbd:	eb b8                	jmp    80103b77 <growproc+0x27>
80103bbf:	90                   	nop
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0){
80103bc0:	83 ec 04             	sub    $0x4,%esp
80103bc3:	01 c3                	add    %eax,%ebx
80103bc5:	53                   	push   %ebx
80103bc6:	50                   	push   %eax
80103bc7:	ff 72 04             	pushl  0x4(%edx)
80103bca:	e8 f1 38 00 00       	call   801074c0 <deallocuvm>
80103bcf:	83 c4 10             	add    $0x10,%esp
80103bd2:	85 c0                	test   %eax,%eax
80103bd4:	75 e0                	jne    80103bb6 <growproc+0x66>
      release(&ptable.lock);
80103bd6:	83 ec 0c             	sub    $0xc,%esp
80103bd9:	68 40 2b 11 80       	push   $0x80112b40
80103bde:	e8 dd 10 00 00       	call   80104cc0 <release>
      return -1;
80103be3:	83 c4 10             	add    $0x10,%esp
80103be6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103beb:	eb ac                	jmp    80103b99 <growproc+0x49>
80103bed:	8d 76 00             	lea    0x0(%esi),%esi

80103bf0 <fork>:
{
80103bf0:	55                   	push   %ebp
80103bf1:	89 e5                	mov    %esp,%ebp
80103bf3:	57                   	push   %edi
80103bf4:	56                   	push   %esi
80103bf5:	53                   	push   %ebx
80103bf6:	83 ec 18             	sub    $0x18,%esp
  acquire(&ptable.lock);
80103bf9:	68 40 2b 11 80       	push   $0x80112b40
80103bfe:	e8 fd 0e 00 00       	call   80104b00 <acquire>
  if((np = allocproc()) == 0){
80103c03:	e8 98 fd ff ff       	call   801039a0 <allocproc>
80103c08:	83 c4 10             	add    $0x10,%esp
80103c0b:	85 c0                	test   %eax,%eax
80103c0d:	0f 84 cd 00 00 00    	je     80103ce0 <fork+0xf0>
80103c13:	89 c3                	mov    %eax,%ebx
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
80103c15:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103c1b:	83 ec 08             	sub    $0x8,%esp
80103c1e:	ff 30                	pushl  (%eax)
80103c20:	ff 70 04             	pushl  0x4(%eax)
80103c23:	e8 98 3b 00 00       	call   801077c0 <copyuvm>
80103c28:	83 c4 10             	add    $0x10,%esp
80103c2b:	85 c0                	test   %eax,%eax
80103c2d:	89 43 04             	mov    %eax,0x4(%ebx)
80103c30:	0f 84 c1 00 00 00    	je     80103cf7 <fork+0x107>
  np->sz = proc->sz;
80103c36:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  *nt->tf = *thread->tf;
80103c3c:	8b 7b 7c             	mov    0x7c(%ebx),%edi
80103c3f:	b9 13 00 00 00       	mov    $0x13,%ecx
  np->sz = proc->sz;
80103c44:	8b 00                	mov    (%eax),%eax
80103c46:	89 03                	mov    %eax,(%ebx)
  np->parent = proc;
80103c48:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103c4e:	89 43 10             	mov    %eax,0x10(%ebx)
  *nt->tf = *thread->tf;
80103c51:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
80103c57:	8b 70 10             	mov    0x10(%eax),%esi
80103c5a:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103c5c:	31 f6                	xor    %esi,%esi
  nt->tf->eax = 0;
80103c5e:	8b 43 7c             	mov    0x7c(%ebx),%eax
80103c61:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103c68:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103c6f:	90                   	nop
    if(proc->ofile[i])
80103c70:	8b 44 b2 18          	mov    0x18(%edx,%esi,4),%eax
80103c74:	85 c0                	test   %eax,%eax
80103c76:	74 17                	je     80103c8f <fork+0x9f>
      np->ofile[i] = filedup(proc->ofile[i]);
80103c78:	83 ec 0c             	sub    $0xc,%esp
80103c7b:	50                   	push   %eax
80103c7c:	e8 af d1 ff ff       	call   80100e30 <filedup>
80103c81:	89 44 b3 18          	mov    %eax,0x18(%ebx,%esi,4)
80103c85:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103c8c:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NOFILE; i++)
80103c8f:	83 c6 01             	add    $0x1,%esi
80103c92:	83 fe 10             	cmp    $0x10,%esi
80103c95:	75 d9                	jne    80103c70 <fork+0x80>
  np->cwd = idup(proc->cwd);
80103c97:	83 ec 0c             	sub    $0xc,%esp
80103c9a:	ff 72 58             	pushl  0x58(%edx)
80103c9d:	e8 ae d9 ff ff       	call   80101650 <idup>
80103ca2:	89 43 58             	mov    %eax,0x58(%ebx)
  safestrcpy(np->name, proc->name, sizeof(proc->name));
80103ca5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103cab:	83 c4 0c             	add    $0xc,%esp
80103cae:	6a 10                	push   $0x10
80103cb0:	83 c0 5c             	add    $0x5c,%eax
80103cb3:	50                   	push   %eax
80103cb4:	8d 43 5c             	lea    0x5c(%ebx),%eax
80103cb7:	50                   	push   %eax
80103cb8:	e8 33 12 00 00       	call   80104ef0 <safestrcpy>
  nt->state = TRUNNABLE;
80103cbd:	c7 43 70 03 00 00 00 	movl   $0x3,0x70(%ebx)
  pid = np->pid;
80103cc4:	8b 73 0c             	mov    0xc(%ebx),%esi
  release(&ptable.lock);
80103cc7:	c7 04 24 40 2b 11 80 	movl   $0x80112b40,(%esp)
80103cce:	e8 ed 0f 00 00       	call   80104cc0 <release>
  return pid;
80103cd3:	83 c4 10             	add    $0x10,%esp
}
80103cd6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103cd9:	89 f0                	mov    %esi,%eax
80103cdb:	5b                   	pop    %ebx
80103cdc:	5e                   	pop    %esi
80103cdd:	5f                   	pop    %edi
80103cde:	5d                   	pop    %ebp
80103cdf:	c3                   	ret    
    release(&ptable.lock);
80103ce0:	83 ec 0c             	sub    $0xc,%esp
    return -1;
80103ce3:	be ff ff ff ff       	mov    $0xffffffff,%esi
    release(&ptable.lock);
80103ce8:	68 40 2b 11 80       	push   $0x80112b40
80103ced:	e8 ce 0f 00 00       	call   80104cc0 <release>
    return -1;
80103cf2:	83 c4 10             	add    $0x10,%esp
80103cf5:	eb df                	jmp    80103cd6 <fork+0xe6>
    kfree(nt->kstack);
80103cf7:	83 ec 0c             	sub    $0xc,%esp
80103cfa:	ff 73 74             	pushl  0x74(%ebx)
    return -1;
80103cfd:	be ff ff ff ff       	mov    $0xffffffff,%esi
    kfree(nt->kstack);
80103d02:	e8 69 e6 ff ff       	call   80102370 <kfree>
    nt->kstack = 0;
80103d07:	c7 43 74 00 00 00 00 	movl   $0x0,0x74(%ebx)
    np->state = UNUSED;
80103d0e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    release(&ptable.lock);
80103d15:	c7 04 24 40 2b 11 80 	movl   $0x80112b40,(%esp)
80103d1c:	e8 9f 0f 00 00       	call   80104cc0 <release>
    return -1;
80103d21:	83 c4 10             	add    $0x10,%esp
80103d24:	eb b0                	jmp    80103cd6 <fork+0xe6>
80103d26:	8d 76 00             	lea    0x0(%esi),%esi
80103d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103d30 <kill_all>:
{
80103d30:	55                   	push   %ebp
    if(t->state != TRUNNING && t->state != TUNUSED && t != thread) //kill not running
80103d31:	65 8b 0d 08 00 00 00 	mov    %gs:0x8,%ecx
{
80103d38:	89 e5                	mov    %esp,%ebp
80103d3a:	53                   	push   %ebx
  struct proc *p =  proc;
80103d3b:	65 8b 1d 04 00 00 00 	mov    %gs:0x4,%ebx
  for(t = p->threads; t < &p->threads[NTHREAD]; t++){
80103d42:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103d45:	8d 93 6c 02 00 00    	lea    0x26c(%ebx),%edx
80103d4b:	90                   	nop
80103d4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(t->state != TRUNNING && t->state != TUNUSED && t != thread) //kill not running
80103d50:	f7 40 04 fb ff ff ff 	testl  $0xfffffffb,0x4(%eax)
80103d57:	74 0b                	je     80103d64 <kill_all+0x34>
80103d59:	39 c1                	cmp    %eax,%ecx
80103d5b:	74 07                	je     80103d64 <kill_all+0x34>
          t->state = TZOMBIE;
80103d5d:	c7 40 04 05 00 00 00 	movl   $0x5,0x4(%eax)
  for(t = p->threads; t < &p->threads[NTHREAD]; t++){
80103d64:	83 c0 20             	add    $0x20,%eax
80103d67:	39 d0                	cmp    %edx,%eax
80103d69:	72 e5                	jb     80103d50 <kill_all+0x20>
  thread->state = TZOMBIE;
80103d6b:	c7 41 04 05 00 00 00 	movl   $0x5,0x4(%ecx)
  proc->killed = 1; //kill the process if all dead
80103d72:	c7 43 14 01 00 00 00 	movl   $0x1,0x14(%ebx)
}
80103d79:	5b                   	pop    %ebx
80103d7a:	5d                   	pop    %ebp
80103d7b:	c3                   	ret    
80103d7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103d80 <clearThread>:
{
80103d80:	55                   	push   %ebp
80103d81:	89 e5                	mov    %esp,%ebp
80103d83:	53                   	push   %ebx
80103d84:	83 ec 04             	sub    $0x4,%esp
80103d87:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(t->state == TINVALID || t->state == TZOMBIE)
80103d8a:	8b 43 04             	mov    0x4(%ebx),%eax
80103d8d:	83 e8 05             	sub    $0x5,%eax
80103d90:	83 f8 01             	cmp    $0x1,%eax
80103d93:	76 2b                	jbe    80103dc0 <clearThread+0x40>
  t->kstack = 0;
80103d95:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  t->tid = 0;
80103d9c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  t->state = TUNUSED;
80103da2:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
  t->parent = 0;
80103da9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  t->killed = 0;
80103db0:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%ebx)
}
80103db7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103dba:	c9                   	leave  
80103dbb:	c3                   	ret    
80103dbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kfree(t->kstack);
80103dc0:	83 ec 0c             	sub    $0xc,%esp
80103dc3:	ff 73 08             	pushl  0x8(%ebx)
80103dc6:	e8 a5 e5 ff ff       	call   80102370 <kfree>
80103dcb:	83 c4 10             	add    $0x10,%esp
80103dce:	eb c5                	jmp    80103d95 <clearThread+0x15>

80103dd0 <scheduler>:
{
80103dd0:	55                   	push   %ebp
80103dd1:	89 e5                	mov    %esp,%ebp
80103dd3:	57                   	push   %edi
80103dd4:	56                   	push   %esi
80103dd5:	53                   	push   %ebx
80103dd6:	83 ec 0c             	sub    $0xc,%esp
  asm volatile("sti");
80103dd9:	fb                   	sti    
    acquire(&ptable.lock);
80103dda:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ddd:	be 74 2b 11 80       	mov    $0x80112b74,%esi
    acquire(&ptable.lock);
80103de2:	68 40 2b 11 80       	push   $0x80112b40
80103de7:	e8 14 0d 00 00       	call   80104b00 <acquire>
80103dec:	83 c4 10             	add    $0x10,%esp
80103def:	eb 15                	jmp    80103e06 <scheduler+0x36>
80103df1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103df8:	81 ff 74 c6 11 80    	cmp    $0x8011c674,%edi
80103dfe:	89 fe                	mov    %edi,%esi
80103e00:	0f 83 84 00 00 00    	jae    80103e8a <scheduler+0xba>
      if(p->state != USED)
80103e06:	83 7e 08 01          	cmpl   $0x1,0x8(%esi)
80103e0a:	8d be 6c 02 00 00    	lea    0x26c(%esi),%edi
80103e10:	75 e6                	jne    80103df8 <scheduler+0x28>
80103e12:	8d 5e 6c             	lea    0x6c(%esi),%ebx
80103e15:	8d 76 00             	lea    0x0(%esi),%esi
        if(t->state != TRUNNABLE)
80103e18:	83 7b 04 03          	cmpl   $0x3,0x4(%ebx)
80103e1c:	75 57                	jne    80103e75 <scheduler+0xa5>
        switchuvm(p);
80103e1e:	83 ec 0c             	sub    $0xc,%esp
        thread = t;
80103e21:	65 89 1d 08 00 00 00 	mov    %ebx,%gs:0x8
        proc = p;
80103e28:	65 89 35 04 00 00 00 	mov    %esi,%gs:0x4
        switchuvm(p);
80103e2f:	56                   	push   %esi
80103e30:	e8 ab 34 00 00       	call   801072e0 <switchuvm>
        t->state = TRUNNING;
80103e35:	c7 43 04 04 00 00 00 	movl   $0x4,0x4(%ebx)
        swtch(&cpu->scheduler, t->context);
80103e3c:	58                   	pop    %eax
80103e3d:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103e43:	5a                   	pop    %edx
80103e44:	ff 73 14             	pushl  0x14(%ebx)
80103e47:	83 c0 04             	add    $0x4,%eax
80103e4a:	50                   	push   %eax
80103e4b:	e8 fb 10 00 00       	call   80104f4b <swtch>
        switchkvm();
80103e50:	e8 6b 34 00 00       	call   801072c0 <switchkvm>
        if(p->state != USED)
80103e55:	83 c4 10             	add    $0x10,%esp
80103e58:	83 7e 08 01          	cmpl   $0x1,0x8(%esi)
        proc = 0;
80103e5c:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80103e63:	00 00 00 00 
        thread = 0;
80103e67:	65 c7 05 08 00 00 00 	movl   $0x0,%gs:0x8
80103e6e:	00 00 00 00 
        if(p->state != USED)
80103e72:	0f 45 df             	cmovne %edi,%ebx
      for(t = p->threads; t < &p->threads[NTHREAD]; t++){
80103e75:	83 c3 20             	add    $0x20,%ebx
80103e78:	39 df                	cmp    %ebx,%edi
80103e7a:	77 9c                	ja     80103e18 <scheduler+0x48>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e7c:	81 ff 74 c6 11 80    	cmp    $0x8011c674,%edi
80103e82:	89 fe                	mov    %edi,%esi
80103e84:	0f 82 7c ff ff ff    	jb     80103e06 <scheduler+0x36>
    release(&ptable.lock);
80103e8a:	83 ec 0c             	sub    $0xc,%esp
80103e8d:	68 40 2b 11 80       	push   $0x80112b40
80103e92:	e8 29 0e 00 00       	call   80104cc0 <release>
    sti();
80103e97:	83 c4 10             	add    $0x10,%esp
80103e9a:	e9 3a ff ff ff       	jmp    80103dd9 <scheduler+0x9>
80103e9f:	90                   	nop

80103ea0 <sched>:
{
80103ea0:	55                   	push   %ebp
80103ea1:	89 e5                	mov    %esp,%ebp
80103ea3:	53                   	push   %ebx
80103ea4:	83 ec 10             	sub    $0x10,%esp
  if(!holding(&ptable.lock))
80103ea7:	68 40 2b 11 80       	push   $0x80112b40
80103eac:	e8 5f 0d 00 00       	call   80104c10 <holding>
80103eb1:	83 c4 10             	add    $0x10,%esp
80103eb4:	85 c0                	test   %eax,%eax
80103eb6:	74 4c                	je     80103f04 <sched+0x64>
  if(cpu->ncli != 1)
80103eb8:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80103ebf:	83 ba ac 00 00 00 01 	cmpl   $0x1,0xac(%edx)
80103ec6:	75 63                	jne    80103f2b <sched+0x8b>
  if(thread->state == TRUNNING)
80103ec8:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
80103ece:	83 78 04 04          	cmpl   $0x4,0x4(%eax)
80103ed2:	74 4a                	je     80103f1e <sched+0x7e>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103ed4:	9c                   	pushf  
80103ed5:	59                   	pop    %ecx
  if(readeflags()&FL_IF)
80103ed6:	80 e5 02             	and    $0x2,%ch
80103ed9:	75 36                	jne    80103f11 <sched+0x71>
  swtch(&thread->context, cpu->scheduler);
80103edb:	83 ec 08             	sub    $0x8,%esp
80103ede:	83 c0 14             	add    $0x14,%eax
  intena = cpu->intena;
80103ee1:	8b 9a b0 00 00 00    	mov    0xb0(%edx),%ebx
  swtch(&thread->context, cpu->scheduler);
80103ee7:	ff 72 04             	pushl  0x4(%edx)
80103eea:	50                   	push   %eax
80103eeb:	e8 5b 10 00 00       	call   80104f4b <swtch>
  cpu->intena = intena;
80103ef0:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
}
80103ef6:	83 c4 10             	add    $0x10,%esp
  cpu->intena = intena;
80103ef9:	89 98 b0 00 00 00    	mov    %ebx,0xb0(%eax)
}
80103eff:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103f02:	c9                   	leave  
80103f03:	c3                   	ret    
    panic("sched ptable.lock");
80103f04:	83 ec 0c             	sub    $0xc,%esp
80103f07:	68 b8 80 10 80       	push   $0x801080b8
80103f0c:	e8 5f c4 ff ff       	call   80100370 <panic>
    panic("sched interruptible");
80103f11:	83 ec 0c             	sub    $0xc,%esp
80103f14:	68 e4 80 10 80       	push   $0x801080e4
80103f19:	e8 52 c4 ff ff       	call   80100370 <panic>
    panic("sched running");
80103f1e:	83 ec 0c             	sub    $0xc,%esp
80103f21:	68 d6 80 10 80       	push   $0x801080d6
80103f26:	e8 45 c4 ff ff       	call   80100370 <panic>
    panic("sched locks");
80103f2b:	83 ec 0c             	sub    $0xc,%esp
80103f2e:	68 ca 80 10 80       	push   $0x801080ca
80103f33:	e8 38 c4 ff ff       	call   80100370 <panic>
80103f38:	90                   	nop
80103f39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103f40 <exit>:
{
80103f40:	55                   	push   %ebp
  if(proc == initproc)
80103f41:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
{
80103f48:	89 e5                	mov    %esp,%ebp
80103f4a:	56                   	push   %esi
80103f4b:	53                   	push   %ebx
80103f4c:	31 db                	xor    %ebx,%ebx
  if(proc == initproc)
80103f4e:	3b 15 bc b5 10 80    	cmp    0x8010b5bc,%edx
80103f54:	0f 84 6a 01 00 00    	je     801040c4 <exit+0x184>
80103f5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(proc->ofile[fd]){
80103f60:	8d 73 04             	lea    0x4(%ebx),%esi
80103f63:	8b 44 b2 08          	mov    0x8(%edx,%esi,4),%eax
80103f67:	85 c0                	test   %eax,%eax
80103f69:	74 1b                	je     80103f86 <exit+0x46>
      fileclose(proc->ofile[fd]);
80103f6b:	83 ec 0c             	sub    $0xc,%esp
80103f6e:	50                   	push   %eax
80103f6f:	e8 0c cf ff ff       	call   80100e80 <fileclose>
      proc->ofile[fd] = 0;
80103f74:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103f7b:	83 c4 10             	add    $0x10,%esp
80103f7e:	c7 44 b2 08 00 00 00 	movl   $0x0,0x8(%edx,%esi,4)
80103f85:	00 
  for(fd = 0; fd < NOFILE; fd++){
80103f86:	83 c3 01             	add    $0x1,%ebx
80103f89:	83 fb 10             	cmp    $0x10,%ebx
80103f8c:	75 d2                	jne    80103f60 <exit+0x20>
  begin_op();
80103f8e:	e8 fd ec ff ff       	call   80102c90 <begin_op>
  iput(proc->cwd);
80103f93:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103f99:	83 ec 0c             	sub    $0xc,%esp
80103f9c:	ff 70 58             	pushl  0x58(%eax)
80103f9f:	e8 4c d8 ff ff       	call   801017f0 <iput>
  end_op();
80103fa4:	e8 57 ed ff ff       	call   80102d00 <end_op>
  proc->cwd = 0;
80103fa9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103faf:	c7 40 58 00 00 00 00 	movl   $0x0,0x58(%eax)
  acquire(&ptable.lock);
80103fb6:	c7 04 24 40 2b 11 80 	movl   $0x80112b40,(%esp)
80103fbd:	e8 3e 0b 00 00       	call   80104b00 <acquire>
  wakeup1(proc->parent);
80103fc2:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
80103fc9:	83 c4 10             	add    $0x10,%esp
wakeup1(void *chan)
{
  struct proc *p;
  struct thread *t;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103fcc:	b8 74 2b 11 80       	mov    $0x80112b74,%eax
  wakeup1(proc->parent);
80103fd1:	8b 59 10             	mov    0x10(%ecx),%ebx
80103fd4:	eb 14                	jmp    80103fea <exit+0xaa>
80103fd6:	8d 76 00             	lea    0x0(%esi),%esi
80103fd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103fe0:	81 fa 74 c6 11 80    	cmp    $0x8011c674,%edx
80103fe6:	89 d0                	mov    %edx,%eax
80103fe8:	73 31                	jae    8010401b <exit+0xdb>
    if(p->state == USED)
80103fea:	83 78 08 01          	cmpl   $0x1,0x8(%eax)
80103fee:	8d 90 6c 02 00 00    	lea    0x26c(%eax),%edx
80103ff4:	75 ea                	jne    80103fe0 <exit+0xa0>
80103ff6:	83 c0 6c             	add    $0x6c,%eax
80103ff9:	eb 0c                	jmp    80104007 <exit+0xc7>
80103ffb:	90                   	nop
80103ffc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    {
      for(t = p->threads; t < &p->threads[NTHREAD]; t++)
80104000:	83 c0 20             	add    $0x20,%eax
80104003:	39 d0                	cmp    %edx,%eax
80104005:	73 d9                	jae    80103fe0 <exit+0xa0>
        if(t->state == TSLEEPING && t->chan == chan)
80104007:	83 78 04 02          	cmpl   $0x2,0x4(%eax)
8010400b:	75 f3                	jne    80104000 <exit+0xc0>
8010400d:	3b 58 18             	cmp    0x18(%eax),%ebx
80104010:	75 ee                	jne    80104000 <exit+0xc0>
          t->state = TRUNNABLE;
80104012:	c7 40 04 03 00 00 00 	movl   $0x3,0x4(%eax)
80104019:	eb e5                	jmp    80104000 <exit+0xc0>
      p->parent = initproc;
8010401b:	8b 35 bc b5 10 80    	mov    0x8010b5bc,%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104021:	bb 74 2b 11 80       	mov    $0x80112b74,%ebx
80104026:	eb 16                	jmp    8010403e <exit+0xfe>
80104028:	90                   	nop
80104029:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104030:	81 c3 6c 02 00 00    	add    $0x26c,%ebx
80104036:	81 fb 74 c6 11 80    	cmp    $0x8011c674,%ebx
8010403c:	73 55                	jae    80104093 <exit+0x153>
    if(p->parent == proc){
8010403e:	3b 4b 10             	cmp    0x10(%ebx),%ecx
80104041:	75 ed                	jne    80104030 <exit+0xf0>
      if(p->state == ZOMBIE)
80104043:	83 7b 08 02          	cmpl   $0x2,0x8(%ebx)
      p->parent = initproc;
80104047:	89 73 10             	mov    %esi,0x10(%ebx)
      if(p->state == ZOMBIE)
8010404a:	75 e4                	jne    80104030 <exit+0xf0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010404c:	b8 74 2b 11 80       	mov    $0x80112b74,%eax
80104051:	eb 0f                	jmp    80104062 <exit+0x122>
80104053:	90                   	nop
80104054:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104058:	81 fa 74 c6 11 80    	cmp    $0x8011c674,%edx
8010405e:	89 d0                	mov    %edx,%eax
80104060:	73 ce                	jae    80104030 <exit+0xf0>
    if(p->state == USED)
80104062:	83 78 08 01          	cmpl   $0x1,0x8(%eax)
80104066:	8d 90 6c 02 00 00    	lea    0x26c(%eax),%edx
8010406c:	75 ea                	jne    80104058 <exit+0x118>
8010406e:	83 c0 6c             	add    $0x6c,%eax
80104071:	eb 0c                	jmp    8010407f <exit+0x13f>
80104073:	90                   	nop
80104074:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(t = p->threads; t < &p->threads[NTHREAD]; t++)
80104078:	83 c0 20             	add    $0x20,%eax
8010407b:	39 c2                	cmp    %eax,%edx
8010407d:	76 d9                	jbe    80104058 <exit+0x118>
        if(t->state == TSLEEPING && t->chan == chan)
8010407f:	83 78 04 02          	cmpl   $0x2,0x4(%eax)
80104083:	75 f3                	jne    80104078 <exit+0x138>
80104085:	3b 70 18             	cmp    0x18(%eax),%esi
80104088:	75 ee                	jne    80104078 <exit+0x138>
          t->state = TRUNNABLE;
8010408a:	c7 40 04 03 00 00 00 	movl   $0x3,0x4(%eax)
80104091:	eb e5                	jmp    80104078 <exit+0x138>
  kill_all();
80104093:	e8 98 fc ff ff       	call   80103d30 <kill_all>
  thread->state = TINVALID;
80104098:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
8010409e:	c7 40 04 06 00 00 00 	movl   $0x6,0x4(%eax)
  proc->state = ZOMBIE;
801040a5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801040ab:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%eax)
  sched();
801040b2:	e8 e9 fd ff ff       	call   80103ea0 <sched>
  panic("zombie exit");
801040b7:	83 ec 0c             	sub    $0xc,%esp
801040ba:	68 05 81 10 80       	push   $0x80108105
801040bf:	e8 ac c2 ff ff       	call   80100370 <panic>
    panic("init exiting");
801040c4:	83 ec 0c             	sub    $0xc,%esp
801040c7:	68 f8 80 10 80       	push   $0x801080f8
801040cc:	e8 9f c2 ff ff       	call   80100370 <panic>
801040d1:	eb 0d                	jmp    801040e0 <yield>
801040d3:	90                   	nop
801040d4:	90                   	nop
801040d5:	90                   	nop
801040d6:	90                   	nop
801040d7:	90                   	nop
801040d8:	90                   	nop
801040d9:	90                   	nop
801040da:	90                   	nop
801040db:	90                   	nop
801040dc:	90                   	nop
801040dd:	90                   	nop
801040de:	90                   	nop
801040df:	90                   	nop

801040e0 <yield>:
{
801040e0:	55                   	push   %ebp
801040e1:	89 e5                	mov    %esp,%ebp
801040e3:	83 ec 14             	sub    $0x14,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
801040e6:	68 40 2b 11 80       	push   $0x80112b40
801040eb:	e8 10 0a 00 00       	call   80104b00 <acquire>
  thread->state = TRUNNABLE;
801040f0:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
801040f6:	c7 40 04 03 00 00 00 	movl   $0x3,0x4(%eax)
  sched();
801040fd:	e8 9e fd ff ff       	call   80103ea0 <sched>
  release(&ptable.lock);
80104102:	c7 04 24 40 2b 11 80 	movl   $0x80112b40,(%esp)
80104109:	e8 b2 0b 00 00       	call   80104cc0 <release>
}
8010410e:	83 c4 10             	add    $0x10,%esp
80104111:	c9                   	leave  
80104112:	c3                   	ret    
80104113:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104120 <sleep>:
  if(proc == 0 || thread == 0)
80104120:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
{
80104126:	55                   	push   %ebp
80104127:	89 e5                	mov    %esp,%ebp
80104129:	56                   	push   %esi
8010412a:	53                   	push   %ebx
  if(proc == 0 || thread == 0)
8010412b:	85 c0                	test   %eax,%eax
{
8010412d:	8b 75 08             	mov    0x8(%ebp),%esi
80104130:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(proc == 0 || thread == 0)
80104133:	0f 84 9a 00 00 00    	je     801041d3 <sleep+0xb3>
80104139:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
8010413f:	85 c0                	test   %eax,%eax
80104141:	0f 84 8c 00 00 00    	je     801041d3 <sleep+0xb3>
  if(lk == 0)
80104147:	85 db                	test   %ebx,%ebx
80104149:	0f 84 91 00 00 00    	je     801041e0 <sleep+0xc0>
  if(lk != &ptable.lock){  //DOC: sleeplock0
8010414f:	81 fb 40 2b 11 80    	cmp    $0x80112b40,%ebx
80104155:	74 59                	je     801041b0 <sleep+0x90>
    acquire(&ptable.lock);  //DOC: 4lock1
80104157:	83 ec 0c             	sub    $0xc,%esp
8010415a:	68 40 2b 11 80       	push   $0x80112b40
8010415f:	e8 9c 09 00 00       	call   80104b00 <acquire>
    release(lk);
80104164:	89 1c 24             	mov    %ebx,(%esp)
80104167:	e8 54 0b 00 00       	call   80104cc0 <release>
  thread->chan = chan;
8010416c:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
80104172:	89 70 18             	mov    %esi,0x18(%eax)
  thread->state = TSLEEPING;
80104175:	c7 40 04 02 00 00 00 	movl   $0x2,0x4(%eax)
  sched();
8010417c:	e8 1f fd ff ff       	call   80103ea0 <sched>
  thread->chan = 0;
80104181:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
80104187:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
    release(&ptable.lock);
8010418e:	c7 04 24 40 2b 11 80 	movl   $0x80112b40,(%esp)
80104195:	e8 26 0b 00 00       	call   80104cc0 <release>
    acquire(lk);
8010419a:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010419d:	83 c4 10             	add    $0x10,%esp
}
801041a0:	8d 65 f8             	lea    -0x8(%ebp),%esp
801041a3:	5b                   	pop    %ebx
801041a4:	5e                   	pop    %esi
801041a5:	5d                   	pop    %ebp
    acquire(lk);
801041a6:	e9 55 09 00 00       	jmp    80104b00 <acquire>
801041ab:	90                   	nop
801041ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  thread->chan = chan;
801041b0:	89 70 18             	mov    %esi,0x18(%eax)
  thread->state = TSLEEPING;
801041b3:	c7 40 04 02 00 00 00 	movl   $0x2,0x4(%eax)
  sched();
801041ba:	e8 e1 fc ff ff       	call   80103ea0 <sched>
  thread->chan = 0;
801041bf:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
801041c5:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
}
801041cc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801041cf:	5b                   	pop    %ebx
801041d0:	5e                   	pop    %esi
801041d1:	5d                   	pop    %ebp
801041d2:	c3                   	ret    
    panic("sleep");
801041d3:	83 ec 0c             	sub    $0xc,%esp
801041d6:	68 11 81 10 80       	push   $0x80108111
801041db:	e8 90 c1 ff ff       	call   80100370 <panic>
    panic("sleep without lk");
801041e0:	83 ec 0c             	sub    $0xc,%esp
801041e3:	68 17 81 10 80       	push   $0x80108117
801041e8:	e8 83 c1 ff ff       	call   80100370 <panic>
801041ed:	8d 76 00             	lea    0x0(%esi),%esi

801041f0 <wait>:
{
801041f0:	55                   	push   %ebp
801041f1:	89 e5                	mov    %esp,%ebp
801041f3:	57                   	push   %edi
801041f4:	56                   	push   %esi
801041f5:	53                   	push   %ebx
801041f6:	83 ec 28             	sub    $0x28,%esp
  acquire(&ptable.lock);
801041f9:	68 40 2b 11 80       	push   $0x80112b40
801041fe:	e8 fd 08 00 00       	call   80104b00 <acquire>
80104203:	83 c4 10             	add    $0x10,%esp
      if(p->parent != proc)
80104206:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
    havekids = 0;
8010420c:	31 d2                	xor    %edx,%edx
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010420e:	bb 74 2b 11 80       	mov    $0x80112b74,%ebx
80104213:	eb 11                	jmp    80104226 <wait+0x36>
80104215:	8d 76 00             	lea    0x0(%esi),%esi
80104218:	81 c3 6c 02 00 00    	add    $0x26c,%ebx
8010421e:	81 fb 74 c6 11 80    	cmp    $0x8011c674,%ebx
80104224:	73 1e                	jae    80104244 <wait+0x54>
      if(p->parent != proc)
80104226:	39 43 10             	cmp    %eax,0x10(%ebx)
80104229:	75 ed                	jne    80104218 <wait+0x28>
      if(p->state == ZOMBIE){
8010422b:	83 7b 08 02          	cmpl   $0x2,0x8(%ebx)
8010422f:	74 3f                	je     80104270 <wait+0x80>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104231:	81 c3 6c 02 00 00    	add    $0x26c,%ebx
      havekids = 1;
80104237:	ba 01 00 00 00       	mov    $0x1,%edx
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010423c:	81 fb 74 c6 11 80    	cmp    $0x8011c674,%ebx
80104242:	72 e2                	jb     80104226 <wait+0x36>
    if(!havekids || proc->killed){
80104244:	85 d2                	test   %edx,%edx
80104246:	0f 84 c9 00 00 00    	je     80104315 <wait+0x125>
8010424c:	8b 50 14             	mov    0x14(%eax),%edx
8010424f:	85 d2                	test   %edx,%edx
80104251:	0f 85 be 00 00 00    	jne    80104315 <wait+0x125>
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
80104257:	83 ec 08             	sub    $0x8,%esp
8010425a:	68 40 2b 11 80       	push   $0x80112b40
8010425f:	50                   	push   %eax
80104260:	e8 bb fe ff ff       	call   80104120 <sleep>
    havekids = 0;
80104265:	83 c4 10             	add    $0x10,%esp
80104268:	eb 9c                	jmp    80104206 <wait+0x16>
8010426a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        pid = p->pid;
80104270:	8b 43 0c             	mov    0xc(%ebx),%eax
        for(t = p->threads; t < &p->threads[NTHREAD]; t++)
80104273:	8d 73 6c             	lea    0x6c(%ebx),%esi
80104276:	8d bb 6c 02 00 00    	lea    0x26c(%ebx),%edi
        pid = p->pid;
8010427c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010427f:	eb 30                	jmp    801042b1 <wait+0xc1>
80104281:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  t->kstack = 0;
80104288:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
  t->tid = 0;
8010428f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
        for(t = p->threads; t < &p->threads[NTHREAD]; t++)
80104295:	83 c6 20             	add    $0x20,%esi
  t->state = TUNUSED;
80104298:	c7 46 e4 00 00 00 00 	movl   $0x0,-0x1c(%esi)
  t->parent = 0;
8010429f:	c7 46 ec 00 00 00 00 	movl   $0x0,-0x14(%esi)
  t->killed = 0;
801042a6:	c7 46 fc 00 00 00 00 	movl   $0x0,-0x4(%esi)
        for(t = p->threads; t < &p->threads[NTHREAD]; t++)
801042ad:	39 f7                	cmp    %esi,%edi
801042af:	76 1f                	jbe    801042d0 <wait+0xe0>
  if(t->state == TINVALID || t->state == TZOMBIE)
801042b1:	8b 46 04             	mov    0x4(%esi),%eax
801042b4:	83 e8 05             	sub    $0x5,%eax
801042b7:	83 f8 01             	cmp    $0x1,%eax
801042ba:	77 cc                	ja     80104288 <wait+0x98>
    kfree(t->kstack);
801042bc:	83 ec 0c             	sub    $0xc,%esp
801042bf:	ff 76 08             	pushl  0x8(%esi)
801042c2:	e8 a9 e0 ff ff       	call   80102370 <kfree>
801042c7:	83 c4 10             	add    $0x10,%esp
801042ca:	eb bc                	jmp    80104288 <wait+0x98>
801042cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        freevm(p->pgdir);
801042d0:	83 ec 0c             	sub    $0xc,%esp
801042d3:	ff 73 04             	pushl  0x4(%ebx)
801042d6:	e8 15 34 00 00       	call   801076f0 <freevm>
        release(&ptable.lock);
801042db:	c7 04 24 40 2b 11 80 	movl   $0x80112b40,(%esp)
        p->pid = 0;
801042e2:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        p->parent = 0;
801042e9:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->name[0] = 0;
801042f0:	c6 43 5c 00          	movb   $0x0,0x5c(%ebx)
        p->killed = 0;
801042f4:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->state = UNUSED;
801042fb:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        release(&ptable.lock);
80104302:	e8 b9 09 00 00       	call   80104cc0 <release>
        return pid;
80104307:	83 c4 10             	add    $0x10,%esp
}
8010430a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010430d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104310:	5b                   	pop    %ebx
80104311:	5e                   	pop    %esi
80104312:	5f                   	pop    %edi
80104313:	5d                   	pop    %ebp
80104314:	c3                   	ret    
      release(&ptable.lock);
80104315:	83 ec 0c             	sub    $0xc,%esp
80104318:	68 40 2b 11 80       	push   $0x80112b40
8010431d:	e8 9e 09 00 00       	call   80104cc0 <release>
      return -1;
80104322:	83 c4 10             	add    $0x10,%esp
80104325:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
8010432c:	eb dc                	jmp    8010430a <wait+0x11a>
8010432e:	66 90                	xchg   %ax,%ax

80104330 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104330:	55                   	push   %ebp
80104331:	89 e5                	mov    %esp,%ebp
80104333:	53                   	push   %ebx
80104334:	83 ec 10             	sub    $0x10,%esp
80104337:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010433a:	68 40 2b 11 80       	push   $0x80112b40
8010433f:	e8 bc 07 00 00       	call   80104b00 <acquire>
80104344:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104347:	b8 74 2b 11 80       	mov    $0x80112b74,%eax
8010434c:	eb 0c                	jmp    8010435a <wakeup+0x2a>
8010434e:	66 90                	xchg   %ax,%ax
80104350:	81 fa 74 c6 11 80    	cmp    $0x8011c674,%edx
80104356:	89 d0                	mov    %edx,%eax
80104358:	73 36                	jae    80104390 <wakeup+0x60>
    if(p->state == USED)
8010435a:	83 78 08 01          	cmpl   $0x1,0x8(%eax)
8010435e:	8d 90 6c 02 00 00    	lea    0x26c(%eax),%edx
80104364:	75 ea                	jne    80104350 <wakeup+0x20>
80104366:	83 c0 6c             	add    $0x6c,%eax
80104369:	eb 0c                	jmp    80104377 <wakeup+0x47>
8010436b:	90                   	nop
8010436c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(t = p->threads; t < &p->threads[NTHREAD]; t++)
80104370:	83 c0 20             	add    $0x20,%eax
80104373:	39 c2                	cmp    %eax,%edx
80104375:	76 d9                	jbe    80104350 <wakeup+0x20>
        if(t->state == TSLEEPING && t->chan == chan)
80104377:	83 78 04 02          	cmpl   $0x2,0x4(%eax)
8010437b:	75 f3                	jne    80104370 <wakeup+0x40>
8010437d:	3b 58 18             	cmp    0x18(%eax),%ebx
80104380:	75 ee                	jne    80104370 <wakeup+0x40>
          t->state = TRUNNABLE;
80104382:	c7 40 04 03 00 00 00 	movl   $0x3,0x4(%eax)
80104389:	eb e5                	jmp    80104370 <wakeup+0x40>
8010438b:	90                   	nop
8010438c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  wakeup1(chan);
  release(&ptable.lock);
80104390:	c7 45 08 40 2b 11 80 	movl   $0x80112b40,0x8(%ebp)
}
80104397:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010439a:	c9                   	leave  
  release(&ptable.lock);
8010439b:	e9 20 09 00 00       	jmp    80104cc0 <release>

801043a0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801043a0:	55                   	push   %ebp
801043a1:	89 e5                	mov    %esp,%ebp
801043a3:	53                   	push   %ebx
801043a4:	83 ec 10             	sub    $0x10,%esp
801043a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;
  struct thread *t;

  acquire(&ptable.lock);
801043aa:	68 40 2b 11 80       	push   $0x80112b40
801043af:	e8 4c 07 00 00       	call   80104b00 <acquire>
801043b4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801043b7:	b8 74 2b 11 80       	mov    $0x80112b74,%eax
801043bc:	eb 0e                	jmp    801043cc <kill+0x2c>
801043be:	66 90                	xchg   %ax,%ax
801043c0:	05 6c 02 00 00       	add    $0x26c,%eax
801043c5:	3d 74 c6 11 80       	cmp    $0x8011c674,%eax
801043ca:	73 44                	jae    80104410 <kill+0x70>
    if(p->pid == pid){
801043cc:	39 58 0c             	cmp    %ebx,0xc(%eax)
801043cf:	75 ef                	jne    801043c0 <kill+0x20>
      p->killed = 1;
801043d1:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
      // Wake process from sleep if necessary.
      for(t = p->threads; t < &p->threads[NTHREAD]; t++)
801043d8:	8d 50 6c             	lea    0x6c(%eax),%edx
801043db:	05 6c 02 00 00       	add    $0x26c,%eax
        if(t->state == TSLEEPING)
801043e0:	83 7a 04 02          	cmpl   $0x2,0x4(%edx)
801043e4:	75 07                	jne    801043ed <kill+0x4d>
          t->state = TRUNNABLE;
801043e6:	c7 42 04 03 00 00 00 	movl   $0x3,0x4(%edx)
      for(t = p->threads; t < &p->threads[NTHREAD]; t++)
801043ed:	83 c2 20             	add    $0x20,%edx
801043f0:	39 d0                	cmp    %edx,%eax
801043f2:	77 ec                	ja     801043e0 <kill+0x40>

      release(&ptable.lock);
801043f4:	83 ec 0c             	sub    $0xc,%esp
801043f7:	68 40 2b 11 80       	push   $0x80112b40
801043fc:	e8 bf 08 00 00       	call   80104cc0 <release>
      return 0;
80104401:	83 c4 10             	add    $0x10,%esp
80104404:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80104406:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104409:	c9                   	leave  
8010440a:	c3                   	ret    
8010440b:	90                   	nop
8010440c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104410:	83 ec 0c             	sub    $0xc,%esp
80104413:	68 40 2b 11 80       	push   $0x80112b40
80104418:	e8 a3 08 00 00       	call   80104cc0 <release>
  return -1;
8010441d:	83 c4 10             	add    $0x10,%esp
80104420:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104425:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104428:	c9                   	leave  
80104429:	c3                   	ret    
8010442a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104430 <killSelf>:
// Kill the threads with of given process with pid.
// Thread won't exit until it returns
// to user space (see trap in trap.c).
void
killSelf()
{
80104430:	55                   	push   %ebp
80104431:	89 e5                	mov    %esp,%ebp
80104433:	83 ec 14             	sub    $0x14,%esp
  acquire(&ptable.lock);
80104436:	68 40 2b 11 80       	push   $0x80112b40
8010443b:	e8 c0 06 00 00       	call   80104b00 <acquire>
  wakeup1(thread);
80104440:	65 8b 0d 08 00 00 00 	mov    %gs:0x8,%ecx
80104447:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010444a:	b8 74 2b 11 80       	mov    $0x80112b74,%eax
8010444f:	eb 11                	jmp    80104462 <killSelf+0x32>
80104451:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104458:	81 fa 74 c6 11 80    	cmp    $0x8011c674,%edx
8010445e:	89 d0                	mov    %edx,%eax
80104460:	73 36                	jae    80104498 <killSelf+0x68>
    if(p->state == USED)
80104462:	83 78 08 01          	cmpl   $0x1,0x8(%eax)
80104466:	8d 90 6c 02 00 00    	lea    0x26c(%eax),%edx
8010446c:	75 ea                	jne    80104458 <killSelf+0x28>
8010446e:	83 c0 6c             	add    $0x6c,%eax
80104471:	eb 0c                	jmp    8010447f <killSelf+0x4f>
80104473:	90                   	nop
80104474:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(t = p->threads; t < &p->threads[NTHREAD]; t++)
80104478:	83 c0 20             	add    $0x20,%eax
8010447b:	39 c2                	cmp    %eax,%edx
8010447d:	76 d9                	jbe    80104458 <killSelf+0x28>
        if(t->state == TSLEEPING && t->chan == chan)
8010447f:	83 78 04 02          	cmpl   $0x2,0x4(%eax)
80104483:	75 f3                	jne    80104478 <killSelf+0x48>
80104485:	3b 48 18             	cmp    0x18(%eax),%ecx
80104488:	75 ee                	jne    80104478 <killSelf+0x48>
          t->state = TRUNNABLE;
8010448a:	c7 40 04 03 00 00 00 	movl   $0x3,0x4(%eax)
80104491:	eb e5                	jmp    80104478 <killSelf+0x48>
80104493:	90                   	nop
80104494:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  thread->state = TINVALID; // thread must INVALID itself! - else two cpu's can run on the same thread
80104498:	c7 41 04 06 00 00 00 	movl   $0x6,0x4(%ecx)
  sched();
}
8010449f:	c9                   	leave  
  sched();
801044a0:	e9 fb f9 ff ff       	jmp    80103ea0 <sched>
801044a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801044a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801044b0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801044b0:	55                   	push   %ebp
801044b1:	89 e5                	mov    %esp,%ebp
801044b3:	57                   	push   %edi
801044b4:	56                   	push   %esi
801044b5:	53                   	push   %ebx
  struct proc *p;
  struct thread *t;
  char *state;//, *threadState;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801044b6:	be 74 2b 11 80       	mov    $0x80112b74,%esi
{
801044bb:	83 ec 3c             	sub    $0x3c,%esp
801044be:	66 90                	xchg   %ax,%ax
    if(p->state == UNUSED)
801044c0:	8b 46 08             	mov    0x8(%esi),%eax
801044c3:	8d 9e 6c 02 00 00    	lea    0x26c(%esi),%ebx
801044c9:	85 c0                	test   %eax,%eax
801044cb:	74 50                	je     8010451d <procdump+0x6d>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801044cd:	83 f8 02             	cmp    $0x2,%eax
      state = states[p->state];
    else
      state = "???";
801044d0:	ba 28 81 10 80       	mov    $0x80108128,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801044d5:	77 11                	ja     801044e8 <procdump+0x38>
801044d7:	8b 14 85 48 81 10 80 	mov    -0x7fef7eb8(,%eax,4),%edx
      state = "???";
801044de:	b8 28 81 10 80       	mov    $0x80108128,%eax
801044e3:	85 d2                	test   %edx,%edx
801044e5:	0f 44 d0             	cmove  %eax,%edx

    cprintf("%d %s %s\n", p->pid, state, p->name);
801044e8:	8d 46 5c             	lea    0x5c(%esi),%eax
801044eb:	8d 7e 6c             	lea    0x6c(%esi),%edi
801044ee:	8d 9e 6c 02 00 00    	lea    0x26c(%esi),%ebx
801044f4:	50                   	push   %eax
801044f5:	52                   	push   %edx
801044f6:	ff 76 0c             	pushl  0xc(%esi)
801044f9:	68 2c 81 10 80       	push   $0x8010812c
801044fe:	e8 3d c1 ff ff       	call   80100640 <cprintf>
80104503:	83 c4 10             	add    $0x10,%esp
80104506:	8d 76 00             	lea    0x0(%esi),%esi
80104509:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    for(t = p->threads; t < &p->threads[NTHREAD]; t++){


      if(t->state == TSLEEPING){
80104510:	83 7f 04 02          	cmpl   $0x2,0x4(%edi)
80104514:	74 1a                	je     80104530 <procdump+0x80>
    for(t = p->threads; t < &p->threads[NTHREAD]; t++){
80104516:	83 c7 20             	add    $0x20,%edi
80104519:	39 df                	cmp    %ebx,%edi
8010451b:	72 f3                	jb     80104510 <procdump+0x60>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010451d:	81 fb 74 c6 11 80    	cmp    $0x8011c674,%ebx
80104523:	89 de                	mov    %ebx,%esi
80104525:	72 99                	jb     801044c0 <procdump+0x10>
      }
    }


  }
}
80104527:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010452a:	5b                   	pop    %ebx
8010452b:	5e                   	pop    %esi
8010452c:	5f                   	pop    %edi
8010452d:	5d                   	pop    %ebp
8010452e:	c3                   	ret    
8010452f:	90                   	nop
        getcallerpcs((uint*)t->context->ebp+2, pc);
80104530:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104533:	83 ec 08             	sub    $0x8,%esp
80104536:	8d 75 c0             	lea    -0x40(%ebp),%esi
80104539:	50                   	push   %eax
8010453a:	8b 57 14             	mov    0x14(%edi),%edx
8010453d:	8b 52 0c             	mov    0xc(%edx),%edx
80104540:	83 c2 08             	add    $0x8,%edx
80104543:	52                   	push   %edx
80104544:	e8 77 06 00 00       	call   80104bc0 <getcallerpcs>
80104549:	83 c4 10             	add    $0x10,%esp
8010454c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        for(i=0; i<10 && pc[i] != 0; i++)
80104550:	8b 0e                	mov    (%esi),%ecx
80104552:	85 c9                	test   %ecx,%ecx
80104554:	74 1b                	je     80104571 <procdump+0xc1>
          cprintf("%p ", pc[i]);
80104556:	83 ec 08             	sub    $0x8,%esp
80104559:	83 c6 04             	add    $0x4,%esi
8010455c:	51                   	push   %ecx
8010455d:	68 36 81 10 80       	push   $0x80108136
80104562:	e8 d9 c0 ff ff       	call   80100640 <cprintf>
        for(i=0; i<10 && pc[i] != 0; i++)
80104567:	8d 45 e8             	lea    -0x18(%ebp),%eax
8010456a:	83 c4 10             	add    $0x10,%esp
8010456d:	39 c6                	cmp    %eax,%esi
8010456f:	75 df                	jne    80104550 <procdump+0xa0>
        cprintf("\n");
80104571:	83 ec 0c             	sub    $0xc,%esp
80104574:	68 66 80 10 80       	push   $0x80108066
80104579:	e8 c2 c0 ff ff       	call   80100640 <cprintf>
8010457e:	83 c4 10             	add    $0x10,%esp
80104581:	eb 93                	jmp    80104516 <procdump+0x66>
80104583:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104590 <kthread_create>:
// Create a new thread with context of the calling process.
// Newly created thread state will be TRUNABLE
// must allocate a user stack for the new thread to use
int
kthread_create(void* (*start_func)(), void* stack, int stack_size) //create a thread for calling process
{
80104590:	55                   	push   %ebp
80104591:	89 e5                	mov    %esp,%ebp
80104593:	57                   	push   %edi
80104594:	56                   	push   %esi
  struct thread *t;
  t = allocthread(proc); //allocate
80104595:	83 ec 0c             	sub    $0xc,%esp
80104598:	65 ff 35 04 00 00 00 	pushl  %gs:0x4
8010459f:	e8 fc f2 ff ff       	call   801038a0 <allocthread>
  if(t != 0){ //Was thread allocated properly
801045a4:	83 c4 10             	add    $0x10,%esp
801045a7:	85 c0                	test   %eax,%eax
801045a9:	74 42                	je     801045ed <kthread_create+0x5d>
    *t->tf = *thread->tf; //copy frame
801045ab:	65 8b 15 08 00 00 00 	mov    %gs:0x8,%edx
801045b2:	8b 78 10             	mov    0x10(%eax),%edi
801045b5:	b9 13 00 00 00       	mov    $0x13,%ecx
801045ba:	8b 72 10             	mov    0x10(%edx),%esi
    t->tf->esp = (uint)stack+stack_size;
801045bd:	8b 55 10             	mov    0x10(%ebp),%edx
    *t->tf = *thread->tf; //copy frame
801045c0:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    t->tf->esp = (uint)stack+stack_size;
801045c2:	03 55 0c             	add    0xc(%ebp),%edx
801045c5:	8b 48 10             	mov    0x10(%eax),%ecx
801045c8:	89 51 44             	mov    %edx,0x44(%ecx)
    t->tf->ebp = t->tf->esp;
801045cb:	8b 50 10             	mov    0x10(%eax),%edx
801045ce:	8b 4a 44             	mov    0x44(%edx),%ecx
801045d1:	89 4a 08             	mov    %ecx,0x8(%edx)
    t->tf->eip = (uint)start_func;
801045d4:	8b 4d 08             	mov    0x8(%ebp),%ecx
801045d7:	8b 50 10             	mov    0x10(%eax),%edx
801045da:	89 4a 38             	mov    %ecx,0x38(%edx)
    t->state = TRUNNABLE; //set runnable
801045dd:	c7 40 04 03 00 00 00 	movl   $0x3,0x4(%eax)
    return t->tid;
801045e4:	8b 00                	mov    (%eax),%eax
  } else { //Error allocating thread
    return -1;
  }
}
801045e6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801045e9:	5e                   	pop    %esi
801045ea:	5f                   	pop    %edi
801045eb:	5d                   	pop    %ebp
801045ec:	c3                   	ret    
    return -1;
801045ed:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801045f2:	eb f2                	jmp    801045e6 <kthread_create+0x56>
801045f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801045fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104600 <kthread_id>:
// Return the caller thread's id
// If Error: non-positive error identifier returned
int
kthread_id() //returns the thread id
{
  if((thread != 0) && (proc != 0)){ //If both pointers non zero
80104600:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
{
80104606:	55                   	push   %ebp
80104607:	89 e5                	mov    %esp,%ebp
  if((thread != 0) && (proc != 0)){ //If both pointers non zero
80104609:	85 c0                	test   %eax,%eax
8010460b:	74 13                	je     80104620 <kthread_id+0x20>
8010460d:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104614:	85 d2                	test   %edx,%edx
80104616:	74 08                	je     80104620 <kthread_id+0x20>
    return thread->tid;
80104618:	8b 00                	mov    (%eax),%eax
  } else { //Error otherwise
    return -1;
  }
}
8010461a:	5d                   	pop    %ebp
8010461b:	c3                   	ret    
8010461c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104620:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104625:	5d                   	pop    %ebp
80104626:	c3                   	ret    
80104627:	89 f6                	mov    %esi,%esi
80104629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104630 <kthread_exit>:

// Terminate the execution of the calling thread
// Should not terminate the whole process if other thread exist within the same process
void
kthread_exit() //close current thread and maybe the process
{
80104630:	55                   	push   %ebp
80104631:	89 e5                	mov    %esp,%ebp
80104633:	57                   	push   %edi
80104634:	56                   	push   %esi
80104635:	53                   	push   %ebx
80104636:	83 ec 18             	sub    $0x18,%esp
  struct thread *t;
  acquire(&ptable.lock); //process switch cause issues with in search
80104639:	68 40 2b 11 80       	push   $0x80112b40
8010463e:	e8 bd 04 00 00       	call   80104b00 <acquire>
  struct proc *p = proc;
  int found = 0;
  for(t = p->threads; found != 1 && t < &p->threads[NTHREAD]; t++){ //loop through threads
    if(t->tid != thread->tid){ //if not current thread
80104643:	65 8b 0d 08 00 00 00 	mov    %gs:0x8,%ecx
  struct proc *p = proc;
8010464a:	65 8b 1d 04 00 00 00 	mov    %gs:0x4,%ebx
    if(t->tid != thread->tid){ //if not current thread
80104651:	83 c4 10             	add    $0x10,%esp
80104654:	8b 39                	mov    (%ecx),%edi
  for(t = p->threads; found != 1 && t < &p->threads[NTHREAD]; t++){ //loop through threads
80104656:	8d 43 6c             	lea    0x6c(%ebx),%eax
80104659:	81 c3 6c 02 00 00    	add    $0x26c,%ebx
8010465f:	90                   	nop
    if(t->tid != thread->tid){ //if not current thread
80104660:	39 38                	cmp    %edi,(%eax)
80104662:	74 0f                	je     80104673 <kthread_exit+0x43>
      if((t->state != TUNUSED) && (t->state != TZOMBIE) && (t->state != TINVALID)) //if not bad state
80104664:	8b 50 04             	mov    0x4(%eax),%edx
80104667:	8d 72 fb             	lea    -0x5(%edx),%esi
8010466a:	83 fe 01             	cmp    $0x1,%esi
8010466d:	76 04                	jbe    80104673 <kthread_exit+0x43>
8010466f:	85 d2                	test   %edx,%edx
80104671:	75 19                	jne    8010468c <kthread_exit+0x5c>
  for(t = p->threads; found != 1 && t < &p->threads[NTHREAD]; t++){ //loop through threads
80104673:	83 c0 20             	add    $0x20,%eax
80104676:	39 c3                	cmp    %eax,%ebx
80104678:	77 e6                	ja     80104660 <kthread_exit+0x30>

  if(found){ //if not a solo thread
    wakeup1(thread); //wakeup chan
    release(&ptable.lock);
  } else{ //if solo thread
    release(&ptable.lock); //wakeup gets lock so release.
8010467a:	83 ec 0c             	sub    $0xc,%esp
8010467d:	68 40 2b 11 80       	push   $0x80112b40
80104682:	e8 39 06 00 00       	call   80104cc0 <release>
    exit(); //process go bye bye
80104687:	e8 b4 f8 ff ff       	call   80103f40 <exit>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010468c:	b8 74 2b 11 80       	mov    $0x80112b74,%eax
80104691:	eb 0f                	jmp    801046a2 <kthread_exit+0x72>
80104693:	90                   	nop
80104694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104698:	81 fa 74 c6 11 80    	cmp    $0x8011c674,%edx
8010469e:	89 d0                	mov    %edx,%eax
801046a0:	73 36                	jae    801046d8 <kthread_exit+0xa8>
    if(p->state == USED)
801046a2:	83 78 08 01          	cmpl   $0x1,0x8(%eax)
801046a6:	8d 90 6c 02 00 00    	lea    0x26c(%eax),%edx
801046ac:	75 ea                	jne    80104698 <kthread_exit+0x68>
801046ae:	83 c0 6c             	add    $0x6c,%eax
801046b1:	eb 0c                	jmp    801046bf <kthread_exit+0x8f>
801046b3:	90                   	nop
801046b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(t = p->threads; t < &p->threads[NTHREAD]; t++)
801046b8:	83 c0 20             	add    $0x20,%eax
801046bb:	39 d0                	cmp    %edx,%eax
801046bd:	73 d9                	jae    80104698 <kthread_exit+0x68>
        if(t->state == TSLEEPING && t->chan == chan)
801046bf:	83 78 04 02          	cmpl   $0x2,0x4(%eax)
801046c3:	75 f3                	jne    801046b8 <kthread_exit+0x88>
801046c5:	3b 48 18             	cmp    0x18(%eax),%ecx
801046c8:	75 ee                	jne    801046b8 <kthread_exit+0x88>
          t->state = TRUNNABLE;
801046ca:	c7 40 04 03 00 00 00 	movl   $0x3,0x4(%eax)
801046d1:	eb e5                	jmp    801046b8 <kthread_exit+0x88>
801046d3:	90                   	nop
801046d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    release(&ptable.lock);
801046d8:	83 ec 0c             	sub    $0xc,%esp
801046db:	68 40 2b 11 80       	push   $0x80112b40
801046e0:	e8 db 05 00 00       	call   80104cc0 <release>
    wakeup(thread); //wakeup chan
  }
  acquire(&ptable.lock);
801046e5:	c7 04 24 40 2b 11 80 	movl   $0x80112b40,(%esp)
801046ec:	e8 0f 04 00 00       	call   80104b00 <acquire>
  thread->state = TZOMBIE;
801046f1:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
  sched();
801046f7:	83 c4 10             	add    $0x10,%esp
  thread->state = TZOMBIE;
801046fa:	c7 40 04 05 00 00 00 	movl   $0x5,0x4(%eax)
}
80104701:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104704:	5b                   	pop    %ebx
80104705:	5e                   	pop    %esi
80104706:	5f                   	pop    %edi
80104707:	5d                   	pop    %ebp
  sched();
80104708:	e9 93 f7 ff ff       	jmp    80103ea0 <sched>
8010470d:	8d 76 00             	lea    0x0(%esi),%esi

80104710 <kthread_join>:
// Suspend the execution of the thread until the target thread terminates
// NOT suspended if thread has already exist
// Return 0 when sucessful
int
kthread_join(int thread_id)
{
80104710:	55                   	push   %ebp
80104711:	89 e5                	mov    %esp,%ebp
80104713:	56                   	push   %esi
80104714:	53                   	push   %ebx
80104715:	83 ec 10             	sub    $0x10,%esp

  if(thread_id == thread->tid){ //dont allow join on self
80104718:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
{
8010471e:	8b 75 08             	mov    0x8(%ebp),%esi
  if(thread_id == thread->tid){ //dont allow join on self
80104721:	39 30                	cmp    %esi,(%eax)
80104723:	74 26                	je     8010474b <kthread_join+0x3b>
    return -1;
  }

  struct thread *t;
  struct proc *p = proc;
80104725:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  int found = 0;

  for(t = p->threads; found != 1 && t < &p->threads[NTHREAD]; t++){ //loop through threads
    if(t->tid == thread_id){ //if we found the one
8010472c:	3b 72 6c             	cmp    0x6c(%edx),%esi
  for(t = p->threads; found != 1 && t < &p->threads[NTHREAD]; t++){ //loop through threads
8010472f:	8d 5a 6c             	lea    0x6c(%edx),%ebx
80104732:	8d 82 6c 02 00 00    	lea    0x26c(%edx),%eax
    if(t->tid == thread_id){ //if we found the one
80104738:	75 0a                	jne    80104744 <kthread_join+0x34>
8010473a:	eb 24                	jmp    80104760 <kthread_join+0x50>
8010473c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104740:	39 33                	cmp    %esi,(%ebx)
80104742:	74 1c                	je     80104760 <kthread_join+0x50>
  for(t = p->threads; found != 1 && t < &p->threads[NTHREAD]; t++){ //loop through threads
80104744:	83 c3 20             	add    $0x20,%ebx
80104747:	39 c3                	cmp    %eax,%ebx
80104749:	72 f5                	jb     80104740 <kthread_join+0x30>
    if(t->state == TZOMBIE) { //Clear thread if already exited
      clearThread(t);
    }
    return 0;
  }
}
8010474b:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
8010474e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104753:	5b                   	pop    %ebx
80104754:	5e                   	pop    %esi
80104755:	5d                   	pop    %ebp
80104756:	c3                   	ret    
80104757:	89 f6                	mov    %esi,%esi
80104759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    acquire(&ptable.lock); //lock needed for sleep, so acquire
80104760:	83 ec 0c             	sub    $0xc,%esp
80104763:	68 40 2b 11 80       	push   $0x80112b40
80104768:	e8 93 03 00 00       	call   80104b00 <acquire>
    while(t->tid == thread_id && ((t->state != TUNUSED) && (t->state != TZOMBIE) && (t->state != TINVALID))){
8010476d:	83 c4 10             	add    $0x10,%esp
80104770:	3b 33                	cmp    (%ebx),%esi
80104772:	74 25                	je     80104799 <kthread_join+0x89>
80104774:	eb 2e                	jmp    801047a4 <kthread_join+0x94>
80104776:	8d 76 00             	lea    0x0(%esi),%esi
80104779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104780:	85 c0                	test   %eax,%eax
80104782:	74 20                	je     801047a4 <kthread_join+0x94>
      sleep(t, &ptable.lock); //sleep with lock if state isn't bad
80104784:	83 ec 08             	sub    $0x8,%esp
80104787:	68 40 2b 11 80       	push   $0x80112b40
8010478c:	53                   	push   %ebx
8010478d:	e8 8e f9 ff ff       	call   80104120 <sleep>
    while(t->tid == thread_id && ((t->state != TUNUSED) && (t->state != TZOMBIE) && (t->state != TINVALID))){
80104792:	83 c4 10             	add    $0x10,%esp
80104795:	39 33                	cmp    %esi,(%ebx)
80104797:	75 0b                	jne    801047a4 <kthread_join+0x94>
80104799:	8b 43 04             	mov    0x4(%ebx),%eax
8010479c:	8d 50 fb             	lea    -0x5(%eax),%edx
8010479f:	83 fa 01             	cmp    $0x1,%edx
801047a2:	77 dc                	ja     80104780 <kthread_join+0x70>
    release(&ptable.lock); //lock nolonger needed
801047a4:	83 ec 0c             	sub    $0xc,%esp
801047a7:	68 40 2b 11 80       	push   $0x80112b40
801047ac:	e8 0f 05 00 00       	call   80104cc0 <release>
    if(t->state == TZOMBIE) { //Clear thread if already exited
801047b1:	83 c4 10             	add    $0x10,%esp
    return 0;
801047b4:	31 c0                	xor    %eax,%eax
    if(t->state == TZOMBIE) { //Clear thread if already exited
801047b6:	83 7b 04 05          	cmpl   $0x5,0x4(%ebx)
801047ba:	74 0c                	je     801047c8 <kthread_join+0xb8>
}
801047bc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801047bf:	5b                   	pop    %ebx
801047c0:	5e                   	pop    %esi
801047c1:	5d                   	pop    %ebp
801047c2:	c3                   	ret    
801047c3:	90                   	nop
801047c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kfree(t->kstack);
801047c8:	83 ec 0c             	sub    $0xc,%esp
801047cb:	ff 73 08             	pushl  0x8(%ebx)
801047ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
801047d1:	e8 9a db ff ff       	call   80102370 <kfree>
  t->kstack = 0;
801047d6:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  t->tid = 0;
801047dd:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  t->killed = 0;
801047e3:	83 c4 10             	add    $0x10,%esp
  t->state = TUNUSED;
801047e6:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
  t->parent = 0;
801047ed:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  t->killed = 0;
801047f4:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%ebx)
801047fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801047fe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104801:	5b                   	pop    %ebx
80104802:	5e                   	pop    %esi
80104803:	5d                   	pop    %ebp
80104804:	c3                   	ret    
80104805:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104810 <kthread_mutex_alloc>:

// Allocate a mutex object and initializes it
// Return ID of mutex
int
kthread_mutex_alloc()
{
80104810:	55                   	push   %ebp
80104811:	89 e5                	mov    %esp,%ebp
80104813:	53                   	push   %ebx
  struct mutex *m;
  acquire(&mtable.lock);
  // Going through all mutex table with unused mutex
  for(m = mtable.mutex; m->state != M_UNUSED && m < &mtable.mutex[NPROC]; m++){
80104814:	bb 34 29 11 80       	mov    $0x80112934,%ebx
{
80104819:	83 ec 10             	sub    $0x10,%esp
  acquire(&mtable.lock);
8010481c:	68 00 29 11 80       	push   $0x80112900
80104821:	e8 da 02 00 00       	call   80104b00 <acquire>
  for(m = mtable.mutex; m->state != M_UNUSED && m < &mtable.mutex[NPROC]; m++){
80104826:	8b 15 38 29 11 80    	mov    0x80112938,%edx
8010482c:	83 c4 10             	add    $0x10,%esp
8010482f:	85 d2                	test   %edx,%edx
80104831:	75 0d                	jne    80104840 <kthread_mutex_alloc+0x30>
80104833:	eb 1d                	jmp    80104852 <kthread_mutex_alloc+0x42>
80104835:	8d 76 00             	lea    0x0(%esi),%esi
80104838:	81 fb 34 2b 11 80    	cmp    $0x80112b34,%ebx
8010483e:	73 0a                	jae    8010484a <kthread_mutex_alloc+0x3a>
80104840:	83 c3 08             	add    $0x8,%ebx
80104843:	8b 43 04             	mov    0x4(%ebx),%eax
80104846:	85 c0                	test   %eax,%eax
80104848:	75 ee                	jne    80104838 <kthread_mutex_alloc+0x28>
  } 
  if(m == &mtable.mutex[NPROC]){
8010484a:	81 fb 34 2b 11 80    	cmp    $0x80112b34,%ebx
80104850:	74 2e                	je     80104880 <kthread_mutex_alloc+0x70>
    release(&mtable.lock);
    return -1;
  }
  // Initialize mutex
  m->mid = nextmid++;
80104852:	a1 08 b0 10 80       	mov    0x8010b008,%eax
  m->state = M_UNLOCKED;
  release(&mtable.lock);
80104857:	83 ec 0c             	sub    $0xc,%esp
  m->state = M_UNLOCKED;
8010485a:	c7 43 04 02 00 00 00 	movl   $0x2,0x4(%ebx)
  release(&mtable.lock);
80104861:	68 00 29 11 80       	push   $0x80112900
  m->mid = nextmid++;
80104866:	8d 50 01             	lea    0x1(%eax),%edx
80104869:	89 03                	mov    %eax,(%ebx)
8010486b:	89 15 08 b0 10 80    	mov    %edx,0x8010b008
  release(&mtable.lock);
80104871:	e8 4a 04 00 00       	call   80104cc0 <release>
  return m->mid;
80104876:	8b 03                	mov    (%ebx),%eax
80104878:	83 c4 10             	add    $0x10,%esp
}
8010487b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010487e:	c9                   	leave  
8010487f:	c3                   	ret    
    release(&mtable.lock);
80104880:	83 ec 0c             	sub    $0xc,%esp
80104883:	68 00 29 11 80       	push   $0x80112900
80104888:	e8 33 04 00 00       	call   80104cc0 <release>
    return -1;
8010488d:	83 c4 10             	add    $0x10,%esp
80104890:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104895:	eb e4                	jmp    8010487b <kthread_mutex_alloc+0x6b>
80104897:	89 f6                	mov    %esi,%esi
80104899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801048a0 <kthread_mutex_dealloc>:

// De-allocate mutex which is no longer needed
// Return 0 when sucess, -1 when failure
int
kthread_mutex_dealloc(int mutex_id)
{
801048a0:	55                   	push   %ebp
801048a1:	89 e5                	mov    %esp,%ebp
801048a3:	53                   	push   %ebx
801048a4:	83 ec 10             	sub    $0x10,%esp
801048a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct mutex *m;
  acquire(&mtable.lock);
801048aa:	68 00 29 11 80       	push   $0x80112900
801048af:	e8 4c 02 00 00       	call   80104b00 <acquire>
  // Loop through mutex table to find given mutex_id
  for(m = mtable.mutex; m->mid != mutex_id && m < &mtable.mutex[NPROC]; m++){}
801048b4:	83 c4 10             	add    $0x10,%esp
801048b7:	3b 1d 34 29 11 80    	cmp    0x80112934,%ebx
801048bd:	b8 34 29 11 80       	mov    $0x80112934,%eax
801048c2:	75 13                	jne    801048d7 <kthread_mutex_dealloc+0x37>
801048c4:	eb 1f                	jmp    801048e5 <kthread_mutex_dealloc+0x45>
801048c6:	8d 76 00             	lea    0x0(%esi),%esi
801048c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801048d0:	3d 34 2b 11 80       	cmp    $0x80112b34,%eax
801048d5:	73 07                	jae    801048de <kthread_mutex_dealloc+0x3e>
801048d7:	83 c0 08             	add    $0x8,%eax
801048da:	39 18                	cmp    %ebx,(%eax)
801048dc:	75 f2                	jne    801048d0 <kthread_mutex_dealloc+0x30>
  if(m == &mtable.mutex[NPROC] || m->state == M_LOCKED) // can't find unsed mutex or state is locked
801048de:	3d 34 2b 11 80       	cmp    $0x80112b34,%eax
801048e3:	74 2a                	je     8010490f <kthread_mutex_dealloc+0x6f>
801048e5:	83 78 04 01          	cmpl   $0x1,0x4(%eax)
801048e9:	74 24                	je     8010490f <kthread_mutex_dealloc+0x6f>
    release(&mtable.lock);
    return -1;
  }else{ // deallocate all properties of mutex
    m->mid = 0;
    m->state = M_UNUSED;
    release(&mtable.lock);
801048eb:	83 ec 0c             	sub    $0xc,%esp
    m->mid = 0;
801048ee:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    m->state = M_UNUSED;
801048f4:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    release(&mtable.lock);
801048fb:	68 00 29 11 80       	push   $0x80112900
80104900:	e8 bb 03 00 00       	call   80104cc0 <release>
    return 0;
80104905:	83 c4 10             	add    $0x10,%esp
80104908:	31 c0                	xor    %eax,%eax
  }
  release(&mtable.lock);
  return -1;
}
8010490a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010490d:	c9                   	leave  
8010490e:	c3                   	ret    
    release(&mtable.lock);
8010490f:	83 ec 0c             	sub    $0xc,%esp
80104912:	68 00 29 11 80       	push   $0x80112900
80104917:	e8 a4 03 00 00       	call   80104cc0 <release>
    return -1;
8010491c:	83 c4 10             	add    $0x10,%esp
8010491f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104924:	eb e4                	jmp    8010490a <kthread_mutex_dealloc+0x6a>
80104926:	8d 76 00             	lea    0x0(%esi),%esi
80104929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104930 <kthread_mutex_lock>:

// Used by thread to lock the mutex using mutex_id
// If already locked, block the calling thread until mutex is unlocked
int
kthread_mutex_lock(int mutex_id)
{
80104930:	55                   	push   %ebp
80104931:	89 e5                	mov    %esp,%ebp
80104933:	56                   	push   %esi
80104934:	53                   	push   %ebx
80104935:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct mutex *m;
  acquire(&mtable.lock);
80104938:	83 ec 0c             	sub    $0xc,%esp
8010493b:	68 00 29 11 80       	push   $0x80112900
80104940:	e8 bb 01 00 00       	call   80104b00 <acquire>
80104945:	83 c4 10             	add    $0x10,%esp

  int i =0;
80104948:	31 c0                	xor    %eax,%eax
8010494a:	eb 0c                	jmp    80104958 <kthread_mutex_lock+0x28>
8010494c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for (; i < MAX_MUTEXES; i++){ // Loop and find mutex_id
80104950:	83 c0 01             	add    $0x1,%eax
80104953:	83 f8 40             	cmp    $0x40,%eax
80104956:	74 78                	je     801049d0 <kthread_mutex_lock+0xa0>
    m = &mtable.mutex[i];
    if(m->mid == mutex_id)
80104958:	39 1c c5 34 29 11 80 	cmp    %ebx,-0x7feed6cc(,%eax,8)
8010495f:	75 ef                	jne    80104950 <kthread_mutex_lock+0x20>
  if (i == MAX_MUTEXES){ // Can't find mutex_id
    release(&mtable.lock);
    return -1;
  }

  while (m->state == M_LOCKED) // Spin lock
80104961:	8d 58 06             	lea    0x6(%eax),%ebx
80104964:	8b 04 dd 08 29 11 80 	mov    -0x7feed6f8(,%ebx,8),%eax
    m = &mtable.mutex[i];
8010496b:	8d 34 dd 04 29 11 80 	lea    -0x7feed6fc(,%ebx,8),%esi
  while (m->state == M_LOCKED) // Spin lock
80104972:	83 f8 01             	cmp    $0x1,%eax
80104975:	75 26                	jne    8010499d <kthread_mutex_lock+0x6d>
80104977:	89 f6                	mov    %esi,%esi
80104979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    sleep(m, &mtable.lock);
80104980:	83 ec 08             	sub    $0x8,%esp
80104983:	68 00 29 11 80       	push   $0x80112900
80104988:	56                   	push   %esi
80104989:	e8 92 f7 ff ff       	call   80104120 <sleep>
  while (m->state == M_LOCKED) // Spin lock
8010498e:	8b 04 dd 08 29 11 80 	mov    -0x7feed6f8(,%ebx,8),%eax
80104995:	83 c4 10             	add    $0x10,%esp
80104998:	83 f8 01             	cmp    $0x1,%eax
8010499b:	74 e3                	je     80104980 <kthread_mutex_lock+0x50>

  if(m->state != M_UNLOCKED){ // fail ed
8010499d:	83 f8 02             	cmp    $0x2,%eax
801049a0:	75 2e                	jne    801049d0 <kthread_mutex_lock+0xa0>
    release(&mtable.lock);
    return -1;
  }

  m->state = M_LOCKED;
  release(&mtable.lock);
801049a2:	83 ec 0c             	sub    $0xc,%esp
  m->state = M_LOCKED;
801049a5:	c7 04 dd 08 29 11 80 	movl   $0x1,-0x7feed6f8(,%ebx,8)
801049ac:	01 00 00 00 
  release(&mtable.lock);
801049b0:	68 00 29 11 80       	push   $0x80112900
801049b5:	e8 06 03 00 00       	call   80104cc0 <release>
  return 0;
801049ba:	83 c4 10             	add    $0x10,%esp
}
801049bd:	8d 65 f8             	lea    -0x8(%ebp),%esp
  return 0;
801049c0:	31 c0                	xor    %eax,%eax
}
801049c2:	5b                   	pop    %ebx
801049c3:	5e                   	pop    %esi
801049c4:	5d                   	pop    %ebp
801049c5:	c3                   	ret    
801049c6:	8d 76 00             	lea    0x0(%esi),%esi
801049c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    release(&mtable.lock);
801049d0:	83 ec 0c             	sub    $0xc,%esp
801049d3:	68 00 29 11 80       	push   $0x80112900
801049d8:	e8 e3 02 00 00       	call   80104cc0 <release>
    return -1;
801049dd:	83 c4 10             	add    $0x10,%esp
}
801049e0:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
801049e3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801049e8:	5b                   	pop    %ebx
801049e9:	5e                   	pop    %esi
801049ea:	5d                   	pop    %ebp
801049eb:	c3                   	ret    
801049ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801049f0 <kthread_mutex_unlock>:

// Unlock the mutex with given mutex_id
// If there are any blocked threads, one of the threads will acquire the mutex
int
kthread_mutex_unlock(int mutex_id)
{
801049f0:	55                   	push   %ebp
801049f1:	89 e5                	mov    %esp,%ebp
801049f3:	53                   	push   %ebx
801049f4:	83 ec 10             	sub    $0x10,%esp
801049f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct mutex *m;
  acquire(&mtable.lock);
801049fa:	68 00 29 11 80       	push   $0x80112900
801049ff:	e8 fc 00 00 00       	call   80104b00 <acquire>
80104a04:	83 c4 10             	add    $0x10,%esp
  int i =0;
80104a07:	31 c0                	xor    %eax,%eax
80104a09:	eb 11                	jmp    80104a1c <kthread_mutex_unlock+0x2c>
80104a0b:	90                   	nop
80104a0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for (; i < MAX_MUTEXES; i++){ // loop through to find mutex_id
80104a10:	83 c0 01             	add    $0x1,%eax
80104a13:	83 f8 40             	cmp    $0x40,%eax
80104a16:	0f 84 9b 00 00 00    	je     80104ab7 <kthread_mutex_unlock+0xc7>
    m = &mtable.mutex[i];
    if(m->mid == mutex_id)
80104a1c:	39 1c c5 34 29 11 80 	cmp    %ebx,-0x7feed6cc(,%eax,8)
80104a23:	89 c2                	mov    %eax,%edx
80104a25:	75 e9                	jne    80104a10 <kthread_mutex_unlock+0x20>
    m = &mtable.mutex[i];
80104a27:	8d 0c d5 34 29 11 80 	lea    -0x7feed6cc(,%edx,8),%ecx
      break;
  }
  if (m == &mtable.mutex[NPROC] || m->state != M_LOCKED){ // can't find mutex_id or state is not locked
80104a2e:	81 f9 34 2b 11 80    	cmp    $0x80112b34,%ecx
80104a34:	0f 84 87 00 00 00    	je     80104ac1 <kthread_mutex_unlock+0xd1>
80104a3a:	83 c0 06             	add    $0x6,%eax
80104a3d:	83 3c c5 08 29 11 80 	cmpl   $0x1,-0x7feed6f8(,%eax,8)
80104a44:	01 
80104a45:	75 7a                	jne    80104ac1 <kthread_mutex_unlock+0xd1>
    release(&mtable.lock);
    return -1;
  }

  m->state = M_UNLOCKED;
80104a47:	c7 04 c5 08 29 11 80 	movl   $0x2,-0x7feed6f8(,%eax,8)
80104a4e:	02 00 00 00 
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104a52:	b8 74 2b 11 80       	mov    $0x80112b74,%eax
80104a57:	eb 11                	jmp    80104a6a <kthread_mutex_unlock+0x7a>
80104a59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a60:	81 fa 74 c6 11 80    	cmp    $0x8011c674,%edx
80104a66:	89 d0                	mov    %edx,%eax
80104a68:	73 36                	jae    80104aa0 <kthread_mutex_unlock+0xb0>
    if(p->state == USED)
80104a6a:	83 78 08 01          	cmpl   $0x1,0x8(%eax)
80104a6e:	8d 90 6c 02 00 00    	lea    0x26c(%eax),%edx
80104a74:	75 ea                	jne    80104a60 <kthread_mutex_unlock+0x70>
80104a76:	83 c0 6c             	add    $0x6c,%eax
80104a79:	eb 0c                	jmp    80104a87 <kthread_mutex_unlock+0x97>
80104a7b:	90                   	nop
80104a7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(t = p->threads; t < &p->threads[NTHREAD]; t++)
80104a80:	83 c0 20             	add    $0x20,%eax
80104a83:	39 d0                	cmp    %edx,%eax
80104a85:	73 d9                	jae    80104a60 <kthread_mutex_unlock+0x70>
        if(t->state == TSLEEPING && t->chan == chan)
80104a87:	83 78 04 02          	cmpl   $0x2,0x4(%eax)
80104a8b:	75 f3                	jne    80104a80 <kthread_mutex_unlock+0x90>
80104a8d:	3b 48 18             	cmp    0x18(%eax),%ecx
80104a90:	75 ee                	jne    80104a80 <kthread_mutex_unlock+0x90>
          t->state = TRUNNABLE;
80104a92:	c7 40 04 03 00 00 00 	movl   $0x3,0x4(%eax)
80104a99:	eb e5                	jmp    80104a80 <kthread_mutex_unlock+0x90>
80104a9b:	90                   	nop
80104a9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  wakeup1(m); // wakeup thread
  release(&mtable.lock);
80104aa0:	83 ec 0c             	sub    $0xc,%esp
80104aa3:	68 00 29 11 80       	push   $0x80112900
80104aa8:	e8 13 02 00 00       	call   80104cc0 <release>
  return 0;
80104aad:	83 c4 10             	add    $0x10,%esp
80104ab0:	31 c0                	xor    %eax,%eax
}
80104ab2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ab5:	c9                   	leave  
80104ab6:	c3                   	ret    
80104ab7:	b8 3f 00 00 00       	mov    $0x3f,%eax
80104abc:	e9 66 ff ff ff       	jmp    80104a27 <kthread_mutex_unlock+0x37>
    release(&mtable.lock);
80104ac1:	83 ec 0c             	sub    $0xc,%esp
80104ac4:	68 00 29 11 80       	push   $0x80112900
80104ac9:	e8 f2 01 00 00       	call   80104cc0 <release>
    return -1;
80104ace:	83 c4 10             	add    $0x10,%esp
80104ad1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ad6:	eb da                	jmp    80104ab2 <kthread_mutex_unlock+0xc2>
80104ad8:	66 90                	xchg   %ax,%ax
80104ada:	66 90                	xchg   %ax,%ax
80104adc:	66 90                	xchg   %ax,%ax
80104ade:	66 90                	xchg   %ax,%ax

80104ae0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104ae0:	55                   	push   %ebp
80104ae1:	89 e5                	mov    %esp,%ebp
80104ae3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104ae6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104ae9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80104aef:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104af2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104af9:	5d                   	pop    %ebp
80104afa:	c3                   	ret    
80104afb:	90                   	nop
80104afc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104b00 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80104b00:	55                   	push   %ebp
80104b01:	89 e5                	mov    %esp,%ebp
80104b03:	53                   	push   %ebx
80104b04:	83 ec 04             	sub    $0x4,%esp
80104b07:	9c                   	pushf  
80104b08:	5a                   	pop    %edx
  asm volatile("cli");
80104b09:	fa                   	cli    
{
  int eflags;

  eflags = readeflags();
  cli();
  if(cpu->ncli == 0)
80104b0a:	65 8b 0d 00 00 00 00 	mov    %gs:0x0,%ecx
80104b11:	8b 81 ac 00 00 00    	mov    0xac(%ecx),%eax
80104b17:	85 c0                	test   %eax,%eax
80104b19:	75 0c                	jne    80104b27 <acquire+0x27>
    cpu->intena = eflags & FL_IF;
80104b1b:	81 e2 00 02 00 00    	and    $0x200,%edx
80104b21:	89 91 b0 00 00 00    	mov    %edx,0xb0(%ecx)
  if(holding(lk))
80104b27:	8b 55 08             	mov    0x8(%ebp),%edx
  cpu->ncli += 1;
80104b2a:	83 c0 01             	add    $0x1,%eax
80104b2d:	89 81 ac 00 00 00    	mov    %eax,0xac(%ecx)
  return lock->locked && lock->cpu == cpu;
80104b33:	8b 02                	mov    (%edx),%eax
80104b35:	85 c0                	test   %eax,%eax
80104b37:	74 05                	je     80104b3e <acquire+0x3e>
80104b39:	39 4a 08             	cmp    %ecx,0x8(%edx)
80104b3c:	74 74                	je     80104bb2 <acquire+0xb2>
  asm volatile("lock; xchgl %0, %1" :
80104b3e:	b9 01 00 00 00       	mov    $0x1,%ecx
80104b43:	90                   	nop
80104b44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b48:	89 c8                	mov    %ecx,%eax
80104b4a:	f0 87 02             	lock xchg %eax,(%edx)
  while(xchg(&lk->locked, 1) != 0)
80104b4d:	85 c0                	test   %eax,%eax
80104b4f:	75 f7                	jne    80104b48 <acquire+0x48>
  __sync_synchronize();
80104b51:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = cpu;
80104b56:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104b59:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  for(i = 0; i < 10; i++){
80104b5f:	31 d2                	xor    %edx,%edx
  lk->cpu = cpu;
80104b61:	89 41 08             	mov    %eax,0x8(%ecx)
  getcallerpcs(&lk, lk->pcs);
80104b64:	83 c1 0c             	add    $0xc,%ecx
  ebp = (uint*)v - 2;
80104b67:	89 e8                	mov    %ebp,%eax
80104b69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104b70:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104b76:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104b7c:	77 1a                	ja     80104b98 <acquire+0x98>
    pcs[i] = ebp[1];     // saved %eip
80104b7e:	8b 58 04             	mov    0x4(%eax),%ebx
80104b81:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104b84:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104b87:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104b89:	83 fa 0a             	cmp    $0xa,%edx
80104b8c:	75 e2                	jne    80104b70 <acquire+0x70>
}
80104b8e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b91:	c9                   	leave  
80104b92:	c3                   	ret    
80104b93:	90                   	nop
80104b94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b98:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80104b9b:	83 c1 28             	add    $0x28,%ecx
80104b9e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104ba0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104ba6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104ba9:	39 c8                	cmp    %ecx,%eax
80104bab:	75 f3                	jne    80104ba0 <acquire+0xa0>
}
80104bad:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104bb0:	c9                   	leave  
80104bb1:	c3                   	ret    
    panic("acquire");
80104bb2:	83 ec 0c             	sub    $0xc,%esp
80104bb5:	68 54 81 10 80       	push   $0x80108154
80104bba:	e8 b1 b7 ff ff       	call   80100370 <panic>
80104bbf:	90                   	nop

80104bc0 <getcallerpcs>:
{
80104bc0:	55                   	push   %ebp
  for(i = 0; i < 10; i++){
80104bc1:	31 d2                	xor    %edx,%edx
{
80104bc3:	89 e5                	mov    %esp,%ebp
80104bc5:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104bc6:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104bc9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
80104bcc:	83 e8 08             	sub    $0x8,%eax
80104bcf:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104bd0:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104bd6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104bdc:	77 1a                	ja     80104bf8 <getcallerpcs+0x38>
    pcs[i] = ebp[1];     // saved %eip
80104bde:	8b 58 04             	mov    0x4(%eax),%ebx
80104be1:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104be4:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104be7:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104be9:	83 fa 0a             	cmp    $0xa,%edx
80104bec:	75 e2                	jne    80104bd0 <getcallerpcs+0x10>
}
80104bee:	5b                   	pop    %ebx
80104bef:	5d                   	pop    %ebp
80104bf0:	c3                   	ret    
80104bf1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bf8:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80104bfb:	83 c1 28             	add    $0x28,%ecx
80104bfe:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104c00:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104c06:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104c09:	39 c1                	cmp    %eax,%ecx
80104c0b:	75 f3                	jne    80104c00 <getcallerpcs+0x40>
}
80104c0d:	5b                   	pop    %ebx
80104c0e:	5d                   	pop    %ebp
80104c0f:	c3                   	ret    

80104c10 <holding>:
{
80104c10:	55                   	push   %ebp
80104c11:	89 e5                	mov    %esp,%ebp
80104c13:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == cpu;
80104c16:	8b 02                	mov    (%edx),%eax
80104c18:	85 c0                	test   %eax,%eax
80104c1a:	74 14                	je     80104c30 <holding+0x20>
80104c1c:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104c22:	39 42 08             	cmp    %eax,0x8(%edx)
}
80104c25:	5d                   	pop    %ebp
  return lock->locked && lock->cpu == cpu;
80104c26:	0f 94 c0             	sete   %al
80104c29:	0f b6 c0             	movzbl %al,%eax
}
80104c2c:	c3                   	ret    
80104c2d:	8d 76 00             	lea    0x0(%esi),%esi
80104c30:	31 c0                	xor    %eax,%eax
80104c32:	5d                   	pop    %ebp
80104c33:	c3                   	ret    
80104c34:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c3a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104c40 <pushcli>:
{
80104c40:	55                   	push   %ebp
80104c41:	89 e5                	mov    %esp,%ebp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104c43:	9c                   	pushf  
80104c44:	59                   	pop    %ecx
  asm volatile("cli");
80104c45:	fa                   	cli    
  if(cpu->ncli == 0)
80104c46:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104c4d:	8b 82 ac 00 00 00    	mov    0xac(%edx),%eax
80104c53:	85 c0                	test   %eax,%eax
80104c55:	75 0c                	jne    80104c63 <pushcli+0x23>
    cpu->intena = eflags & FL_IF;
80104c57:	81 e1 00 02 00 00    	and    $0x200,%ecx
80104c5d:	89 8a b0 00 00 00    	mov    %ecx,0xb0(%edx)
  cpu->ncli += 1;
80104c63:	83 c0 01             	add    $0x1,%eax
80104c66:	89 82 ac 00 00 00    	mov    %eax,0xac(%edx)
}
80104c6c:	5d                   	pop    %ebp
80104c6d:	c3                   	ret    
80104c6e:	66 90                	xchg   %ax,%ax

80104c70 <popcli>:

void
popcli(void)
{
80104c70:	55                   	push   %ebp
80104c71:	89 e5                	mov    %esp,%ebp
80104c73:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104c76:	9c                   	pushf  
80104c77:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104c78:	f6 c4 02             	test   $0x2,%ah
80104c7b:	75 2c                	jne    80104ca9 <popcli+0x39>
    panic("popcli - interruptible");
  if(--cpu->ncli < 0)
80104c7d:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104c84:	83 aa ac 00 00 00 01 	subl   $0x1,0xac(%edx)
80104c8b:	78 0f                	js     80104c9c <popcli+0x2c>
    panic("popcli");
  if(cpu->ncli == 0 && cpu->intena)
80104c8d:	75 0b                	jne    80104c9a <popcli+0x2a>
80104c8f:	8b 82 b0 00 00 00    	mov    0xb0(%edx),%eax
80104c95:	85 c0                	test   %eax,%eax
80104c97:	74 01                	je     80104c9a <popcli+0x2a>
  asm volatile("sti");
80104c99:	fb                   	sti    
    sti();
}
80104c9a:	c9                   	leave  
80104c9b:	c3                   	ret    
    panic("popcli");
80104c9c:	83 ec 0c             	sub    $0xc,%esp
80104c9f:	68 73 81 10 80       	push   $0x80108173
80104ca4:	e8 c7 b6 ff ff       	call   80100370 <panic>
    panic("popcli - interruptible");
80104ca9:	83 ec 0c             	sub    $0xc,%esp
80104cac:	68 5c 81 10 80       	push   $0x8010815c
80104cb1:	e8 ba b6 ff ff       	call   80100370 <panic>
80104cb6:	8d 76 00             	lea    0x0(%esi),%esi
80104cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104cc0 <release>:
{
80104cc0:	55                   	push   %ebp
80104cc1:	89 e5                	mov    %esp,%ebp
80104cc3:	83 ec 08             	sub    $0x8,%esp
80104cc6:	8b 45 08             	mov    0x8(%ebp),%eax
  return lock->locked && lock->cpu == cpu;
80104cc9:	8b 10                	mov    (%eax),%edx
80104ccb:	85 d2                	test   %edx,%edx
80104ccd:	74 2b                	je     80104cfa <release+0x3a>
80104ccf:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104cd6:	39 50 08             	cmp    %edx,0x8(%eax)
80104cd9:	75 1f                	jne    80104cfa <release+0x3a>
  lk->pcs[0] = 0;
80104cdb:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
80104ce2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  __sync_synchronize();
80104ce9:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->locked = 0;
80104cee:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
80104cf4:	c9                   	leave  
  popcli();
80104cf5:	e9 76 ff ff ff       	jmp    80104c70 <popcli>
    panic("release");
80104cfa:	83 ec 0c             	sub    $0xc,%esp
80104cfd:	68 7a 81 10 80       	push   $0x8010817a
80104d02:	e8 69 b6 ff ff       	call   80100370 <panic>
80104d07:	66 90                	xchg   %ax,%ax
80104d09:	66 90                	xchg   %ax,%ax
80104d0b:	66 90                	xchg   %ax,%ax
80104d0d:	66 90                	xchg   %ax,%ax
80104d0f:	90                   	nop

80104d10 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104d10:	55                   	push   %ebp
80104d11:	89 e5                	mov    %esp,%ebp
80104d13:	57                   	push   %edi
80104d14:	53                   	push   %ebx
80104d15:	8b 55 08             	mov    0x8(%ebp),%edx
80104d18:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
80104d1b:	f6 c2 03             	test   $0x3,%dl
80104d1e:	75 05                	jne    80104d25 <memset+0x15>
80104d20:	f6 c1 03             	test   $0x3,%cl
80104d23:	74 13                	je     80104d38 <memset+0x28>
  asm volatile("cld; rep stosb" :
80104d25:	89 d7                	mov    %edx,%edi
80104d27:	8b 45 0c             	mov    0xc(%ebp),%eax
80104d2a:	fc                   	cld    
80104d2b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80104d2d:	5b                   	pop    %ebx
80104d2e:	89 d0                	mov    %edx,%eax
80104d30:	5f                   	pop    %edi
80104d31:	5d                   	pop    %ebp
80104d32:	c3                   	ret    
80104d33:	90                   	nop
80104d34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
80104d38:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104d3c:	c1 e9 02             	shr    $0x2,%ecx
80104d3f:	89 f8                	mov    %edi,%eax
80104d41:	89 fb                	mov    %edi,%ebx
80104d43:	c1 e0 18             	shl    $0x18,%eax
80104d46:	c1 e3 10             	shl    $0x10,%ebx
80104d49:	09 d8                	or     %ebx,%eax
80104d4b:	09 f8                	or     %edi,%eax
80104d4d:	c1 e7 08             	shl    $0x8,%edi
80104d50:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80104d52:	89 d7                	mov    %edx,%edi
80104d54:	fc                   	cld    
80104d55:	f3 ab                	rep stos %eax,%es:(%edi)
}
80104d57:	5b                   	pop    %ebx
80104d58:	89 d0                	mov    %edx,%eax
80104d5a:	5f                   	pop    %edi
80104d5b:	5d                   	pop    %ebp
80104d5c:	c3                   	ret    
80104d5d:	8d 76 00             	lea    0x0(%esi),%esi

80104d60 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104d60:	55                   	push   %ebp
80104d61:	89 e5                	mov    %esp,%ebp
80104d63:	57                   	push   %edi
80104d64:	56                   	push   %esi
80104d65:	53                   	push   %ebx
80104d66:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104d69:	8b 75 08             	mov    0x8(%ebp),%esi
80104d6c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104d6f:	85 db                	test   %ebx,%ebx
80104d71:	74 29                	je     80104d9c <memcmp+0x3c>
    if(*s1 != *s2)
80104d73:	0f b6 16             	movzbl (%esi),%edx
80104d76:	0f b6 0f             	movzbl (%edi),%ecx
80104d79:	38 d1                	cmp    %dl,%cl
80104d7b:	75 2b                	jne    80104da8 <memcmp+0x48>
80104d7d:	b8 01 00 00 00       	mov    $0x1,%eax
80104d82:	eb 14                	jmp    80104d98 <memcmp+0x38>
80104d84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104d88:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
80104d8c:	83 c0 01             	add    $0x1,%eax
80104d8f:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80104d94:	38 ca                	cmp    %cl,%dl
80104d96:	75 10                	jne    80104da8 <memcmp+0x48>
  while(n-- > 0){
80104d98:	39 d8                	cmp    %ebx,%eax
80104d9a:	75 ec                	jne    80104d88 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
80104d9c:	5b                   	pop    %ebx
  return 0;
80104d9d:	31 c0                	xor    %eax,%eax
}
80104d9f:	5e                   	pop    %esi
80104da0:	5f                   	pop    %edi
80104da1:	5d                   	pop    %ebp
80104da2:	c3                   	ret    
80104da3:	90                   	nop
80104da4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
80104da8:	0f b6 c2             	movzbl %dl,%eax
}
80104dab:	5b                   	pop    %ebx
      return *s1 - *s2;
80104dac:	29 c8                	sub    %ecx,%eax
}
80104dae:	5e                   	pop    %esi
80104daf:	5f                   	pop    %edi
80104db0:	5d                   	pop    %ebp
80104db1:	c3                   	ret    
80104db2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104db9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104dc0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104dc0:	55                   	push   %ebp
80104dc1:	89 e5                	mov    %esp,%ebp
80104dc3:	56                   	push   %esi
80104dc4:	53                   	push   %ebx
80104dc5:	8b 45 08             	mov    0x8(%ebp),%eax
80104dc8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104dcb:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104dce:	39 c3                	cmp    %eax,%ebx
80104dd0:	73 26                	jae    80104df8 <memmove+0x38>
80104dd2:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80104dd5:	39 c8                	cmp    %ecx,%eax
80104dd7:	73 1f                	jae    80104df8 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80104dd9:	85 f6                	test   %esi,%esi
80104ddb:	8d 56 ff             	lea    -0x1(%esi),%edx
80104dde:	74 0f                	je     80104def <memmove+0x2f>
      *--d = *--s;
80104de0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104de4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80104de7:	83 ea 01             	sub    $0x1,%edx
80104dea:	83 fa ff             	cmp    $0xffffffff,%edx
80104ded:	75 f1                	jne    80104de0 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104def:	5b                   	pop    %ebx
80104df0:	5e                   	pop    %esi
80104df1:	5d                   	pop    %ebp
80104df2:	c3                   	ret    
80104df3:	90                   	nop
80104df4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80104df8:	31 d2                	xor    %edx,%edx
80104dfa:	85 f6                	test   %esi,%esi
80104dfc:	74 f1                	je     80104def <memmove+0x2f>
80104dfe:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80104e00:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104e04:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104e07:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
80104e0a:	39 d6                	cmp    %edx,%esi
80104e0c:	75 f2                	jne    80104e00 <memmove+0x40>
}
80104e0e:	5b                   	pop    %ebx
80104e0f:	5e                   	pop    %esi
80104e10:	5d                   	pop    %ebp
80104e11:	c3                   	ret    
80104e12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e20 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104e20:	55                   	push   %ebp
80104e21:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104e23:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80104e24:	eb 9a                	jmp    80104dc0 <memmove>
80104e26:	8d 76 00             	lea    0x0(%esi),%esi
80104e29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e30 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80104e30:	55                   	push   %ebp
80104e31:	89 e5                	mov    %esp,%ebp
80104e33:	57                   	push   %edi
80104e34:	56                   	push   %esi
80104e35:	8b 7d 10             	mov    0x10(%ebp),%edi
80104e38:	53                   	push   %ebx
80104e39:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104e3c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
80104e3f:	85 ff                	test   %edi,%edi
80104e41:	74 2f                	je     80104e72 <strncmp+0x42>
80104e43:	0f b6 01             	movzbl (%ecx),%eax
80104e46:	0f b6 1e             	movzbl (%esi),%ebx
80104e49:	84 c0                	test   %al,%al
80104e4b:	74 37                	je     80104e84 <strncmp+0x54>
80104e4d:	38 c3                	cmp    %al,%bl
80104e4f:	75 33                	jne    80104e84 <strncmp+0x54>
80104e51:	01 f7                	add    %esi,%edi
80104e53:	eb 13                	jmp    80104e68 <strncmp+0x38>
80104e55:	8d 76 00             	lea    0x0(%esi),%esi
80104e58:	0f b6 01             	movzbl (%ecx),%eax
80104e5b:	84 c0                	test   %al,%al
80104e5d:	74 21                	je     80104e80 <strncmp+0x50>
80104e5f:	0f b6 1a             	movzbl (%edx),%ebx
80104e62:	89 d6                	mov    %edx,%esi
80104e64:	38 d8                	cmp    %bl,%al
80104e66:	75 1c                	jne    80104e84 <strncmp+0x54>
    n--, p++, q++;
80104e68:	8d 56 01             	lea    0x1(%esi),%edx
80104e6b:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104e6e:	39 fa                	cmp    %edi,%edx
80104e70:	75 e6                	jne    80104e58 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80104e72:	5b                   	pop    %ebx
    return 0;
80104e73:	31 c0                	xor    %eax,%eax
}
80104e75:	5e                   	pop    %esi
80104e76:	5f                   	pop    %edi
80104e77:	5d                   	pop    %ebp
80104e78:	c3                   	ret    
80104e79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e80:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
80104e84:	29 d8                	sub    %ebx,%eax
}
80104e86:	5b                   	pop    %ebx
80104e87:	5e                   	pop    %esi
80104e88:	5f                   	pop    %edi
80104e89:	5d                   	pop    %ebp
80104e8a:	c3                   	ret    
80104e8b:	90                   	nop
80104e8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104e90 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104e90:	55                   	push   %ebp
80104e91:	89 e5                	mov    %esp,%ebp
80104e93:	56                   	push   %esi
80104e94:	53                   	push   %ebx
80104e95:	8b 45 08             	mov    0x8(%ebp),%eax
80104e98:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104e9b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104e9e:	89 c2                	mov    %eax,%edx
80104ea0:	eb 19                	jmp    80104ebb <strncpy+0x2b>
80104ea2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104ea8:	83 c3 01             	add    $0x1,%ebx
80104eab:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
80104eaf:	83 c2 01             	add    $0x1,%edx
80104eb2:	84 c9                	test   %cl,%cl
80104eb4:	88 4a ff             	mov    %cl,-0x1(%edx)
80104eb7:	74 09                	je     80104ec2 <strncpy+0x32>
80104eb9:	89 f1                	mov    %esi,%ecx
80104ebb:	85 c9                	test   %ecx,%ecx
80104ebd:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104ec0:	7f e6                	jg     80104ea8 <strncpy+0x18>
    ;
  while(n-- > 0)
80104ec2:	31 c9                	xor    %ecx,%ecx
80104ec4:	85 f6                	test   %esi,%esi
80104ec6:	7e 17                	jle    80104edf <strncpy+0x4f>
80104ec8:	90                   	nop
80104ec9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104ed0:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104ed4:	89 f3                	mov    %esi,%ebx
80104ed6:	83 c1 01             	add    $0x1,%ecx
80104ed9:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
80104edb:	85 db                	test   %ebx,%ebx
80104edd:	7f f1                	jg     80104ed0 <strncpy+0x40>
  return os;
}
80104edf:	5b                   	pop    %ebx
80104ee0:	5e                   	pop    %esi
80104ee1:	5d                   	pop    %ebp
80104ee2:	c3                   	ret    
80104ee3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104ee9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ef0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104ef0:	55                   	push   %ebp
80104ef1:	89 e5                	mov    %esp,%ebp
80104ef3:	56                   	push   %esi
80104ef4:	53                   	push   %ebx
80104ef5:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104ef8:	8b 45 08             	mov    0x8(%ebp),%eax
80104efb:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
80104efe:	85 c9                	test   %ecx,%ecx
80104f00:	7e 26                	jle    80104f28 <safestrcpy+0x38>
80104f02:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104f06:	89 c1                	mov    %eax,%ecx
80104f08:	eb 17                	jmp    80104f21 <safestrcpy+0x31>
80104f0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104f10:	83 c2 01             	add    $0x1,%edx
80104f13:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104f17:	83 c1 01             	add    $0x1,%ecx
80104f1a:	84 db                	test   %bl,%bl
80104f1c:	88 59 ff             	mov    %bl,-0x1(%ecx)
80104f1f:	74 04                	je     80104f25 <safestrcpy+0x35>
80104f21:	39 f2                	cmp    %esi,%edx
80104f23:	75 eb                	jne    80104f10 <safestrcpy+0x20>
    ;
  *s = 0;
80104f25:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104f28:	5b                   	pop    %ebx
80104f29:	5e                   	pop    %esi
80104f2a:	5d                   	pop    %ebp
80104f2b:	c3                   	ret    
80104f2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104f30 <strlen>:

int
strlen(const char *s)
{
80104f30:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104f31:	31 c0                	xor    %eax,%eax
{
80104f33:	89 e5                	mov    %esp,%ebp
80104f35:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104f38:	80 3a 00             	cmpb   $0x0,(%edx)
80104f3b:	74 0c                	je     80104f49 <strlen+0x19>
80104f3d:	8d 76 00             	lea    0x0(%esi),%esi
80104f40:	83 c0 01             	add    $0x1,%eax
80104f43:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104f47:	75 f7                	jne    80104f40 <strlen+0x10>
    ;
  return n;
}
80104f49:	5d                   	pop    %ebp
80104f4a:	c3                   	ret    

80104f4b <swtch>:
80104f4b:	8b 44 24 04          	mov    0x4(%esp),%eax
80104f4f:	8b 54 24 08          	mov    0x8(%esp),%edx
80104f53:	55                   	push   %ebp
80104f54:	53                   	push   %ebx
80104f55:	56                   	push   %esi
80104f56:	57                   	push   %edi
80104f57:	89 20                	mov    %esp,(%eax)
80104f59:	89 d4                	mov    %edx,%esp
80104f5b:	5f                   	pop    %edi
80104f5c:	5e                   	pop    %esi
80104f5d:	5b                   	pop    %ebx
80104f5e:	5d                   	pop    %ebp
80104f5f:	c3                   	ret    

80104f60 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104f60:	55                   	push   %ebp
  if(addr >= proc->sz || addr+4 > proc->sz)
80104f61:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
{
80104f68:	89 e5                	mov    %esp,%ebp
80104f6a:	8b 45 08             	mov    0x8(%ebp),%eax
  if(addr >= proc->sz || addr+4 > proc->sz)
80104f6d:	8b 12                	mov    (%edx),%edx
80104f6f:	39 c2                	cmp    %eax,%edx
80104f71:	76 15                	jbe    80104f88 <fetchint+0x28>
80104f73:	8d 48 04             	lea    0x4(%eax),%ecx
80104f76:	39 ca                	cmp    %ecx,%edx
80104f78:	72 0e                	jb     80104f88 <fetchint+0x28>
    return -1;
  *ip = *(int*)(addr);
80104f7a:	8b 10                	mov    (%eax),%edx
80104f7c:	8b 45 0c             	mov    0xc(%ebp),%eax
80104f7f:	89 10                	mov    %edx,(%eax)
  return 0;
80104f81:	31 c0                	xor    %eax,%eax
}
80104f83:	5d                   	pop    %ebp
80104f84:	c3                   	ret    
80104f85:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104f88:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104f8d:	5d                   	pop    %ebp
80104f8e:	c3                   	ret    
80104f8f:	90                   	nop

80104f90 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104f90:	55                   	push   %ebp
  char *s, *ep;

  if(addr >= proc->sz)
80104f91:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
{
80104f97:	89 e5                	mov    %esp,%ebp
80104f99:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if(addr >= proc->sz)
80104f9c:	39 08                	cmp    %ecx,(%eax)
80104f9e:	76 2c                	jbe    80104fcc <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104fa0:	8b 55 0c             	mov    0xc(%ebp),%edx
80104fa3:	89 c8                	mov    %ecx,%eax
80104fa5:	89 0a                	mov    %ecx,(%edx)
  ep = (char*)proc->sz;
80104fa7:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104fae:	8b 12                	mov    (%edx),%edx
  for(s = *pp; s < ep; s++)
80104fb0:	39 d1                	cmp    %edx,%ecx
80104fb2:	73 18                	jae    80104fcc <fetchstr+0x3c>
    if(*s == 0)
80104fb4:	80 39 00             	cmpb   $0x0,(%ecx)
80104fb7:	75 0c                	jne    80104fc5 <fetchstr+0x35>
80104fb9:	eb 25                	jmp    80104fe0 <fetchstr+0x50>
80104fbb:	90                   	nop
80104fbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104fc0:	80 38 00             	cmpb   $0x0,(%eax)
80104fc3:	74 13                	je     80104fd8 <fetchstr+0x48>
  for(s = *pp; s < ep; s++)
80104fc5:	83 c0 01             	add    $0x1,%eax
80104fc8:	39 c2                	cmp    %eax,%edx
80104fca:	77 f4                	ja     80104fc0 <fetchstr+0x30>
    return -1;
80104fcc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  return -1;
}
80104fd1:	5d                   	pop    %ebp
80104fd2:	c3                   	ret    
80104fd3:	90                   	nop
80104fd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104fd8:	29 c8                	sub    %ecx,%eax
80104fda:	5d                   	pop    %ebp
80104fdb:	c3                   	ret    
80104fdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(*s == 0)
80104fe0:	31 c0                	xor    %eax,%eax
}
80104fe2:	5d                   	pop    %ebp
80104fe3:	c3                   	ret    
80104fe4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104fea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104ff0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(thread->tf->esp + 4 + 4*n, ip);
80104ff0:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
{
80104ff6:	55                   	push   %ebp
80104ff7:	89 e5                	mov    %esp,%ebp
  return fetchint(thread->tf->esp + 4 + 4*n, ip);
80104ff9:	8b 40 10             	mov    0x10(%eax),%eax
80104ffc:	8b 55 08             	mov    0x8(%ebp),%edx
80104fff:	8b 40 44             	mov    0x44(%eax),%eax
80105002:	8d 04 90             	lea    (%eax,%edx,4),%eax
  if(addr >= proc->sz || addr+4 > proc->sz)
80105005:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  return fetchint(thread->tf->esp + 4 + 4*n, ip);
8010500c:	8d 48 04             	lea    0x4(%eax),%ecx
  if(addr >= proc->sz || addr+4 > proc->sz)
8010500f:	8b 12                	mov    (%edx),%edx
80105011:	39 d1                	cmp    %edx,%ecx
80105013:	73 1b                	jae    80105030 <argint+0x40>
80105015:	8d 48 08             	lea    0x8(%eax),%ecx
80105018:	39 ca                	cmp    %ecx,%edx
8010501a:	72 14                	jb     80105030 <argint+0x40>
  *ip = *(int*)(addr);
8010501c:	8b 50 04             	mov    0x4(%eax),%edx
8010501f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105022:	89 10                	mov    %edx,(%eax)
  return 0;
80105024:	31 c0                	xor    %eax,%eax
}
80105026:	5d                   	pop    %ebp
80105027:	c3                   	ret    
80105028:	90                   	nop
80105029:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105030:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105035:	5d                   	pop    %ebp
80105036:	c3                   	ret    
80105037:	89 f6                	mov    %esi,%esi
80105039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105040 <argptr>:
  return fetchint(thread->tf->esp + 4 + 4*n, ip);
80105040:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80105046:	55                   	push   %ebp
80105047:	89 e5                	mov    %esp,%ebp
  return fetchint(thread->tf->esp + 4 + 4*n, ip);
80105049:	8b 40 10             	mov    0x10(%eax),%eax
8010504c:	8b 55 08             	mov    0x8(%ebp),%edx
8010504f:	8b 40 44             	mov    0x44(%eax),%eax
80105052:	8d 14 90             	lea    (%eax,%edx,4),%edx
  if(addr >= proc->sz || addr+4 > proc->sz)
80105055:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  return fetchint(thread->tf->esp + 4 + 4*n, ip);
8010505b:	8d 4a 04             	lea    0x4(%edx),%ecx
  if(addr >= proc->sz || addr+4 > proc->sz)
8010505e:	8b 00                	mov    (%eax),%eax
80105060:	39 c1                	cmp    %eax,%ecx
80105062:	73 24                	jae    80105088 <argptr+0x48>
80105064:	8d 4a 08             	lea    0x8(%edx),%ecx
80105067:	39 c8                	cmp    %ecx,%eax
80105069:	72 1d                	jb     80105088 <argptr+0x48>
  *ip = *(int*)(addr);
8010506b:	8b 52 04             	mov    0x4(%edx),%edx
  int i;

  if(argint(n, &i) < 0)
    return -1;
  if((uint)i >= proc->sz || (uint)i+size > proc->sz)
8010506e:	39 c2                	cmp    %eax,%edx
80105070:	73 16                	jae    80105088 <argptr+0x48>
80105072:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105075:	01 d1                	add    %edx,%ecx
80105077:	39 c1                	cmp    %eax,%ecx
80105079:	77 0d                	ja     80105088 <argptr+0x48>
    return -1;
  *pp = (char*)i;
8010507b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010507e:	89 10                	mov    %edx,(%eax)
  return 0;
80105080:	31 c0                	xor    %eax,%eax
}
80105082:	5d                   	pop    %ebp
80105083:	c3                   	ret    
80105084:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105088:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010508d:	5d                   	pop    %ebp
8010508e:	c3                   	ret    
8010508f:	90                   	nop

80105090 <argstr>:
  return fetchint(thread->tf->esp + 4 + 4*n, ip);
80105090:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105096:	55                   	push   %ebp
80105097:	89 e5                	mov    %esp,%ebp
  return fetchint(thread->tf->esp + 4 + 4*n, ip);
80105099:	8b 40 10             	mov    0x10(%eax),%eax
8010509c:	8b 55 08             	mov    0x8(%ebp),%edx
8010509f:	8b 40 44             	mov    0x44(%eax),%eax
801050a2:	8d 14 90             	lea    (%eax,%edx,4),%edx
  if(addr >= proc->sz || addr+4 > proc->sz)
801050a5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  return fetchint(thread->tf->esp + 4 + 4*n, ip);
801050ab:	8d 4a 04             	lea    0x4(%edx),%ecx
  if(addr >= proc->sz || addr+4 > proc->sz)
801050ae:	8b 00                	mov    (%eax),%eax
801050b0:	39 c1                	cmp    %eax,%ecx
801050b2:	73 38                	jae    801050ec <argstr+0x5c>
801050b4:	8d 4a 08             	lea    0x8(%edx),%ecx
801050b7:	39 c8                	cmp    %ecx,%eax
801050b9:	72 31                	jb     801050ec <argstr+0x5c>
  *ip = *(int*)(addr);
801050bb:	8b 4a 04             	mov    0x4(%edx),%ecx
  if(addr >= proc->sz)
801050be:	39 c1                	cmp    %eax,%ecx
801050c0:	73 2a                	jae    801050ec <argstr+0x5c>
  *pp = (char*)addr;
801050c2:	8b 55 0c             	mov    0xc(%ebp),%edx
801050c5:	89 c8                	mov    %ecx,%eax
801050c7:	89 0a                	mov    %ecx,(%edx)
  ep = (char*)proc->sz;
801050c9:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801050d0:	8b 12                	mov    (%edx),%edx
  for(s = *pp; s < ep; s++)
801050d2:	39 d1                	cmp    %edx,%ecx
801050d4:	73 16                	jae    801050ec <argstr+0x5c>
    if(*s == 0)
801050d6:	80 39 00             	cmpb   $0x0,(%ecx)
801050d9:	75 0a                	jne    801050e5 <argstr+0x55>
801050db:	eb 23                	jmp    80105100 <argstr+0x70>
801050dd:	8d 76 00             	lea    0x0(%esi),%esi
801050e0:	80 38 00             	cmpb   $0x0,(%eax)
801050e3:	74 13                	je     801050f8 <argstr+0x68>
  for(s = *pp; s < ep; s++)
801050e5:	83 c0 01             	add    $0x1,%eax
801050e8:	39 c2                	cmp    %eax,%edx
801050ea:	77 f4                	ja     801050e0 <argstr+0x50>
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
801050ec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchstr(addr, pp);
}
801050f1:	5d                   	pop    %ebp
801050f2:	c3                   	ret    
801050f3:	90                   	nop
801050f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801050f8:	29 c8                	sub    %ecx,%eax
801050fa:	5d                   	pop    %ebp
801050fb:	c3                   	ret    
801050fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(*s == 0)
80105100:	31 c0                	xor    %eax,%eax
}
80105102:	5d                   	pop    %ebp
80105103:	c3                   	ret    
80105104:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010510a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105110 <syscall>:
};


void
syscall(void)
{
80105110:	55                   	push   %ebp
80105111:	89 e5                	mov    %esp,%ebp
80105113:	83 ec 08             	sub    $0x8,%esp
  int num;

  num = thread->tf->eax;
80105116:	65 8b 15 08 00 00 00 	mov    %gs:0x8,%edx
8010511d:	8b 42 10             	mov    0x10(%edx),%eax
80105120:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105123:	8d 48 ff             	lea    -0x1(%eax),%ecx
80105126:	83 f9 1d             	cmp    $0x1d,%ecx
80105129:	77 25                	ja     80105150 <syscall+0x40>
8010512b:	8b 0c 85 a0 81 10 80 	mov    -0x7fef7e60(,%eax,4),%ecx
80105132:	85 c9                	test   %ecx,%ecx
80105134:	74 1a                	je     80105150 <syscall+0x40>
    thread->tf->eax = syscalls[num]();
80105136:	ff d1                	call   *%ecx
80105138:	65 8b 15 08 00 00 00 	mov    %gs:0x8,%edx
8010513f:	8b 52 10             	mov    0x10(%edx),%edx
80105142:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            thread->tid, proc->name, num);
    thread->tf->eax = -1;
  }
}
80105145:	c9                   	leave  
80105146:	c3                   	ret    
80105147:	89 f6                	mov    %esi,%esi
80105149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    cprintf("%d %s: unknown sys call %d\n",
80105150:	50                   	push   %eax
            thread->tid, proc->name, num);
80105151:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105157:	83 c0 5c             	add    $0x5c,%eax
    cprintf("%d %s: unknown sys call %d\n",
8010515a:	50                   	push   %eax
8010515b:	ff 32                	pushl  (%edx)
8010515d:	68 82 81 10 80       	push   $0x80108182
80105162:	e8 d9 b4 ff ff       	call   80100640 <cprintf>
    thread->tf->eax = -1;
80105167:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
8010516d:	83 c4 10             	add    $0x10,%esp
80105170:	8b 40 10             	mov    0x10(%eax),%eax
80105173:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
8010517a:	c9                   	leave  
8010517b:	c3                   	ret    
8010517c:	66 90                	xchg   %ax,%ax
8010517e:	66 90                	xchg   %ax,%ax

80105180 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105180:	55                   	push   %ebp
80105181:	89 e5                	mov    %esp,%ebp
80105183:	57                   	push   %edi
80105184:	56                   	push   %esi
80105185:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105186:	8d 75 da             	lea    -0x26(%ebp),%esi
{
80105189:	83 ec 44             	sub    $0x44,%esp
8010518c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
8010518f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80105192:	56                   	push   %esi
80105193:	50                   	push   %eax
{
80105194:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80105197:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
8010519a:	e8 a1 cd ff ff       	call   80101f40 <nameiparent>
8010519f:	83 c4 10             	add    $0x10,%esp
801051a2:	85 c0                	test   %eax,%eax
801051a4:	0f 84 46 01 00 00    	je     801052f0 <create+0x170>
    return 0;
  ilock(dp);
801051aa:	83 ec 0c             	sub    $0xc,%esp
801051ad:	89 c3                	mov    %eax,%ebx
801051af:	50                   	push   %eax
801051b0:	e8 cb c4 ff ff       	call   80101680 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
801051b5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
801051b8:	83 c4 0c             	add    $0xc,%esp
801051bb:	50                   	push   %eax
801051bc:	56                   	push   %esi
801051bd:	53                   	push   %ebx
801051be:	e8 2d ca ff ff       	call   80101bf0 <dirlookup>
801051c3:	83 c4 10             	add    $0x10,%esp
801051c6:	85 c0                	test   %eax,%eax
801051c8:	89 c7                	mov    %eax,%edi
801051ca:	74 34                	je     80105200 <create+0x80>
    iunlockput(dp);
801051cc:	83 ec 0c             	sub    $0xc,%esp
801051cf:	53                   	push   %ebx
801051d0:	e8 7b c7 ff ff       	call   80101950 <iunlockput>
    ilock(ip);
801051d5:	89 3c 24             	mov    %edi,(%esp)
801051d8:	e8 a3 c4 ff ff       	call   80101680 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
801051dd:	83 c4 10             	add    $0x10,%esp
801051e0:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
801051e5:	0f 85 95 00 00 00    	jne    80105280 <create+0x100>
801051eb:	66 83 7f 10 02       	cmpw   $0x2,0x10(%edi)
801051f0:	0f 85 8a 00 00 00    	jne    80105280 <create+0x100>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
801051f6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801051f9:	89 f8                	mov    %edi,%eax
801051fb:	5b                   	pop    %ebx
801051fc:	5e                   	pop    %esi
801051fd:	5f                   	pop    %edi
801051fe:	5d                   	pop    %ebp
801051ff:	c3                   	ret    
  if((ip = ialloc(dp->dev, type)) == 0)
80105200:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80105204:	83 ec 08             	sub    $0x8,%esp
80105207:	50                   	push   %eax
80105208:	ff 33                	pushl  (%ebx)
8010520a:	e8 01 c3 ff ff       	call   80101510 <ialloc>
8010520f:	83 c4 10             	add    $0x10,%esp
80105212:	85 c0                	test   %eax,%eax
80105214:	89 c7                	mov    %eax,%edi
80105216:	0f 84 e8 00 00 00    	je     80105304 <create+0x184>
  ilock(ip);
8010521c:	83 ec 0c             	sub    $0xc,%esp
8010521f:	50                   	push   %eax
80105220:	e8 5b c4 ff ff       	call   80101680 <ilock>
  ip->major = major;
80105225:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80105229:	66 89 47 12          	mov    %ax,0x12(%edi)
  ip->minor = minor;
8010522d:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80105231:	66 89 47 14          	mov    %ax,0x14(%edi)
  ip->nlink = 1;
80105235:	b8 01 00 00 00       	mov    $0x1,%eax
8010523a:	66 89 47 16          	mov    %ax,0x16(%edi)
  iupdate(ip);
8010523e:	89 3c 24             	mov    %edi,(%esp)
80105241:	e8 8a c3 ff ff       	call   801015d0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80105246:	83 c4 10             	add    $0x10,%esp
80105249:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
8010524e:	74 50                	je     801052a0 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80105250:	83 ec 04             	sub    $0x4,%esp
80105253:	ff 77 04             	pushl  0x4(%edi)
80105256:	56                   	push   %esi
80105257:	53                   	push   %ebx
80105258:	e8 03 cc ff ff       	call   80101e60 <dirlink>
8010525d:	83 c4 10             	add    $0x10,%esp
80105260:	85 c0                	test   %eax,%eax
80105262:	0f 88 8f 00 00 00    	js     801052f7 <create+0x177>
  iunlockput(dp);
80105268:	83 ec 0c             	sub    $0xc,%esp
8010526b:	53                   	push   %ebx
8010526c:	e8 df c6 ff ff       	call   80101950 <iunlockput>
  return ip;
80105271:	83 c4 10             	add    $0x10,%esp
}
80105274:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105277:	89 f8                	mov    %edi,%eax
80105279:	5b                   	pop    %ebx
8010527a:	5e                   	pop    %esi
8010527b:	5f                   	pop    %edi
8010527c:	5d                   	pop    %ebp
8010527d:	c3                   	ret    
8010527e:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80105280:	83 ec 0c             	sub    $0xc,%esp
80105283:	57                   	push   %edi
    return 0;
80105284:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80105286:	e8 c5 c6 ff ff       	call   80101950 <iunlockput>
    return 0;
8010528b:	83 c4 10             	add    $0x10,%esp
}
8010528e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105291:	89 f8                	mov    %edi,%eax
80105293:	5b                   	pop    %ebx
80105294:	5e                   	pop    %esi
80105295:	5f                   	pop    %edi
80105296:	5d                   	pop    %ebp
80105297:	c3                   	ret    
80105298:	90                   	nop
80105299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
801052a0:	66 83 43 16 01       	addw   $0x1,0x16(%ebx)
    iupdate(dp);
801052a5:	83 ec 0c             	sub    $0xc,%esp
801052a8:	53                   	push   %ebx
801052a9:	e8 22 c3 ff ff       	call   801015d0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
801052ae:	83 c4 0c             	add    $0xc,%esp
801052b1:	ff 77 04             	pushl  0x4(%edi)
801052b4:	68 38 82 10 80       	push   $0x80108238
801052b9:	57                   	push   %edi
801052ba:	e8 a1 cb ff ff       	call   80101e60 <dirlink>
801052bf:	83 c4 10             	add    $0x10,%esp
801052c2:	85 c0                	test   %eax,%eax
801052c4:	78 1c                	js     801052e2 <create+0x162>
801052c6:	83 ec 04             	sub    $0x4,%esp
801052c9:	ff 73 04             	pushl  0x4(%ebx)
801052cc:	68 37 82 10 80       	push   $0x80108237
801052d1:	57                   	push   %edi
801052d2:	e8 89 cb ff ff       	call   80101e60 <dirlink>
801052d7:	83 c4 10             	add    $0x10,%esp
801052da:	85 c0                	test   %eax,%eax
801052dc:	0f 89 6e ff ff ff    	jns    80105250 <create+0xd0>
      panic("create dots");
801052e2:	83 ec 0c             	sub    $0xc,%esp
801052e5:	68 2b 82 10 80       	push   $0x8010822b
801052ea:	e8 81 b0 ff ff       	call   80100370 <panic>
801052ef:	90                   	nop
    return 0;
801052f0:	31 ff                	xor    %edi,%edi
801052f2:	e9 ff fe ff ff       	jmp    801051f6 <create+0x76>
    panic("create: dirlink");
801052f7:	83 ec 0c             	sub    $0xc,%esp
801052fa:	68 3a 82 10 80       	push   $0x8010823a
801052ff:	e8 6c b0 ff ff       	call   80100370 <panic>
    panic("create: ialloc");
80105304:	83 ec 0c             	sub    $0xc,%esp
80105307:	68 1c 82 10 80       	push   $0x8010821c
8010530c:	e8 5f b0 ff ff       	call   80100370 <panic>
80105311:	eb 0d                	jmp    80105320 <argfd.constprop.0>
80105313:	90                   	nop
80105314:	90                   	nop
80105315:	90                   	nop
80105316:	90                   	nop
80105317:	90                   	nop
80105318:	90                   	nop
80105319:	90                   	nop
8010531a:	90                   	nop
8010531b:	90                   	nop
8010531c:	90                   	nop
8010531d:	90                   	nop
8010531e:	90                   	nop
8010531f:	90                   	nop

80105320 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80105320:	55                   	push   %ebp
80105321:	89 e5                	mov    %esp,%ebp
80105323:	56                   	push   %esi
80105324:	53                   	push   %ebx
80105325:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80105327:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
8010532a:	89 d6                	mov    %edx,%esi
8010532c:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010532f:	50                   	push   %eax
80105330:	6a 00                	push   $0x0
80105332:	e8 b9 fc ff ff       	call   80104ff0 <argint>
80105337:	83 c4 10             	add    $0x10,%esp
8010533a:	85 c0                	test   %eax,%eax
8010533c:	78 32                	js     80105370 <argfd.constprop.0+0x50>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
8010533e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105341:	83 f8 0f             	cmp    $0xf,%eax
80105344:	77 2a                	ja     80105370 <argfd.constprop.0+0x50>
80105346:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
8010534d:	8b 4c 82 18          	mov    0x18(%edx,%eax,4),%ecx
80105351:	85 c9                	test   %ecx,%ecx
80105353:	74 1b                	je     80105370 <argfd.constprop.0+0x50>
  if(pfd)
80105355:	85 db                	test   %ebx,%ebx
80105357:	74 02                	je     8010535b <argfd.constprop.0+0x3b>
    *pfd = fd;
80105359:	89 03                	mov    %eax,(%ebx)
    *pf = f;
8010535b:	89 0e                	mov    %ecx,(%esi)
  return 0;
8010535d:	31 c0                	xor    %eax,%eax
}
8010535f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105362:	5b                   	pop    %ebx
80105363:	5e                   	pop    %esi
80105364:	5d                   	pop    %ebp
80105365:	c3                   	ret    
80105366:	8d 76 00             	lea    0x0(%esi),%esi
80105369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105370:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105375:	eb e8                	jmp    8010535f <argfd.constprop.0+0x3f>
80105377:	89 f6                	mov    %esi,%esi
80105379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105380 <sys_dup>:
{
80105380:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80105381:	31 c0                	xor    %eax,%eax
{
80105383:	89 e5                	mov    %esp,%ebp
80105385:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80105386:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
80105389:	83 ec 14             	sub    $0x14,%esp
  if(argfd(0, 0, &f) < 0)
8010538c:	e8 8f ff ff ff       	call   80105320 <argfd.constprop.0>
80105391:	85 c0                	test   %eax,%eax
80105393:	78 3b                	js     801053d0 <sys_dup+0x50>
  if((fd=fdalloc(f)) < 0)
80105395:	8b 55 f4             	mov    -0xc(%ebp),%edx
    if(proc->ofile[fd] == 0){
80105398:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  for(fd = 0; fd < NOFILE; fd++){
8010539e:	31 db                	xor    %ebx,%ebx
801053a0:	eb 0e                	jmp    801053b0 <sys_dup+0x30>
801053a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801053a8:	83 c3 01             	add    $0x1,%ebx
801053ab:	83 fb 10             	cmp    $0x10,%ebx
801053ae:	74 20                	je     801053d0 <sys_dup+0x50>
    if(proc->ofile[fd] == 0){
801053b0:	8b 4c 98 18          	mov    0x18(%eax,%ebx,4),%ecx
801053b4:	85 c9                	test   %ecx,%ecx
801053b6:	75 f0                	jne    801053a8 <sys_dup+0x28>
  filedup(f);
801053b8:	83 ec 0c             	sub    $0xc,%esp
      proc->ofile[fd] = f;
801053bb:	89 54 98 18          	mov    %edx,0x18(%eax,%ebx,4)
  filedup(f);
801053bf:	52                   	push   %edx
801053c0:	e8 6b ba ff ff       	call   80100e30 <filedup>
}
801053c5:	89 d8                	mov    %ebx,%eax
  return fd;
801053c7:	83 c4 10             	add    $0x10,%esp
}
801053ca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801053cd:	c9                   	leave  
801053ce:	c3                   	ret    
801053cf:	90                   	nop
    return -1;
801053d0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
801053d5:	89 d8                	mov    %ebx,%eax
801053d7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801053da:	c9                   	leave  
801053db:	c3                   	ret    
801053dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801053e0 <sys_read>:
{
801053e0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801053e1:	31 c0                	xor    %eax,%eax
{
801053e3:	89 e5                	mov    %esp,%ebp
801053e5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801053e8:	8d 55 ec             	lea    -0x14(%ebp),%edx
801053eb:	e8 30 ff ff ff       	call   80105320 <argfd.constprop.0>
801053f0:	85 c0                	test   %eax,%eax
801053f2:	78 4c                	js     80105440 <sys_read+0x60>
801053f4:	8d 45 f0             	lea    -0x10(%ebp),%eax
801053f7:	83 ec 08             	sub    $0x8,%esp
801053fa:	50                   	push   %eax
801053fb:	6a 02                	push   $0x2
801053fd:	e8 ee fb ff ff       	call   80104ff0 <argint>
80105402:	83 c4 10             	add    $0x10,%esp
80105405:	85 c0                	test   %eax,%eax
80105407:	78 37                	js     80105440 <sys_read+0x60>
80105409:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010540c:	83 ec 04             	sub    $0x4,%esp
8010540f:	ff 75 f0             	pushl  -0x10(%ebp)
80105412:	50                   	push   %eax
80105413:	6a 01                	push   $0x1
80105415:	e8 26 fc ff ff       	call   80105040 <argptr>
8010541a:	83 c4 10             	add    $0x10,%esp
8010541d:	85 c0                	test   %eax,%eax
8010541f:	78 1f                	js     80105440 <sys_read+0x60>
  return fileread(f, p, n);
80105421:	83 ec 04             	sub    $0x4,%esp
80105424:	ff 75 f0             	pushl  -0x10(%ebp)
80105427:	ff 75 f4             	pushl  -0xc(%ebp)
8010542a:	ff 75 ec             	pushl  -0x14(%ebp)
8010542d:	e8 6e bb ff ff       	call   80100fa0 <fileread>
80105432:	83 c4 10             	add    $0x10,%esp
}
80105435:	c9                   	leave  
80105436:	c3                   	ret    
80105437:	89 f6                	mov    %esi,%esi
80105439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105440:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105445:	c9                   	leave  
80105446:	c3                   	ret    
80105447:	89 f6                	mov    %esi,%esi
80105449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105450 <sys_write>:
{
80105450:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105451:	31 c0                	xor    %eax,%eax
{
80105453:	89 e5                	mov    %esp,%ebp
80105455:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105458:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010545b:	e8 c0 fe ff ff       	call   80105320 <argfd.constprop.0>
80105460:	85 c0                	test   %eax,%eax
80105462:	78 4c                	js     801054b0 <sys_write+0x60>
80105464:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105467:	83 ec 08             	sub    $0x8,%esp
8010546a:	50                   	push   %eax
8010546b:	6a 02                	push   $0x2
8010546d:	e8 7e fb ff ff       	call   80104ff0 <argint>
80105472:	83 c4 10             	add    $0x10,%esp
80105475:	85 c0                	test   %eax,%eax
80105477:	78 37                	js     801054b0 <sys_write+0x60>
80105479:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010547c:	83 ec 04             	sub    $0x4,%esp
8010547f:	ff 75 f0             	pushl  -0x10(%ebp)
80105482:	50                   	push   %eax
80105483:	6a 01                	push   $0x1
80105485:	e8 b6 fb ff ff       	call   80105040 <argptr>
8010548a:	83 c4 10             	add    $0x10,%esp
8010548d:	85 c0                	test   %eax,%eax
8010548f:	78 1f                	js     801054b0 <sys_write+0x60>
  return filewrite(f, p, n);
80105491:	83 ec 04             	sub    $0x4,%esp
80105494:	ff 75 f0             	pushl  -0x10(%ebp)
80105497:	ff 75 f4             	pushl  -0xc(%ebp)
8010549a:	ff 75 ec             	pushl  -0x14(%ebp)
8010549d:	e8 8e bb ff ff       	call   80101030 <filewrite>
801054a2:	83 c4 10             	add    $0x10,%esp
}
801054a5:	c9                   	leave  
801054a6:	c3                   	ret    
801054a7:	89 f6                	mov    %esi,%esi
801054a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801054b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801054b5:	c9                   	leave  
801054b6:	c3                   	ret    
801054b7:	89 f6                	mov    %esi,%esi
801054b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801054c0 <sys_close>:
{
801054c0:	55                   	push   %ebp
801054c1:	89 e5                	mov    %esp,%ebp
801054c3:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
801054c6:	8d 55 f4             	lea    -0xc(%ebp),%edx
801054c9:	8d 45 f0             	lea    -0x10(%ebp),%eax
801054cc:	e8 4f fe ff ff       	call   80105320 <argfd.constprop.0>
801054d1:	85 c0                	test   %eax,%eax
801054d3:	78 2b                	js     80105500 <sys_close+0x40>
  proc->ofile[fd] = 0;
801054d5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801054db:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
801054de:	83 ec 0c             	sub    $0xc,%esp
  proc->ofile[fd] = 0;
801054e1:	c7 44 90 18 00 00 00 	movl   $0x0,0x18(%eax,%edx,4)
801054e8:	00 
  fileclose(f);
801054e9:	ff 75 f4             	pushl  -0xc(%ebp)
801054ec:	e8 8f b9 ff ff       	call   80100e80 <fileclose>
  return 0;
801054f1:	83 c4 10             	add    $0x10,%esp
801054f4:	31 c0                	xor    %eax,%eax
}
801054f6:	c9                   	leave  
801054f7:	c3                   	ret    
801054f8:	90                   	nop
801054f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105500:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105505:	c9                   	leave  
80105506:	c3                   	ret    
80105507:	89 f6                	mov    %esi,%esi
80105509:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105510 <sys_fstat>:
{
80105510:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105511:	31 c0                	xor    %eax,%eax
{
80105513:	89 e5                	mov    %esp,%ebp
80105515:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105518:	8d 55 f0             	lea    -0x10(%ebp),%edx
8010551b:	e8 00 fe ff ff       	call   80105320 <argfd.constprop.0>
80105520:	85 c0                	test   %eax,%eax
80105522:	78 2c                	js     80105550 <sys_fstat+0x40>
80105524:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105527:	83 ec 04             	sub    $0x4,%esp
8010552a:	6a 14                	push   $0x14
8010552c:	50                   	push   %eax
8010552d:	6a 01                	push   $0x1
8010552f:	e8 0c fb ff ff       	call   80105040 <argptr>
80105534:	83 c4 10             	add    $0x10,%esp
80105537:	85 c0                	test   %eax,%eax
80105539:	78 15                	js     80105550 <sys_fstat+0x40>
  return filestat(f, st);
8010553b:	83 ec 08             	sub    $0x8,%esp
8010553e:	ff 75 f4             	pushl  -0xc(%ebp)
80105541:	ff 75 f0             	pushl  -0x10(%ebp)
80105544:	e8 07 ba ff ff       	call   80100f50 <filestat>
80105549:	83 c4 10             	add    $0x10,%esp
}
8010554c:	c9                   	leave  
8010554d:	c3                   	ret    
8010554e:	66 90                	xchg   %ax,%ax
    return -1;
80105550:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105555:	c9                   	leave  
80105556:	c3                   	ret    
80105557:	89 f6                	mov    %esi,%esi
80105559:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105560 <sys_link>:
{
80105560:	55                   	push   %ebp
80105561:	89 e5                	mov    %esp,%ebp
80105563:	57                   	push   %edi
80105564:	56                   	push   %esi
80105565:	53                   	push   %ebx
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105566:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105569:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010556c:	50                   	push   %eax
8010556d:	6a 00                	push   $0x0
8010556f:	e8 1c fb ff ff       	call   80105090 <argstr>
80105574:	83 c4 10             	add    $0x10,%esp
80105577:	85 c0                	test   %eax,%eax
80105579:	0f 88 fb 00 00 00    	js     8010567a <sys_link+0x11a>
8010557f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105582:	83 ec 08             	sub    $0x8,%esp
80105585:	50                   	push   %eax
80105586:	6a 01                	push   $0x1
80105588:	e8 03 fb ff ff       	call   80105090 <argstr>
8010558d:	83 c4 10             	add    $0x10,%esp
80105590:	85 c0                	test   %eax,%eax
80105592:	0f 88 e2 00 00 00    	js     8010567a <sys_link+0x11a>
  begin_op();
80105598:	e8 f3 d6 ff ff       	call   80102c90 <begin_op>
  if((ip = namei(old)) == 0){
8010559d:	83 ec 0c             	sub    $0xc,%esp
801055a0:	ff 75 d4             	pushl  -0x2c(%ebp)
801055a3:	e8 78 c9 ff ff       	call   80101f20 <namei>
801055a8:	83 c4 10             	add    $0x10,%esp
801055ab:	85 c0                	test   %eax,%eax
801055ad:	89 c3                	mov    %eax,%ebx
801055af:	0f 84 ea 00 00 00    	je     8010569f <sys_link+0x13f>
  ilock(ip);
801055b5:	83 ec 0c             	sub    $0xc,%esp
801055b8:	50                   	push   %eax
801055b9:	e8 c2 c0 ff ff       	call   80101680 <ilock>
  if(ip->type == T_DIR){
801055be:	83 c4 10             	add    $0x10,%esp
801055c1:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
801055c6:	0f 84 bb 00 00 00    	je     80105687 <sys_link+0x127>
  ip->nlink++;
801055cc:	66 83 43 16 01       	addw   $0x1,0x16(%ebx)
  iupdate(ip);
801055d1:	83 ec 0c             	sub    $0xc,%esp
  if((dp = nameiparent(new, name)) == 0)
801055d4:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
801055d7:	53                   	push   %ebx
801055d8:	e8 f3 bf ff ff       	call   801015d0 <iupdate>
  iunlock(ip);
801055dd:	89 1c 24             	mov    %ebx,(%esp)
801055e0:	e8 ab c1 ff ff       	call   80101790 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
801055e5:	58                   	pop    %eax
801055e6:	5a                   	pop    %edx
801055e7:	57                   	push   %edi
801055e8:	ff 75 d0             	pushl  -0x30(%ebp)
801055eb:	e8 50 c9 ff ff       	call   80101f40 <nameiparent>
801055f0:	83 c4 10             	add    $0x10,%esp
801055f3:	85 c0                	test   %eax,%eax
801055f5:	89 c6                	mov    %eax,%esi
801055f7:	74 5b                	je     80105654 <sys_link+0xf4>
  ilock(dp);
801055f9:	83 ec 0c             	sub    $0xc,%esp
801055fc:	50                   	push   %eax
801055fd:	e8 7e c0 ff ff       	call   80101680 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105602:	83 c4 10             	add    $0x10,%esp
80105605:	8b 03                	mov    (%ebx),%eax
80105607:	39 06                	cmp    %eax,(%esi)
80105609:	75 3d                	jne    80105648 <sys_link+0xe8>
8010560b:	83 ec 04             	sub    $0x4,%esp
8010560e:	ff 73 04             	pushl  0x4(%ebx)
80105611:	57                   	push   %edi
80105612:	56                   	push   %esi
80105613:	e8 48 c8 ff ff       	call   80101e60 <dirlink>
80105618:	83 c4 10             	add    $0x10,%esp
8010561b:	85 c0                	test   %eax,%eax
8010561d:	78 29                	js     80105648 <sys_link+0xe8>
  iunlockput(dp);
8010561f:	83 ec 0c             	sub    $0xc,%esp
80105622:	56                   	push   %esi
80105623:	e8 28 c3 ff ff       	call   80101950 <iunlockput>
  iput(ip);
80105628:	89 1c 24             	mov    %ebx,(%esp)
8010562b:	e8 c0 c1 ff ff       	call   801017f0 <iput>
  end_op();
80105630:	e8 cb d6 ff ff       	call   80102d00 <end_op>
  return 0;
80105635:	83 c4 10             	add    $0x10,%esp
80105638:	31 c0                	xor    %eax,%eax
}
8010563a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010563d:	5b                   	pop    %ebx
8010563e:	5e                   	pop    %esi
8010563f:	5f                   	pop    %edi
80105640:	5d                   	pop    %ebp
80105641:	c3                   	ret    
80105642:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105648:	83 ec 0c             	sub    $0xc,%esp
8010564b:	56                   	push   %esi
8010564c:	e8 ff c2 ff ff       	call   80101950 <iunlockput>
    goto bad;
80105651:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105654:	83 ec 0c             	sub    $0xc,%esp
80105657:	53                   	push   %ebx
80105658:	e8 23 c0 ff ff       	call   80101680 <ilock>
  ip->nlink--;
8010565d:	66 83 6b 16 01       	subw   $0x1,0x16(%ebx)
  iupdate(ip);
80105662:	89 1c 24             	mov    %ebx,(%esp)
80105665:	e8 66 bf ff ff       	call   801015d0 <iupdate>
  iunlockput(ip);
8010566a:	89 1c 24             	mov    %ebx,(%esp)
8010566d:	e8 de c2 ff ff       	call   80101950 <iunlockput>
  end_op();
80105672:	e8 89 d6 ff ff       	call   80102d00 <end_op>
  return -1;
80105677:	83 c4 10             	add    $0x10,%esp
}
8010567a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010567d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105682:	5b                   	pop    %ebx
80105683:	5e                   	pop    %esi
80105684:	5f                   	pop    %edi
80105685:	5d                   	pop    %ebp
80105686:	c3                   	ret    
    iunlockput(ip);
80105687:	83 ec 0c             	sub    $0xc,%esp
8010568a:	53                   	push   %ebx
8010568b:	e8 c0 c2 ff ff       	call   80101950 <iunlockput>
    end_op();
80105690:	e8 6b d6 ff ff       	call   80102d00 <end_op>
    return -1;
80105695:	83 c4 10             	add    $0x10,%esp
80105698:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010569d:	eb 9b                	jmp    8010563a <sys_link+0xda>
    end_op();
8010569f:	e8 5c d6 ff ff       	call   80102d00 <end_op>
    return -1;
801056a4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056a9:	eb 8f                	jmp    8010563a <sys_link+0xda>
801056ab:	90                   	nop
801056ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801056b0 <sys_unlink>:
{
801056b0:	55                   	push   %ebp
801056b1:	89 e5                	mov    %esp,%ebp
801056b3:	57                   	push   %edi
801056b4:	56                   	push   %esi
801056b5:	53                   	push   %ebx
  if(argstr(0, &path) < 0)
801056b6:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
801056b9:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
801056bc:	50                   	push   %eax
801056bd:	6a 00                	push   $0x0
801056bf:	e8 cc f9 ff ff       	call   80105090 <argstr>
801056c4:	83 c4 10             	add    $0x10,%esp
801056c7:	85 c0                	test   %eax,%eax
801056c9:	0f 88 77 01 00 00    	js     80105846 <sys_unlink+0x196>
  if((dp = nameiparent(path, name)) == 0){
801056cf:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
801056d2:	e8 b9 d5 ff ff       	call   80102c90 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801056d7:	83 ec 08             	sub    $0x8,%esp
801056da:	53                   	push   %ebx
801056db:	ff 75 c0             	pushl  -0x40(%ebp)
801056de:	e8 5d c8 ff ff       	call   80101f40 <nameiparent>
801056e3:	83 c4 10             	add    $0x10,%esp
801056e6:	85 c0                	test   %eax,%eax
801056e8:	89 c6                	mov    %eax,%esi
801056ea:	0f 84 60 01 00 00    	je     80105850 <sys_unlink+0x1a0>
  ilock(dp);
801056f0:	83 ec 0c             	sub    $0xc,%esp
801056f3:	50                   	push   %eax
801056f4:	e8 87 bf ff ff       	call   80101680 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801056f9:	58                   	pop    %eax
801056fa:	5a                   	pop    %edx
801056fb:	68 38 82 10 80       	push   $0x80108238
80105700:	53                   	push   %ebx
80105701:	e8 ca c4 ff ff       	call   80101bd0 <namecmp>
80105706:	83 c4 10             	add    $0x10,%esp
80105709:	85 c0                	test   %eax,%eax
8010570b:	0f 84 03 01 00 00    	je     80105814 <sys_unlink+0x164>
80105711:	83 ec 08             	sub    $0x8,%esp
80105714:	68 37 82 10 80       	push   $0x80108237
80105719:	53                   	push   %ebx
8010571a:	e8 b1 c4 ff ff       	call   80101bd0 <namecmp>
8010571f:	83 c4 10             	add    $0x10,%esp
80105722:	85 c0                	test   %eax,%eax
80105724:	0f 84 ea 00 00 00    	je     80105814 <sys_unlink+0x164>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010572a:	8d 45 c4             	lea    -0x3c(%ebp),%eax
8010572d:	83 ec 04             	sub    $0x4,%esp
80105730:	50                   	push   %eax
80105731:	53                   	push   %ebx
80105732:	56                   	push   %esi
80105733:	e8 b8 c4 ff ff       	call   80101bf0 <dirlookup>
80105738:	83 c4 10             	add    $0x10,%esp
8010573b:	85 c0                	test   %eax,%eax
8010573d:	89 c3                	mov    %eax,%ebx
8010573f:	0f 84 cf 00 00 00    	je     80105814 <sys_unlink+0x164>
  ilock(ip);
80105745:	83 ec 0c             	sub    $0xc,%esp
80105748:	50                   	push   %eax
80105749:	e8 32 bf ff ff       	call   80101680 <ilock>
  if(ip->nlink < 1)
8010574e:	83 c4 10             	add    $0x10,%esp
80105751:	66 83 7b 16 00       	cmpw   $0x0,0x16(%ebx)
80105756:	0f 8e 10 01 00 00    	jle    8010586c <sys_unlink+0x1bc>
  if(ip->type == T_DIR && !isdirempty(ip)){
8010575c:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
80105761:	74 6d                	je     801057d0 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80105763:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105766:	83 ec 04             	sub    $0x4,%esp
80105769:	6a 10                	push   $0x10
8010576b:	6a 00                	push   $0x0
8010576d:	50                   	push   %eax
8010576e:	e8 9d f5 ff ff       	call   80104d10 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105773:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105776:	6a 10                	push   $0x10
80105778:	ff 75 c4             	pushl  -0x3c(%ebp)
8010577b:	50                   	push   %eax
8010577c:	56                   	push   %esi
8010577d:	e8 1e c3 ff ff       	call   80101aa0 <writei>
80105782:	83 c4 20             	add    $0x20,%esp
80105785:	83 f8 10             	cmp    $0x10,%eax
80105788:	0f 85 eb 00 00 00    	jne    80105879 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
8010578e:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
80105793:	0f 84 97 00 00 00    	je     80105830 <sys_unlink+0x180>
  iunlockput(dp);
80105799:	83 ec 0c             	sub    $0xc,%esp
8010579c:	56                   	push   %esi
8010579d:	e8 ae c1 ff ff       	call   80101950 <iunlockput>
  ip->nlink--;
801057a2:	66 83 6b 16 01       	subw   $0x1,0x16(%ebx)
  iupdate(ip);
801057a7:	89 1c 24             	mov    %ebx,(%esp)
801057aa:	e8 21 be ff ff       	call   801015d0 <iupdate>
  iunlockput(ip);
801057af:	89 1c 24             	mov    %ebx,(%esp)
801057b2:	e8 99 c1 ff ff       	call   80101950 <iunlockput>
  end_op();
801057b7:	e8 44 d5 ff ff       	call   80102d00 <end_op>
  return 0;
801057bc:	83 c4 10             	add    $0x10,%esp
801057bf:	31 c0                	xor    %eax,%eax
}
801057c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801057c4:	5b                   	pop    %ebx
801057c5:	5e                   	pop    %esi
801057c6:	5f                   	pop    %edi
801057c7:	5d                   	pop    %ebp
801057c8:	c3                   	ret    
801057c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801057d0:	83 7b 18 20          	cmpl   $0x20,0x18(%ebx)
801057d4:	76 8d                	jbe    80105763 <sys_unlink+0xb3>
801057d6:	bf 20 00 00 00       	mov    $0x20,%edi
801057db:	eb 0f                	jmp    801057ec <sys_unlink+0x13c>
801057dd:	8d 76 00             	lea    0x0(%esi),%esi
801057e0:	83 c7 10             	add    $0x10,%edi
801057e3:	3b 7b 18             	cmp    0x18(%ebx),%edi
801057e6:	0f 83 77 ff ff ff    	jae    80105763 <sys_unlink+0xb3>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801057ec:	8d 45 d8             	lea    -0x28(%ebp),%eax
801057ef:	6a 10                	push   $0x10
801057f1:	57                   	push   %edi
801057f2:	50                   	push   %eax
801057f3:	53                   	push   %ebx
801057f4:	e8 a7 c1 ff ff       	call   801019a0 <readi>
801057f9:	83 c4 10             	add    $0x10,%esp
801057fc:	83 f8 10             	cmp    $0x10,%eax
801057ff:	75 5e                	jne    8010585f <sys_unlink+0x1af>
    if(de.inum != 0)
80105801:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105806:	74 d8                	je     801057e0 <sys_unlink+0x130>
    iunlockput(ip);
80105808:	83 ec 0c             	sub    $0xc,%esp
8010580b:	53                   	push   %ebx
8010580c:	e8 3f c1 ff ff       	call   80101950 <iunlockput>
    goto bad;
80105811:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
80105814:	83 ec 0c             	sub    $0xc,%esp
80105817:	56                   	push   %esi
80105818:	e8 33 c1 ff ff       	call   80101950 <iunlockput>
  end_op();
8010581d:	e8 de d4 ff ff       	call   80102d00 <end_op>
  return -1;
80105822:	83 c4 10             	add    $0x10,%esp
80105825:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010582a:	eb 95                	jmp    801057c1 <sys_unlink+0x111>
8010582c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
80105830:	66 83 6e 16 01       	subw   $0x1,0x16(%esi)
    iupdate(dp);
80105835:	83 ec 0c             	sub    $0xc,%esp
80105838:	56                   	push   %esi
80105839:	e8 92 bd ff ff       	call   801015d0 <iupdate>
8010583e:	83 c4 10             	add    $0x10,%esp
80105841:	e9 53 ff ff ff       	jmp    80105799 <sys_unlink+0xe9>
    return -1;
80105846:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010584b:	e9 71 ff ff ff       	jmp    801057c1 <sys_unlink+0x111>
    end_op();
80105850:	e8 ab d4 ff ff       	call   80102d00 <end_op>
    return -1;
80105855:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010585a:	e9 62 ff ff ff       	jmp    801057c1 <sys_unlink+0x111>
      panic("isdirempty: readi");
8010585f:	83 ec 0c             	sub    $0xc,%esp
80105862:	68 5c 82 10 80       	push   $0x8010825c
80105867:	e8 04 ab ff ff       	call   80100370 <panic>
    panic("unlink: nlink < 1");
8010586c:	83 ec 0c             	sub    $0xc,%esp
8010586f:	68 4a 82 10 80       	push   $0x8010824a
80105874:	e8 f7 aa ff ff       	call   80100370 <panic>
    panic("unlink: writei");
80105879:	83 ec 0c             	sub    $0xc,%esp
8010587c:	68 6e 82 10 80       	push   $0x8010826e
80105881:	e8 ea aa ff ff       	call   80100370 <panic>
80105886:	8d 76 00             	lea    0x0(%esi),%esi
80105889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105890 <sys_open>:

int
sys_open(void)
{
80105890:	55                   	push   %ebp
80105891:	89 e5                	mov    %esp,%ebp
80105893:	57                   	push   %edi
80105894:	56                   	push   %esi
80105895:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105896:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105899:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010589c:	50                   	push   %eax
8010589d:	6a 00                	push   $0x0
8010589f:	e8 ec f7 ff ff       	call   80105090 <argstr>
801058a4:	83 c4 10             	add    $0x10,%esp
801058a7:	85 c0                	test   %eax,%eax
801058a9:	0f 88 1d 01 00 00    	js     801059cc <sys_open+0x13c>
801058af:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801058b2:	83 ec 08             	sub    $0x8,%esp
801058b5:	50                   	push   %eax
801058b6:	6a 01                	push   $0x1
801058b8:	e8 33 f7 ff ff       	call   80104ff0 <argint>
801058bd:	83 c4 10             	add    $0x10,%esp
801058c0:	85 c0                	test   %eax,%eax
801058c2:	0f 88 04 01 00 00    	js     801059cc <sys_open+0x13c>
    return -1;

  begin_op();
801058c8:	e8 c3 d3 ff ff       	call   80102c90 <begin_op>

  if(omode & O_CREATE){
801058cd:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801058d1:	0f 85 a9 00 00 00    	jne    80105980 <sys_open+0xf0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801058d7:	83 ec 0c             	sub    $0xc,%esp
801058da:	ff 75 e0             	pushl  -0x20(%ebp)
801058dd:	e8 3e c6 ff ff       	call   80101f20 <namei>
801058e2:	83 c4 10             	add    $0x10,%esp
801058e5:	85 c0                	test   %eax,%eax
801058e7:	89 c6                	mov    %eax,%esi
801058e9:	0f 84 b2 00 00 00    	je     801059a1 <sys_open+0x111>
      end_op();
      return -1;
    }
    ilock(ip);
801058ef:	83 ec 0c             	sub    $0xc,%esp
801058f2:	50                   	push   %eax
801058f3:	e8 88 bd ff ff       	call   80101680 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801058f8:	83 c4 10             	add    $0x10,%esp
801058fb:	66 83 7e 10 01       	cmpw   $0x1,0x10(%esi)
80105900:	0f 84 aa 00 00 00    	je     801059b0 <sys_open+0x120>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105906:	e8 b5 b4 ff ff       	call   80100dc0 <filealloc>
8010590b:	85 c0                	test   %eax,%eax
8010590d:	89 c7                	mov    %eax,%edi
8010590f:	0f 84 a6 00 00 00    	je     801059bb <sys_open+0x12b>
    if(proc->ofile[fd] == 0){
80105915:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  for(fd = 0; fd < NOFILE; fd++){
8010591c:	31 db                	xor    %ebx,%ebx
8010591e:	eb 0c                	jmp    8010592c <sys_open+0x9c>
80105920:	83 c3 01             	add    $0x1,%ebx
80105923:	83 fb 10             	cmp    $0x10,%ebx
80105926:	0f 84 ac 00 00 00    	je     801059d8 <sys_open+0x148>
    if(proc->ofile[fd] == 0){
8010592c:	8b 44 9a 18          	mov    0x18(%edx,%ebx,4),%eax
80105930:	85 c0                	test   %eax,%eax
80105932:	75 ec                	jne    80105920 <sys_open+0x90>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105934:	83 ec 0c             	sub    $0xc,%esp
      proc->ofile[fd] = f;
80105937:	89 7c 9a 18          	mov    %edi,0x18(%edx,%ebx,4)
  iunlock(ip);
8010593b:	56                   	push   %esi
8010593c:	e8 4f be ff ff       	call   80101790 <iunlock>
  end_op();
80105941:	e8 ba d3 ff ff       	call   80102d00 <end_op>

  f->type = FD_INODE;
80105946:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
8010594c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010594f:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105952:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
80105955:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
8010595c:	89 d0                	mov    %edx,%eax
8010595e:	f7 d0                	not    %eax
80105960:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105963:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105966:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105969:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
8010596d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105970:	89 d8                	mov    %ebx,%eax
80105972:	5b                   	pop    %ebx
80105973:	5e                   	pop    %esi
80105974:	5f                   	pop    %edi
80105975:	5d                   	pop    %ebp
80105976:	c3                   	ret    
80105977:	89 f6                	mov    %esi,%esi
80105979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ip = create(path, T_FILE, 0, 0);
80105980:	83 ec 0c             	sub    $0xc,%esp
80105983:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105986:	31 c9                	xor    %ecx,%ecx
80105988:	6a 00                	push   $0x0
8010598a:	ba 02 00 00 00       	mov    $0x2,%edx
8010598f:	e8 ec f7 ff ff       	call   80105180 <create>
    if(ip == 0){
80105994:	83 c4 10             	add    $0x10,%esp
80105997:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80105999:	89 c6                	mov    %eax,%esi
    if(ip == 0){
8010599b:	0f 85 65 ff ff ff    	jne    80105906 <sys_open+0x76>
      end_op();
801059a1:	e8 5a d3 ff ff       	call   80102d00 <end_op>
      return -1;
801059a6:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801059ab:	eb c0                	jmp    8010596d <sys_open+0xdd>
801059ad:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
801059b0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801059b3:	85 d2                	test   %edx,%edx
801059b5:	0f 84 4b ff ff ff    	je     80105906 <sys_open+0x76>
    iunlockput(ip);
801059bb:	83 ec 0c             	sub    $0xc,%esp
801059be:	56                   	push   %esi
801059bf:	e8 8c bf ff ff       	call   80101950 <iunlockput>
    end_op();
801059c4:	e8 37 d3 ff ff       	call   80102d00 <end_op>
    return -1;
801059c9:	83 c4 10             	add    $0x10,%esp
801059cc:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801059d1:	eb 9a                	jmp    8010596d <sys_open+0xdd>
801059d3:	90                   	nop
801059d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
801059d8:	83 ec 0c             	sub    $0xc,%esp
801059db:	57                   	push   %edi
801059dc:	e8 9f b4 ff ff       	call   80100e80 <fileclose>
801059e1:	83 c4 10             	add    $0x10,%esp
801059e4:	eb d5                	jmp    801059bb <sys_open+0x12b>
801059e6:	8d 76 00             	lea    0x0(%esi),%esi
801059e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801059f0 <sys_mkdir>:

int
sys_mkdir(void)
{
801059f0:	55                   	push   %ebp
801059f1:	89 e5                	mov    %esp,%ebp
801059f3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801059f6:	e8 95 d2 ff ff       	call   80102c90 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801059fb:	8d 45 f4             	lea    -0xc(%ebp),%eax
801059fe:	83 ec 08             	sub    $0x8,%esp
80105a01:	50                   	push   %eax
80105a02:	6a 00                	push   $0x0
80105a04:	e8 87 f6 ff ff       	call   80105090 <argstr>
80105a09:	83 c4 10             	add    $0x10,%esp
80105a0c:	85 c0                	test   %eax,%eax
80105a0e:	78 30                	js     80105a40 <sys_mkdir+0x50>
80105a10:	83 ec 0c             	sub    $0xc,%esp
80105a13:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a16:	31 c9                	xor    %ecx,%ecx
80105a18:	6a 00                	push   $0x0
80105a1a:	ba 01 00 00 00       	mov    $0x1,%edx
80105a1f:	e8 5c f7 ff ff       	call   80105180 <create>
80105a24:	83 c4 10             	add    $0x10,%esp
80105a27:	85 c0                	test   %eax,%eax
80105a29:	74 15                	je     80105a40 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105a2b:	83 ec 0c             	sub    $0xc,%esp
80105a2e:	50                   	push   %eax
80105a2f:	e8 1c bf ff ff       	call   80101950 <iunlockput>
  end_op();
80105a34:	e8 c7 d2 ff ff       	call   80102d00 <end_op>
  return 0;
80105a39:	83 c4 10             	add    $0x10,%esp
80105a3c:	31 c0                	xor    %eax,%eax
}
80105a3e:	c9                   	leave  
80105a3f:	c3                   	ret    
    end_op();
80105a40:	e8 bb d2 ff ff       	call   80102d00 <end_op>
    return -1;
80105a45:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105a4a:	c9                   	leave  
80105a4b:	c3                   	ret    
80105a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105a50 <sys_mknod>:

int
sys_mknod(void)
{
80105a50:	55                   	push   %ebp
80105a51:	89 e5                	mov    %esp,%ebp
80105a53:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105a56:	e8 35 d2 ff ff       	call   80102c90 <begin_op>
  if((argstr(0, &path)) < 0 ||
80105a5b:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105a5e:	83 ec 08             	sub    $0x8,%esp
80105a61:	50                   	push   %eax
80105a62:	6a 00                	push   $0x0
80105a64:	e8 27 f6 ff ff       	call   80105090 <argstr>
80105a69:	83 c4 10             	add    $0x10,%esp
80105a6c:	85 c0                	test   %eax,%eax
80105a6e:	78 60                	js     80105ad0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105a70:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105a73:	83 ec 08             	sub    $0x8,%esp
80105a76:	50                   	push   %eax
80105a77:	6a 01                	push   $0x1
80105a79:	e8 72 f5 ff ff       	call   80104ff0 <argint>
  if((argstr(0, &path)) < 0 ||
80105a7e:	83 c4 10             	add    $0x10,%esp
80105a81:	85 c0                	test   %eax,%eax
80105a83:	78 4b                	js     80105ad0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105a85:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a88:	83 ec 08             	sub    $0x8,%esp
80105a8b:	50                   	push   %eax
80105a8c:	6a 02                	push   $0x2
80105a8e:	e8 5d f5 ff ff       	call   80104ff0 <argint>
     argint(1, &major) < 0 ||
80105a93:	83 c4 10             	add    $0x10,%esp
80105a96:	85 c0                	test   %eax,%eax
80105a98:	78 36                	js     80105ad0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80105a9a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
80105a9e:	83 ec 0c             	sub    $0xc,%esp
     (ip = create(path, T_DEV, major, minor)) == 0){
80105aa1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
     argint(2, &minor) < 0 ||
80105aa5:	ba 03 00 00 00       	mov    $0x3,%edx
80105aaa:	50                   	push   %eax
80105aab:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105aae:	e8 cd f6 ff ff       	call   80105180 <create>
80105ab3:	83 c4 10             	add    $0x10,%esp
80105ab6:	85 c0                	test   %eax,%eax
80105ab8:	74 16                	je     80105ad0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105aba:	83 ec 0c             	sub    $0xc,%esp
80105abd:	50                   	push   %eax
80105abe:	e8 8d be ff ff       	call   80101950 <iunlockput>
  end_op();
80105ac3:	e8 38 d2 ff ff       	call   80102d00 <end_op>
  return 0;
80105ac8:	83 c4 10             	add    $0x10,%esp
80105acb:	31 c0                	xor    %eax,%eax
}
80105acd:	c9                   	leave  
80105ace:	c3                   	ret    
80105acf:	90                   	nop
    end_op();
80105ad0:	e8 2b d2 ff ff       	call   80102d00 <end_op>
    return -1;
80105ad5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ada:	c9                   	leave  
80105adb:	c3                   	ret    
80105adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105ae0 <sys_chdir>:

int
sys_chdir(void)
{
80105ae0:	55                   	push   %ebp
80105ae1:	89 e5                	mov    %esp,%ebp
80105ae3:	53                   	push   %ebx
80105ae4:	83 ec 14             	sub    $0x14,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105ae7:	e8 a4 d1 ff ff       	call   80102c90 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105aec:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105aef:	83 ec 08             	sub    $0x8,%esp
80105af2:	50                   	push   %eax
80105af3:	6a 00                	push   $0x0
80105af5:	e8 96 f5 ff ff       	call   80105090 <argstr>
80105afa:	83 c4 10             	add    $0x10,%esp
80105afd:	85 c0                	test   %eax,%eax
80105aff:	78 7f                	js     80105b80 <sys_chdir+0xa0>
80105b01:	83 ec 0c             	sub    $0xc,%esp
80105b04:	ff 75 f4             	pushl  -0xc(%ebp)
80105b07:	e8 14 c4 ff ff       	call   80101f20 <namei>
80105b0c:	83 c4 10             	add    $0x10,%esp
80105b0f:	85 c0                	test   %eax,%eax
80105b11:	89 c3                	mov    %eax,%ebx
80105b13:	74 6b                	je     80105b80 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
80105b15:	83 ec 0c             	sub    $0xc,%esp
80105b18:	50                   	push   %eax
80105b19:	e8 62 bb ff ff       	call   80101680 <ilock>
  if(ip->type != T_DIR){
80105b1e:	83 c4 10             	add    $0x10,%esp
80105b21:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
80105b26:	75 38                	jne    80105b60 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105b28:	83 ec 0c             	sub    $0xc,%esp
80105b2b:	53                   	push   %ebx
80105b2c:	e8 5f bc ff ff       	call   80101790 <iunlock>
  iput(proc->cwd);
80105b31:	58                   	pop    %eax
80105b32:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105b38:	ff 70 58             	pushl  0x58(%eax)
80105b3b:	e8 b0 bc ff ff       	call   801017f0 <iput>
  end_op();
80105b40:	e8 bb d1 ff ff       	call   80102d00 <end_op>
  proc->cwd = ip;
80105b45:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  return 0;
80105b4b:	83 c4 10             	add    $0x10,%esp
  proc->cwd = ip;
80105b4e:	89 58 58             	mov    %ebx,0x58(%eax)
  return 0;
80105b51:	31 c0                	xor    %eax,%eax
}
80105b53:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105b56:	c9                   	leave  
80105b57:	c3                   	ret    
80105b58:	90                   	nop
80105b59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(ip);
80105b60:	83 ec 0c             	sub    $0xc,%esp
80105b63:	53                   	push   %ebx
80105b64:	e8 e7 bd ff ff       	call   80101950 <iunlockput>
    end_op();
80105b69:	e8 92 d1 ff ff       	call   80102d00 <end_op>
    return -1;
80105b6e:	83 c4 10             	add    $0x10,%esp
80105b71:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b76:	eb db                	jmp    80105b53 <sys_chdir+0x73>
80105b78:	90                   	nop
80105b79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105b80:	e8 7b d1 ff ff       	call   80102d00 <end_op>
    return -1;
80105b85:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b8a:	eb c7                	jmp    80105b53 <sys_chdir+0x73>
80105b8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105b90 <sys_exec>:

int
sys_exec(void)
{
80105b90:	55                   	push   %ebp
80105b91:	89 e5                	mov    %esp,%ebp
80105b93:	57                   	push   %edi
80105b94:	56                   	push   %esi
80105b95:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105b96:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
80105b9c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105ba2:	50                   	push   %eax
80105ba3:	6a 00                	push   $0x0
80105ba5:	e8 e6 f4 ff ff       	call   80105090 <argstr>
80105baa:	83 c4 10             	add    $0x10,%esp
80105bad:	85 c0                	test   %eax,%eax
80105baf:	0f 88 87 00 00 00    	js     80105c3c <sys_exec+0xac>
80105bb5:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105bbb:	83 ec 08             	sub    $0x8,%esp
80105bbe:	50                   	push   %eax
80105bbf:	6a 01                	push   $0x1
80105bc1:	e8 2a f4 ff ff       	call   80104ff0 <argint>
80105bc6:	83 c4 10             	add    $0x10,%esp
80105bc9:	85 c0                	test   %eax,%eax
80105bcb:	78 6f                	js     80105c3c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105bcd:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105bd3:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
80105bd6:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105bd8:	68 80 00 00 00       	push   $0x80
80105bdd:	6a 00                	push   $0x0
80105bdf:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105be5:	50                   	push   %eax
80105be6:	e8 25 f1 ff ff       	call   80104d10 <memset>
80105beb:	83 c4 10             	add    $0x10,%esp
80105bee:	eb 2c                	jmp    80105c1c <sys_exec+0x8c>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
80105bf0:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105bf6:	85 c0                	test   %eax,%eax
80105bf8:	74 56                	je     80105c50 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105bfa:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80105c00:	83 ec 08             	sub    $0x8,%esp
80105c03:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80105c06:	52                   	push   %edx
80105c07:	50                   	push   %eax
80105c08:	e8 83 f3 ff ff       	call   80104f90 <fetchstr>
80105c0d:	83 c4 10             	add    $0x10,%esp
80105c10:	85 c0                	test   %eax,%eax
80105c12:	78 28                	js     80105c3c <sys_exec+0xac>
  for(i=0;; i++){
80105c14:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105c17:	83 fb 20             	cmp    $0x20,%ebx
80105c1a:	74 20                	je     80105c3c <sys_exec+0xac>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105c1c:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105c22:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80105c29:	83 ec 08             	sub    $0x8,%esp
80105c2c:	57                   	push   %edi
80105c2d:	01 f0                	add    %esi,%eax
80105c2f:	50                   	push   %eax
80105c30:	e8 2b f3 ff ff       	call   80104f60 <fetchint>
80105c35:	83 c4 10             	add    $0x10,%esp
80105c38:	85 c0                	test   %eax,%eax
80105c3a:	79 b4                	jns    80105bf0 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
80105c3c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80105c3f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105c44:	5b                   	pop    %ebx
80105c45:	5e                   	pop    %esi
80105c46:	5f                   	pop    %edi
80105c47:	5d                   	pop    %ebp
80105c48:	c3                   	ret    
80105c49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80105c50:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105c56:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
80105c59:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105c60:	00 00 00 00 
  return exec(path, argv);
80105c64:	50                   	push   %eax
80105c65:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
80105c6b:	e8 c0 ad ff ff       	call   80100a30 <exec>
80105c70:	83 c4 10             	add    $0x10,%esp
}
80105c73:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c76:	5b                   	pop    %ebx
80105c77:	5e                   	pop    %esi
80105c78:	5f                   	pop    %edi
80105c79:	5d                   	pop    %ebp
80105c7a:	c3                   	ret    
80105c7b:	90                   	nop
80105c7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105c80 <sys_pipe>:

int
sys_pipe(void)
{
80105c80:	55                   	push   %ebp
80105c81:	89 e5                	mov    %esp,%ebp
80105c83:	57                   	push   %edi
80105c84:	56                   	push   %esi
80105c85:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105c86:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105c89:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105c8c:	6a 08                	push   $0x8
80105c8e:	50                   	push   %eax
80105c8f:	6a 00                	push   $0x0
80105c91:	e8 aa f3 ff ff       	call   80105040 <argptr>
80105c96:	83 c4 10             	add    $0x10,%esp
80105c99:	85 c0                	test   %eax,%eax
80105c9b:	0f 88 a4 00 00 00    	js     80105d45 <sys_pipe+0xc5>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105ca1:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105ca4:	83 ec 08             	sub    $0x8,%esp
80105ca7:	50                   	push   %eax
80105ca8:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105cab:	50                   	push   %eax
80105cac:	e8 7f d7 ff ff       	call   80103430 <pipealloc>
80105cb1:	83 c4 10             	add    $0x10,%esp
80105cb4:	85 c0                	test   %eax,%eax
80105cb6:	0f 88 89 00 00 00    	js     80105d45 <sys_pipe+0xc5>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105cbc:	8b 5d e0             	mov    -0x20(%ebp),%ebx
    if(proc->ofile[fd] == 0){
80105cbf:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
  for(fd = 0; fd < NOFILE; fd++){
80105cc6:	31 c0                	xor    %eax,%eax
80105cc8:	eb 0e                	jmp    80105cd8 <sys_pipe+0x58>
80105cca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105cd0:	83 c0 01             	add    $0x1,%eax
80105cd3:	83 f8 10             	cmp    $0x10,%eax
80105cd6:	74 58                	je     80105d30 <sys_pipe+0xb0>
    if(proc->ofile[fd] == 0){
80105cd8:	8b 54 81 18          	mov    0x18(%ecx,%eax,4),%edx
80105cdc:	85 d2                	test   %edx,%edx
80105cde:	75 f0                	jne    80105cd0 <sys_pipe+0x50>
80105ce0:	8d 34 81             	lea    (%ecx,%eax,4),%esi
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105ce3:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80105ce6:	31 d2                	xor    %edx,%edx
      proc->ofile[fd] = f;
80105ce8:	89 5e 18             	mov    %ebx,0x18(%esi)
80105ceb:	eb 0b                	jmp    80105cf8 <sys_pipe+0x78>
80105ced:	8d 76 00             	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105cf0:	83 c2 01             	add    $0x1,%edx
80105cf3:	83 fa 10             	cmp    $0x10,%edx
80105cf6:	74 28                	je     80105d20 <sys_pipe+0xa0>
    if(proc->ofile[fd] == 0){
80105cf8:	83 7c 91 18 00       	cmpl   $0x0,0x18(%ecx,%edx,4)
80105cfd:	75 f1                	jne    80105cf0 <sys_pipe+0x70>
      proc->ofile[fd] = f;
80105cff:	89 7c 91 18          	mov    %edi,0x18(%ecx,%edx,4)
      proc->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80105d03:	8b 4d dc             	mov    -0x24(%ebp),%ecx
80105d06:	89 01                	mov    %eax,(%ecx)
  fd[1] = fd1;
80105d08:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105d0b:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105d0e:	31 c0                	xor    %eax,%eax
}
80105d10:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d13:	5b                   	pop    %ebx
80105d14:	5e                   	pop    %esi
80105d15:	5f                   	pop    %edi
80105d16:	5d                   	pop    %ebp
80105d17:	c3                   	ret    
80105d18:	90                   	nop
80105d19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      proc->ofile[fd0] = 0;
80105d20:	c7 46 18 00 00 00 00 	movl   $0x0,0x18(%esi)
80105d27:	89 f6                	mov    %esi,%esi
80105d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    fileclose(rf);
80105d30:	83 ec 0c             	sub    $0xc,%esp
80105d33:	53                   	push   %ebx
80105d34:	e8 47 b1 ff ff       	call   80100e80 <fileclose>
    fileclose(wf);
80105d39:	58                   	pop    %eax
80105d3a:	ff 75 e4             	pushl  -0x1c(%ebp)
80105d3d:	e8 3e b1 ff ff       	call   80100e80 <fileclose>
    return -1;
80105d42:	83 c4 10             	add    $0x10,%esp
80105d45:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d4a:	eb c4                	jmp    80105d10 <sys_pipe+0x90>
80105d4c:	66 90                	xchg   %ax,%ax
80105d4e:	66 90                	xchg   %ax,%ax

80105d50 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80105d50:	55                   	push   %ebp
80105d51:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105d53:	5d                   	pop    %ebp
  return fork();
80105d54:	e9 97 de ff ff       	jmp    80103bf0 <fork>
80105d59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105d60 <sys_exit>:

int
sys_exit(void)
{
80105d60:	55                   	push   %ebp
80105d61:	89 e5                	mov    %esp,%ebp
80105d63:	83 ec 08             	sub    $0x8,%esp
  exit();
80105d66:	e8 d5 e1 ff ff       	call   80103f40 <exit>
  return 0;  // not reached
}
80105d6b:	31 c0                	xor    %eax,%eax
80105d6d:	c9                   	leave  
80105d6e:	c3                   	ret    
80105d6f:	90                   	nop

80105d70 <sys_wait>:

int
sys_wait(void)
{
80105d70:	55                   	push   %ebp
80105d71:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105d73:	5d                   	pop    %ebp
  return wait();
80105d74:	e9 77 e4 ff ff       	jmp    801041f0 <wait>
80105d79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105d80 <sys_kill>:

int
sys_kill(void)
{
80105d80:	55                   	push   %ebp
80105d81:	89 e5                	mov    %esp,%ebp
80105d83:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105d86:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105d89:	50                   	push   %eax
80105d8a:	6a 00                	push   $0x0
80105d8c:	e8 5f f2 ff ff       	call   80104ff0 <argint>
80105d91:	83 c4 10             	add    $0x10,%esp
80105d94:	85 c0                	test   %eax,%eax
80105d96:	78 18                	js     80105db0 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105d98:	83 ec 0c             	sub    $0xc,%esp
80105d9b:	ff 75 f4             	pushl  -0xc(%ebp)
80105d9e:	e8 fd e5 ff ff       	call   801043a0 <kill>
80105da3:	83 c4 10             	add    $0x10,%esp
}
80105da6:	c9                   	leave  
80105da7:	c3                   	ret    
80105da8:	90                   	nop
80105da9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105db0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105db5:	c9                   	leave  
80105db6:	c3                   	ret    
80105db7:	89 f6                	mov    %esi,%esi
80105db9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105dc0 <sys_getpid>:

int
sys_getpid(void)
{
  return proc->pid;
80105dc0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
{
80105dc6:	55                   	push   %ebp
80105dc7:	89 e5                	mov    %esp,%ebp
  return proc->pid;
80105dc9:	8b 40 0c             	mov    0xc(%eax),%eax
}
80105dcc:	5d                   	pop    %ebp
80105dcd:	c3                   	ret    
80105dce:	66 90                	xchg   %ax,%ax

80105dd0 <sys_sbrk>:

int
sys_sbrk(void)
{
80105dd0:	55                   	push   %ebp
80105dd1:	89 e5                	mov    %esp,%ebp
80105dd3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105dd4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105dd7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105dda:	50                   	push   %eax
80105ddb:	6a 00                	push   $0x0
80105ddd:	e8 0e f2 ff ff       	call   80104ff0 <argint>
80105de2:	83 c4 10             	add    $0x10,%esp
80105de5:	85 c0                	test   %eax,%eax
80105de7:	78 27                	js     80105e10 <sys_sbrk+0x40>
    return -1;
  addr = proc->sz;
80105de9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  if(growproc(n) < 0)
80105def:	83 ec 0c             	sub    $0xc,%esp
  addr = proc->sz;
80105df2:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105df4:	ff 75 f4             	pushl  -0xc(%ebp)
80105df7:	e8 54 dd ff ff       	call   80103b50 <growproc>
80105dfc:	83 c4 10             	add    $0x10,%esp
80105dff:	85 c0                	test   %eax,%eax
80105e01:	78 0d                	js     80105e10 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105e03:	89 d8                	mov    %ebx,%eax
80105e05:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105e08:	c9                   	leave  
80105e09:	c3                   	ret    
80105e0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80105e10:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105e15:	eb ec                	jmp    80105e03 <sys_sbrk+0x33>
80105e17:	89 f6                	mov    %esi,%esi
80105e19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105e20 <sys_sleep>:

int
sys_sleep(void)
{
80105e20:	55                   	push   %ebp
80105e21:	89 e5                	mov    %esp,%ebp
80105e23:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105e24:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105e27:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105e2a:	50                   	push   %eax
80105e2b:	6a 00                	push   $0x0
80105e2d:	e8 be f1 ff ff       	call   80104ff0 <argint>
80105e32:	83 c4 10             	add    $0x10,%esp
80105e35:	85 c0                	test   %eax,%eax
80105e37:	0f 88 8a 00 00 00    	js     80105ec7 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
80105e3d:	83 ec 0c             	sub    $0xc,%esp
80105e40:	68 80 c6 11 80       	push   $0x8011c680
80105e45:	e8 b6 ec ff ff       	call   80104b00 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105e4a:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105e4d:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80105e50:	8b 1d c0 ce 11 80    	mov    0x8011cec0,%ebx
  while(ticks - ticks0 < n){
80105e56:	85 d2                	test   %edx,%edx
80105e58:	75 27                	jne    80105e81 <sys_sleep+0x61>
80105e5a:	eb 54                	jmp    80105eb0 <sys_sleep+0x90>
80105e5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(proc->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105e60:	83 ec 08             	sub    $0x8,%esp
80105e63:	68 80 c6 11 80       	push   $0x8011c680
80105e68:	68 c0 ce 11 80       	push   $0x8011cec0
80105e6d:	e8 ae e2 ff ff       	call   80104120 <sleep>
  while(ticks - ticks0 < n){
80105e72:	a1 c0 ce 11 80       	mov    0x8011cec0,%eax
80105e77:	83 c4 10             	add    $0x10,%esp
80105e7a:	29 d8                	sub    %ebx,%eax
80105e7c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105e7f:	73 2f                	jae    80105eb0 <sys_sleep+0x90>
    if(proc->killed){
80105e81:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105e87:	8b 40 14             	mov    0x14(%eax),%eax
80105e8a:	85 c0                	test   %eax,%eax
80105e8c:	74 d2                	je     80105e60 <sys_sleep+0x40>
      release(&tickslock);
80105e8e:	83 ec 0c             	sub    $0xc,%esp
80105e91:	68 80 c6 11 80       	push   $0x8011c680
80105e96:	e8 25 ee ff ff       	call   80104cc0 <release>
      return -1;
80105e9b:	83 c4 10             	add    $0x10,%esp
80105e9e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
80105ea3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105ea6:	c9                   	leave  
80105ea7:	c3                   	ret    
80105ea8:	90                   	nop
80105ea9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&tickslock);
80105eb0:	83 ec 0c             	sub    $0xc,%esp
80105eb3:	68 80 c6 11 80       	push   $0x8011c680
80105eb8:	e8 03 ee ff ff       	call   80104cc0 <release>
  return 0;
80105ebd:	83 c4 10             	add    $0x10,%esp
80105ec0:	31 c0                	xor    %eax,%eax
}
80105ec2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105ec5:	c9                   	leave  
80105ec6:	c3                   	ret    
    return -1;
80105ec7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ecc:	eb f4                	jmp    80105ec2 <sys_sleep+0xa2>
80105ece:	66 90                	xchg   %ax,%ax

80105ed0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105ed0:	55                   	push   %ebp
80105ed1:	89 e5                	mov    %esp,%ebp
80105ed3:	53                   	push   %ebx
80105ed4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105ed7:	68 80 c6 11 80       	push   $0x8011c680
80105edc:	e8 1f ec ff ff       	call   80104b00 <acquire>
  xticks = ticks;
80105ee1:	8b 1d c0 ce 11 80    	mov    0x8011cec0,%ebx
  release(&tickslock);
80105ee7:	c7 04 24 80 c6 11 80 	movl   $0x8011c680,(%esp)
80105eee:	e8 cd ed ff ff       	call   80104cc0 <release>
  return xticks;
}
80105ef3:	89 d8                	mov    %ebx,%eax
80105ef5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105ef8:	c9                   	leave  
80105ef9:	c3                   	ret    
80105efa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105f00 <sys_procdump>:

int
sys_procdump(void)
{
80105f00:	55                   	push   %ebp
80105f01:	89 e5                	mov    %esp,%ebp
80105f03:	83 ec 08             	sub    $0x8,%esp
  procdump();
80105f06:	e8 a5 e5 ff ff       	call   801044b0 <procdump>
  return 0;
}
80105f0b:	31 c0                	xor    %eax,%eax
80105f0d:	c9                   	leave  
80105f0e:	c3                   	ret    
80105f0f:	90                   	nop

80105f10 <sys_kthread_create>:

//MARCHANT added
//adjust to pointer
int
sys_kthread_create(void)
{
80105f10:	55                   	push   %ebp
80105f11:	89 e5                	mov    %esp,%ebp
80105f13:	83 ec 1c             	sub    $0x1c,%esp
  void* (*start_func)();
  void* stack;
  int stack_size;

  argptr(0, (char**) &start_func, 0);
80105f16:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105f19:	6a 00                	push   $0x0
80105f1b:	50                   	push   %eax
80105f1c:	6a 00                	push   $0x0
80105f1e:	e8 1d f1 ff ff       	call   80105040 <argptr>
  argptr(1, (char**) &stack, 0);
80105f23:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105f26:	83 c4 0c             	add    $0xc,%esp
80105f29:	6a 00                	push   $0x0
80105f2b:	50                   	push   %eax
80105f2c:	6a 01                	push   $0x1
80105f2e:	e8 0d f1 ff ff       	call   80105040 <argptr>
  argint(2, &stack_size);
80105f33:	58                   	pop    %eax
80105f34:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105f37:	5a                   	pop    %edx
80105f38:	50                   	push   %eax
80105f39:	6a 02                	push   $0x2
80105f3b:	e8 b0 f0 ff ff       	call   80104ff0 <argint>

  return kthread_create(start_func, stack, stack_size);
80105f40:	83 c4 0c             	add    $0xc,%esp
80105f43:	ff 75 f4             	pushl  -0xc(%ebp)
80105f46:	ff 75 f0             	pushl  -0x10(%ebp)
80105f49:	ff 75 ec             	pushl  -0x14(%ebp)
80105f4c:	e8 3f e6 ff ff       	call   80104590 <kthread_create>
}
80105f51:	c9                   	leave  
80105f52:	c3                   	ret    
80105f53:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105f60 <sys_kthread_id>:

//MARCHANT added
int
sys_kthread_id(void)
{
80105f60:	55                   	push   %ebp
80105f61:	89 e5                	mov    %esp,%ebp
  return kthread_id();
}
80105f63:	5d                   	pop    %ebp
  return kthread_id();
80105f64:	e9 97 e6 ff ff       	jmp    80104600 <kthread_id>
80105f69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105f70 <sys_kthread_exit>:

//MARCHANT added
int
sys_kthread_exit(void)
{
80105f70:	55                   	push   %ebp
80105f71:	89 e5                	mov    %esp,%ebp
80105f73:	83 ec 08             	sub    $0x8,%esp
  kthread_exit();
80105f76:	e8 b5 e6 ff ff       	call   80104630 <kthread_exit>
  return 0;
}
80105f7b:	31 c0                	xor    %eax,%eax
80105f7d:	c9                   	leave  
80105f7e:	c3                   	ret    
80105f7f:	90                   	nop

80105f80 <sys_kthread_join>:

//MARCHANT added
int
sys_kthread_join(void)
{
80105f80:	55                   	push   %ebp
80105f81:	89 e5                	mov    %esp,%ebp
80105f83:	83 ec 20             	sub    $0x20,%esp
  int thread_id;
  argint(0, &thread_id);
80105f86:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105f89:	50                   	push   %eax
80105f8a:	6a 00                	push   $0x0
80105f8c:	e8 5f f0 ff ff       	call   80104ff0 <argint>
  return kthread_join(thread_id);
80105f91:	58                   	pop    %eax
80105f92:	ff 75 f4             	pushl  -0xc(%ebp)
80105f95:	e8 76 e7 ff ff       	call   80104710 <kthread_join>
}
80105f9a:	c9                   	leave  
80105f9b:	c3                   	ret    
80105f9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105fa0 <sys_kthread_mutex_alloc>:


//HN 
int
sys_kthread_mutex_alloc(void){
80105fa0:	55                   	push   %ebp
80105fa1:	89 e5                	mov    %esp,%ebp
  return kthread_mutex_alloc();
}
80105fa3:	5d                   	pop    %ebp
  return kthread_mutex_alloc();
80105fa4:	e9 67 e8 ff ff       	jmp    80104810 <kthread_mutex_alloc>
80105fa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105fb0 <sys_kthread_mutex_dealloc>:

int 
sys_kthread_mutex_dealloc(void){
80105fb0:	55                   	push   %ebp
80105fb1:	89 e5                	mov    %esp,%ebp
80105fb3:	83 ec 20             	sub    $0x20,%esp
  int mutex_id;
  argint(0, &mutex_id);
80105fb6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105fb9:	50                   	push   %eax
80105fba:	6a 00                	push   $0x0
80105fbc:	e8 2f f0 ff ff       	call   80104ff0 <argint>
  return kthread_mutex_dealloc(mutex_id);
80105fc1:	58                   	pop    %eax
80105fc2:	ff 75 f4             	pushl  -0xc(%ebp)
80105fc5:	e8 d6 e8 ff ff       	call   801048a0 <kthread_mutex_dealloc>
}
80105fca:	c9                   	leave  
80105fcb:	c3                   	ret    
80105fcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105fd0 <sys_kthread_mutex_lock>:


int
sys_kthread_mutex_lock(void){
80105fd0:	55                   	push   %ebp
80105fd1:	89 e5                	mov    %esp,%ebp
80105fd3:	83 ec 20             	sub    $0x20,%esp
  int mutex_id;
  argint(0, &mutex_id);
80105fd6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105fd9:	50                   	push   %eax
80105fda:	6a 00                	push   $0x0
80105fdc:	e8 0f f0 ff ff       	call   80104ff0 <argint>
  return kthread_mutex_lock(mutex_id);
80105fe1:	58                   	pop    %eax
80105fe2:	ff 75 f4             	pushl  -0xc(%ebp)
80105fe5:	e8 46 e9 ff ff       	call   80104930 <kthread_mutex_lock>
}
80105fea:	c9                   	leave  
80105feb:	c3                   	ret    
80105fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105ff0 <sys_kthread_mutex_unlock>:


int 
sys_kthread_mutex_unlock(void){
80105ff0:	55                   	push   %ebp
80105ff1:	89 e5                	mov    %esp,%ebp
80105ff3:	83 ec 20             	sub    $0x20,%esp
  int mutex_id;
  argint(0, &mutex_id);
80105ff6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105ff9:	50                   	push   %eax
80105ffa:	6a 00                	push   $0x0
80105ffc:	e8 ef ef ff ff       	call   80104ff0 <argint>
  return kthread_mutex_unlock(mutex_id);
80106001:	58                   	pop    %eax
80106002:	ff 75 f4             	pushl  -0xc(%ebp)
80106005:	e8 e6 e9 ff ff       	call   801049f0 <kthread_mutex_unlock>
}
8010600a:	c9                   	leave  
8010600b:	c3                   	ret    
8010600c:	66 90                	xchg   %ax,%ax
8010600e:	66 90                	xchg   %ax,%ax

80106010 <timerinit>:
80106010:	55                   	push   %ebp
80106011:	b8 34 00 00 00       	mov    $0x34,%eax
80106016:	ba 43 00 00 00       	mov    $0x43,%edx
8010601b:	89 e5                	mov    %esp,%ebp
8010601d:	83 ec 14             	sub    $0x14,%esp
80106020:	ee                   	out    %al,(%dx)
80106021:	ba 40 00 00 00       	mov    $0x40,%edx
80106026:	b8 9c ff ff ff       	mov    $0xffffff9c,%eax
8010602b:	ee                   	out    %al,(%dx)
8010602c:	b8 2e 00 00 00       	mov    $0x2e,%eax
80106031:	ee                   	out    %al,(%dx)
80106032:	6a 00                	push   $0x0
80106034:	e8 27 d3 ff ff       	call   80103360 <picenable>
80106039:	83 c4 10             	add    $0x10,%esp
8010603c:	c9                   	leave  
8010603d:	c3                   	ret    

8010603e <alltraps>:
8010603e:	1e                   	push   %ds
8010603f:	06                   	push   %es
80106040:	0f a0                	push   %fs
80106042:	0f a8                	push   %gs
80106044:	60                   	pusha  
80106045:	66 b8 10 00          	mov    $0x10,%ax
80106049:	8e d8                	mov    %eax,%ds
8010604b:	8e c0                	mov    %eax,%es
8010604d:	66 b8 18 00          	mov    $0x18,%ax
80106051:	8e e0                	mov    %eax,%fs
80106053:	8e e8                	mov    %eax,%gs
80106055:	54                   	push   %esp
80106056:	e8 c5 00 00 00       	call   80106120 <trap>
8010605b:	83 c4 04             	add    $0x4,%esp

8010605e <trapret>:
8010605e:	61                   	popa   
8010605f:	0f a9                	pop    %gs
80106061:	0f a1                	pop    %fs
80106063:	07                   	pop    %es
80106064:	1f                   	pop    %ds
80106065:	83 c4 08             	add    $0x8,%esp
80106068:	cf                   	iret   
80106069:	66 90                	xchg   %ax,%ax
8010606b:	66 90                	xchg   %ax,%ax
8010606d:	66 90                	xchg   %ax,%ax
8010606f:	90                   	nop

80106070 <tvinit>:
80106070:	55                   	push   %ebp
80106071:	31 c0                	xor    %eax,%eax
80106073:	89 e5                	mov    %esp,%ebp
80106075:	83 ec 08             	sub    $0x8,%esp
80106078:	90                   	nop
80106079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106080:	8b 14 85 14 b0 10 80 	mov    -0x7fef4fec(,%eax,4),%edx
80106087:	c7 04 c5 c2 c6 11 80 	movl   $0x8e000008,-0x7fee393e(,%eax,8)
8010608e:	08 00 00 8e 
80106092:	66 89 14 c5 c0 c6 11 	mov    %dx,-0x7fee3940(,%eax,8)
80106099:	80 
8010609a:	c1 ea 10             	shr    $0x10,%edx
8010609d:	66 89 14 c5 c6 c6 11 	mov    %dx,-0x7fee393a(,%eax,8)
801060a4:	80 
801060a5:	83 c0 01             	add    $0x1,%eax
801060a8:	3d 00 01 00 00       	cmp    $0x100,%eax
801060ad:	75 d1                	jne    80106080 <tvinit+0x10>
801060af:	a1 14 b1 10 80       	mov    0x8010b114,%eax
801060b4:	83 ec 08             	sub    $0x8,%esp
801060b7:	c7 05 c2 c8 11 80 08 	movl   $0xef000008,0x8011c8c2
801060be:	00 00 ef 
801060c1:	68 7d 82 10 80       	push   $0x8010827d
801060c6:	68 80 c6 11 80       	push   $0x8011c680
801060cb:	66 a3 c0 c8 11 80    	mov    %ax,0x8011c8c0
801060d1:	c1 e8 10             	shr    $0x10,%eax
801060d4:	66 a3 c6 c8 11 80    	mov    %ax,0x8011c8c6
801060da:	e8 01 ea ff ff       	call   80104ae0 <initlock>
801060df:	83 c4 10             	add    $0x10,%esp
801060e2:	c9                   	leave  
801060e3:	c3                   	ret    
801060e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801060ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801060f0 <idtinit>:
801060f0:	55                   	push   %ebp
801060f1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
801060f6:	89 e5                	mov    %esp,%ebp
801060f8:	83 ec 10             	sub    $0x10,%esp
801060fb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
801060ff:	b8 c0 c6 11 80       	mov    $0x8011c6c0,%eax
80106104:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80106108:	c1 e8 10             	shr    $0x10,%eax
8010610b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
8010610f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106112:	0f 01 18             	lidtl  (%eax)
80106115:	c9                   	leave  
80106116:	c3                   	ret    
80106117:	89 f6                	mov    %esi,%esi
80106119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106120 <trap>:
80106120:	55                   	push   %ebp
80106121:	89 e5                	mov    %esp,%ebp
80106123:	57                   	push   %edi
80106124:	56                   	push   %esi
80106125:	53                   	push   %ebx
80106126:	83 ec 0c             	sub    $0xc,%esp
80106129:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010612c:	8b 43 30             	mov    0x30(%ebx),%eax
8010612f:	83 f8 40             	cmp    $0x40,%eax
80106132:	0f 84 28 01 00 00    	je     80106260 <trap+0x140>
80106138:	83 e8 20             	sub    $0x20,%eax
8010613b:	83 f8 1f             	cmp    $0x1f,%eax
8010613e:	77 10                	ja     80106150 <trap+0x30>
80106140:	ff 24 85 24 83 10 80 	jmp    *-0x7fef7cdc(,%eax,4)
80106147:	89 f6                	mov    %esi,%esi
80106149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106150:	65 8b 3d 08 00 00 00 	mov    %gs:0x8,%edi
80106157:	8b 73 38             	mov    0x38(%ebx),%esi
8010615a:	85 ff                	test   %edi,%edi
8010615c:	0f 84 8a 02 00 00    	je     801063ec <trap+0x2cc>
80106162:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80106166:	0f 84 80 02 00 00    	je     801063ec <trap+0x2cc>
8010616c:	0f 20 d7             	mov    %cr2,%edi
8010616f:	e8 1c c6 ff ff       	call   80102790 <cpunum>
80106174:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
8010617b:	57                   	push   %edi
8010617c:	56                   	push   %esi
8010617d:	50                   	push   %eax
8010617e:	ff 73 34             	pushl  0x34(%ebx)
80106181:	ff 73 30             	pushl  0x30(%ebx)
80106184:	8d 42 5c             	lea    0x5c(%edx),%eax
80106187:	50                   	push   %eax
80106188:	ff 72 0c             	pushl  0xc(%edx)
8010618b:	68 e0 82 10 80       	push   $0x801082e0
80106190:	e8 ab a4 ff ff       	call   80100640 <cprintf>
80106195:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010619b:	83 c4 20             	add    $0x20,%esp
8010619e:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
801061a5:	8d 76 00             	lea    0x0(%esi),%esi
801061a8:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
801061ae:	85 c0                	test   %eax,%eax
801061b0:	0f 84 92 00 00 00    	je     80106248 <trap+0x128>
801061b6:	8b 70 1c             	mov    0x1c(%eax),%esi
801061b9:	85 f6                	test   %esi,%esi
801061bb:	74 0d                	je     801061ca <trap+0xaa>
801061bd:	0f b7 53 3c          	movzwl 0x3c(%ebx),%edx
801061c1:	83 e2 03             	and    $0x3,%edx
801061c4:	66 83 fa 03          	cmp    $0x3,%dx
801061c8:	74 76                	je     80106240 <trap+0x120>
801061ca:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801061d1:	85 d2                	test   %edx,%edx
801061d3:	74 22                	je     801061f7 <trap+0xd7>
801061d5:	8b 4a 14             	mov    0x14(%edx),%ecx
801061d8:	85 c9                	test   %ecx,%ecx
801061da:	74 11                	je     801061ed <trap+0xcd>
801061dc:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
801061e0:	83 e0 03             	and    $0x3,%eax
801061e3:	66 83 f8 03          	cmp    $0x3,%ax
801061e7:	0f 84 bb 01 00 00    	je     801063a8 <trap+0x288>
801061ed:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
801061f3:	85 c0                	test   %eax,%eax
801061f5:	74 22                	je     80106219 <trap+0xf9>
801061f7:	83 78 04 04          	cmpl   $0x4,0x4(%eax)
801061fb:	0f 84 3f 01 00 00    	je     80106340 <trap+0x220>
80106201:	8b 50 1c             	mov    0x1c(%eax),%edx
80106204:	85 d2                	test   %edx,%edx
80106206:	74 11                	je     80106219 <trap+0xf9>
80106208:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
8010620c:	83 e0 03             	and    $0x3,%eax
8010620f:	66 83 f8 03          	cmp    $0x3,%ax
80106213:	0f 84 7f 01 00 00    	je     80106398 <trap+0x278>
80106219:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010621f:	85 c0                	test   %eax,%eax
80106221:	74 14                	je     80106237 <trap+0x117>
80106223:	8b 40 14             	mov    0x14(%eax),%eax
80106226:	85 c0                	test   %eax,%eax
80106228:	74 0d                	je     80106237 <trap+0x117>
8010622a:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
8010622e:	83 e0 03             	and    $0x3,%eax
80106231:	66 83 f8 03          	cmp    $0x3,%ax
80106235:	74 77                	je     801062ae <trap+0x18e>
80106237:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010623a:	5b                   	pop    %ebx
8010623b:	5e                   	pop    %esi
8010623c:	5f                   	pop    %edi
8010623d:	5d                   	pop    %ebp
8010623e:	c3                   	ret    
8010623f:	90                   	nop
80106240:	e8 eb e1 ff ff       	call   80104430 <killSelf>
80106245:	8d 76 00             	lea    0x0(%esi),%esi
80106248:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
8010624f:	85 d2                	test   %edx,%edx
80106251:	0f 85 7e ff ff ff    	jne    801061d5 <trap+0xb5>
80106257:	eb 94                	jmp    801061ed <trap+0xcd>
80106259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106260:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
80106266:	8b 40 1c             	mov    0x1c(%eax),%eax
80106269:	85 c0                	test   %eax,%eax
8010626b:	0f 85 17 01 00 00    	jne    80106388 <trap+0x268>
80106271:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106277:	8b 40 14             	mov    0x14(%eax),%eax
8010627a:	85 c0                	test   %eax,%eax
8010627c:	0f 85 f6 00 00 00    	jne    80106378 <trap+0x258>
80106282:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
80106288:	89 58 10             	mov    %ebx,0x10(%eax)
8010628b:	e8 80 ee ff ff       	call   80105110 <syscall>
80106290:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
80106296:	8b 40 1c             	mov    0x1c(%eax),%eax
80106299:	85 c0                	test   %eax,%eax
8010629b:	0f 85 c7 00 00 00    	jne    80106368 <trap+0x248>
801062a1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801062a7:	8b 40 14             	mov    0x14(%eax),%eax
801062aa:	85 c0                	test   %eax,%eax
801062ac:	74 89                	je     80106237 <trap+0x117>
801062ae:	8d 65 f4             	lea    -0xc(%ebp),%esp
801062b1:	5b                   	pop    %ebx
801062b2:	5e                   	pop    %esi
801062b3:	5f                   	pop    %edi
801062b4:	5d                   	pop    %ebp
801062b5:	e9 86 dc ff ff       	jmp    80103f40 <exit>
801062ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801062c0:	e8 ab c3 ff ff       	call   80102670 <kbdintr>
801062c5:	e8 76 c5 ff ff       	call   80102840 <lapiceoi>
801062ca:	e9 d9 fe ff ff       	jmp    801061a8 <trap+0x88>
801062cf:	90                   	nop
801062d0:	e8 bb 02 00 00       	call   80106590 <uartintr>
801062d5:	e8 66 c5 ff ff       	call   80102840 <lapiceoi>
801062da:	e9 c9 fe ff ff       	jmp    801061a8 <trap+0x88>
801062df:	90                   	nop
801062e0:	e8 ab c4 ff ff       	call   80102790 <cpunum>
801062e5:	85 c0                	test   %eax,%eax
801062e7:	0f 84 cb 00 00 00    	je     801063b8 <trap+0x298>
801062ed:	e8 4e c5 ff ff       	call   80102840 <lapiceoi>
801062f2:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
801062f8:	85 c0                	test   %eax,%eax
801062fa:	0f 85 b6 fe ff ff    	jne    801061b6 <trap+0x96>
80106300:	e9 43 ff ff ff       	jmp    80106248 <trap+0x128>
80106305:	8d 76 00             	lea    0x0(%esi),%esi
80106308:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
8010630c:	8b 7b 38             	mov    0x38(%ebx),%edi
8010630f:	e8 7c c4 ff ff       	call   80102790 <cpunum>
80106314:	57                   	push   %edi
80106315:	56                   	push   %esi
80106316:	50                   	push   %eax
80106317:	68 88 82 10 80       	push   $0x80108288
8010631c:	e8 1f a3 ff ff       	call   80100640 <cprintf>
80106321:	e8 1a c5 ff ff       	call   80102840 <lapiceoi>
80106326:	83 c4 10             	add    $0x10,%esp
80106329:	e9 7a fe ff ff       	jmp    801061a8 <trap+0x88>
8010632e:	66 90                	xchg   %ax,%ax
80106330:	e8 9b bd ff ff       	call   801020d0 <ideintr>
80106335:	eb b6                	jmp    801062ed <trap+0x1cd>
80106337:	89 f6                	mov    %esi,%esi
80106339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106340:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80106344:	0f 85 b7 fe ff ff    	jne    80106201 <trap+0xe1>
8010634a:	e8 91 dd ff ff       	call   801040e0 <yield>
8010634f:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
80106355:	85 c0                	test   %eax,%eax
80106357:	0f 85 a4 fe ff ff    	jne    80106201 <trap+0xe1>
8010635d:	e9 b7 fe ff ff       	jmp    80106219 <trap+0xf9>
80106362:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106368:	e8 c3 e0 ff ff       	call   80104430 <killSelf>
8010636d:	e9 2f ff ff ff       	jmp    801062a1 <trap+0x181>
80106372:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106378:	e8 c3 db ff ff       	call   80103f40 <exit>
8010637d:	e9 00 ff ff ff       	jmp    80106282 <trap+0x162>
80106382:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106388:	e8 a3 e0 ff ff       	call   80104430 <killSelf>
8010638d:	e9 df fe ff ff       	jmp    80106271 <trap+0x151>
80106392:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106398:	e8 93 e0 ff ff       	call   80104430 <killSelf>
8010639d:	e9 77 fe ff ff       	jmp    80106219 <trap+0xf9>
801063a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801063a8:	e8 93 db ff ff       	call   80103f40 <exit>
801063ad:	e9 3b fe ff ff       	jmp    801061ed <trap+0xcd>
801063b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801063b8:	83 ec 0c             	sub    $0xc,%esp
801063bb:	68 80 c6 11 80       	push   $0x8011c680
801063c0:	e8 3b e7 ff ff       	call   80104b00 <acquire>
801063c5:	c7 04 24 c0 ce 11 80 	movl   $0x8011cec0,(%esp)
801063cc:	83 05 c0 ce 11 80 01 	addl   $0x1,0x8011cec0
801063d3:	e8 58 df ff ff       	call   80104330 <wakeup>
801063d8:	c7 04 24 80 c6 11 80 	movl   $0x8011c680,(%esp)
801063df:	e8 dc e8 ff ff       	call   80104cc0 <release>
801063e4:	83 c4 10             	add    $0x10,%esp
801063e7:	e9 01 ff ff ff       	jmp    801062ed <trap+0x1cd>
801063ec:	0f 20 d7             	mov    %cr2,%edi
801063ef:	e8 9c c3 ff ff       	call   80102790 <cpunum>
801063f4:	83 ec 0c             	sub    $0xc,%esp
801063f7:	57                   	push   %edi
801063f8:	56                   	push   %esi
801063f9:	50                   	push   %eax
801063fa:	ff 73 30             	pushl  0x30(%ebx)
801063fd:	68 ac 82 10 80       	push   $0x801082ac
80106402:	e8 39 a2 ff ff       	call   80100640 <cprintf>
80106407:	83 c4 14             	add    $0x14,%esp
8010640a:	68 82 82 10 80       	push   $0x80108282
8010640f:	e8 5c 9f ff ff       	call   80100370 <panic>
80106414:	66 90                	xchg   %ax,%ax
80106416:	66 90                	xchg   %ax,%ax
80106418:	66 90                	xchg   %ax,%ax
8010641a:	66 90                	xchg   %ax,%ax
8010641c:	66 90                	xchg   %ax,%ax
8010641e:	66 90                	xchg   %ax,%ax

80106420 <uartgetc>:
80106420:	a1 c0 b5 10 80       	mov    0x8010b5c0,%eax
80106425:	55                   	push   %ebp
80106426:	89 e5                	mov    %esp,%ebp
80106428:	85 c0                	test   %eax,%eax
8010642a:	74 1c                	je     80106448 <uartgetc+0x28>
8010642c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106431:	ec                   	in     (%dx),%al
80106432:	a8 01                	test   $0x1,%al
80106434:	74 12                	je     80106448 <uartgetc+0x28>
80106436:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010643b:	ec                   	in     (%dx),%al
8010643c:	0f b6 c0             	movzbl %al,%eax
8010643f:	5d                   	pop    %ebp
80106440:	c3                   	ret    
80106441:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106448:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010644d:	5d                   	pop    %ebp
8010644e:	c3                   	ret    
8010644f:	90                   	nop

80106450 <uartputc.part.0>:
80106450:	55                   	push   %ebp
80106451:	89 e5                	mov    %esp,%ebp
80106453:	57                   	push   %edi
80106454:	56                   	push   %esi
80106455:	53                   	push   %ebx
80106456:	89 c7                	mov    %eax,%edi
80106458:	bb 80 00 00 00       	mov    $0x80,%ebx
8010645d:	be fd 03 00 00       	mov    $0x3fd,%esi
80106462:	83 ec 0c             	sub    $0xc,%esp
80106465:	eb 1b                	jmp    80106482 <uartputc.part.0+0x32>
80106467:	89 f6                	mov    %esi,%esi
80106469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106470:	83 ec 0c             	sub    $0xc,%esp
80106473:	6a 0a                	push   $0xa
80106475:	e8 e6 c3 ff ff       	call   80102860 <microdelay>
8010647a:	83 c4 10             	add    $0x10,%esp
8010647d:	83 eb 01             	sub    $0x1,%ebx
80106480:	74 07                	je     80106489 <uartputc.part.0+0x39>
80106482:	89 f2                	mov    %esi,%edx
80106484:	ec                   	in     (%dx),%al
80106485:	a8 20                	test   $0x20,%al
80106487:	74 e7                	je     80106470 <uartputc.part.0+0x20>
80106489:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010648e:	89 f8                	mov    %edi,%eax
80106490:	ee                   	out    %al,(%dx)
80106491:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106494:	5b                   	pop    %ebx
80106495:	5e                   	pop    %esi
80106496:	5f                   	pop    %edi
80106497:	5d                   	pop    %ebp
80106498:	c3                   	ret    
80106499:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801064a0 <uartinit>:
801064a0:	55                   	push   %ebp
801064a1:	31 c9                	xor    %ecx,%ecx
801064a3:	89 c8                	mov    %ecx,%eax
801064a5:	89 e5                	mov    %esp,%ebp
801064a7:	57                   	push   %edi
801064a8:	56                   	push   %esi
801064a9:	53                   	push   %ebx
801064aa:	bb fa 03 00 00       	mov    $0x3fa,%ebx
801064af:	89 da                	mov    %ebx,%edx
801064b1:	83 ec 0c             	sub    $0xc,%esp
801064b4:	ee                   	out    %al,(%dx)
801064b5:	bf fb 03 00 00       	mov    $0x3fb,%edi
801064ba:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
801064bf:	89 fa                	mov    %edi,%edx
801064c1:	ee                   	out    %al,(%dx)
801064c2:	b8 0c 00 00 00       	mov    $0xc,%eax
801064c7:	ba f8 03 00 00       	mov    $0x3f8,%edx
801064cc:	ee                   	out    %al,(%dx)
801064cd:	be f9 03 00 00       	mov    $0x3f9,%esi
801064d2:	89 c8                	mov    %ecx,%eax
801064d4:	89 f2                	mov    %esi,%edx
801064d6:	ee                   	out    %al,(%dx)
801064d7:	b8 03 00 00 00       	mov    $0x3,%eax
801064dc:	89 fa                	mov    %edi,%edx
801064de:	ee                   	out    %al,(%dx)
801064df:	ba fc 03 00 00       	mov    $0x3fc,%edx
801064e4:	89 c8                	mov    %ecx,%eax
801064e6:	ee                   	out    %al,(%dx)
801064e7:	b8 01 00 00 00       	mov    $0x1,%eax
801064ec:	89 f2                	mov    %esi,%edx
801064ee:	ee                   	out    %al,(%dx)
801064ef:	ba fd 03 00 00       	mov    $0x3fd,%edx
801064f4:	ec                   	in     (%dx),%al
801064f5:	3c ff                	cmp    $0xff,%al
801064f7:	74 5a                	je     80106553 <uartinit+0xb3>
801064f9:	c7 05 c0 b5 10 80 01 	movl   $0x1,0x8010b5c0
80106500:	00 00 00 
80106503:	89 da                	mov    %ebx,%edx
80106505:	ec                   	in     (%dx),%al
80106506:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010650b:	ec                   	in     (%dx),%al
8010650c:	83 ec 0c             	sub    $0xc,%esp
8010650f:	6a 04                	push   $0x4
80106511:	e8 4a ce ff ff       	call   80103360 <picenable>
80106516:	59                   	pop    %ecx
80106517:	5b                   	pop    %ebx
80106518:	6a 00                	push   $0x0
8010651a:	6a 04                	push   $0x4
8010651c:	bb a4 83 10 80       	mov    $0x801083a4,%ebx
80106521:	e8 0a be ff ff       	call   80102330 <ioapicenable>
80106526:	83 c4 10             	add    $0x10,%esp
80106529:	b8 78 00 00 00       	mov    $0x78,%eax
8010652e:	eb 0a                	jmp    8010653a <uartinit+0x9a>
80106530:	83 c3 01             	add    $0x1,%ebx
80106533:	0f be 03             	movsbl (%ebx),%eax
80106536:	84 c0                	test   %al,%al
80106538:	74 19                	je     80106553 <uartinit+0xb3>
8010653a:	8b 15 c0 b5 10 80    	mov    0x8010b5c0,%edx
80106540:	85 d2                	test   %edx,%edx
80106542:	74 ec                	je     80106530 <uartinit+0x90>
80106544:	83 c3 01             	add    $0x1,%ebx
80106547:	e8 04 ff ff ff       	call   80106450 <uartputc.part.0>
8010654c:	0f be 03             	movsbl (%ebx),%eax
8010654f:	84 c0                	test   %al,%al
80106551:	75 e7                	jne    8010653a <uartinit+0x9a>
80106553:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106556:	5b                   	pop    %ebx
80106557:	5e                   	pop    %esi
80106558:	5f                   	pop    %edi
80106559:	5d                   	pop    %ebp
8010655a:	c3                   	ret    
8010655b:	90                   	nop
8010655c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106560 <uartputc>:
80106560:	8b 15 c0 b5 10 80    	mov    0x8010b5c0,%edx
80106566:	55                   	push   %ebp
80106567:	89 e5                	mov    %esp,%ebp
80106569:	85 d2                	test   %edx,%edx
8010656b:	8b 45 08             	mov    0x8(%ebp),%eax
8010656e:	74 10                	je     80106580 <uartputc+0x20>
80106570:	5d                   	pop    %ebp
80106571:	e9 da fe ff ff       	jmp    80106450 <uartputc.part.0>
80106576:	8d 76 00             	lea    0x0(%esi),%esi
80106579:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106580:	5d                   	pop    %ebp
80106581:	c3                   	ret    
80106582:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106590 <uartintr>:
80106590:	55                   	push   %ebp
80106591:	89 e5                	mov    %esp,%ebp
80106593:	83 ec 14             	sub    $0x14,%esp
80106596:	68 20 64 10 80       	push   $0x80106420
8010659b:	e8 50 a2 ff ff       	call   801007f0 <consoleintr>
801065a0:	83 c4 10             	add    $0x10,%esp
801065a3:	c9                   	leave  
801065a4:	c3                   	ret    

801065a5 <vector0>:
801065a5:	6a 00                	push   $0x0
801065a7:	6a 00                	push   $0x0
801065a9:	e9 90 fa ff ff       	jmp    8010603e <alltraps>

801065ae <vector1>:
801065ae:	6a 00                	push   $0x0
801065b0:	6a 01                	push   $0x1
801065b2:	e9 87 fa ff ff       	jmp    8010603e <alltraps>

801065b7 <vector2>:
801065b7:	6a 00                	push   $0x0
801065b9:	6a 02                	push   $0x2
801065bb:	e9 7e fa ff ff       	jmp    8010603e <alltraps>

801065c0 <vector3>:
801065c0:	6a 00                	push   $0x0
801065c2:	6a 03                	push   $0x3
801065c4:	e9 75 fa ff ff       	jmp    8010603e <alltraps>

801065c9 <vector4>:
801065c9:	6a 00                	push   $0x0
801065cb:	6a 04                	push   $0x4
801065cd:	e9 6c fa ff ff       	jmp    8010603e <alltraps>

801065d2 <vector5>:
801065d2:	6a 00                	push   $0x0
801065d4:	6a 05                	push   $0x5
801065d6:	e9 63 fa ff ff       	jmp    8010603e <alltraps>

801065db <vector6>:
801065db:	6a 00                	push   $0x0
801065dd:	6a 06                	push   $0x6
801065df:	e9 5a fa ff ff       	jmp    8010603e <alltraps>

801065e4 <vector7>:
801065e4:	6a 00                	push   $0x0
801065e6:	6a 07                	push   $0x7
801065e8:	e9 51 fa ff ff       	jmp    8010603e <alltraps>

801065ed <vector8>:
801065ed:	6a 08                	push   $0x8
801065ef:	e9 4a fa ff ff       	jmp    8010603e <alltraps>

801065f4 <vector9>:
801065f4:	6a 00                	push   $0x0
801065f6:	6a 09                	push   $0x9
801065f8:	e9 41 fa ff ff       	jmp    8010603e <alltraps>

801065fd <vector10>:
801065fd:	6a 0a                	push   $0xa
801065ff:	e9 3a fa ff ff       	jmp    8010603e <alltraps>

80106604 <vector11>:
80106604:	6a 0b                	push   $0xb
80106606:	e9 33 fa ff ff       	jmp    8010603e <alltraps>

8010660b <vector12>:
8010660b:	6a 0c                	push   $0xc
8010660d:	e9 2c fa ff ff       	jmp    8010603e <alltraps>

80106612 <vector13>:
80106612:	6a 0d                	push   $0xd
80106614:	e9 25 fa ff ff       	jmp    8010603e <alltraps>

80106619 <vector14>:
80106619:	6a 0e                	push   $0xe
8010661b:	e9 1e fa ff ff       	jmp    8010603e <alltraps>

80106620 <vector15>:
80106620:	6a 00                	push   $0x0
80106622:	6a 0f                	push   $0xf
80106624:	e9 15 fa ff ff       	jmp    8010603e <alltraps>

80106629 <vector16>:
80106629:	6a 00                	push   $0x0
8010662b:	6a 10                	push   $0x10
8010662d:	e9 0c fa ff ff       	jmp    8010603e <alltraps>

80106632 <vector17>:
80106632:	6a 11                	push   $0x11
80106634:	e9 05 fa ff ff       	jmp    8010603e <alltraps>

80106639 <vector18>:
80106639:	6a 00                	push   $0x0
8010663b:	6a 12                	push   $0x12
8010663d:	e9 fc f9 ff ff       	jmp    8010603e <alltraps>

80106642 <vector19>:
80106642:	6a 00                	push   $0x0
80106644:	6a 13                	push   $0x13
80106646:	e9 f3 f9 ff ff       	jmp    8010603e <alltraps>

8010664b <vector20>:
8010664b:	6a 00                	push   $0x0
8010664d:	6a 14                	push   $0x14
8010664f:	e9 ea f9 ff ff       	jmp    8010603e <alltraps>

80106654 <vector21>:
80106654:	6a 00                	push   $0x0
80106656:	6a 15                	push   $0x15
80106658:	e9 e1 f9 ff ff       	jmp    8010603e <alltraps>

8010665d <vector22>:
8010665d:	6a 00                	push   $0x0
8010665f:	6a 16                	push   $0x16
80106661:	e9 d8 f9 ff ff       	jmp    8010603e <alltraps>

80106666 <vector23>:
80106666:	6a 00                	push   $0x0
80106668:	6a 17                	push   $0x17
8010666a:	e9 cf f9 ff ff       	jmp    8010603e <alltraps>

8010666f <vector24>:
8010666f:	6a 00                	push   $0x0
80106671:	6a 18                	push   $0x18
80106673:	e9 c6 f9 ff ff       	jmp    8010603e <alltraps>

80106678 <vector25>:
80106678:	6a 00                	push   $0x0
8010667a:	6a 19                	push   $0x19
8010667c:	e9 bd f9 ff ff       	jmp    8010603e <alltraps>

80106681 <vector26>:
80106681:	6a 00                	push   $0x0
80106683:	6a 1a                	push   $0x1a
80106685:	e9 b4 f9 ff ff       	jmp    8010603e <alltraps>

8010668a <vector27>:
8010668a:	6a 00                	push   $0x0
8010668c:	6a 1b                	push   $0x1b
8010668e:	e9 ab f9 ff ff       	jmp    8010603e <alltraps>

80106693 <vector28>:
80106693:	6a 00                	push   $0x0
80106695:	6a 1c                	push   $0x1c
80106697:	e9 a2 f9 ff ff       	jmp    8010603e <alltraps>

8010669c <vector29>:
8010669c:	6a 00                	push   $0x0
8010669e:	6a 1d                	push   $0x1d
801066a0:	e9 99 f9 ff ff       	jmp    8010603e <alltraps>

801066a5 <vector30>:
801066a5:	6a 00                	push   $0x0
801066a7:	6a 1e                	push   $0x1e
801066a9:	e9 90 f9 ff ff       	jmp    8010603e <alltraps>

801066ae <vector31>:
801066ae:	6a 00                	push   $0x0
801066b0:	6a 1f                	push   $0x1f
801066b2:	e9 87 f9 ff ff       	jmp    8010603e <alltraps>

801066b7 <vector32>:
801066b7:	6a 00                	push   $0x0
801066b9:	6a 20                	push   $0x20
801066bb:	e9 7e f9 ff ff       	jmp    8010603e <alltraps>

801066c0 <vector33>:
801066c0:	6a 00                	push   $0x0
801066c2:	6a 21                	push   $0x21
801066c4:	e9 75 f9 ff ff       	jmp    8010603e <alltraps>

801066c9 <vector34>:
801066c9:	6a 00                	push   $0x0
801066cb:	6a 22                	push   $0x22
801066cd:	e9 6c f9 ff ff       	jmp    8010603e <alltraps>

801066d2 <vector35>:
801066d2:	6a 00                	push   $0x0
801066d4:	6a 23                	push   $0x23
801066d6:	e9 63 f9 ff ff       	jmp    8010603e <alltraps>

801066db <vector36>:
801066db:	6a 00                	push   $0x0
801066dd:	6a 24                	push   $0x24
801066df:	e9 5a f9 ff ff       	jmp    8010603e <alltraps>

801066e4 <vector37>:
801066e4:	6a 00                	push   $0x0
801066e6:	6a 25                	push   $0x25
801066e8:	e9 51 f9 ff ff       	jmp    8010603e <alltraps>

801066ed <vector38>:
801066ed:	6a 00                	push   $0x0
801066ef:	6a 26                	push   $0x26
801066f1:	e9 48 f9 ff ff       	jmp    8010603e <alltraps>

801066f6 <vector39>:
801066f6:	6a 00                	push   $0x0
801066f8:	6a 27                	push   $0x27
801066fa:	e9 3f f9 ff ff       	jmp    8010603e <alltraps>

801066ff <vector40>:
801066ff:	6a 00                	push   $0x0
80106701:	6a 28                	push   $0x28
80106703:	e9 36 f9 ff ff       	jmp    8010603e <alltraps>

80106708 <vector41>:
80106708:	6a 00                	push   $0x0
8010670a:	6a 29                	push   $0x29
8010670c:	e9 2d f9 ff ff       	jmp    8010603e <alltraps>

80106711 <vector42>:
80106711:	6a 00                	push   $0x0
80106713:	6a 2a                	push   $0x2a
80106715:	e9 24 f9 ff ff       	jmp    8010603e <alltraps>

8010671a <vector43>:
8010671a:	6a 00                	push   $0x0
8010671c:	6a 2b                	push   $0x2b
8010671e:	e9 1b f9 ff ff       	jmp    8010603e <alltraps>

80106723 <vector44>:
80106723:	6a 00                	push   $0x0
80106725:	6a 2c                	push   $0x2c
80106727:	e9 12 f9 ff ff       	jmp    8010603e <alltraps>

8010672c <vector45>:
8010672c:	6a 00                	push   $0x0
8010672e:	6a 2d                	push   $0x2d
80106730:	e9 09 f9 ff ff       	jmp    8010603e <alltraps>

80106735 <vector46>:
80106735:	6a 00                	push   $0x0
80106737:	6a 2e                	push   $0x2e
80106739:	e9 00 f9 ff ff       	jmp    8010603e <alltraps>

8010673e <vector47>:
8010673e:	6a 00                	push   $0x0
80106740:	6a 2f                	push   $0x2f
80106742:	e9 f7 f8 ff ff       	jmp    8010603e <alltraps>

80106747 <vector48>:
80106747:	6a 00                	push   $0x0
80106749:	6a 30                	push   $0x30
8010674b:	e9 ee f8 ff ff       	jmp    8010603e <alltraps>

80106750 <vector49>:
80106750:	6a 00                	push   $0x0
80106752:	6a 31                	push   $0x31
80106754:	e9 e5 f8 ff ff       	jmp    8010603e <alltraps>

80106759 <vector50>:
80106759:	6a 00                	push   $0x0
8010675b:	6a 32                	push   $0x32
8010675d:	e9 dc f8 ff ff       	jmp    8010603e <alltraps>

80106762 <vector51>:
80106762:	6a 00                	push   $0x0
80106764:	6a 33                	push   $0x33
80106766:	e9 d3 f8 ff ff       	jmp    8010603e <alltraps>

8010676b <vector52>:
8010676b:	6a 00                	push   $0x0
8010676d:	6a 34                	push   $0x34
8010676f:	e9 ca f8 ff ff       	jmp    8010603e <alltraps>

80106774 <vector53>:
80106774:	6a 00                	push   $0x0
80106776:	6a 35                	push   $0x35
80106778:	e9 c1 f8 ff ff       	jmp    8010603e <alltraps>

8010677d <vector54>:
8010677d:	6a 00                	push   $0x0
8010677f:	6a 36                	push   $0x36
80106781:	e9 b8 f8 ff ff       	jmp    8010603e <alltraps>

80106786 <vector55>:
80106786:	6a 00                	push   $0x0
80106788:	6a 37                	push   $0x37
8010678a:	e9 af f8 ff ff       	jmp    8010603e <alltraps>

8010678f <vector56>:
8010678f:	6a 00                	push   $0x0
80106791:	6a 38                	push   $0x38
80106793:	e9 a6 f8 ff ff       	jmp    8010603e <alltraps>

80106798 <vector57>:
80106798:	6a 00                	push   $0x0
8010679a:	6a 39                	push   $0x39
8010679c:	e9 9d f8 ff ff       	jmp    8010603e <alltraps>

801067a1 <vector58>:
801067a1:	6a 00                	push   $0x0
801067a3:	6a 3a                	push   $0x3a
801067a5:	e9 94 f8 ff ff       	jmp    8010603e <alltraps>

801067aa <vector59>:
801067aa:	6a 00                	push   $0x0
801067ac:	6a 3b                	push   $0x3b
801067ae:	e9 8b f8 ff ff       	jmp    8010603e <alltraps>

801067b3 <vector60>:
801067b3:	6a 00                	push   $0x0
801067b5:	6a 3c                	push   $0x3c
801067b7:	e9 82 f8 ff ff       	jmp    8010603e <alltraps>

801067bc <vector61>:
801067bc:	6a 00                	push   $0x0
801067be:	6a 3d                	push   $0x3d
801067c0:	e9 79 f8 ff ff       	jmp    8010603e <alltraps>

801067c5 <vector62>:
801067c5:	6a 00                	push   $0x0
801067c7:	6a 3e                	push   $0x3e
801067c9:	e9 70 f8 ff ff       	jmp    8010603e <alltraps>

801067ce <vector63>:
801067ce:	6a 00                	push   $0x0
801067d0:	6a 3f                	push   $0x3f
801067d2:	e9 67 f8 ff ff       	jmp    8010603e <alltraps>

801067d7 <vector64>:
801067d7:	6a 00                	push   $0x0
801067d9:	6a 40                	push   $0x40
801067db:	e9 5e f8 ff ff       	jmp    8010603e <alltraps>

801067e0 <vector65>:
801067e0:	6a 00                	push   $0x0
801067e2:	6a 41                	push   $0x41
801067e4:	e9 55 f8 ff ff       	jmp    8010603e <alltraps>

801067e9 <vector66>:
801067e9:	6a 00                	push   $0x0
801067eb:	6a 42                	push   $0x42
801067ed:	e9 4c f8 ff ff       	jmp    8010603e <alltraps>

801067f2 <vector67>:
801067f2:	6a 00                	push   $0x0
801067f4:	6a 43                	push   $0x43
801067f6:	e9 43 f8 ff ff       	jmp    8010603e <alltraps>

801067fb <vector68>:
801067fb:	6a 00                	push   $0x0
801067fd:	6a 44                	push   $0x44
801067ff:	e9 3a f8 ff ff       	jmp    8010603e <alltraps>

80106804 <vector69>:
80106804:	6a 00                	push   $0x0
80106806:	6a 45                	push   $0x45
80106808:	e9 31 f8 ff ff       	jmp    8010603e <alltraps>

8010680d <vector70>:
8010680d:	6a 00                	push   $0x0
8010680f:	6a 46                	push   $0x46
80106811:	e9 28 f8 ff ff       	jmp    8010603e <alltraps>

80106816 <vector71>:
80106816:	6a 00                	push   $0x0
80106818:	6a 47                	push   $0x47
8010681a:	e9 1f f8 ff ff       	jmp    8010603e <alltraps>

8010681f <vector72>:
8010681f:	6a 00                	push   $0x0
80106821:	6a 48                	push   $0x48
80106823:	e9 16 f8 ff ff       	jmp    8010603e <alltraps>

80106828 <vector73>:
80106828:	6a 00                	push   $0x0
8010682a:	6a 49                	push   $0x49
8010682c:	e9 0d f8 ff ff       	jmp    8010603e <alltraps>

80106831 <vector74>:
80106831:	6a 00                	push   $0x0
80106833:	6a 4a                	push   $0x4a
80106835:	e9 04 f8 ff ff       	jmp    8010603e <alltraps>

8010683a <vector75>:
8010683a:	6a 00                	push   $0x0
8010683c:	6a 4b                	push   $0x4b
8010683e:	e9 fb f7 ff ff       	jmp    8010603e <alltraps>

80106843 <vector76>:
80106843:	6a 00                	push   $0x0
80106845:	6a 4c                	push   $0x4c
80106847:	e9 f2 f7 ff ff       	jmp    8010603e <alltraps>

8010684c <vector77>:
8010684c:	6a 00                	push   $0x0
8010684e:	6a 4d                	push   $0x4d
80106850:	e9 e9 f7 ff ff       	jmp    8010603e <alltraps>

80106855 <vector78>:
80106855:	6a 00                	push   $0x0
80106857:	6a 4e                	push   $0x4e
80106859:	e9 e0 f7 ff ff       	jmp    8010603e <alltraps>

8010685e <vector79>:
8010685e:	6a 00                	push   $0x0
80106860:	6a 4f                	push   $0x4f
80106862:	e9 d7 f7 ff ff       	jmp    8010603e <alltraps>

80106867 <vector80>:
80106867:	6a 00                	push   $0x0
80106869:	6a 50                	push   $0x50
8010686b:	e9 ce f7 ff ff       	jmp    8010603e <alltraps>

80106870 <vector81>:
80106870:	6a 00                	push   $0x0
80106872:	6a 51                	push   $0x51
80106874:	e9 c5 f7 ff ff       	jmp    8010603e <alltraps>

80106879 <vector82>:
80106879:	6a 00                	push   $0x0
8010687b:	6a 52                	push   $0x52
8010687d:	e9 bc f7 ff ff       	jmp    8010603e <alltraps>

80106882 <vector83>:
80106882:	6a 00                	push   $0x0
80106884:	6a 53                	push   $0x53
80106886:	e9 b3 f7 ff ff       	jmp    8010603e <alltraps>

8010688b <vector84>:
8010688b:	6a 00                	push   $0x0
8010688d:	6a 54                	push   $0x54
8010688f:	e9 aa f7 ff ff       	jmp    8010603e <alltraps>

80106894 <vector85>:
80106894:	6a 00                	push   $0x0
80106896:	6a 55                	push   $0x55
80106898:	e9 a1 f7 ff ff       	jmp    8010603e <alltraps>

8010689d <vector86>:
8010689d:	6a 00                	push   $0x0
8010689f:	6a 56                	push   $0x56
801068a1:	e9 98 f7 ff ff       	jmp    8010603e <alltraps>

801068a6 <vector87>:
801068a6:	6a 00                	push   $0x0
801068a8:	6a 57                	push   $0x57
801068aa:	e9 8f f7 ff ff       	jmp    8010603e <alltraps>

801068af <vector88>:
801068af:	6a 00                	push   $0x0
801068b1:	6a 58                	push   $0x58
801068b3:	e9 86 f7 ff ff       	jmp    8010603e <alltraps>

801068b8 <vector89>:
801068b8:	6a 00                	push   $0x0
801068ba:	6a 59                	push   $0x59
801068bc:	e9 7d f7 ff ff       	jmp    8010603e <alltraps>

801068c1 <vector90>:
801068c1:	6a 00                	push   $0x0
801068c3:	6a 5a                	push   $0x5a
801068c5:	e9 74 f7 ff ff       	jmp    8010603e <alltraps>

801068ca <vector91>:
801068ca:	6a 00                	push   $0x0
801068cc:	6a 5b                	push   $0x5b
801068ce:	e9 6b f7 ff ff       	jmp    8010603e <alltraps>

801068d3 <vector92>:
801068d3:	6a 00                	push   $0x0
801068d5:	6a 5c                	push   $0x5c
801068d7:	e9 62 f7 ff ff       	jmp    8010603e <alltraps>

801068dc <vector93>:
801068dc:	6a 00                	push   $0x0
801068de:	6a 5d                	push   $0x5d
801068e0:	e9 59 f7 ff ff       	jmp    8010603e <alltraps>

801068e5 <vector94>:
801068e5:	6a 00                	push   $0x0
801068e7:	6a 5e                	push   $0x5e
801068e9:	e9 50 f7 ff ff       	jmp    8010603e <alltraps>

801068ee <vector95>:
801068ee:	6a 00                	push   $0x0
801068f0:	6a 5f                	push   $0x5f
801068f2:	e9 47 f7 ff ff       	jmp    8010603e <alltraps>

801068f7 <vector96>:
801068f7:	6a 00                	push   $0x0
801068f9:	6a 60                	push   $0x60
801068fb:	e9 3e f7 ff ff       	jmp    8010603e <alltraps>

80106900 <vector97>:
80106900:	6a 00                	push   $0x0
80106902:	6a 61                	push   $0x61
80106904:	e9 35 f7 ff ff       	jmp    8010603e <alltraps>

80106909 <vector98>:
80106909:	6a 00                	push   $0x0
8010690b:	6a 62                	push   $0x62
8010690d:	e9 2c f7 ff ff       	jmp    8010603e <alltraps>

80106912 <vector99>:
80106912:	6a 00                	push   $0x0
80106914:	6a 63                	push   $0x63
80106916:	e9 23 f7 ff ff       	jmp    8010603e <alltraps>

8010691b <vector100>:
8010691b:	6a 00                	push   $0x0
8010691d:	6a 64                	push   $0x64
8010691f:	e9 1a f7 ff ff       	jmp    8010603e <alltraps>

80106924 <vector101>:
80106924:	6a 00                	push   $0x0
80106926:	6a 65                	push   $0x65
80106928:	e9 11 f7 ff ff       	jmp    8010603e <alltraps>

8010692d <vector102>:
8010692d:	6a 00                	push   $0x0
8010692f:	6a 66                	push   $0x66
80106931:	e9 08 f7 ff ff       	jmp    8010603e <alltraps>

80106936 <vector103>:
80106936:	6a 00                	push   $0x0
80106938:	6a 67                	push   $0x67
8010693a:	e9 ff f6 ff ff       	jmp    8010603e <alltraps>

8010693f <vector104>:
8010693f:	6a 00                	push   $0x0
80106941:	6a 68                	push   $0x68
80106943:	e9 f6 f6 ff ff       	jmp    8010603e <alltraps>

80106948 <vector105>:
80106948:	6a 00                	push   $0x0
8010694a:	6a 69                	push   $0x69
8010694c:	e9 ed f6 ff ff       	jmp    8010603e <alltraps>

80106951 <vector106>:
80106951:	6a 00                	push   $0x0
80106953:	6a 6a                	push   $0x6a
80106955:	e9 e4 f6 ff ff       	jmp    8010603e <alltraps>

8010695a <vector107>:
8010695a:	6a 00                	push   $0x0
8010695c:	6a 6b                	push   $0x6b
8010695e:	e9 db f6 ff ff       	jmp    8010603e <alltraps>

80106963 <vector108>:
80106963:	6a 00                	push   $0x0
80106965:	6a 6c                	push   $0x6c
80106967:	e9 d2 f6 ff ff       	jmp    8010603e <alltraps>

8010696c <vector109>:
8010696c:	6a 00                	push   $0x0
8010696e:	6a 6d                	push   $0x6d
80106970:	e9 c9 f6 ff ff       	jmp    8010603e <alltraps>

80106975 <vector110>:
80106975:	6a 00                	push   $0x0
80106977:	6a 6e                	push   $0x6e
80106979:	e9 c0 f6 ff ff       	jmp    8010603e <alltraps>

8010697e <vector111>:
8010697e:	6a 00                	push   $0x0
80106980:	6a 6f                	push   $0x6f
80106982:	e9 b7 f6 ff ff       	jmp    8010603e <alltraps>

80106987 <vector112>:
80106987:	6a 00                	push   $0x0
80106989:	6a 70                	push   $0x70
8010698b:	e9 ae f6 ff ff       	jmp    8010603e <alltraps>

80106990 <vector113>:
80106990:	6a 00                	push   $0x0
80106992:	6a 71                	push   $0x71
80106994:	e9 a5 f6 ff ff       	jmp    8010603e <alltraps>

80106999 <vector114>:
80106999:	6a 00                	push   $0x0
8010699b:	6a 72                	push   $0x72
8010699d:	e9 9c f6 ff ff       	jmp    8010603e <alltraps>

801069a2 <vector115>:
801069a2:	6a 00                	push   $0x0
801069a4:	6a 73                	push   $0x73
801069a6:	e9 93 f6 ff ff       	jmp    8010603e <alltraps>

801069ab <vector116>:
801069ab:	6a 00                	push   $0x0
801069ad:	6a 74                	push   $0x74
801069af:	e9 8a f6 ff ff       	jmp    8010603e <alltraps>

801069b4 <vector117>:
801069b4:	6a 00                	push   $0x0
801069b6:	6a 75                	push   $0x75
801069b8:	e9 81 f6 ff ff       	jmp    8010603e <alltraps>

801069bd <vector118>:
801069bd:	6a 00                	push   $0x0
801069bf:	6a 76                	push   $0x76
801069c1:	e9 78 f6 ff ff       	jmp    8010603e <alltraps>

801069c6 <vector119>:
801069c6:	6a 00                	push   $0x0
801069c8:	6a 77                	push   $0x77
801069ca:	e9 6f f6 ff ff       	jmp    8010603e <alltraps>

801069cf <vector120>:
801069cf:	6a 00                	push   $0x0
801069d1:	6a 78                	push   $0x78
801069d3:	e9 66 f6 ff ff       	jmp    8010603e <alltraps>

801069d8 <vector121>:
801069d8:	6a 00                	push   $0x0
801069da:	6a 79                	push   $0x79
801069dc:	e9 5d f6 ff ff       	jmp    8010603e <alltraps>

801069e1 <vector122>:
801069e1:	6a 00                	push   $0x0
801069e3:	6a 7a                	push   $0x7a
801069e5:	e9 54 f6 ff ff       	jmp    8010603e <alltraps>

801069ea <vector123>:
801069ea:	6a 00                	push   $0x0
801069ec:	6a 7b                	push   $0x7b
801069ee:	e9 4b f6 ff ff       	jmp    8010603e <alltraps>

801069f3 <vector124>:
801069f3:	6a 00                	push   $0x0
801069f5:	6a 7c                	push   $0x7c
801069f7:	e9 42 f6 ff ff       	jmp    8010603e <alltraps>

801069fc <vector125>:
801069fc:	6a 00                	push   $0x0
801069fe:	6a 7d                	push   $0x7d
80106a00:	e9 39 f6 ff ff       	jmp    8010603e <alltraps>

80106a05 <vector126>:
80106a05:	6a 00                	push   $0x0
80106a07:	6a 7e                	push   $0x7e
80106a09:	e9 30 f6 ff ff       	jmp    8010603e <alltraps>

80106a0e <vector127>:
80106a0e:	6a 00                	push   $0x0
80106a10:	6a 7f                	push   $0x7f
80106a12:	e9 27 f6 ff ff       	jmp    8010603e <alltraps>

80106a17 <vector128>:
80106a17:	6a 00                	push   $0x0
80106a19:	68 80 00 00 00       	push   $0x80
80106a1e:	e9 1b f6 ff ff       	jmp    8010603e <alltraps>

80106a23 <vector129>:
80106a23:	6a 00                	push   $0x0
80106a25:	68 81 00 00 00       	push   $0x81
80106a2a:	e9 0f f6 ff ff       	jmp    8010603e <alltraps>

80106a2f <vector130>:
80106a2f:	6a 00                	push   $0x0
80106a31:	68 82 00 00 00       	push   $0x82
80106a36:	e9 03 f6 ff ff       	jmp    8010603e <alltraps>

80106a3b <vector131>:
80106a3b:	6a 00                	push   $0x0
80106a3d:	68 83 00 00 00       	push   $0x83
80106a42:	e9 f7 f5 ff ff       	jmp    8010603e <alltraps>

80106a47 <vector132>:
80106a47:	6a 00                	push   $0x0
80106a49:	68 84 00 00 00       	push   $0x84
80106a4e:	e9 eb f5 ff ff       	jmp    8010603e <alltraps>

80106a53 <vector133>:
80106a53:	6a 00                	push   $0x0
80106a55:	68 85 00 00 00       	push   $0x85
80106a5a:	e9 df f5 ff ff       	jmp    8010603e <alltraps>

80106a5f <vector134>:
80106a5f:	6a 00                	push   $0x0
80106a61:	68 86 00 00 00       	push   $0x86
80106a66:	e9 d3 f5 ff ff       	jmp    8010603e <alltraps>

80106a6b <vector135>:
80106a6b:	6a 00                	push   $0x0
80106a6d:	68 87 00 00 00       	push   $0x87
80106a72:	e9 c7 f5 ff ff       	jmp    8010603e <alltraps>

80106a77 <vector136>:
80106a77:	6a 00                	push   $0x0
80106a79:	68 88 00 00 00       	push   $0x88
80106a7e:	e9 bb f5 ff ff       	jmp    8010603e <alltraps>

80106a83 <vector137>:
80106a83:	6a 00                	push   $0x0
80106a85:	68 89 00 00 00       	push   $0x89
80106a8a:	e9 af f5 ff ff       	jmp    8010603e <alltraps>

80106a8f <vector138>:
80106a8f:	6a 00                	push   $0x0
80106a91:	68 8a 00 00 00       	push   $0x8a
80106a96:	e9 a3 f5 ff ff       	jmp    8010603e <alltraps>

80106a9b <vector139>:
80106a9b:	6a 00                	push   $0x0
80106a9d:	68 8b 00 00 00       	push   $0x8b
80106aa2:	e9 97 f5 ff ff       	jmp    8010603e <alltraps>

80106aa7 <vector140>:
80106aa7:	6a 00                	push   $0x0
80106aa9:	68 8c 00 00 00       	push   $0x8c
80106aae:	e9 8b f5 ff ff       	jmp    8010603e <alltraps>

80106ab3 <vector141>:
80106ab3:	6a 00                	push   $0x0
80106ab5:	68 8d 00 00 00       	push   $0x8d
80106aba:	e9 7f f5 ff ff       	jmp    8010603e <alltraps>

80106abf <vector142>:
80106abf:	6a 00                	push   $0x0
80106ac1:	68 8e 00 00 00       	push   $0x8e
80106ac6:	e9 73 f5 ff ff       	jmp    8010603e <alltraps>

80106acb <vector143>:
80106acb:	6a 00                	push   $0x0
80106acd:	68 8f 00 00 00       	push   $0x8f
80106ad2:	e9 67 f5 ff ff       	jmp    8010603e <alltraps>

80106ad7 <vector144>:
80106ad7:	6a 00                	push   $0x0
80106ad9:	68 90 00 00 00       	push   $0x90
80106ade:	e9 5b f5 ff ff       	jmp    8010603e <alltraps>

80106ae3 <vector145>:
80106ae3:	6a 00                	push   $0x0
80106ae5:	68 91 00 00 00       	push   $0x91
80106aea:	e9 4f f5 ff ff       	jmp    8010603e <alltraps>

80106aef <vector146>:
80106aef:	6a 00                	push   $0x0
80106af1:	68 92 00 00 00       	push   $0x92
80106af6:	e9 43 f5 ff ff       	jmp    8010603e <alltraps>

80106afb <vector147>:
80106afb:	6a 00                	push   $0x0
80106afd:	68 93 00 00 00       	push   $0x93
80106b02:	e9 37 f5 ff ff       	jmp    8010603e <alltraps>

80106b07 <vector148>:
80106b07:	6a 00                	push   $0x0
80106b09:	68 94 00 00 00       	push   $0x94
80106b0e:	e9 2b f5 ff ff       	jmp    8010603e <alltraps>

80106b13 <vector149>:
80106b13:	6a 00                	push   $0x0
80106b15:	68 95 00 00 00       	push   $0x95
80106b1a:	e9 1f f5 ff ff       	jmp    8010603e <alltraps>

80106b1f <vector150>:
80106b1f:	6a 00                	push   $0x0
80106b21:	68 96 00 00 00       	push   $0x96
80106b26:	e9 13 f5 ff ff       	jmp    8010603e <alltraps>

80106b2b <vector151>:
80106b2b:	6a 00                	push   $0x0
80106b2d:	68 97 00 00 00       	push   $0x97
80106b32:	e9 07 f5 ff ff       	jmp    8010603e <alltraps>

80106b37 <vector152>:
80106b37:	6a 00                	push   $0x0
80106b39:	68 98 00 00 00       	push   $0x98
80106b3e:	e9 fb f4 ff ff       	jmp    8010603e <alltraps>

80106b43 <vector153>:
80106b43:	6a 00                	push   $0x0
80106b45:	68 99 00 00 00       	push   $0x99
80106b4a:	e9 ef f4 ff ff       	jmp    8010603e <alltraps>

80106b4f <vector154>:
80106b4f:	6a 00                	push   $0x0
80106b51:	68 9a 00 00 00       	push   $0x9a
80106b56:	e9 e3 f4 ff ff       	jmp    8010603e <alltraps>

80106b5b <vector155>:
80106b5b:	6a 00                	push   $0x0
80106b5d:	68 9b 00 00 00       	push   $0x9b
80106b62:	e9 d7 f4 ff ff       	jmp    8010603e <alltraps>

80106b67 <vector156>:
80106b67:	6a 00                	push   $0x0
80106b69:	68 9c 00 00 00       	push   $0x9c
80106b6e:	e9 cb f4 ff ff       	jmp    8010603e <alltraps>

80106b73 <vector157>:
80106b73:	6a 00                	push   $0x0
80106b75:	68 9d 00 00 00       	push   $0x9d
80106b7a:	e9 bf f4 ff ff       	jmp    8010603e <alltraps>

80106b7f <vector158>:
80106b7f:	6a 00                	push   $0x0
80106b81:	68 9e 00 00 00       	push   $0x9e
80106b86:	e9 b3 f4 ff ff       	jmp    8010603e <alltraps>

80106b8b <vector159>:
80106b8b:	6a 00                	push   $0x0
80106b8d:	68 9f 00 00 00       	push   $0x9f
80106b92:	e9 a7 f4 ff ff       	jmp    8010603e <alltraps>

80106b97 <vector160>:
80106b97:	6a 00                	push   $0x0
80106b99:	68 a0 00 00 00       	push   $0xa0
80106b9e:	e9 9b f4 ff ff       	jmp    8010603e <alltraps>

80106ba3 <vector161>:
80106ba3:	6a 00                	push   $0x0
80106ba5:	68 a1 00 00 00       	push   $0xa1
80106baa:	e9 8f f4 ff ff       	jmp    8010603e <alltraps>

80106baf <vector162>:
80106baf:	6a 00                	push   $0x0
80106bb1:	68 a2 00 00 00       	push   $0xa2
80106bb6:	e9 83 f4 ff ff       	jmp    8010603e <alltraps>

80106bbb <vector163>:
80106bbb:	6a 00                	push   $0x0
80106bbd:	68 a3 00 00 00       	push   $0xa3
80106bc2:	e9 77 f4 ff ff       	jmp    8010603e <alltraps>

80106bc7 <vector164>:
80106bc7:	6a 00                	push   $0x0
80106bc9:	68 a4 00 00 00       	push   $0xa4
80106bce:	e9 6b f4 ff ff       	jmp    8010603e <alltraps>

80106bd3 <vector165>:
80106bd3:	6a 00                	push   $0x0
80106bd5:	68 a5 00 00 00       	push   $0xa5
80106bda:	e9 5f f4 ff ff       	jmp    8010603e <alltraps>

80106bdf <vector166>:
80106bdf:	6a 00                	push   $0x0
80106be1:	68 a6 00 00 00       	push   $0xa6
80106be6:	e9 53 f4 ff ff       	jmp    8010603e <alltraps>

80106beb <vector167>:
80106beb:	6a 00                	push   $0x0
80106bed:	68 a7 00 00 00       	push   $0xa7
80106bf2:	e9 47 f4 ff ff       	jmp    8010603e <alltraps>

80106bf7 <vector168>:
80106bf7:	6a 00                	push   $0x0
80106bf9:	68 a8 00 00 00       	push   $0xa8
80106bfe:	e9 3b f4 ff ff       	jmp    8010603e <alltraps>

80106c03 <vector169>:
80106c03:	6a 00                	push   $0x0
80106c05:	68 a9 00 00 00       	push   $0xa9
80106c0a:	e9 2f f4 ff ff       	jmp    8010603e <alltraps>

80106c0f <vector170>:
80106c0f:	6a 00                	push   $0x0
80106c11:	68 aa 00 00 00       	push   $0xaa
80106c16:	e9 23 f4 ff ff       	jmp    8010603e <alltraps>

80106c1b <vector171>:
80106c1b:	6a 00                	push   $0x0
80106c1d:	68 ab 00 00 00       	push   $0xab
80106c22:	e9 17 f4 ff ff       	jmp    8010603e <alltraps>

80106c27 <vector172>:
80106c27:	6a 00                	push   $0x0
80106c29:	68 ac 00 00 00       	push   $0xac
80106c2e:	e9 0b f4 ff ff       	jmp    8010603e <alltraps>

80106c33 <vector173>:
80106c33:	6a 00                	push   $0x0
80106c35:	68 ad 00 00 00       	push   $0xad
80106c3a:	e9 ff f3 ff ff       	jmp    8010603e <alltraps>

80106c3f <vector174>:
80106c3f:	6a 00                	push   $0x0
80106c41:	68 ae 00 00 00       	push   $0xae
80106c46:	e9 f3 f3 ff ff       	jmp    8010603e <alltraps>

80106c4b <vector175>:
80106c4b:	6a 00                	push   $0x0
80106c4d:	68 af 00 00 00       	push   $0xaf
80106c52:	e9 e7 f3 ff ff       	jmp    8010603e <alltraps>

80106c57 <vector176>:
80106c57:	6a 00                	push   $0x0
80106c59:	68 b0 00 00 00       	push   $0xb0
80106c5e:	e9 db f3 ff ff       	jmp    8010603e <alltraps>

80106c63 <vector177>:
80106c63:	6a 00                	push   $0x0
80106c65:	68 b1 00 00 00       	push   $0xb1
80106c6a:	e9 cf f3 ff ff       	jmp    8010603e <alltraps>

80106c6f <vector178>:
80106c6f:	6a 00                	push   $0x0
80106c71:	68 b2 00 00 00       	push   $0xb2
80106c76:	e9 c3 f3 ff ff       	jmp    8010603e <alltraps>

80106c7b <vector179>:
80106c7b:	6a 00                	push   $0x0
80106c7d:	68 b3 00 00 00       	push   $0xb3
80106c82:	e9 b7 f3 ff ff       	jmp    8010603e <alltraps>

80106c87 <vector180>:
80106c87:	6a 00                	push   $0x0
80106c89:	68 b4 00 00 00       	push   $0xb4
80106c8e:	e9 ab f3 ff ff       	jmp    8010603e <alltraps>

80106c93 <vector181>:
80106c93:	6a 00                	push   $0x0
80106c95:	68 b5 00 00 00       	push   $0xb5
80106c9a:	e9 9f f3 ff ff       	jmp    8010603e <alltraps>

80106c9f <vector182>:
80106c9f:	6a 00                	push   $0x0
80106ca1:	68 b6 00 00 00       	push   $0xb6
80106ca6:	e9 93 f3 ff ff       	jmp    8010603e <alltraps>

80106cab <vector183>:
80106cab:	6a 00                	push   $0x0
80106cad:	68 b7 00 00 00       	push   $0xb7
80106cb2:	e9 87 f3 ff ff       	jmp    8010603e <alltraps>

80106cb7 <vector184>:
80106cb7:	6a 00                	push   $0x0
80106cb9:	68 b8 00 00 00       	push   $0xb8
80106cbe:	e9 7b f3 ff ff       	jmp    8010603e <alltraps>

80106cc3 <vector185>:
80106cc3:	6a 00                	push   $0x0
80106cc5:	68 b9 00 00 00       	push   $0xb9
80106cca:	e9 6f f3 ff ff       	jmp    8010603e <alltraps>

80106ccf <vector186>:
80106ccf:	6a 00                	push   $0x0
80106cd1:	68 ba 00 00 00       	push   $0xba
80106cd6:	e9 63 f3 ff ff       	jmp    8010603e <alltraps>

80106cdb <vector187>:
80106cdb:	6a 00                	push   $0x0
80106cdd:	68 bb 00 00 00       	push   $0xbb
80106ce2:	e9 57 f3 ff ff       	jmp    8010603e <alltraps>

80106ce7 <vector188>:
80106ce7:	6a 00                	push   $0x0
80106ce9:	68 bc 00 00 00       	push   $0xbc
80106cee:	e9 4b f3 ff ff       	jmp    8010603e <alltraps>

80106cf3 <vector189>:
80106cf3:	6a 00                	push   $0x0
80106cf5:	68 bd 00 00 00       	push   $0xbd
80106cfa:	e9 3f f3 ff ff       	jmp    8010603e <alltraps>

80106cff <vector190>:
80106cff:	6a 00                	push   $0x0
80106d01:	68 be 00 00 00       	push   $0xbe
80106d06:	e9 33 f3 ff ff       	jmp    8010603e <alltraps>

80106d0b <vector191>:
80106d0b:	6a 00                	push   $0x0
80106d0d:	68 bf 00 00 00       	push   $0xbf
80106d12:	e9 27 f3 ff ff       	jmp    8010603e <alltraps>

80106d17 <vector192>:
80106d17:	6a 00                	push   $0x0
80106d19:	68 c0 00 00 00       	push   $0xc0
80106d1e:	e9 1b f3 ff ff       	jmp    8010603e <alltraps>

80106d23 <vector193>:
80106d23:	6a 00                	push   $0x0
80106d25:	68 c1 00 00 00       	push   $0xc1
80106d2a:	e9 0f f3 ff ff       	jmp    8010603e <alltraps>

80106d2f <vector194>:
80106d2f:	6a 00                	push   $0x0
80106d31:	68 c2 00 00 00       	push   $0xc2
80106d36:	e9 03 f3 ff ff       	jmp    8010603e <alltraps>

80106d3b <vector195>:
80106d3b:	6a 00                	push   $0x0
80106d3d:	68 c3 00 00 00       	push   $0xc3
80106d42:	e9 f7 f2 ff ff       	jmp    8010603e <alltraps>

80106d47 <vector196>:
80106d47:	6a 00                	push   $0x0
80106d49:	68 c4 00 00 00       	push   $0xc4
80106d4e:	e9 eb f2 ff ff       	jmp    8010603e <alltraps>

80106d53 <vector197>:
80106d53:	6a 00                	push   $0x0
80106d55:	68 c5 00 00 00       	push   $0xc5
80106d5a:	e9 df f2 ff ff       	jmp    8010603e <alltraps>

80106d5f <vector198>:
80106d5f:	6a 00                	push   $0x0
80106d61:	68 c6 00 00 00       	push   $0xc6
80106d66:	e9 d3 f2 ff ff       	jmp    8010603e <alltraps>

80106d6b <vector199>:
80106d6b:	6a 00                	push   $0x0
80106d6d:	68 c7 00 00 00       	push   $0xc7
80106d72:	e9 c7 f2 ff ff       	jmp    8010603e <alltraps>

80106d77 <vector200>:
80106d77:	6a 00                	push   $0x0
80106d79:	68 c8 00 00 00       	push   $0xc8
80106d7e:	e9 bb f2 ff ff       	jmp    8010603e <alltraps>

80106d83 <vector201>:
80106d83:	6a 00                	push   $0x0
80106d85:	68 c9 00 00 00       	push   $0xc9
80106d8a:	e9 af f2 ff ff       	jmp    8010603e <alltraps>

80106d8f <vector202>:
80106d8f:	6a 00                	push   $0x0
80106d91:	68 ca 00 00 00       	push   $0xca
80106d96:	e9 a3 f2 ff ff       	jmp    8010603e <alltraps>

80106d9b <vector203>:
80106d9b:	6a 00                	push   $0x0
80106d9d:	68 cb 00 00 00       	push   $0xcb
80106da2:	e9 97 f2 ff ff       	jmp    8010603e <alltraps>

80106da7 <vector204>:
80106da7:	6a 00                	push   $0x0
80106da9:	68 cc 00 00 00       	push   $0xcc
80106dae:	e9 8b f2 ff ff       	jmp    8010603e <alltraps>

80106db3 <vector205>:
80106db3:	6a 00                	push   $0x0
80106db5:	68 cd 00 00 00       	push   $0xcd
80106dba:	e9 7f f2 ff ff       	jmp    8010603e <alltraps>

80106dbf <vector206>:
80106dbf:	6a 00                	push   $0x0
80106dc1:	68 ce 00 00 00       	push   $0xce
80106dc6:	e9 73 f2 ff ff       	jmp    8010603e <alltraps>

80106dcb <vector207>:
80106dcb:	6a 00                	push   $0x0
80106dcd:	68 cf 00 00 00       	push   $0xcf
80106dd2:	e9 67 f2 ff ff       	jmp    8010603e <alltraps>

80106dd7 <vector208>:
80106dd7:	6a 00                	push   $0x0
80106dd9:	68 d0 00 00 00       	push   $0xd0
80106dde:	e9 5b f2 ff ff       	jmp    8010603e <alltraps>

80106de3 <vector209>:
80106de3:	6a 00                	push   $0x0
80106de5:	68 d1 00 00 00       	push   $0xd1
80106dea:	e9 4f f2 ff ff       	jmp    8010603e <alltraps>

80106def <vector210>:
80106def:	6a 00                	push   $0x0
80106df1:	68 d2 00 00 00       	push   $0xd2
80106df6:	e9 43 f2 ff ff       	jmp    8010603e <alltraps>

80106dfb <vector211>:
80106dfb:	6a 00                	push   $0x0
80106dfd:	68 d3 00 00 00       	push   $0xd3
80106e02:	e9 37 f2 ff ff       	jmp    8010603e <alltraps>

80106e07 <vector212>:
80106e07:	6a 00                	push   $0x0
80106e09:	68 d4 00 00 00       	push   $0xd4
80106e0e:	e9 2b f2 ff ff       	jmp    8010603e <alltraps>

80106e13 <vector213>:
80106e13:	6a 00                	push   $0x0
80106e15:	68 d5 00 00 00       	push   $0xd5
80106e1a:	e9 1f f2 ff ff       	jmp    8010603e <alltraps>

80106e1f <vector214>:
80106e1f:	6a 00                	push   $0x0
80106e21:	68 d6 00 00 00       	push   $0xd6
80106e26:	e9 13 f2 ff ff       	jmp    8010603e <alltraps>

80106e2b <vector215>:
80106e2b:	6a 00                	push   $0x0
80106e2d:	68 d7 00 00 00       	push   $0xd7
80106e32:	e9 07 f2 ff ff       	jmp    8010603e <alltraps>

80106e37 <vector216>:
80106e37:	6a 00                	push   $0x0
80106e39:	68 d8 00 00 00       	push   $0xd8
80106e3e:	e9 fb f1 ff ff       	jmp    8010603e <alltraps>

80106e43 <vector217>:
80106e43:	6a 00                	push   $0x0
80106e45:	68 d9 00 00 00       	push   $0xd9
80106e4a:	e9 ef f1 ff ff       	jmp    8010603e <alltraps>

80106e4f <vector218>:
80106e4f:	6a 00                	push   $0x0
80106e51:	68 da 00 00 00       	push   $0xda
80106e56:	e9 e3 f1 ff ff       	jmp    8010603e <alltraps>

80106e5b <vector219>:
80106e5b:	6a 00                	push   $0x0
80106e5d:	68 db 00 00 00       	push   $0xdb
80106e62:	e9 d7 f1 ff ff       	jmp    8010603e <alltraps>

80106e67 <vector220>:
80106e67:	6a 00                	push   $0x0
80106e69:	68 dc 00 00 00       	push   $0xdc
80106e6e:	e9 cb f1 ff ff       	jmp    8010603e <alltraps>

80106e73 <vector221>:
80106e73:	6a 00                	push   $0x0
80106e75:	68 dd 00 00 00       	push   $0xdd
80106e7a:	e9 bf f1 ff ff       	jmp    8010603e <alltraps>

80106e7f <vector222>:
80106e7f:	6a 00                	push   $0x0
80106e81:	68 de 00 00 00       	push   $0xde
80106e86:	e9 b3 f1 ff ff       	jmp    8010603e <alltraps>

80106e8b <vector223>:
80106e8b:	6a 00                	push   $0x0
80106e8d:	68 df 00 00 00       	push   $0xdf
80106e92:	e9 a7 f1 ff ff       	jmp    8010603e <alltraps>

80106e97 <vector224>:
80106e97:	6a 00                	push   $0x0
80106e99:	68 e0 00 00 00       	push   $0xe0
80106e9e:	e9 9b f1 ff ff       	jmp    8010603e <alltraps>

80106ea3 <vector225>:
80106ea3:	6a 00                	push   $0x0
80106ea5:	68 e1 00 00 00       	push   $0xe1
80106eaa:	e9 8f f1 ff ff       	jmp    8010603e <alltraps>

80106eaf <vector226>:
80106eaf:	6a 00                	push   $0x0
80106eb1:	68 e2 00 00 00       	push   $0xe2
80106eb6:	e9 83 f1 ff ff       	jmp    8010603e <alltraps>

80106ebb <vector227>:
80106ebb:	6a 00                	push   $0x0
80106ebd:	68 e3 00 00 00       	push   $0xe3
80106ec2:	e9 77 f1 ff ff       	jmp    8010603e <alltraps>

80106ec7 <vector228>:
80106ec7:	6a 00                	push   $0x0
80106ec9:	68 e4 00 00 00       	push   $0xe4
80106ece:	e9 6b f1 ff ff       	jmp    8010603e <alltraps>

80106ed3 <vector229>:
80106ed3:	6a 00                	push   $0x0
80106ed5:	68 e5 00 00 00       	push   $0xe5
80106eda:	e9 5f f1 ff ff       	jmp    8010603e <alltraps>

80106edf <vector230>:
80106edf:	6a 00                	push   $0x0
80106ee1:	68 e6 00 00 00       	push   $0xe6
80106ee6:	e9 53 f1 ff ff       	jmp    8010603e <alltraps>

80106eeb <vector231>:
80106eeb:	6a 00                	push   $0x0
80106eed:	68 e7 00 00 00       	push   $0xe7
80106ef2:	e9 47 f1 ff ff       	jmp    8010603e <alltraps>

80106ef7 <vector232>:
80106ef7:	6a 00                	push   $0x0
80106ef9:	68 e8 00 00 00       	push   $0xe8
80106efe:	e9 3b f1 ff ff       	jmp    8010603e <alltraps>

80106f03 <vector233>:
80106f03:	6a 00                	push   $0x0
80106f05:	68 e9 00 00 00       	push   $0xe9
80106f0a:	e9 2f f1 ff ff       	jmp    8010603e <alltraps>

80106f0f <vector234>:
80106f0f:	6a 00                	push   $0x0
80106f11:	68 ea 00 00 00       	push   $0xea
80106f16:	e9 23 f1 ff ff       	jmp    8010603e <alltraps>

80106f1b <vector235>:
80106f1b:	6a 00                	push   $0x0
80106f1d:	68 eb 00 00 00       	push   $0xeb
80106f22:	e9 17 f1 ff ff       	jmp    8010603e <alltraps>

80106f27 <vector236>:
80106f27:	6a 00                	push   $0x0
80106f29:	68 ec 00 00 00       	push   $0xec
80106f2e:	e9 0b f1 ff ff       	jmp    8010603e <alltraps>

80106f33 <vector237>:
80106f33:	6a 00                	push   $0x0
80106f35:	68 ed 00 00 00       	push   $0xed
80106f3a:	e9 ff f0 ff ff       	jmp    8010603e <alltraps>

80106f3f <vector238>:
80106f3f:	6a 00                	push   $0x0
80106f41:	68 ee 00 00 00       	push   $0xee
80106f46:	e9 f3 f0 ff ff       	jmp    8010603e <alltraps>

80106f4b <vector239>:
80106f4b:	6a 00                	push   $0x0
80106f4d:	68 ef 00 00 00       	push   $0xef
80106f52:	e9 e7 f0 ff ff       	jmp    8010603e <alltraps>

80106f57 <vector240>:
80106f57:	6a 00                	push   $0x0
80106f59:	68 f0 00 00 00       	push   $0xf0
80106f5e:	e9 db f0 ff ff       	jmp    8010603e <alltraps>

80106f63 <vector241>:
80106f63:	6a 00                	push   $0x0
80106f65:	68 f1 00 00 00       	push   $0xf1
80106f6a:	e9 cf f0 ff ff       	jmp    8010603e <alltraps>

80106f6f <vector242>:
80106f6f:	6a 00                	push   $0x0
80106f71:	68 f2 00 00 00       	push   $0xf2
80106f76:	e9 c3 f0 ff ff       	jmp    8010603e <alltraps>

80106f7b <vector243>:
80106f7b:	6a 00                	push   $0x0
80106f7d:	68 f3 00 00 00       	push   $0xf3
80106f82:	e9 b7 f0 ff ff       	jmp    8010603e <alltraps>

80106f87 <vector244>:
80106f87:	6a 00                	push   $0x0
80106f89:	68 f4 00 00 00       	push   $0xf4
80106f8e:	e9 ab f0 ff ff       	jmp    8010603e <alltraps>

80106f93 <vector245>:
80106f93:	6a 00                	push   $0x0
80106f95:	68 f5 00 00 00       	push   $0xf5
80106f9a:	e9 9f f0 ff ff       	jmp    8010603e <alltraps>

80106f9f <vector246>:
80106f9f:	6a 00                	push   $0x0
80106fa1:	68 f6 00 00 00       	push   $0xf6
80106fa6:	e9 93 f0 ff ff       	jmp    8010603e <alltraps>

80106fab <vector247>:
80106fab:	6a 00                	push   $0x0
80106fad:	68 f7 00 00 00       	push   $0xf7
80106fb2:	e9 87 f0 ff ff       	jmp    8010603e <alltraps>

80106fb7 <vector248>:
80106fb7:	6a 00                	push   $0x0
80106fb9:	68 f8 00 00 00       	push   $0xf8
80106fbe:	e9 7b f0 ff ff       	jmp    8010603e <alltraps>

80106fc3 <vector249>:
80106fc3:	6a 00                	push   $0x0
80106fc5:	68 f9 00 00 00       	push   $0xf9
80106fca:	e9 6f f0 ff ff       	jmp    8010603e <alltraps>

80106fcf <vector250>:
80106fcf:	6a 00                	push   $0x0
80106fd1:	68 fa 00 00 00       	push   $0xfa
80106fd6:	e9 63 f0 ff ff       	jmp    8010603e <alltraps>

80106fdb <vector251>:
80106fdb:	6a 00                	push   $0x0
80106fdd:	68 fb 00 00 00       	push   $0xfb
80106fe2:	e9 57 f0 ff ff       	jmp    8010603e <alltraps>

80106fe7 <vector252>:
80106fe7:	6a 00                	push   $0x0
80106fe9:	68 fc 00 00 00       	push   $0xfc
80106fee:	e9 4b f0 ff ff       	jmp    8010603e <alltraps>

80106ff3 <vector253>:
80106ff3:	6a 00                	push   $0x0
80106ff5:	68 fd 00 00 00       	push   $0xfd
80106ffa:	e9 3f f0 ff ff       	jmp    8010603e <alltraps>

80106fff <vector254>:
80106fff:	6a 00                	push   $0x0
80107001:	68 fe 00 00 00       	push   $0xfe
80107006:	e9 33 f0 ff ff       	jmp    8010603e <alltraps>

8010700b <vector255>:
8010700b:	6a 00                	push   $0x0
8010700d:	68 ff 00 00 00       	push   $0xff
80107012:	e9 27 f0 ff ff       	jmp    8010603e <alltraps>
80107017:	66 90                	xchg   %ax,%ax
80107019:	66 90                	xchg   %ax,%ax
8010701b:	66 90                	xchg   %ax,%ax
8010701d:	66 90                	xchg   %ax,%ax
8010701f:	90                   	nop

80107020 <walkpgdir>:
80107020:	55                   	push   %ebp
80107021:	89 e5                	mov    %esp,%ebp
80107023:	57                   	push   %edi
80107024:	56                   	push   %esi
80107025:	53                   	push   %ebx
80107026:	89 d3                	mov    %edx,%ebx
80107028:	89 d7                	mov    %edx,%edi
8010702a:	c1 eb 16             	shr    $0x16,%ebx
8010702d:	8d 34 98             	lea    (%eax,%ebx,4),%esi
80107030:	83 ec 0c             	sub    $0xc,%esp
80107033:	8b 06                	mov    (%esi),%eax
80107035:	a8 01                	test   $0x1,%al
80107037:	74 27                	je     80107060 <walkpgdir+0x40>
80107039:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010703e:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80107044:	c1 ef 0a             	shr    $0xa,%edi
80107047:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010704a:	89 fa                	mov    %edi,%edx
8010704c:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107052:	8d 04 13             	lea    (%ebx,%edx,1),%eax
80107055:	5b                   	pop    %ebx
80107056:	5e                   	pop    %esi
80107057:	5f                   	pop    %edi
80107058:	5d                   	pop    %ebp
80107059:	c3                   	ret    
8010705a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107060:	85 c9                	test   %ecx,%ecx
80107062:	74 34                	je     80107098 <walkpgdir+0x78>
80107064:	e8 b7 b4 ff ff       	call   80102520 <kalloc>
80107069:	85 c0                	test   %eax,%eax
8010706b:	89 c3                	mov    %eax,%ebx
8010706d:	74 29                	je     80107098 <walkpgdir+0x78>
8010706f:	83 ec 04             	sub    $0x4,%esp
80107072:	68 00 10 00 00       	push   $0x1000
80107077:	6a 00                	push   $0x0
80107079:	50                   	push   %eax
8010707a:	e8 91 dc ff ff       	call   80104d10 <memset>
8010707f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107085:	83 c4 10             	add    $0x10,%esp
80107088:	25 f8 fe ff ff       	and    $0xfffffef8,%eax
8010708d:	83 c8 07             	or     $0x7,%eax
80107090:	89 06                	mov    %eax,(%esi)
80107092:	eb b0                	jmp    80107044 <walkpgdir+0x24>
80107094:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107098:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010709b:	31 c0                	xor    %eax,%eax
8010709d:	5b                   	pop    %ebx
8010709e:	5e                   	pop    %esi
8010709f:	5f                   	pop    %edi
801070a0:	5d                   	pop    %ebp
801070a1:	c3                   	ret    
801070a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801070b0 <mappages>:
801070b0:	55                   	push   %ebp
801070b1:	89 e5                	mov    %esp,%ebp
801070b3:	57                   	push   %edi
801070b4:	56                   	push   %esi
801070b5:	53                   	push   %ebx
801070b6:	89 d3                	mov    %edx,%ebx
801070b8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801070be:	83 ec 1c             	sub    $0x1c,%esp
801070c1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801070c4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
801070c8:	8b 7d 08             	mov    0x8(%ebp),%edi
801070cb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801070d0:	89 45 e0             	mov    %eax,-0x20(%ebp)
801070d3:	8b 45 0c             	mov    0xc(%ebp),%eax
801070d6:	29 df                	sub    %ebx,%edi
801070d8:	83 c8 01             	or     $0x1,%eax
801070db:	89 45 dc             	mov    %eax,-0x24(%ebp)
801070de:	eb 15                	jmp    801070f5 <mappages+0x45>
801070e0:	f6 00 01             	testb  $0x1,(%eax)
801070e3:	75 45                	jne    8010712a <mappages+0x7a>
801070e5:	0b 75 dc             	or     -0x24(%ebp),%esi
801070e8:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
801070eb:	89 30                	mov    %esi,(%eax)
801070ed:	74 31                	je     80107120 <mappages+0x70>
801070ef:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801070f5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801070f8:	b9 01 00 00 00       	mov    $0x1,%ecx
801070fd:	89 da                	mov    %ebx,%edx
801070ff:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80107102:	e8 19 ff ff ff       	call   80107020 <walkpgdir>
80107107:	85 c0                	test   %eax,%eax
80107109:	75 d5                	jne    801070e0 <mappages+0x30>
8010710b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010710e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107113:	5b                   	pop    %ebx
80107114:	5e                   	pop    %esi
80107115:	5f                   	pop    %edi
80107116:	5d                   	pop    %ebp
80107117:	c3                   	ret    
80107118:	90                   	nop
80107119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107120:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107123:	31 c0                	xor    %eax,%eax
80107125:	5b                   	pop    %ebx
80107126:	5e                   	pop    %esi
80107127:	5f                   	pop    %edi
80107128:	5d                   	pop    %ebp
80107129:	c3                   	ret    
8010712a:	83 ec 0c             	sub    $0xc,%esp
8010712d:	68 ac 83 10 80       	push   $0x801083ac
80107132:	e8 39 92 ff ff       	call   80100370 <panic>
80107137:	89 f6                	mov    %esi,%esi
80107139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107140 <getSharedCounter>:
80107140:	55                   	push   %ebp
80107141:	89 e5                	mov    %esp,%ebp
80107143:	8b 45 08             	mov    0x8(%ebp),%eax
80107146:	5d                   	pop    %ebp
80107147:	0f b6 80 40 cf 11 80 	movzbl -0x7fee30c0(%eax),%eax
8010714e:	c3                   	ret    
8010714f:	90                   	nop

80107150 <seginit>:
80107150:	55                   	push   %ebp
80107151:	89 e5                	mov    %esp,%ebp
80107153:	53                   	push   %ebx
80107154:	31 db                	xor    %ebx,%ebx
80107156:	83 ec 14             	sub    $0x14,%esp
80107159:	e8 32 b6 ff ff       	call   80102790 <cpunum>
8010715e:	8d 04 40             	lea    (%eax,%eax,2),%eax
80107161:	c1 e0 06             	shl    $0x6,%eax
80107164:	8d 90 e0 22 11 80    	lea    -0x7feedd20(%eax),%edx
8010716a:	8d 88 94 23 11 80    	lea    -0x7feedc6c(%eax),%ecx
80107170:	c7 80 58 23 11 80 ff 	movl   $0xffff,-0x7feedca8(%eax)
80107177:	ff 00 00 
8010717a:	c7 80 5c 23 11 80 00 	movl   $0xcf9a00,-0x7feedca4(%eax)
80107181:	9a cf 00 
80107184:	c7 80 60 23 11 80 ff 	movl   $0xffff,-0x7feedca0(%eax)
8010718b:	ff 00 00 
8010718e:	c7 80 64 23 11 80 00 	movl   $0xcf9200,-0x7feedc9c(%eax)
80107195:	92 cf 00 
80107198:	c7 80 70 23 11 80 ff 	movl   $0xffff,-0x7feedc90(%eax)
8010719f:	ff 00 00 
801071a2:	c7 80 74 23 11 80 00 	movl   $0xcffa00,-0x7feedc8c(%eax)
801071a9:	fa cf 00 
801071ac:	c7 80 78 23 11 80 ff 	movl   $0xffff,-0x7feedc88(%eax)
801071b3:	ff 00 00 
801071b6:	c7 80 7c 23 11 80 00 	movl   $0xcff200,-0x7feedc84(%eax)
801071bd:	f2 cf 00 
801071c0:	66 89 9a 88 00 00 00 	mov    %bx,0x88(%edx)
801071c7:	89 cb                	mov    %ecx,%ebx
801071c9:	c1 eb 10             	shr    $0x10,%ebx
801071cc:	66 89 8a 8a 00 00 00 	mov    %cx,0x8a(%edx)
801071d3:	c1 e9 18             	shr    $0x18,%ecx
801071d6:	88 9a 8c 00 00 00    	mov    %bl,0x8c(%edx)
801071dc:	bb 92 c0 ff ff       	mov    $0xffffc092,%ebx
801071e1:	66 89 98 6d 23 11 80 	mov    %bx,-0x7feedc93(%eax)
801071e8:	05 50 23 11 80       	add    $0x80112350,%eax
801071ed:	88 8a 8f 00 00 00    	mov    %cl,0x8f(%edx)
801071f3:	b9 37 00 00 00       	mov    $0x37,%ecx
801071f8:	66 89 4d f2          	mov    %cx,-0xe(%ebp)
801071fc:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
80107200:	c1 e8 10             	shr    $0x10,%eax
80107203:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
80107207:	8d 45 f2             	lea    -0xe(%ebp),%eax
8010720a:	0f 01 10             	lgdtl  (%eax)
8010720d:	b8 18 00 00 00       	mov    $0x18,%eax
80107212:	8e e8                	mov    %eax,%gs
80107214:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
8010721b:	00 00 00 00 
8010721f:	65 89 15 00 00 00 00 	mov    %edx,%gs:0x0
80107226:	83 c4 14             	add    $0x14,%esp
80107229:	5b                   	pop    %ebx
8010722a:	5d                   	pop    %ebp
8010722b:	c3                   	ret    
8010722c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107230 <setupkvm>:
80107230:	55                   	push   %ebp
80107231:	89 e5                	mov    %esp,%ebp
80107233:	56                   	push   %esi
80107234:	53                   	push   %ebx
80107235:	e8 e6 b2 ff ff       	call   80102520 <kalloc>
8010723a:	85 c0                	test   %eax,%eax
8010723c:	74 52                	je     80107290 <setupkvm+0x60>
8010723e:	83 ec 04             	sub    $0x4,%esp
80107241:	89 c6                	mov    %eax,%esi
80107243:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
80107248:	68 00 10 00 00       	push   $0x1000
8010724d:	6a 00                	push   $0x0
8010724f:	50                   	push   %eax
80107250:	e8 bb da ff ff       	call   80104d10 <memset>
80107255:	83 c4 10             	add    $0x10,%esp
80107258:	8b 43 04             	mov    0x4(%ebx),%eax
8010725b:	8b 4b 08             	mov    0x8(%ebx),%ecx
8010725e:	83 ec 08             	sub    $0x8,%esp
80107261:	8b 13                	mov    (%ebx),%edx
80107263:	ff 73 0c             	pushl  0xc(%ebx)
80107266:	50                   	push   %eax
80107267:	29 c1                	sub    %eax,%ecx
80107269:	89 f0                	mov    %esi,%eax
8010726b:	e8 40 fe ff ff       	call   801070b0 <mappages>
80107270:	83 c4 10             	add    $0x10,%esp
80107273:	85 c0                	test   %eax,%eax
80107275:	78 19                	js     80107290 <setupkvm+0x60>
80107277:	83 c3 10             	add    $0x10,%ebx
8010727a:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107280:	75 d6                	jne    80107258 <setupkvm+0x28>
80107282:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107285:	89 f0                	mov    %esi,%eax
80107287:	5b                   	pop    %ebx
80107288:	5e                   	pop    %esi
80107289:	5d                   	pop    %ebp
8010728a:	c3                   	ret    
8010728b:	90                   	nop
8010728c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107290:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107293:	31 f6                	xor    %esi,%esi
80107295:	89 f0                	mov    %esi,%eax
80107297:	5b                   	pop    %ebx
80107298:	5e                   	pop    %esi
80107299:	5d                   	pop    %ebp
8010729a:	c3                   	ret    
8010729b:	90                   	nop
8010729c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801072a0 <kvmalloc>:
801072a0:	55                   	push   %ebp
801072a1:	89 e5                	mov    %esp,%ebp
801072a3:	83 ec 08             	sub    $0x8,%esp
801072a6:	e8 85 ff ff ff       	call   80107230 <setupkvm>
801072ab:	a3 e0 ce 11 80       	mov    %eax,0x8011cee0
801072b0:	05 00 00 00 80       	add    $0x80000000,%eax
801072b5:	0f 22 d8             	mov    %eax,%cr3
801072b8:	c9                   	leave  
801072b9:	c3                   	ret    
801072ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801072c0 <switchkvm>:
801072c0:	a1 e0 ce 11 80       	mov    0x8011cee0,%eax
801072c5:	55                   	push   %ebp
801072c6:	89 e5                	mov    %esp,%ebp
801072c8:	05 00 00 00 80       	add    $0x80000000,%eax
801072cd:	0f 22 d8             	mov    %eax,%cr3
801072d0:	5d                   	pop    %ebp
801072d1:	c3                   	ret    
801072d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801072d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801072e0 <switchuvm>:
801072e0:	55                   	push   %ebp
801072e1:	89 e5                	mov    %esp,%ebp
801072e3:	53                   	push   %ebx
801072e4:	83 ec 04             	sub    $0x4,%esp
801072e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
801072ea:	e8 51 d9 ff ff       	call   80104c40 <pushcli>
801072ef:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801072f5:	b9 67 00 00 00       	mov    $0x67,%ecx
801072fa:	8d 50 08             	lea    0x8(%eax),%edx
801072fd:	66 89 88 a0 00 00 00 	mov    %cx,0xa0(%eax)
80107304:	66 89 90 a2 00 00 00 	mov    %dx,0xa2(%eax)
8010730b:	89 d1                	mov    %edx,%ecx
8010730d:	c1 ea 18             	shr    $0x18,%edx
80107310:	88 90 a7 00 00 00    	mov    %dl,0xa7(%eax)
80107316:	ba 89 40 00 00       	mov    $0x4089,%edx
8010731b:	c1 e9 10             	shr    $0x10,%ecx
8010731e:	66 89 90 a5 00 00 00 	mov    %dx,0xa5(%eax)
80107325:	65 8b 15 08 00 00 00 	mov    %gs:0x8,%edx
8010732c:	88 88 a4 00 00 00    	mov    %cl,0xa4(%eax)
80107332:	b9 10 00 00 00       	mov    $0x10,%ecx
80107337:	66 89 48 10          	mov    %cx,0x10(%eax)
8010733b:	8b 52 08             	mov    0x8(%edx),%edx
8010733e:	81 c2 00 10 00 00    	add    $0x1000,%edx
80107344:	89 50 0c             	mov    %edx,0xc(%eax)
80107347:	ba ff ff ff ff       	mov    $0xffffffff,%edx
8010734c:	66 89 50 6e          	mov    %dx,0x6e(%eax)
80107350:	b8 30 00 00 00       	mov    $0x30,%eax
80107355:	0f 00 d8             	ltr    %ax
80107358:	8b 43 04             	mov    0x4(%ebx),%eax
8010735b:	85 c0                	test   %eax,%eax
8010735d:	74 11                	je     80107370 <switchuvm+0x90>
8010735f:	05 00 00 00 80       	add    $0x80000000,%eax
80107364:	0f 22 d8             	mov    %eax,%cr3
80107367:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010736a:	c9                   	leave  
8010736b:	e9 00 d9 ff ff       	jmp    80104c70 <popcli>
80107370:	83 ec 0c             	sub    $0xc,%esp
80107373:	68 b2 83 10 80       	push   $0x801083b2
80107378:	e8 f3 8f ff ff       	call   80100370 <panic>
8010737d:	8d 76 00             	lea    0x0(%esi),%esi

80107380 <inituvm>:
80107380:	55                   	push   %ebp
80107381:	89 e5                	mov    %esp,%ebp
80107383:	57                   	push   %edi
80107384:	56                   	push   %esi
80107385:	53                   	push   %ebx
80107386:	83 ec 1c             	sub    $0x1c,%esp
80107389:	8b 75 10             	mov    0x10(%ebp),%esi
8010738c:	8b 45 08             	mov    0x8(%ebp),%eax
8010738f:	8b 7d 0c             	mov    0xc(%ebp),%edi
80107392:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80107398:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010739b:	77 49                	ja     801073e6 <inituvm+0x66>
8010739d:	e8 7e b1 ff ff       	call   80102520 <kalloc>
801073a2:	83 ec 04             	sub    $0x4,%esp
801073a5:	89 c3                	mov    %eax,%ebx
801073a7:	68 00 10 00 00       	push   $0x1000
801073ac:	6a 00                	push   $0x0
801073ae:	50                   	push   %eax
801073af:	e8 5c d9 ff ff       	call   80104d10 <memset>
801073b4:	58                   	pop    %eax
801073b5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801073bb:	b9 00 10 00 00       	mov    $0x1000,%ecx
801073c0:	5a                   	pop    %edx
801073c1:	6a 06                	push   $0x6
801073c3:	50                   	push   %eax
801073c4:	31 d2                	xor    %edx,%edx
801073c6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801073c9:	e8 e2 fc ff ff       	call   801070b0 <mappages>
801073ce:	89 75 10             	mov    %esi,0x10(%ebp)
801073d1:	89 7d 0c             	mov    %edi,0xc(%ebp)
801073d4:	83 c4 10             	add    $0x10,%esp
801073d7:	89 5d 08             	mov    %ebx,0x8(%ebp)
801073da:	8d 65 f4             	lea    -0xc(%ebp),%esp
801073dd:	5b                   	pop    %ebx
801073de:	5e                   	pop    %esi
801073df:	5f                   	pop    %edi
801073e0:	5d                   	pop    %ebp
801073e1:	e9 da d9 ff ff       	jmp    80104dc0 <memmove>
801073e6:	83 ec 0c             	sub    $0xc,%esp
801073e9:	68 c6 83 10 80       	push   $0x801083c6
801073ee:	e8 7d 8f ff ff       	call   80100370 <panic>
801073f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801073f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107400 <loaduvm>:
80107400:	55                   	push   %ebp
80107401:	89 e5                	mov    %esp,%ebp
80107403:	57                   	push   %edi
80107404:	56                   	push   %esi
80107405:	53                   	push   %ebx
80107406:	83 ec 0c             	sub    $0xc,%esp
80107409:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80107410:	0f 85 91 00 00 00    	jne    801074a7 <loaduvm+0xa7>
80107416:	8b 75 18             	mov    0x18(%ebp),%esi
80107419:	31 db                	xor    %ebx,%ebx
8010741b:	85 f6                	test   %esi,%esi
8010741d:	75 1a                	jne    80107439 <loaduvm+0x39>
8010741f:	eb 6f                	jmp    80107490 <loaduvm+0x90>
80107421:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107428:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010742e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80107434:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80107437:	76 57                	jbe    80107490 <loaduvm+0x90>
80107439:	8b 55 0c             	mov    0xc(%ebp),%edx
8010743c:	8b 45 08             	mov    0x8(%ebp),%eax
8010743f:	31 c9                	xor    %ecx,%ecx
80107441:	01 da                	add    %ebx,%edx
80107443:	e8 d8 fb ff ff       	call   80107020 <walkpgdir>
80107448:	85 c0                	test   %eax,%eax
8010744a:	74 4e                	je     8010749a <loaduvm+0x9a>
8010744c:	8b 00                	mov    (%eax),%eax
8010744e:	8b 4d 14             	mov    0x14(%ebp),%ecx
80107451:	bf 00 10 00 00       	mov    $0x1000,%edi
80107456:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010745b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80107461:	0f 46 fe             	cmovbe %esi,%edi
80107464:	01 d9                	add    %ebx,%ecx
80107466:	05 00 00 00 80       	add    $0x80000000,%eax
8010746b:	57                   	push   %edi
8010746c:	51                   	push   %ecx
8010746d:	50                   	push   %eax
8010746e:	ff 75 10             	pushl  0x10(%ebp)
80107471:	e8 2a a5 ff ff       	call   801019a0 <readi>
80107476:	83 c4 10             	add    $0x10,%esp
80107479:	39 f8                	cmp    %edi,%eax
8010747b:	74 ab                	je     80107428 <loaduvm+0x28>
8010747d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107480:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107485:	5b                   	pop    %ebx
80107486:	5e                   	pop    %esi
80107487:	5f                   	pop    %edi
80107488:	5d                   	pop    %ebp
80107489:	c3                   	ret    
8010748a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107490:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107493:	31 c0                	xor    %eax,%eax
80107495:	5b                   	pop    %ebx
80107496:	5e                   	pop    %esi
80107497:	5f                   	pop    %edi
80107498:	5d                   	pop    %ebp
80107499:	c3                   	ret    
8010749a:	83 ec 0c             	sub    $0xc,%esp
8010749d:	68 e0 83 10 80       	push   $0x801083e0
801074a2:	e8 c9 8e ff ff       	call   80100370 <panic>
801074a7:	83 ec 0c             	sub    $0xc,%esp
801074aa:	68 d4 84 10 80       	push   $0x801084d4
801074af:	e8 bc 8e ff ff       	call   80100370 <panic>
801074b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801074ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801074c0 <deallocuvm>:
801074c0:	55                   	push   %ebp
801074c1:	89 e5                	mov    %esp,%ebp
801074c3:	57                   	push   %edi
801074c4:	56                   	push   %esi
801074c5:	53                   	push   %ebx
801074c6:	83 ec 1c             	sub    $0x1c,%esp
801074c9:	8b 75 0c             	mov    0xc(%ebp),%esi
801074cc:	39 75 10             	cmp    %esi,0x10(%ebp)
801074cf:	89 f0                	mov    %esi,%eax
801074d1:	72 0d                	jb     801074e0 <deallocuvm+0x20>
801074d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801074d6:	5b                   	pop    %ebx
801074d7:	5e                   	pop    %esi
801074d8:	5f                   	pop    %edi
801074d9:	5d                   	pop    %ebp
801074da:	c3                   	ret    
801074db:	90                   	nop
801074dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801074e0:	83 ec 0c             	sub    $0xc,%esp
801074e3:	68 00 cf 11 80       	push   $0x8011cf00
801074e8:	e8 13 d6 ff ff       	call   80104b00 <acquire>
801074ed:	8b 45 10             	mov    0x10(%ebp),%eax
801074f0:	83 c4 10             	add    $0x10,%esp
801074f3:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801074f9:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801074ff:	39 de                	cmp    %ebx,%esi
80107501:	77 41                	ja     80107544 <deallocuvm+0x84>
80107503:	eb 5f                	jmp    80107564 <deallocuvm+0xa4>
80107505:	8d 76 00             	lea    0x0(%esi),%esi
80107508:	8b 10                	mov    (%eax),%edx
8010750a:	f6 c2 01             	test   $0x1,%dl
8010750d:	74 2b                	je     8010753a <deallocuvm+0x7a>
8010750f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107515:	0f 84 7f 00 00 00    	je     8010759a <deallocuvm+0xda>
8010751b:	89 d7                	mov    %edx,%edi
8010751d:	c1 ef 0c             	shr    $0xc,%edi
80107520:	0f b6 8f 40 cf 11 80 	movzbl -0x7fee30c0(%edi),%ecx
80107527:	84 c9                	test   %cl,%cl
80107529:	74 55                	je     80107580 <deallocuvm+0xc0>
8010752b:	83 e9 01             	sub    $0x1,%ecx
8010752e:	88 8f 40 cf 11 80    	mov    %cl,-0x7fee30c0(%edi)
80107534:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
8010753a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107540:	39 de                	cmp    %ebx,%esi
80107542:	76 20                	jbe    80107564 <deallocuvm+0xa4>
80107544:	8b 45 08             	mov    0x8(%ebp),%eax
80107547:	31 c9                	xor    %ecx,%ecx
80107549:	89 da                	mov    %ebx,%edx
8010754b:	e8 d0 fa ff ff       	call   80107020 <walkpgdir>
80107550:	85 c0                	test   %eax,%eax
80107552:	75 b4                	jne    80107508 <deallocuvm+0x48>
80107554:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
8010755a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107560:	39 de                	cmp    %ebx,%esi
80107562:	77 e0                	ja     80107544 <deallocuvm+0x84>
80107564:	83 ec 0c             	sub    $0xc,%esp
80107567:	68 00 cf 11 80       	push   $0x8011cf00
8010756c:	e8 4f d7 ff ff       	call   80104cc0 <release>
80107571:	8b 45 10             	mov    0x10(%ebp),%eax
80107574:	83 c4 10             	add    $0x10,%esp
80107577:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010757a:	5b                   	pop    %ebx
8010757b:	5e                   	pop    %esi
8010757c:	5f                   	pop    %edi
8010757d:	5d                   	pop    %ebp
8010757e:	c3                   	ret    
8010757f:	90                   	nop
80107580:	83 ec 0c             	sub    $0xc,%esp
80107583:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80107589:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010758c:	52                   	push   %edx
8010758d:	e8 de ad ff ff       	call   80102370 <kfree>
80107592:	83 c4 10             	add    $0x10,%esp
80107595:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107598:	eb 9a                	jmp    80107534 <deallocuvm+0x74>
8010759a:	83 ec 0c             	sub    $0xc,%esp
8010759d:	68 00 cf 11 80       	push   $0x8011cf00
801075a2:	e8 19 d7 ff ff       	call   80104cc0 <release>
801075a7:	c7 04 24 7a 7d 10 80 	movl   $0x80107d7a,(%esp)
801075ae:	e8 bd 8d ff ff       	call   80100370 <panic>
801075b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801075b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801075c0 <allocuvm>:
801075c0:	55                   	push   %ebp
801075c1:	89 e5                	mov    %esp,%ebp
801075c3:	57                   	push   %edi
801075c4:	56                   	push   %esi
801075c5:	53                   	push   %ebx
801075c6:	83 ec 1c             	sub    $0x1c,%esp
801075c9:	8b 7d 10             	mov    0x10(%ebp),%edi
801075cc:	85 ff                	test   %edi,%edi
801075ce:	0f 88 bc 00 00 00    	js     80107690 <allocuvm+0xd0>
801075d4:	3b 7d 0c             	cmp    0xc(%ebp),%edi
801075d7:	0f 82 a3 00 00 00    	jb     80107680 <allocuvm+0xc0>
801075dd:	8b 45 0c             	mov    0xc(%ebp),%eax
801075e0:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801075e6:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801075ec:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801075ef:	0f 86 8e 00 00 00    	jbe    80107683 <allocuvm+0xc3>
801075f5:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801075f8:	8b 7d 08             	mov    0x8(%ebp),%edi
801075fb:	eb 42                	jmp    8010763f <allocuvm+0x7f>
801075fd:	8d 76 00             	lea    0x0(%esi),%esi
80107600:	83 ec 04             	sub    $0x4,%esp
80107603:	68 00 10 00 00       	push   $0x1000
80107608:	6a 00                	push   $0x0
8010760a:	50                   	push   %eax
8010760b:	e8 00 d7 ff ff       	call   80104d10 <memset>
80107610:	58                   	pop    %eax
80107611:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80107617:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010761c:	5a                   	pop    %edx
8010761d:	6a 06                	push   $0x6
8010761f:	50                   	push   %eax
80107620:	89 da                	mov    %ebx,%edx
80107622:	89 f8                	mov    %edi,%eax
80107624:	e8 87 fa ff ff       	call   801070b0 <mappages>
80107629:	83 c4 10             	add    $0x10,%esp
8010762c:	85 c0                	test   %eax,%eax
8010762e:	78 70                	js     801076a0 <allocuvm+0xe0>
80107630:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107636:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80107639:	0f 86 99 00 00 00    	jbe    801076d8 <allocuvm+0x118>
8010763f:	e8 dc ae ff ff       	call   80102520 <kalloc>
80107644:	85 c0                	test   %eax,%eax
80107646:	89 c6                	mov    %eax,%esi
80107648:	75 b6                	jne    80107600 <allocuvm+0x40>
8010764a:	83 ec 0c             	sub    $0xc,%esp
8010764d:	31 ff                	xor    %edi,%edi
8010764f:	68 fe 83 10 80       	push   $0x801083fe
80107654:	e8 e7 8f ff ff       	call   80100640 <cprintf>
80107659:	83 c4 0c             	add    $0xc,%esp
8010765c:	ff 75 0c             	pushl  0xc(%ebp)
8010765f:	ff 75 10             	pushl  0x10(%ebp)
80107662:	ff 75 08             	pushl  0x8(%ebp)
80107665:	e8 56 fe ff ff       	call   801074c0 <deallocuvm>
8010766a:	83 c4 10             	add    $0x10,%esp
8010766d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107670:	89 f8                	mov    %edi,%eax
80107672:	5b                   	pop    %ebx
80107673:	5e                   	pop    %esi
80107674:	5f                   	pop    %edi
80107675:	5d                   	pop    %ebp
80107676:	c3                   	ret    
80107677:	89 f6                	mov    %esi,%esi
80107679:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107680:	8b 7d 0c             	mov    0xc(%ebp),%edi
80107683:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107686:	89 f8                	mov    %edi,%eax
80107688:	5b                   	pop    %ebx
80107689:	5e                   	pop    %esi
8010768a:	5f                   	pop    %edi
8010768b:	5d                   	pop    %ebp
8010768c:	c3                   	ret    
8010768d:	8d 76 00             	lea    0x0(%esi),%esi
80107690:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107693:	31 ff                	xor    %edi,%edi
80107695:	89 f8                	mov    %edi,%eax
80107697:	5b                   	pop    %ebx
80107698:	5e                   	pop    %esi
80107699:	5f                   	pop    %edi
8010769a:	5d                   	pop    %ebp
8010769b:	c3                   	ret    
8010769c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801076a0:	83 ec 0c             	sub    $0xc,%esp
801076a3:	31 ff                	xor    %edi,%edi
801076a5:	68 16 84 10 80       	push   $0x80108416
801076aa:	e8 91 8f ff ff       	call   80100640 <cprintf>
801076af:	83 c4 0c             	add    $0xc,%esp
801076b2:	ff 75 0c             	pushl  0xc(%ebp)
801076b5:	ff 75 10             	pushl  0x10(%ebp)
801076b8:	ff 75 08             	pushl  0x8(%ebp)
801076bb:	e8 00 fe ff ff       	call   801074c0 <deallocuvm>
801076c0:	89 34 24             	mov    %esi,(%esp)
801076c3:	e8 a8 ac ff ff       	call   80102370 <kfree>
801076c8:	83 c4 10             	add    $0x10,%esp
801076cb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801076ce:	89 f8                	mov    %edi,%eax
801076d0:	5b                   	pop    %ebx
801076d1:	5e                   	pop    %esi
801076d2:	5f                   	pop    %edi
801076d3:	5d                   	pop    %ebp
801076d4:	c3                   	ret    
801076d5:	8d 76 00             	lea    0x0(%esi),%esi
801076d8:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801076db:	8d 65 f4             	lea    -0xc(%ebp),%esp
801076de:	5b                   	pop    %ebx
801076df:	89 f8                	mov    %edi,%eax
801076e1:	5e                   	pop    %esi
801076e2:	5f                   	pop    %edi
801076e3:	5d                   	pop    %ebp
801076e4:	c3                   	ret    
801076e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801076e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801076f0 <freevm>:
801076f0:	55                   	push   %ebp
801076f1:	89 e5                	mov    %esp,%ebp
801076f3:	57                   	push   %edi
801076f4:	56                   	push   %esi
801076f5:	53                   	push   %ebx
801076f6:	83 ec 0c             	sub    $0xc,%esp
801076f9:	8b 75 08             	mov    0x8(%ebp),%esi
801076fc:	85 f6                	test   %esi,%esi
801076fe:	74 79                	je     80107779 <freevm+0x89>
80107700:	83 ec 04             	sub    $0x4,%esp
80107703:	89 f3                	mov    %esi,%ebx
80107705:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
8010770b:	6a 00                	push   $0x0
8010770d:	68 00 00 00 80       	push   $0x80000000
80107712:	56                   	push   %esi
80107713:	e8 a8 fd ff ff       	call   801074c0 <deallocuvm>
80107718:	c7 04 24 00 cf 11 80 	movl   $0x8011cf00,(%esp)
8010771f:	e8 dc d3 ff ff       	call   80104b00 <acquire>
80107724:	83 c4 10             	add    $0x10,%esp
80107727:	eb 0e                	jmp    80107737 <freevm+0x47>
80107729:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107730:	83 c3 04             	add    $0x4,%ebx
80107733:	39 fb                	cmp    %edi,%ebx
80107735:	74 23                	je     8010775a <freevm+0x6a>
80107737:	8b 03                	mov    (%ebx),%eax
80107739:	a8 01                	test   $0x1,%al
8010773b:	74 f3                	je     80107730 <freevm+0x40>
8010773d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107742:	83 ec 0c             	sub    $0xc,%esp
80107745:	83 c3 04             	add    $0x4,%ebx
80107748:	05 00 00 00 80       	add    $0x80000000,%eax
8010774d:	50                   	push   %eax
8010774e:	e8 1d ac ff ff       	call   80102370 <kfree>
80107753:	83 c4 10             	add    $0x10,%esp
80107756:	39 fb                	cmp    %edi,%ebx
80107758:	75 dd                	jne    80107737 <freevm+0x47>
8010775a:	83 ec 0c             	sub    $0xc,%esp
8010775d:	56                   	push   %esi
8010775e:	e8 0d ac ff ff       	call   80102370 <kfree>
80107763:	c7 45 08 00 cf 11 80 	movl   $0x8011cf00,0x8(%ebp)
8010776a:	83 c4 10             	add    $0x10,%esp
8010776d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107770:	5b                   	pop    %ebx
80107771:	5e                   	pop    %esi
80107772:	5f                   	pop    %edi
80107773:	5d                   	pop    %ebp
80107774:	e9 47 d5 ff ff       	jmp    80104cc0 <release>
80107779:	83 ec 0c             	sub    $0xc,%esp
8010777c:	68 32 84 10 80       	push   $0x80108432
80107781:	e8 ea 8b ff ff       	call   80100370 <panic>
80107786:	8d 76 00             	lea    0x0(%esi),%esi
80107789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107790 <clearpteu>:
80107790:	55                   	push   %ebp
80107791:	31 c9                	xor    %ecx,%ecx
80107793:	89 e5                	mov    %esp,%ebp
80107795:	83 ec 08             	sub    $0x8,%esp
80107798:	8b 55 0c             	mov    0xc(%ebp),%edx
8010779b:	8b 45 08             	mov    0x8(%ebp),%eax
8010779e:	e8 7d f8 ff ff       	call   80107020 <walkpgdir>
801077a3:	85 c0                	test   %eax,%eax
801077a5:	74 05                	je     801077ac <clearpteu+0x1c>
801077a7:	83 20 fb             	andl   $0xfffffffb,(%eax)
801077aa:	c9                   	leave  
801077ab:	c3                   	ret    
801077ac:	83 ec 0c             	sub    $0xc,%esp
801077af:	68 43 84 10 80       	push   $0x80108443
801077b4:	e8 b7 8b ff ff       	call   80100370 <panic>
801077b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801077c0 <copyuvm>:
801077c0:	55                   	push   %ebp
801077c1:	89 e5                	mov    %esp,%ebp
801077c3:	57                   	push   %edi
801077c4:	56                   	push   %esi
801077c5:	53                   	push   %ebx
801077c6:	83 ec 1c             	sub    $0x1c,%esp
801077c9:	e8 62 fa ff ff       	call   80107230 <setupkvm>
801077ce:	85 c0                	test   %eax,%eax
801077d0:	89 45 e0             	mov    %eax,-0x20(%ebp)
801077d3:	0f 84 9f 00 00 00    	je     80107878 <copyuvm+0xb8>
801077d9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801077dc:	85 c9                	test   %ecx,%ecx
801077de:	0f 84 94 00 00 00    	je     80107878 <copyuvm+0xb8>
801077e4:	31 ff                	xor    %edi,%edi
801077e6:	eb 4a                	jmp    80107832 <copyuvm+0x72>
801077e8:	90                   	nop
801077e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801077f0:	83 ec 04             	sub    $0x4,%esp
801077f3:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
801077f9:	68 00 10 00 00       	push   $0x1000
801077fe:	53                   	push   %ebx
801077ff:	50                   	push   %eax
80107800:	e8 bb d5 ff ff       	call   80104dc0 <memmove>
80107805:	58                   	pop    %eax
80107806:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
8010780c:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107811:	5a                   	pop    %edx
80107812:	ff 75 e4             	pushl  -0x1c(%ebp)
80107815:	50                   	push   %eax
80107816:	89 fa                	mov    %edi,%edx
80107818:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010781b:	e8 90 f8 ff ff       	call   801070b0 <mappages>
80107820:	83 c4 10             	add    $0x10,%esp
80107823:	85 c0                	test   %eax,%eax
80107825:	78 61                	js     80107888 <copyuvm+0xc8>
80107827:	81 c7 00 10 00 00    	add    $0x1000,%edi
8010782d:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80107830:	76 46                	jbe    80107878 <copyuvm+0xb8>
80107832:	8b 45 08             	mov    0x8(%ebp),%eax
80107835:	31 c9                	xor    %ecx,%ecx
80107837:	89 fa                	mov    %edi,%edx
80107839:	e8 e2 f7 ff ff       	call   80107020 <walkpgdir>
8010783e:	85 c0                	test   %eax,%eax
80107840:	74 61                	je     801078a3 <copyuvm+0xe3>
80107842:	8b 00                	mov    (%eax),%eax
80107844:	a8 01                	test   $0x1,%al
80107846:	74 4e                	je     80107896 <copyuvm+0xd6>
80107848:	89 c3                	mov    %eax,%ebx
8010784a:	25 ff 0f 00 00       	and    $0xfff,%eax
8010784f:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80107855:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107858:	e8 c3 ac ff ff       	call   80102520 <kalloc>
8010785d:	85 c0                	test   %eax,%eax
8010785f:	89 c6                	mov    %eax,%esi
80107861:	75 8d                	jne    801077f0 <copyuvm+0x30>
80107863:	83 ec 0c             	sub    $0xc,%esp
80107866:	ff 75 e0             	pushl  -0x20(%ebp)
80107869:	e8 82 fe ff ff       	call   801076f0 <freevm>
8010786e:	83 c4 10             	add    $0x10,%esp
80107871:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80107878:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010787b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010787e:	5b                   	pop    %ebx
8010787f:	5e                   	pop    %esi
80107880:	5f                   	pop    %edi
80107881:	5d                   	pop    %ebp
80107882:	c3                   	ret    
80107883:	90                   	nop
80107884:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107888:	83 ec 0c             	sub    $0xc,%esp
8010788b:	56                   	push   %esi
8010788c:	e8 df aa ff ff       	call   80102370 <kfree>
80107891:	83 c4 10             	add    $0x10,%esp
80107894:	eb cd                	jmp    80107863 <copyuvm+0xa3>
80107896:	83 ec 0c             	sub    $0xc,%esp
80107899:	68 67 84 10 80       	push   $0x80108467
8010789e:	e8 cd 8a ff ff       	call   80100370 <panic>
801078a3:	83 ec 0c             	sub    $0xc,%esp
801078a6:	68 4d 84 10 80       	push   $0x8010844d
801078ab:	e8 c0 8a ff ff       	call   80100370 <panic>

801078b0 <uva2ka>:
801078b0:	55                   	push   %ebp
801078b1:	31 c9                	xor    %ecx,%ecx
801078b3:	89 e5                	mov    %esp,%ebp
801078b5:	83 ec 08             	sub    $0x8,%esp
801078b8:	8b 55 0c             	mov    0xc(%ebp),%edx
801078bb:	8b 45 08             	mov    0x8(%ebp),%eax
801078be:	e8 5d f7 ff ff       	call   80107020 <walkpgdir>
801078c3:	8b 00                	mov    (%eax),%eax
801078c5:	c9                   	leave  
801078c6:	89 c2                	mov    %eax,%edx
801078c8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801078cd:	83 e2 05             	and    $0x5,%edx
801078d0:	05 00 00 00 80       	add    $0x80000000,%eax
801078d5:	83 fa 05             	cmp    $0x5,%edx
801078d8:	ba 00 00 00 00       	mov    $0x0,%edx
801078dd:	0f 45 c2             	cmovne %edx,%eax
801078e0:	c3                   	ret    
801078e1:	eb 0d                	jmp    801078f0 <copyout>
801078e3:	90                   	nop
801078e4:	90                   	nop
801078e5:	90                   	nop
801078e6:	90                   	nop
801078e7:	90                   	nop
801078e8:	90                   	nop
801078e9:	90                   	nop
801078ea:	90                   	nop
801078eb:	90                   	nop
801078ec:	90                   	nop
801078ed:	90                   	nop
801078ee:	90                   	nop
801078ef:	90                   	nop

801078f0 <copyout>:
801078f0:	55                   	push   %ebp
801078f1:	89 e5                	mov    %esp,%ebp
801078f3:	57                   	push   %edi
801078f4:	56                   	push   %esi
801078f5:	53                   	push   %ebx
801078f6:	83 ec 1c             	sub    $0x1c,%esp
801078f9:	8b 5d 14             	mov    0x14(%ebp),%ebx
801078fc:	8b 55 0c             	mov    0xc(%ebp),%edx
801078ff:	8b 7d 10             	mov    0x10(%ebp),%edi
80107902:	85 db                	test   %ebx,%ebx
80107904:	75 40                	jne    80107946 <copyout+0x56>
80107906:	eb 70                	jmp    80107978 <copyout+0x88>
80107908:	90                   	nop
80107909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107910:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107913:	89 f1                	mov    %esi,%ecx
80107915:	29 d1                	sub    %edx,%ecx
80107917:	81 c1 00 10 00 00    	add    $0x1000,%ecx
8010791d:	39 d9                	cmp    %ebx,%ecx
8010791f:	0f 47 cb             	cmova  %ebx,%ecx
80107922:	29 f2                	sub    %esi,%edx
80107924:	83 ec 04             	sub    $0x4,%esp
80107927:	01 d0                	add    %edx,%eax
80107929:	51                   	push   %ecx
8010792a:	57                   	push   %edi
8010792b:	50                   	push   %eax
8010792c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010792f:	e8 8c d4 ff ff       	call   80104dc0 <memmove>
80107934:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107937:	83 c4 10             	add    $0x10,%esp
8010793a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
80107940:	01 cf                	add    %ecx,%edi
80107942:	29 cb                	sub    %ecx,%ebx
80107944:	74 32                	je     80107978 <copyout+0x88>
80107946:	89 d6                	mov    %edx,%esi
80107948:	83 ec 08             	sub    $0x8,%esp
8010794b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010794e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
80107954:	56                   	push   %esi
80107955:	ff 75 08             	pushl  0x8(%ebp)
80107958:	e8 53 ff ff ff       	call   801078b0 <uva2ka>
8010795d:	83 c4 10             	add    $0x10,%esp
80107960:	85 c0                	test   %eax,%eax
80107962:	75 ac                	jne    80107910 <copyout+0x20>
80107964:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107967:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010796c:	5b                   	pop    %ebx
8010796d:	5e                   	pop    %esi
8010796e:	5f                   	pop    %edi
8010796f:	5d                   	pop    %ebp
80107970:	c3                   	ret    
80107971:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107978:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010797b:	31 c0                	xor    %eax,%eax
8010797d:	5b                   	pop    %ebx
8010797e:	5e                   	pop    %esi
8010797f:	5f                   	pop    %edi
80107980:	5d                   	pop    %ebp
80107981:	c3                   	ret    
80107982:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107990 <pageFault>:
80107990:	55                   	push   %ebp
80107991:	89 e5                	mov    %esp,%ebp
80107993:	57                   	push   %edi
80107994:	56                   	push   %esi
80107995:	53                   	push   %ebx
80107996:	83 ec 1c             	sub    $0x1c,%esp
80107999:	0f 20 d3             	mov    %cr2,%ebx
8010799c:	85 db                	test   %ebx,%ebx
8010799e:	0f 84 bc 00 00 00    	je     80107a60 <pageFault+0xd0>
801079a4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801079aa:	31 c9                	xor    %ecx,%ecx
801079ac:	89 da                	mov    %ebx,%edx
801079ae:	8b 40 04             	mov    0x4(%eax),%eax
801079b1:	e8 6a f6 ff ff       	call   80107020 <walkpgdir>
801079b6:	85 c0                	test   %eax,%eax
801079b8:	89 c6                	mov    %eax,%esi
801079ba:	0f 84 28 01 00 00    	je     80107ae8 <pageFault+0x158>
801079c0:	8b 00                	mov    (%eax),%eax
801079c2:	a8 01                	test   $0x1,%al
801079c4:	0f 84 2b 01 00 00    	je     80107af5 <pageFault+0x165>
801079ca:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801079d1:	39 1a                	cmp    %ebx,(%edx)
801079d3:	77 0b                	ja     801079e0 <pageFault+0x50>
801079d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801079d8:	31 c0                	xor    %eax,%eax
801079da:	5b                   	pop    %ebx
801079db:	5e                   	pop    %esi
801079dc:	5f                   	pop    %edi
801079dd:	5d                   	pop    %ebp
801079de:	c3                   	ret    
801079df:	90                   	nop
801079e0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801079e5:	83 ec 0c             	sub    $0xc,%esp
801079e8:	89 c7                	mov    %eax,%edi
801079ea:	68 00 cf 11 80       	push   $0x8011cf00
801079ef:	89 c3                	mov    %eax,%ebx
801079f1:	c1 ef 0c             	shr    $0xc,%edi
801079f4:	e8 07 d1 ff ff       	call   80104b00 <acquire>
801079f9:	83 c4 10             	add    $0x10,%esp
801079fc:	80 bf 40 cf 11 80 00 	cmpb   $0x0,-0x7fee30c0(%edi)
80107a03:	0f 8f 87 00 00 00    	jg     80107a90 <pageFault+0x100>
80107a09:	0f 85 f3 00 00 00    	jne    80107b02 <pageFault+0x172>
80107a0f:	8b 16                	mov    (%esi),%edx
80107a11:	89 d1                	mov    %edx,%ecx
80107a13:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107a19:	81 e1 ff 0f 00 00    	and    $0xfff,%ecx
80107a1f:	89 c8                	mov    %ecx,%eax
80107a21:	c1 e8 07             	shr    $0x7,%eax
80107a24:	83 e0 02             	and    $0x2,%eax
80107a27:	09 c8                	or     %ecx,%eax
80107a29:	80 e4 fe             	and    $0xfe,%ah
80107a2c:	09 d0                	or     %edx,%eax
80107a2e:	89 06                	mov    %eax,(%esi)
80107a30:	83 ec 0c             	sub    $0xc,%esp
80107a33:	68 00 cf 11 80       	push   $0x8011cf00
80107a38:	e8 83 d2 ff ff       	call   80104cc0 <release>
80107a3d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80107a43:	8b 40 04             	mov    0x4(%eax),%eax
80107a46:	05 00 00 00 80       	add    $0x80000000,%eax
80107a4b:	0f 22 d8             	mov    %eax,%cr3
80107a4e:	83 c4 10             	add    $0x10,%esp
80107a51:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107a54:	b8 01 00 00 00       	mov    $0x1,%eax
80107a59:	5b                   	pop    %ebx
80107a5a:	5e                   	pop    %esi
80107a5b:	5f                   	pop    %edi
80107a5c:	5d                   	pop    %ebp
80107a5d:	c3                   	ret    
80107a5e:	66 90                	xchg   %ax,%ax
80107a60:	83 ec 0c             	sub    $0xc,%esp
80107a63:	68 f8 84 10 80       	push   $0x801084f8
80107a68:	e8 d3 8b ff ff       	call   80100640 <cprintf>
80107a6d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80107a73:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
80107a7a:	e8 c1 c4 ff ff       	call   80103f40 <exit>
80107a7f:	83 c4 10             	add    $0x10,%esp
80107a82:	e9 1d ff ff ff       	jmp    801079a4 <pageFault+0x14>
80107a87:	89 f6                	mov    %esi,%esi
80107a89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107a90:	e8 8b aa ff ff       	call   80102520 <kalloc>
80107a95:	85 c0                	test   %eax,%eax
80107a97:	89 c2                	mov    %eax,%edx
80107a99:	0f 84 36 ff ff ff    	je     801079d5 <pageFault+0x45>
80107a9f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107aa5:	83 ec 04             	sub    $0x4,%esp
80107aa8:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80107aab:	68 00 10 00 00       	push   $0x1000
80107ab0:	50                   	push   %eax
80107ab1:	52                   	push   %edx
80107ab2:	e8 09 d3 ff ff       	call   80104dc0 <memmove>
80107ab7:	8b 0e                	mov    (%esi),%ecx
80107ab9:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107abc:	83 c4 10             	add    $0x10,%esp
80107abf:	81 e1 ff 0f 00 00    	and    $0xfff,%ecx
80107ac5:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80107acb:	89 c8                	mov    %ecx,%eax
80107acd:	c1 e8 07             	shr    $0x7,%eax
80107ad0:	83 e0 02             	and    $0x2,%eax
80107ad3:	09 c8                	or     %ecx,%eax
80107ad5:	80 e4 fe             	and    $0xfe,%ah
80107ad8:	09 c2                	or     %eax,%edx
80107ada:	89 16                	mov    %edx,(%esi)
80107adc:	80 af 40 cf 11 80 01 	subb   $0x1,-0x7fee30c0(%edi)
80107ae3:	e9 48 ff ff ff       	jmp    80107a30 <pageFault+0xa0>
80107ae8:	83 ec 0c             	sub    $0xc,%esp
80107aeb:	68 81 84 10 80       	push   $0x80108481
80107af0:	e8 7b 88 ff ff       	call   80100370 <panic>
80107af5:	83 ec 0c             	sub    $0xc,%esp
80107af8:	68 9d 84 10 80       	push   $0x8010849d
80107afd:	e8 6e 88 ff ff       	call   80100370 <panic>
80107b02:	83 ec 0c             	sub    $0xc,%esp
80107b05:	68 b9 84 10 80       	push   $0x801084b9
80107b0a:	e8 61 88 ff ff       	call   80100370 <panic>
