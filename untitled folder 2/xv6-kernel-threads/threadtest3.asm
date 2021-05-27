
_threadtest3:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return 0;
}
 
int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 14             	sub    $0x14,%esp
  uint *stack, *stack1, *stack2;
  int tid, tid1, tid2;
 
  stack = malloc(MAX_STACK_SIZE);
  14:	68 00 04 00 00       	push   $0x400
  19:	e8 12 08 00 00       	call   830 <malloc>
  memset(stack, 0, sizeof(*stack));
  1e:	83 c4 0c             	add    $0xc,%esp
  stack = malloc(MAX_STACK_SIZE);
  21:	89 c3                	mov    %eax,%ebx
  memset(stack, 0, sizeof(*stack));
  23:	6a 04                	push   $0x4
  25:	6a 00                	push   $0x0
  27:	50                   	push   %eax
  28:	e8 73 02 00 00       	call   2a0 <memset>
  if ((tid = (kthread_create(printme, stack, MAX_STACK_SIZE))) < 0) {
  2d:	83 c4 0c             	add    $0xc,%esp
  30:	68 00 04 00 00       	push   $0x400
  35:	53                   	push   %ebx
  36:	68 c0 01 00 00       	push   $0x1c0
  3b:	e8 a2 04 00 00       	call   4e2 <kthread_create>
  40:	83 c4 10             	add    $0x10,%esp
  43:	85 c0                	test   %eax,%eax
  45:	89 c7                	mov    %eax,%edi
  47:	0f 88 ed 00 00 00    	js     13a <main+0x13a>
    printf(2, "thread_create error\n");
  }
  stack1  = malloc(MAX_STACK_SIZE);
  4d:	83 ec 0c             	sub    $0xc,%esp
  50:	68 00 04 00 00       	push   $0x400
  55:	e8 d6 07 00 00       	call   830 <malloc>
  memset(stack1, 0, sizeof(*stack1));
  5a:	83 c4 0c             	add    $0xc,%esp
  stack1  = malloc(MAX_STACK_SIZE);
  5d:	89 c3                	mov    %eax,%ebx
  memset(stack1, 0, sizeof(*stack1));
  5f:	6a 04                	push   $0x4
  61:	6a 00                	push   $0x0
  63:	50                   	push   %eax
  64:	e8 37 02 00 00       	call   2a0 <memset>
  if ((tid1 = (kthread_create(printme, stack1, MAX_STACK_SIZE))) < 0) {
  69:	83 c4 0c             	add    $0xc,%esp
  6c:	68 00 04 00 00       	push   $0x400
  71:	53                   	push   %ebx
  72:	68 c0 01 00 00       	push   $0x1c0
  77:	e8 66 04 00 00       	call   4e2 <kthread_create>
  7c:	83 c4 10             	add    $0x10,%esp
  7f:	85 c0                	test   %eax,%eax
  81:	89 c6                	mov    %eax,%esi
  83:	0f 88 19 01 00 00    	js     1a2 <main+0x1a2>
    printf(2, "thread_create error\n");
  }
  stack2  = malloc(MAX_STACK_SIZE);
  89:	83 ec 0c             	sub    $0xc,%esp
  8c:	68 00 04 00 00       	push   $0x400
  91:	e8 9a 07 00 00       	call   830 <malloc>
  memset(stack2, 0, sizeof(*stack2));
  96:	83 c4 0c             	add    $0xc,%esp
  stack2  = malloc(MAX_STACK_SIZE);
  99:	89 c3                	mov    %eax,%ebx
  memset(stack2, 0, sizeof(*stack2));
  9b:	6a 04                	push   $0x4
  9d:	6a 00                	push   $0x0
  9f:	50                   	push   %eax
  a0:	e8 fb 01 00 00       	call   2a0 <memset>
  if ((tid2 = (kthread_create(printme, stack2, MAX_STACK_SIZE))) < 0) {
  a5:	83 c4 0c             	add    $0xc,%esp
  a8:	68 00 04 00 00       	push   $0x400
  ad:	53                   	push   %ebx
  ae:	68 c0 01 00 00       	push   $0x1c0
  b3:	e8 2a 04 00 00       	call   4e2 <kthread_create>
  b8:	83 c4 10             	add    $0x10,%esp
  bb:	85 c0                	test   %eax,%eax
  bd:	89 c3                	mov    %eax,%ebx
  bf:	0f 88 c7 00 00 00    	js     18c <main+0x18c>
    printf(2, "thread_create error\n");
  }
  printf(1, "Joining %d\n", tid);
  c5:	83 ec 04             	sub    $0x4,%esp
  c8:	57                   	push   %edi
  c9:	68 52 09 00 00       	push   $0x952
  ce:	6a 01                	push   $0x1
  d0:	e8 fb 04 00 00       	call   5d0 <printf>
  if (kthread_join(tid) < 0) {
  d5:	89 3c 24             	mov    %edi,(%esp)
  d8:	e8 1d 04 00 00       	call   4fa <kthread_join>
  dd:	83 c4 10             	add    $0x10,%esp
  e0:	85 c0                	test   %eax,%eax
  e2:	0f 88 8e 00 00 00    	js     176 <main+0x176>
    printf(2, "join error\n");
  }
 
  printf(1, "Joining %d\n", tid1);
  e8:	83 ec 04             	sub    $0x4,%esp
  eb:	56                   	push   %esi
  ec:	68 52 09 00 00       	push   $0x952
  f1:	6a 01                	push   $0x1
  f3:	e8 d8 04 00 00       	call   5d0 <printf>
  if (kthread_join(tid1) < 0) {
  f8:	89 34 24             	mov    %esi,(%esp)
  fb:	e8 fa 03 00 00       	call   4fa <kthread_join>
 100:	83 c4 10             	add    $0x10,%esp
 103:	85 c0                	test   %eax,%eax
 105:	78 5c                	js     163 <main+0x163>
    printf(2, "join error\n");
  }
 
 
  printf(1, "Joining %d\n", tid2);
 107:	83 ec 04             	sub    $0x4,%esp
 10a:	53                   	push   %ebx
 10b:	68 52 09 00 00       	push   $0x952
 110:	6a 01                	push   $0x1
 112:	e8 b9 04 00 00       	call   5d0 <printf>
  if (kthread_join(tid2) < 0) {
 117:	89 1c 24             	mov    %ebx,(%esp)
 11a:	e8 db 03 00 00       	call   4fa <kthread_join>
 11f:	83 c4 10             	add    $0x10,%esp
 122:	85 c0                	test   %eax,%eax
 124:	78 2a                	js     150 <main+0x150>
    printf(2, "join error\n");
  }
 
 
  printf(1, "\nAll threads done!\n");
 126:	83 ec 08             	sub    $0x8,%esp
 129:	68 6a 09 00 00       	push   $0x96a
 12e:	6a 01                	push   $0x1
 130:	e8 9b 04 00 00       	call   5d0 <printf>
 
  exit();
 135:	e8 08 03 00 00       	call   442 <exit>
    printf(2, "thread_create error\n");
 13a:	50                   	push   %eax
 13b:	50                   	push   %eax
 13c:	68 3d 09 00 00       	push   $0x93d
 141:	6a 02                	push   $0x2
 143:	e8 88 04 00 00       	call   5d0 <printf>
 148:	83 c4 10             	add    $0x10,%esp
 14b:	e9 fd fe ff ff       	jmp    4d <main+0x4d>
    printf(2, "join error\n");
 150:	50                   	push   %eax
 151:	50                   	push   %eax
 152:	68 5e 09 00 00       	push   $0x95e
 157:	6a 02                	push   $0x2
 159:	e8 72 04 00 00       	call   5d0 <printf>
 15e:	83 c4 10             	add    $0x10,%esp
 161:	eb c3                	jmp    126 <main+0x126>
    printf(2, "join error\n");
 163:	52                   	push   %edx
 164:	52                   	push   %edx
 165:	68 5e 09 00 00       	push   $0x95e
 16a:	6a 02                	push   $0x2
 16c:	e8 5f 04 00 00       	call   5d0 <printf>
 171:	83 c4 10             	add    $0x10,%esp
 174:	eb 91                	jmp    107 <main+0x107>
    printf(2, "join error\n");
 176:	51                   	push   %ecx
 177:	51                   	push   %ecx
 178:	68 5e 09 00 00       	push   $0x95e
 17d:	6a 02                	push   $0x2
 17f:	e8 4c 04 00 00       	call   5d0 <printf>
 184:	83 c4 10             	add    $0x10,%esp
 187:	e9 5c ff ff ff       	jmp    e8 <main+0xe8>
    printf(2, "thread_create error\n");
 18c:	50                   	push   %eax
 18d:	50                   	push   %eax
 18e:	68 3d 09 00 00       	push   $0x93d
 193:	6a 02                	push   $0x2
 195:	e8 36 04 00 00       	call   5d0 <printf>
 19a:	83 c4 10             	add    $0x10,%esp
 19d:	e9 23 ff ff ff       	jmp    c5 <main+0xc5>
    printf(2, "thread_create error\n");
 1a2:	50                   	push   %eax
 1a3:	50                   	push   %eax
 1a4:	68 3d 09 00 00       	push   $0x93d
 1a9:	6a 02                	push   $0x2
 1ab:	e8 20 04 00 00       	call   5d0 <printf>
 1b0:	83 c4 10             	add    $0x10,%esp
 1b3:	e9 d1 fe ff ff       	jmp    89 <main+0x89>
 1b8:	66 90                	xchg   %ax,%ax
 1ba:	66 90                	xchg   %ax,%ax
 1bc:	66 90                	xchg   %ax,%ax
 1be:	66 90                	xchg   %ax,%ax

000001c0 <printme>:
void* printme() {
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	83 ec 08             	sub    $0x8,%esp
  printf(1,"Thread %d running !\n", kthread_id());
 1c6:	e8 1f 03 00 00       	call   4ea <kthread_id>
 1cb:	83 ec 04             	sub    $0x4,%esp
 1ce:	50                   	push   %eax
 1cf:	68 28 09 00 00       	push   $0x928
 1d4:	6a 01                	push   $0x1
 1d6:	e8 f5 03 00 00       	call   5d0 <printf>
  kthread_exit();
 1db:	e8 12 03 00 00       	call   4f2 <kthread_exit>
}
 1e0:	31 c0                	xor    %eax,%eax
 1e2:	c9                   	leave  
 1e3:	c3                   	ret    
 1e4:	66 90                	xchg   %ax,%ax
 1e6:	66 90                	xchg   %ax,%ax
 1e8:	66 90                	xchg   %ax,%ax
 1ea:	66 90                	xchg   %ax,%ax
 1ec:	66 90                	xchg   %ax,%ax
 1ee:	66 90                	xchg   %ax,%ax

000001f0 <strcpy>:
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	53                   	push   %ebx
 1f4:	8b 45 08             	mov    0x8(%ebp),%eax
 1f7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 1fa:	89 c2                	mov    %eax,%edx
 1fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 200:	83 c1 01             	add    $0x1,%ecx
 203:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 207:	83 c2 01             	add    $0x1,%edx
 20a:	84 db                	test   %bl,%bl
 20c:	88 5a ff             	mov    %bl,-0x1(%edx)
 20f:	75 ef                	jne    200 <strcpy+0x10>
 211:	5b                   	pop    %ebx
 212:	5d                   	pop    %ebp
 213:	c3                   	ret    
 214:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 21a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000220 <strcmp>:
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	53                   	push   %ebx
 224:	8b 55 08             	mov    0x8(%ebp),%edx
 227:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 22a:	0f b6 02             	movzbl (%edx),%eax
 22d:	0f b6 19             	movzbl (%ecx),%ebx
 230:	84 c0                	test   %al,%al
 232:	75 1c                	jne    250 <strcmp+0x30>
 234:	eb 2a                	jmp    260 <strcmp+0x40>
 236:	8d 76 00             	lea    0x0(%esi),%esi
 239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 240:	83 c2 01             	add    $0x1,%edx
 243:	0f b6 02             	movzbl (%edx),%eax
 246:	83 c1 01             	add    $0x1,%ecx
 249:	0f b6 19             	movzbl (%ecx),%ebx
 24c:	84 c0                	test   %al,%al
 24e:	74 10                	je     260 <strcmp+0x40>
 250:	38 d8                	cmp    %bl,%al
 252:	74 ec                	je     240 <strcmp+0x20>
 254:	29 d8                	sub    %ebx,%eax
 256:	5b                   	pop    %ebx
 257:	5d                   	pop    %ebp
 258:	c3                   	ret    
 259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 260:	31 c0                	xor    %eax,%eax
 262:	29 d8                	sub    %ebx,%eax
 264:	5b                   	pop    %ebx
 265:	5d                   	pop    %ebp
 266:	c3                   	ret    
 267:	89 f6                	mov    %esi,%esi
 269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000270 <strlen>:
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	8b 4d 08             	mov    0x8(%ebp),%ecx
 276:	80 39 00             	cmpb   $0x0,(%ecx)
 279:	74 15                	je     290 <strlen+0x20>
 27b:	31 d2                	xor    %edx,%edx
 27d:	8d 76 00             	lea    0x0(%esi),%esi
 280:	83 c2 01             	add    $0x1,%edx
 283:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 287:	89 d0                	mov    %edx,%eax
 289:	75 f5                	jne    280 <strlen+0x10>
 28b:	5d                   	pop    %ebp
 28c:	c3                   	ret    
 28d:	8d 76 00             	lea    0x0(%esi),%esi
 290:	31 c0                	xor    %eax,%eax
 292:	5d                   	pop    %ebp
 293:	c3                   	ret    
 294:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 29a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000002a0 <memset>:
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	57                   	push   %edi
 2a4:	8b 55 08             	mov    0x8(%ebp),%edx
 2a7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 2aa:	8b 45 0c             	mov    0xc(%ebp),%eax
 2ad:	89 d7                	mov    %edx,%edi
 2af:	fc                   	cld    
 2b0:	f3 aa                	rep stos %al,%es:(%edi)
 2b2:	89 d0                	mov    %edx,%eax
 2b4:	5f                   	pop    %edi
 2b5:	5d                   	pop    %ebp
 2b6:	c3                   	ret    
 2b7:	89 f6                	mov    %esi,%esi
 2b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002c0 <strchr>:
 2c0:	55                   	push   %ebp
 2c1:	89 e5                	mov    %esp,%ebp
 2c3:	53                   	push   %ebx
 2c4:	8b 45 08             	mov    0x8(%ebp),%eax
 2c7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 2ca:	0f b6 10             	movzbl (%eax),%edx
 2cd:	84 d2                	test   %dl,%dl
 2cf:	74 1d                	je     2ee <strchr+0x2e>
 2d1:	38 d3                	cmp    %dl,%bl
 2d3:	89 d9                	mov    %ebx,%ecx
 2d5:	75 0d                	jne    2e4 <strchr+0x24>
 2d7:	eb 17                	jmp    2f0 <strchr+0x30>
 2d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2e0:	38 ca                	cmp    %cl,%dl
 2e2:	74 0c                	je     2f0 <strchr+0x30>
 2e4:	83 c0 01             	add    $0x1,%eax
 2e7:	0f b6 10             	movzbl (%eax),%edx
 2ea:	84 d2                	test   %dl,%dl
 2ec:	75 f2                	jne    2e0 <strchr+0x20>
 2ee:	31 c0                	xor    %eax,%eax
 2f0:	5b                   	pop    %ebx
 2f1:	5d                   	pop    %ebp
 2f2:	c3                   	ret    
 2f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000300 <gets>:
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	57                   	push   %edi
 304:	56                   	push   %esi
 305:	53                   	push   %ebx
 306:	31 f6                	xor    %esi,%esi
 308:	89 f3                	mov    %esi,%ebx
 30a:	83 ec 1c             	sub    $0x1c,%esp
 30d:	8b 7d 08             	mov    0x8(%ebp),%edi
 310:	eb 2f                	jmp    341 <gets+0x41>
 312:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 318:	8d 45 e7             	lea    -0x19(%ebp),%eax
 31b:	83 ec 04             	sub    $0x4,%esp
 31e:	6a 01                	push   $0x1
 320:	50                   	push   %eax
 321:	6a 00                	push   $0x0
 323:	e8 32 01 00 00       	call   45a <read>
 328:	83 c4 10             	add    $0x10,%esp
 32b:	85 c0                	test   %eax,%eax
 32d:	7e 1c                	jle    34b <gets+0x4b>
 32f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 333:	83 c7 01             	add    $0x1,%edi
 336:	88 47 ff             	mov    %al,-0x1(%edi)
 339:	3c 0a                	cmp    $0xa,%al
 33b:	74 23                	je     360 <gets+0x60>
 33d:	3c 0d                	cmp    $0xd,%al
 33f:	74 1f                	je     360 <gets+0x60>
 341:	83 c3 01             	add    $0x1,%ebx
 344:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 347:	89 fe                	mov    %edi,%esi
 349:	7c cd                	jl     318 <gets+0x18>
 34b:	89 f3                	mov    %esi,%ebx
 34d:	8b 45 08             	mov    0x8(%ebp),%eax
 350:	c6 03 00             	movb   $0x0,(%ebx)
 353:	8d 65 f4             	lea    -0xc(%ebp),%esp
 356:	5b                   	pop    %ebx
 357:	5e                   	pop    %esi
 358:	5f                   	pop    %edi
 359:	5d                   	pop    %ebp
 35a:	c3                   	ret    
 35b:	90                   	nop
 35c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 360:	8b 75 08             	mov    0x8(%ebp),%esi
 363:	8b 45 08             	mov    0x8(%ebp),%eax
 366:	01 de                	add    %ebx,%esi
 368:	89 f3                	mov    %esi,%ebx
 36a:	c6 03 00             	movb   $0x0,(%ebx)
 36d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 370:	5b                   	pop    %ebx
 371:	5e                   	pop    %esi
 372:	5f                   	pop    %edi
 373:	5d                   	pop    %ebp
 374:	c3                   	ret    
 375:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000380 <stat>:
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	56                   	push   %esi
 384:	53                   	push   %ebx
 385:	83 ec 08             	sub    $0x8,%esp
 388:	6a 00                	push   $0x0
 38a:	ff 75 08             	pushl  0x8(%ebp)
 38d:	e8 f0 00 00 00       	call   482 <open>
 392:	83 c4 10             	add    $0x10,%esp
 395:	85 c0                	test   %eax,%eax
 397:	78 27                	js     3c0 <stat+0x40>
 399:	83 ec 08             	sub    $0x8,%esp
 39c:	ff 75 0c             	pushl  0xc(%ebp)
 39f:	89 c3                	mov    %eax,%ebx
 3a1:	50                   	push   %eax
 3a2:	e8 f3 00 00 00       	call   49a <fstat>
 3a7:	89 1c 24             	mov    %ebx,(%esp)
 3aa:	89 c6                	mov    %eax,%esi
 3ac:	e8 b9 00 00 00       	call   46a <close>
 3b1:	83 c4 10             	add    $0x10,%esp
 3b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 3b7:	89 f0                	mov    %esi,%eax
 3b9:	5b                   	pop    %ebx
 3ba:	5e                   	pop    %esi
 3bb:	5d                   	pop    %ebp
 3bc:	c3                   	ret    
 3bd:	8d 76 00             	lea    0x0(%esi),%esi
 3c0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 3c5:	eb ed                	jmp    3b4 <stat+0x34>
 3c7:	89 f6                	mov    %esi,%esi
 3c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003d0 <atoi>:
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	53                   	push   %ebx
 3d4:	8b 4d 08             	mov    0x8(%ebp),%ecx
 3d7:	0f be 11             	movsbl (%ecx),%edx
 3da:	8d 42 d0             	lea    -0x30(%edx),%eax
 3dd:	3c 09                	cmp    $0x9,%al
 3df:	b8 00 00 00 00       	mov    $0x0,%eax
 3e4:	77 1f                	ja     405 <atoi+0x35>
 3e6:	8d 76 00             	lea    0x0(%esi),%esi
 3e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 3f0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 3f3:	83 c1 01             	add    $0x1,%ecx
 3f6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
 3fa:	0f be 11             	movsbl (%ecx),%edx
 3fd:	8d 5a d0             	lea    -0x30(%edx),%ebx
 400:	80 fb 09             	cmp    $0x9,%bl
 403:	76 eb                	jbe    3f0 <atoi+0x20>
 405:	5b                   	pop    %ebx
 406:	5d                   	pop    %ebp
 407:	c3                   	ret    
 408:	90                   	nop
 409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000410 <memmove>:
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	56                   	push   %esi
 414:	53                   	push   %ebx
 415:	8b 5d 10             	mov    0x10(%ebp),%ebx
 418:	8b 45 08             	mov    0x8(%ebp),%eax
 41b:	8b 75 0c             	mov    0xc(%ebp),%esi
 41e:	85 db                	test   %ebx,%ebx
 420:	7e 14                	jle    436 <memmove+0x26>
 422:	31 d2                	xor    %edx,%edx
 424:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 428:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 42c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 42f:	83 c2 01             	add    $0x1,%edx
 432:	39 d3                	cmp    %edx,%ebx
 434:	75 f2                	jne    428 <memmove+0x18>
 436:	5b                   	pop    %ebx
 437:	5e                   	pop    %esi
 438:	5d                   	pop    %ebp
 439:	c3                   	ret    

0000043a <fork>:
 43a:	b8 01 00 00 00       	mov    $0x1,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret    

00000442 <exit>:
 442:	b8 02 00 00 00       	mov    $0x2,%eax
 447:	cd 40                	int    $0x40
 449:	c3                   	ret    

0000044a <wait>:
 44a:	b8 03 00 00 00       	mov    $0x3,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret    

00000452 <pipe>:
 452:	b8 04 00 00 00       	mov    $0x4,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret    

0000045a <read>:
 45a:	b8 05 00 00 00       	mov    $0x5,%eax
 45f:	cd 40                	int    $0x40
 461:	c3                   	ret    

00000462 <write>:
 462:	b8 10 00 00 00       	mov    $0x10,%eax
 467:	cd 40                	int    $0x40
 469:	c3                   	ret    

0000046a <close>:
 46a:	b8 15 00 00 00       	mov    $0x15,%eax
 46f:	cd 40                	int    $0x40
 471:	c3                   	ret    

00000472 <kill>:
 472:	b8 06 00 00 00       	mov    $0x6,%eax
 477:	cd 40                	int    $0x40
 479:	c3                   	ret    

0000047a <exec>:
 47a:	b8 07 00 00 00       	mov    $0x7,%eax
 47f:	cd 40                	int    $0x40
 481:	c3                   	ret    

00000482 <open>:
 482:	b8 0f 00 00 00       	mov    $0xf,%eax
 487:	cd 40                	int    $0x40
 489:	c3                   	ret    

0000048a <mknod>:
 48a:	b8 11 00 00 00       	mov    $0x11,%eax
 48f:	cd 40                	int    $0x40
 491:	c3                   	ret    

00000492 <unlink>:
 492:	b8 12 00 00 00       	mov    $0x12,%eax
 497:	cd 40                	int    $0x40
 499:	c3                   	ret    

0000049a <fstat>:
 49a:	b8 08 00 00 00       	mov    $0x8,%eax
 49f:	cd 40                	int    $0x40
 4a1:	c3                   	ret    

000004a2 <link>:
 4a2:	b8 13 00 00 00       	mov    $0x13,%eax
 4a7:	cd 40                	int    $0x40
 4a9:	c3                   	ret    

000004aa <mkdir>:
 4aa:	b8 14 00 00 00       	mov    $0x14,%eax
 4af:	cd 40                	int    $0x40
 4b1:	c3                   	ret    

000004b2 <chdir>:
 4b2:	b8 09 00 00 00       	mov    $0x9,%eax
 4b7:	cd 40                	int    $0x40
 4b9:	c3                   	ret    

000004ba <dup>:
 4ba:	b8 0a 00 00 00       	mov    $0xa,%eax
 4bf:	cd 40                	int    $0x40
 4c1:	c3                   	ret    

000004c2 <getpid>:
 4c2:	b8 0b 00 00 00       	mov    $0xb,%eax
 4c7:	cd 40                	int    $0x40
 4c9:	c3                   	ret    

000004ca <sbrk>:
 4ca:	b8 0c 00 00 00       	mov    $0xc,%eax
 4cf:	cd 40                	int    $0x40
 4d1:	c3                   	ret    

000004d2 <sleep>:
 4d2:	b8 0d 00 00 00       	mov    $0xd,%eax
 4d7:	cd 40                	int    $0x40
 4d9:	c3                   	ret    

000004da <uptime>:
 4da:	b8 0e 00 00 00       	mov    $0xe,%eax
 4df:	cd 40                	int    $0x40
 4e1:	c3                   	ret    

000004e2 <kthread_create>:
 4e2:	b8 16 00 00 00       	mov    $0x16,%eax
 4e7:	cd 40                	int    $0x40
 4e9:	c3                   	ret    

000004ea <kthread_id>:
 4ea:	b8 17 00 00 00       	mov    $0x17,%eax
 4ef:	cd 40                	int    $0x40
 4f1:	c3                   	ret    

000004f2 <kthread_exit>:
 4f2:	b8 18 00 00 00       	mov    $0x18,%eax
 4f7:	cd 40                	int    $0x40
 4f9:	c3                   	ret    

000004fa <kthread_join>:
 4fa:	b8 19 00 00 00       	mov    $0x19,%eax
 4ff:	cd 40                	int    $0x40
 501:	c3                   	ret    

00000502 <kthread_mutex_alloc>:
 502:	b8 1a 00 00 00       	mov    $0x1a,%eax
 507:	cd 40                	int    $0x40
 509:	c3                   	ret    

0000050a <kthread_mutex_dealloc>:
 50a:	b8 1b 00 00 00       	mov    $0x1b,%eax
 50f:	cd 40                	int    $0x40
 511:	c3                   	ret    

00000512 <kthread_mutex_lock>:
 512:	b8 1c 00 00 00       	mov    $0x1c,%eax
 517:	cd 40                	int    $0x40
 519:	c3                   	ret    

0000051a <kthread_mutex_unlock>:
 51a:	b8 1d 00 00 00       	mov    $0x1d,%eax
 51f:	cd 40                	int    $0x40
 521:	c3                   	ret    

00000522 <procdump>:
 522:	b8 1e 00 00 00       	mov    $0x1e,%eax
 527:	cd 40                	int    $0x40
 529:	c3                   	ret    
 52a:	66 90                	xchg   %ax,%ax
 52c:	66 90                	xchg   %ax,%ax
 52e:	66 90                	xchg   %ax,%ax

00000530 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 530:	55                   	push   %ebp
 531:	89 e5                	mov    %esp,%ebp
 533:	57                   	push   %edi
 534:	56                   	push   %esi
 535:	53                   	push   %ebx
 536:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 539:	85 d2                	test   %edx,%edx
{
 53b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 53e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 540:	79 76                	jns    5b8 <printint+0x88>
 542:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 546:	74 70                	je     5b8 <printint+0x88>
    x = -xx;
 548:	f7 d8                	neg    %eax
    neg = 1;
 54a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 551:	31 f6                	xor    %esi,%esi
 553:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 556:	eb 0a                	jmp    562 <printint+0x32>
 558:	90                   	nop
 559:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 560:	89 fe                	mov    %edi,%esi
 562:	31 d2                	xor    %edx,%edx
 564:	8d 7e 01             	lea    0x1(%esi),%edi
 567:	f7 f1                	div    %ecx
 569:	0f b6 92 88 09 00 00 	movzbl 0x988(%edx),%edx
  }while((x /= base) != 0);
 570:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 572:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 575:	75 e9                	jne    560 <printint+0x30>
  if(neg)
 577:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 57a:	85 c0                	test   %eax,%eax
 57c:	74 08                	je     586 <printint+0x56>
    buf[i++] = '-';
 57e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 583:	8d 7e 02             	lea    0x2(%esi),%edi
 586:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 58a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 58d:	8d 76 00             	lea    0x0(%esi),%esi
 590:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 593:	83 ec 04             	sub    $0x4,%esp
 596:	83 ee 01             	sub    $0x1,%esi
 599:	6a 01                	push   $0x1
 59b:	53                   	push   %ebx
 59c:	57                   	push   %edi
 59d:	88 45 d7             	mov    %al,-0x29(%ebp)
 5a0:	e8 bd fe ff ff       	call   462 <write>

  while(--i >= 0)
 5a5:	83 c4 10             	add    $0x10,%esp
 5a8:	39 de                	cmp    %ebx,%esi
 5aa:	75 e4                	jne    590 <printint+0x60>
    putc(fd, buf[i]);
}
 5ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5af:	5b                   	pop    %ebx
 5b0:	5e                   	pop    %esi
 5b1:	5f                   	pop    %edi
 5b2:	5d                   	pop    %ebp
 5b3:	c3                   	ret    
 5b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 5b8:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 5bf:	eb 90                	jmp    551 <printint+0x21>
 5c1:	eb 0d                	jmp    5d0 <printf>
 5c3:	90                   	nop
 5c4:	90                   	nop
 5c5:	90                   	nop
 5c6:	90                   	nop
 5c7:	90                   	nop
 5c8:	90                   	nop
 5c9:	90                   	nop
 5ca:	90                   	nop
 5cb:	90                   	nop
 5cc:	90                   	nop
 5cd:	90                   	nop
 5ce:	90                   	nop
 5cf:	90                   	nop

000005d0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5d0:	55                   	push   %ebp
 5d1:	89 e5                	mov    %esp,%ebp
 5d3:	57                   	push   %edi
 5d4:	56                   	push   %esi
 5d5:	53                   	push   %ebx
 5d6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5d9:	8b 75 0c             	mov    0xc(%ebp),%esi
 5dc:	0f b6 1e             	movzbl (%esi),%ebx
 5df:	84 db                	test   %bl,%bl
 5e1:	0f 84 b3 00 00 00    	je     69a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 5e7:	8d 45 10             	lea    0x10(%ebp),%eax
 5ea:	83 c6 01             	add    $0x1,%esi
  state = 0;
 5ed:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 5ef:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 5f2:	eb 2f                	jmp    623 <printf+0x53>
 5f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 5f8:	83 f8 25             	cmp    $0x25,%eax
 5fb:	0f 84 a7 00 00 00    	je     6a8 <printf+0xd8>
  write(fd, &c, 1);
 601:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 604:	83 ec 04             	sub    $0x4,%esp
 607:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 60a:	6a 01                	push   $0x1
 60c:	50                   	push   %eax
 60d:	ff 75 08             	pushl  0x8(%ebp)
 610:	e8 4d fe ff ff       	call   462 <write>
 615:	83 c4 10             	add    $0x10,%esp
 618:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 61b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 61f:	84 db                	test   %bl,%bl
 621:	74 77                	je     69a <printf+0xca>
    if(state == 0){
 623:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 625:	0f be cb             	movsbl %bl,%ecx
 628:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 62b:	74 cb                	je     5f8 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 62d:	83 ff 25             	cmp    $0x25,%edi
 630:	75 e6                	jne    618 <printf+0x48>
      if(c == 'd'){
 632:	83 f8 64             	cmp    $0x64,%eax
 635:	0f 84 05 01 00 00    	je     740 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 63b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 641:	83 f9 70             	cmp    $0x70,%ecx
 644:	74 72                	je     6b8 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 646:	83 f8 73             	cmp    $0x73,%eax
 649:	0f 84 99 00 00 00    	je     6e8 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 64f:	83 f8 63             	cmp    $0x63,%eax
 652:	0f 84 08 01 00 00    	je     760 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 658:	83 f8 25             	cmp    $0x25,%eax
 65b:	0f 84 ef 00 00 00    	je     750 <printf+0x180>
  write(fd, &c, 1);
 661:	8d 45 e7             	lea    -0x19(%ebp),%eax
 664:	83 ec 04             	sub    $0x4,%esp
 667:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 66b:	6a 01                	push   $0x1
 66d:	50                   	push   %eax
 66e:	ff 75 08             	pushl  0x8(%ebp)
 671:	e8 ec fd ff ff       	call   462 <write>
 676:	83 c4 0c             	add    $0xc,%esp
 679:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 67c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 67f:	6a 01                	push   $0x1
 681:	50                   	push   %eax
 682:	ff 75 08             	pushl  0x8(%ebp)
 685:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 688:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 68a:	e8 d3 fd ff ff       	call   462 <write>
  for(i = 0; fmt[i]; i++){
 68f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 693:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 696:	84 db                	test   %bl,%bl
 698:	75 89                	jne    623 <printf+0x53>
    }
  }
}
 69a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 69d:	5b                   	pop    %ebx
 69e:	5e                   	pop    %esi
 69f:	5f                   	pop    %edi
 6a0:	5d                   	pop    %ebp
 6a1:	c3                   	ret    
 6a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 6a8:	bf 25 00 00 00       	mov    $0x25,%edi
 6ad:	e9 66 ff ff ff       	jmp    618 <printf+0x48>
 6b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 6b8:	83 ec 0c             	sub    $0xc,%esp
 6bb:	b9 10 00 00 00       	mov    $0x10,%ecx
 6c0:	6a 00                	push   $0x0
 6c2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 6c5:	8b 45 08             	mov    0x8(%ebp),%eax
 6c8:	8b 17                	mov    (%edi),%edx
 6ca:	e8 61 fe ff ff       	call   530 <printint>
        ap++;
 6cf:	89 f8                	mov    %edi,%eax
 6d1:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6d4:	31 ff                	xor    %edi,%edi
        ap++;
 6d6:	83 c0 04             	add    $0x4,%eax
 6d9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 6dc:	e9 37 ff ff ff       	jmp    618 <printf+0x48>
 6e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 6e8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 6eb:	8b 08                	mov    (%eax),%ecx
        ap++;
 6ed:	83 c0 04             	add    $0x4,%eax
 6f0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 6f3:	85 c9                	test   %ecx,%ecx
 6f5:	0f 84 8e 00 00 00    	je     789 <printf+0x1b9>
        while(*s != 0){
 6fb:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 6fe:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 700:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 702:	84 c0                	test   %al,%al
 704:	0f 84 0e ff ff ff    	je     618 <printf+0x48>
 70a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 70d:	89 de                	mov    %ebx,%esi
 70f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 712:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 715:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 718:	83 ec 04             	sub    $0x4,%esp
          s++;
 71b:	83 c6 01             	add    $0x1,%esi
 71e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 721:	6a 01                	push   $0x1
 723:	57                   	push   %edi
 724:	53                   	push   %ebx
 725:	e8 38 fd ff ff       	call   462 <write>
        while(*s != 0){
 72a:	0f b6 06             	movzbl (%esi),%eax
 72d:	83 c4 10             	add    $0x10,%esp
 730:	84 c0                	test   %al,%al
 732:	75 e4                	jne    718 <printf+0x148>
 734:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 737:	31 ff                	xor    %edi,%edi
 739:	e9 da fe ff ff       	jmp    618 <printf+0x48>
 73e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 740:	83 ec 0c             	sub    $0xc,%esp
 743:	b9 0a 00 00 00       	mov    $0xa,%ecx
 748:	6a 01                	push   $0x1
 74a:	e9 73 ff ff ff       	jmp    6c2 <printf+0xf2>
 74f:	90                   	nop
  write(fd, &c, 1);
 750:	83 ec 04             	sub    $0x4,%esp
 753:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 756:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 759:	6a 01                	push   $0x1
 75b:	e9 21 ff ff ff       	jmp    681 <printf+0xb1>
        putc(fd, *ap);
 760:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 763:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 766:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 768:	6a 01                	push   $0x1
        ap++;
 76a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 76d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 770:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 773:	50                   	push   %eax
 774:	ff 75 08             	pushl  0x8(%ebp)
 777:	e8 e6 fc ff ff       	call   462 <write>
        ap++;
 77c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 77f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 782:	31 ff                	xor    %edi,%edi
 784:	e9 8f fe ff ff       	jmp    618 <printf+0x48>
          s = "(null)";
 789:	bb 7e 09 00 00       	mov    $0x97e,%ebx
        while(*s != 0){
 78e:	b8 28 00 00 00       	mov    $0x28,%eax
 793:	e9 72 ff ff ff       	jmp    70a <printf+0x13a>
 798:	66 90                	xchg   %ax,%ax
 79a:	66 90                	xchg   %ax,%ax
 79c:	66 90                	xchg   %ax,%ax
 79e:	66 90                	xchg   %ax,%ax

000007a0 <free>:
 7a0:	55                   	push   %ebp
 7a1:	a1 58 0c 00 00       	mov    0xc58,%eax
 7a6:	89 e5                	mov    %esp,%ebp
 7a8:	57                   	push   %edi
 7a9:	56                   	push   %esi
 7aa:	53                   	push   %ebx
 7ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
 7ae:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 7b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7b8:	39 c8                	cmp    %ecx,%eax
 7ba:	8b 10                	mov    (%eax),%edx
 7bc:	73 32                	jae    7f0 <free+0x50>
 7be:	39 d1                	cmp    %edx,%ecx
 7c0:	72 04                	jb     7c6 <free+0x26>
 7c2:	39 d0                	cmp    %edx,%eax
 7c4:	72 32                	jb     7f8 <free+0x58>
 7c6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 7c9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 7cc:	39 fa                	cmp    %edi,%edx
 7ce:	74 30                	je     800 <free+0x60>
 7d0:	89 53 f8             	mov    %edx,-0x8(%ebx)
 7d3:	8b 50 04             	mov    0x4(%eax),%edx
 7d6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7d9:	39 f1                	cmp    %esi,%ecx
 7db:	74 3a                	je     817 <free+0x77>
 7dd:	89 08                	mov    %ecx,(%eax)
 7df:	a3 58 0c 00 00       	mov    %eax,0xc58
 7e4:	5b                   	pop    %ebx
 7e5:	5e                   	pop    %esi
 7e6:	5f                   	pop    %edi
 7e7:	5d                   	pop    %ebp
 7e8:	c3                   	ret    
 7e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7f0:	39 d0                	cmp    %edx,%eax
 7f2:	72 04                	jb     7f8 <free+0x58>
 7f4:	39 d1                	cmp    %edx,%ecx
 7f6:	72 ce                	jb     7c6 <free+0x26>
 7f8:	89 d0                	mov    %edx,%eax
 7fa:	eb bc                	jmp    7b8 <free+0x18>
 7fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 800:	03 72 04             	add    0x4(%edx),%esi
 803:	89 73 fc             	mov    %esi,-0x4(%ebx)
 806:	8b 10                	mov    (%eax),%edx
 808:	8b 12                	mov    (%edx),%edx
 80a:	89 53 f8             	mov    %edx,-0x8(%ebx)
 80d:	8b 50 04             	mov    0x4(%eax),%edx
 810:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 813:	39 f1                	cmp    %esi,%ecx
 815:	75 c6                	jne    7dd <free+0x3d>
 817:	03 53 fc             	add    -0x4(%ebx),%edx
 81a:	a3 58 0c 00 00       	mov    %eax,0xc58
 81f:	89 50 04             	mov    %edx,0x4(%eax)
 822:	8b 53 f8             	mov    -0x8(%ebx),%edx
 825:	89 10                	mov    %edx,(%eax)
 827:	5b                   	pop    %ebx
 828:	5e                   	pop    %esi
 829:	5f                   	pop    %edi
 82a:	5d                   	pop    %ebp
 82b:	c3                   	ret    
 82c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000830 <malloc>:
 830:	55                   	push   %ebp
 831:	89 e5                	mov    %esp,%ebp
 833:	57                   	push   %edi
 834:	56                   	push   %esi
 835:	53                   	push   %ebx
 836:	83 ec 0c             	sub    $0xc,%esp
 839:	8b 45 08             	mov    0x8(%ebp),%eax
 83c:	8b 15 58 0c 00 00    	mov    0xc58,%edx
 842:	8d 78 07             	lea    0x7(%eax),%edi
 845:	c1 ef 03             	shr    $0x3,%edi
 848:	83 c7 01             	add    $0x1,%edi
 84b:	85 d2                	test   %edx,%edx
 84d:	0f 84 9d 00 00 00    	je     8f0 <malloc+0xc0>
 853:	8b 02                	mov    (%edx),%eax
 855:	8b 48 04             	mov    0x4(%eax),%ecx
 858:	39 cf                	cmp    %ecx,%edi
 85a:	76 6c                	jbe    8c8 <malloc+0x98>
 85c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 862:	bb 00 10 00 00       	mov    $0x1000,%ebx
 867:	0f 43 df             	cmovae %edi,%ebx
 86a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 871:	eb 0e                	jmp    881 <malloc+0x51>
 873:	90                   	nop
 874:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 878:	8b 02                	mov    (%edx),%eax
 87a:	8b 48 04             	mov    0x4(%eax),%ecx
 87d:	39 f9                	cmp    %edi,%ecx
 87f:	73 47                	jae    8c8 <malloc+0x98>
 881:	39 05 58 0c 00 00    	cmp    %eax,0xc58
 887:	89 c2                	mov    %eax,%edx
 889:	75 ed                	jne    878 <malloc+0x48>
 88b:	83 ec 0c             	sub    $0xc,%esp
 88e:	56                   	push   %esi
 88f:	e8 36 fc ff ff       	call   4ca <sbrk>
 894:	83 c4 10             	add    $0x10,%esp
 897:	83 f8 ff             	cmp    $0xffffffff,%eax
 89a:	74 1c                	je     8b8 <malloc+0x88>
 89c:	89 58 04             	mov    %ebx,0x4(%eax)
 89f:	83 ec 0c             	sub    $0xc,%esp
 8a2:	83 c0 08             	add    $0x8,%eax
 8a5:	50                   	push   %eax
 8a6:	e8 f5 fe ff ff       	call   7a0 <free>
 8ab:	8b 15 58 0c 00 00    	mov    0xc58,%edx
 8b1:	83 c4 10             	add    $0x10,%esp
 8b4:	85 d2                	test   %edx,%edx
 8b6:	75 c0                	jne    878 <malloc+0x48>
 8b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8bb:	31 c0                	xor    %eax,%eax
 8bd:	5b                   	pop    %ebx
 8be:	5e                   	pop    %esi
 8bf:	5f                   	pop    %edi
 8c0:	5d                   	pop    %ebp
 8c1:	c3                   	ret    
 8c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 8c8:	39 cf                	cmp    %ecx,%edi
 8ca:	74 54                	je     920 <malloc+0xf0>
 8cc:	29 f9                	sub    %edi,%ecx
 8ce:	89 48 04             	mov    %ecx,0x4(%eax)
 8d1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
 8d4:	89 78 04             	mov    %edi,0x4(%eax)
 8d7:	89 15 58 0c 00 00    	mov    %edx,0xc58
 8dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8e0:	83 c0 08             	add    $0x8,%eax
 8e3:	5b                   	pop    %ebx
 8e4:	5e                   	pop    %esi
 8e5:	5f                   	pop    %edi
 8e6:	5d                   	pop    %ebp
 8e7:	c3                   	ret    
 8e8:	90                   	nop
 8e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8f0:	c7 05 58 0c 00 00 5c 	movl   $0xc5c,0xc58
 8f7:	0c 00 00 
 8fa:	c7 05 5c 0c 00 00 5c 	movl   $0xc5c,0xc5c
 901:	0c 00 00 
 904:	b8 5c 0c 00 00       	mov    $0xc5c,%eax
 909:	c7 05 60 0c 00 00 00 	movl   $0x0,0xc60
 910:	00 00 00 
 913:	e9 44 ff ff ff       	jmp    85c <malloc+0x2c>
 918:	90                   	nop
 919:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 920:	8b 08                	mov    (%eax),%ecx
 922:	89 0a                	mov    %ecx,(%edx)
 924:	eb b1                	jmp    8d7 <malloc+0xa7>
