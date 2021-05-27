
_threadtest2:     file format elf32-i386


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
   d:	51                   	push   %ecx
   e:	81 ec 0c 0c 00 00    	sub    $0xc0c,%esp
  printf(stdout, "~~~~~~~~~~~~~~~~~~ thread test ~~~~~~~~~~~~~~~~~~\n");
  14:	68 dc 0c 00 00       	push   $0xcdc
  19:	ff 35 38 11 00 00    	pushl  0x1138
  1f:	e8 cc 07 00 00       	call   7f0 <printf>
  pid = getpid();
  24:	e8 b9 06 00 00       	call   6e2 <getpid>
  29:	a3 48 11 00 00       	mov    %eax,0x1148

  char stack1[MAX_STACK_SIZE];
  char stack2[MAX_STACK_SIZE];
  char stack3[MAX_STACK_SIZE];
  
  thread_ids[2] = kthread_create(third, stack3, MAX_STACK_SIZE);
  2e:	8d 85 f8 fb ff ff    	lea    -0x408(%ebp),%eax
  34:	83 c4 0c             	add    $0xc,%esp
  37:	68 00 04 00 00       	push   $0x400
  3c:	50                   	push   %eax
  3d:	68 30 03 00 00       	push   $0x330
  42:	e8 bb 06 00 00       	call   702 <kthread_create>
	if(!assumption)
  47:	83 c4 10             	add    $0x10,%esp
  4a:	85 c0                	test   %eax,%eax
  thread_ids[2] = kthread_create(third, stack3, MAX_STACK_SIZE);
  4c:	a3 34 11 00 00       	mov    %eax,0x1134
	if(!assumption)
  51:	0f 88 9a 01 00 00    	js     1f1 <main+0x1f1>
  ASSERT(thread_ids[2] >= 0, "failed to create thread 3");
  thread_ids[1] = kthread_create(second, stack2, MAX_STACK_SIZE);
  57:	8d 85 f8 f7 ff ff    	lea    -0x808(%ebp),%eax
  5d:	83 ec 04             	sub    $0x4,%esp
  60:	68 00 04 00 00       	push   $0x400
  65:	50                   	push   %eax
  66:	68 b0 02 00 00       	push   $0x2b0
  6b:	e8 92 06 00 00       	call   702 <kthread_create>
	if(!assumption)
  70:	83 c4 10             	add    $0x10,%esp
  73:	85 c0                	test   %eax,%eax
  thread_ids[1] = kthread_create(second, stack2, MAX_STACK_SIZE);
  75:	a3 30 11 00 00       	mov    %eax,0x1130
	if(!assumption)
  7a:	0f 88 5d 01 00 00    	js     1dd <main+0x1dd>
  ASSERT(thread_ids[1] >= 0, "failed to create thread 2");
  thread_ids[0] = kthread_create(first, stack1, MAX_STACK_SIZE);
  80:	8d 85 f8 f3 ff ff    	lea    -0xc08(%ebp),%eax
  86:	83 ec 04             	sub    $0x4,%esp
  89:	68 00 04 00 00       	push   $0x400
  8e:	50                   	push   %eax
  8f:	68 70 02 00 00       	push   $0x270
  94:	e8 69 06 00 00       	call   702 <kthread_create>
	if(!assumption)
  99:	83 c4 10             	add    $0x10,%esp
  9c:	85 c0                	test   %eax,%eax
  thread_ids[0] = kthread_create(first, stack1, MAX_STACK_SIZE);
  9e:	a3 2c 11 00 00       	mov    %eax,0x112c
	if(!assumption)
  a3:	0f 88 1b 01 00 00    	js     1c4 <main+0x1c4>
  ASSERT(thread_ids[0] >= 0, "failed to create thread 1");

  ASSERT(kthread_join(thread_ids[0]) >= 0, "failed to join thread 1");
  a9:	83 ec 0c             	sub    $0xc,%esp
  ac:	50                   	push   %eax
  ad:	e8 68 06 00 00       	call   71a <kthread_join>
	if(!assumption)
  b2:	83 c4 10             	add    $0x10,%esp
  b5:	85 c0                	test   %eax,%eax
  b7:	0f 88 f3 00 00 00    	js     1b0 <main+0x1b0>
  ASSERT(kthread_join(thread_ids[1]) >= 0, "failed to join thread 2");
  bd:	83 ec 0c             	sub    $0xc,%esp
  c0:	ff 35 30 11 00 00    	pushl  0x1130
  c6:	e8 4f 06 00 00       	call   71a <kthread_join>
	if(!assumption)
  cb:	83 c4 10             	add    $0x10,%esp
  ce:	85 c0                	test   %eax,%eax
  d0:	0f 88 c6 00 00 00    	js     19c <main+0x19c>
  ASSERT(kthread_join(thread_ids[2]) >= 0, "failed to join thread 3");
  d6:	83 ec 0c             	sub    $0xc,%esp
  d9:	ff 35 34 11 00 00    	pushl  0x1134
  df:	e8 36 06 00 00       	call   71a <kthread_join>
	if(!assumption)
  e4:	83 c4 10             	add    $0x10,%esp
  e7:	85 c0                	test   %eax,%eax
  e9:	0f 88 99 00 00 00    	js     188 <main+0x188>
  printf(stdout, "%s\n", "all threads exited");
  ef:	83 ec 04             	sub    $0x4,%esp
  f2:	68 44 0c 00 00       	push   $0xc44
  f7:	68 61 0b 00 00       	push   $0xb61
  fc:	ff 35 38 11 00 00    	pushl  0x1138
 102:	e8 e9 06 00 00       	call   7f0 <printf>
  //attempt to join myself
  ASSERT(kthread_join(kthread_id()) < 0, "joining calling thread returns success");
 107:	e8 fe 05 00 00       	call   70a <kthread_id>
 10c:	89 04 24             	mov    %eax,(%esp)
 10f:	e8 06 06 00 00       	call   71a <kthread_join>
	if(!assumption)
 114:	83 c4 10             	add    $0x10,%esp
 117:	85 c0                	test   %eax,%eax
 119:	78 0f                	js     12a <main+0x12a>
 11b:	ba 58 00 00 00       	mov    $0x58,%edx
 120:	b8 10 0d 00 00       	mov    $0xd10,%eax
 125:	e8 e6 00 00 00       	call   210 <assert.part.0>
  //attempt to join an invalid thread id
  ASSERT(kthread_join(-10) < 0, "joining invalid thread returns success");
 12a:	83 ec 0c             	sub    $0xc,%esp
 12d:	6a f6                	push   $0xfffffff6
 12f:	e8 e6 05 00 00       	call   71a <kthread_join>
	if(!assumption)
 134:	83 c4 10             	add    $0x10,%esp
 137:	85 c0                	test   %eax,%eax
 139:	78 0f                	js     14a <main+0x14a>
 13b:	ba 5a 00 00 00       	mov    $0x5a,%edx
 140:	b8 38 0d 00 00       	mov    $0xd38,%eax
 145:	e8 c6 00 00 00       	call   210 <assert.part.0>
  //attempt to join another process(init)'s thread
  ASSERT(kthread_join(1) < 0, "joining another process's thread returns success");
 14a:	83 ec 0c             	sub    $0xc,%esp
 14d:	6a 01                	push   $0x1
 14f:	e8 c6 05 00 00       	call   71a <kthread_join>
	if(!assumption)
 154:	83 c4 10             	add    $0x10,%esp
 157:	85 c0                	test   %eax,%eax
 159:	78 0f                	js     16a <main+0x16a>
 15b:	ba 5c 00 00 00       	mov    $0x5c,%edx
 160:	b8 60 0d 00 00       	mov    $0xd60,%eax
 165:	e8 a6 00 00 00       	call   210 <assert.part.0>
  
  kthread_exit();
 16a:	e8 a3 05 00 00       	call   712 <kthread_exit>
 16f:	b8 94 0d 00 00       	mov    $0xd94,%eax
 174:	ba 60 00 00 00       	mov    $0x60,%edx
 179:	e8 92 00 00 00       	call   210 <assert.part.0>

  ASSERT(0, "main thread continues to execute after exit");
 17e:	8b 4d fc             	mov    -0x4(%ebp),%ecx
 181:	31 c0                	xor    %eax,%eax
 183:	c9                   	leave  
 184:	8d 61 fc             	lea    -0x4(%ecx),%esp
 187:	c3                   	ret    
 188:	ba 55 00 00 00       	mov    $0x55,%edx
 18d:	b8 2c 0c 00 00       	mov    $0xc2c,%eax
 192:	e8 79 00 00 00       	call   210 <assert.part.0>
 197:	e9 53 ff ff ff       	jmp    ef <main+0xef>
 19c:	ba 54 00 00 00       	mov    $0x54,%edx
 1a1:	b8 b2 0b 00 00       	mov    $0xbb2,%eax
 1a6:	e8 65 00 00 00       	call   210 <assert.part.0>
 1ab:	e9 26 ff ff ff       	jmp    d6 <main+0xd6>
 1b0:	ba 53 00 00 00       	mov    $0x53,%edx
 1b5:	b8 86 0b 00 00       	mov    $0xb86,%eax
 1ba:	e8 51 00 00 00       	call   210 <assert.part.0>
 1bf:	e9 f9 fe ff ff       	jmp    bd <main+0xbd>
 1c4:	b8 12 0c 00 00       	mov    $0xc12,%eax
 1c9:	ba 51 00 00 00       	mov    $0x51,%edx
 1ce:	e8 3d 00 00 00       	call   210 <assert.part.0>
 1d3:	a1 2c 11 00 00       	mov    0x112c,%eax
 1d8:	e9 cc fe ff ff       	jmp    a9 <main+0xa9>
 1dd:	ba 4f 00 00 00       	mov    $0x4f,%edx
 1e2:	b8 f8 0b 00 00       	mov    $0xbf8,%eax
 1e7:	e8 24 00 00 00       	call   210 <assert.part.0>
 1ec:	e9 8f fe ff ff       	jmp    80 <main+0x80>
 1f1:	ba 4d 00 00 00       	mov    $0x4d,%edx
 1f6:	b8 de 0b 00 00       	mov    $0xbde,%eax
 1fb:	e8 10 00 00 00       	call   210 <assert.part.0>
 200:	e9 52 fe ff ff       	jmp    57 <main+0x57>
 205:	66 90                	xchg   %ax,%ax
 207:	66 90                	xchg   %ax,%ax
 209:	66 90                	xchg   %ax,%ax
 20b:	66 90                	xchg   %ax,%ax
 20d:	66 90                	xchg   %ax,%ax
 20f:	90                   	nop

00000210 <assert.part.0>:
assert(_Bool assumption, char* errMsg, int curLine)
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	53                   	push   %ebx
 214:	89 c3                	mov    %eax,%ebx
 216:	83 ec 04             	sub    $0x4,%esp
		printf(stdout, "at %s:%d, ", __FILE__, curLine);
 219:	52                   	push   %edx
 21a:	68 48 0b 00 00       	push   $0xb48
 21f:	68 56 0b 00 00       	push   $0xb56
 224:	ff 35 38 11 00 00    	pushl  0x1138
 22a:	e8 c1 05 00 00       	call   7f0 <printf>
		printf(stdout, "%s\n", errMsg);
 22f:	83 c4 0c             	add    $0xc,%esp
 232:	53                   	push   %ebx
 233:	68 61 0b 00 00       	push   $0xb61
 238:	ff 35 38 11 00 00    	pushl  0x1138
 23e:	e8 ad 05 00 00       	call   7f0 <printf>
		printf(stdout, "test failed\n");
 243:	58                   	pop    %eax
 244:	5a                   	pop    %edx
 245:	68 65 0b 00 00       	push   $0xb65
 24a:	ff 35 38 11 00 00    	pushl  0x1138
 250:	e8 9b 05 00 00       	call   7f0 <printf>
		kill(pid);
 255:	59                   	pop    %ecx
 256:	ff 35 48 11 00 00    	pushl  0x1148
 25c:	e8 31 04 00 00       	call   692 <kill>
 261:	83 c4 10             	add    $0x10,%esp
}
 264:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 267:	c9                   	leave  
 268:	c3                   	ret    
 269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000270 <first>:
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	83 ec 0c             	sub    $0xc,%esp
	printf(stdout, "%s\n", "thread 1 says hello");
 276:	68 72 0b 00 00       	push   $0xb72
 27b:	68 61 0b 00 00       	push   $0xb61
 280:	ff 35 38 11 00 00    	pushl  0x1138
 286:	e8 65 05 00 00       	call   7f0 <printf>
  sleep(2 * TIME_SLICE); //sleep for some scheduling rounds instead of immediately exiting so that others can join
 28b:	c7 04 24 14 00 00 00 	movl   $0x14,(%esp)
 292:	e8 5b 04 00 00       	call   6f2 <sleep>
	kthread_exit();
 297:	e8 76 04 00 00       	call   712 <kthread_exit>
 29c:	b8 58 0c 00 00       	mov    $0xc58,%eax
 2a1:	ba 21 00 00 00       	mov    $0x21,%edx
 2a6:	e8 65 ff ff ff       	call   210 <assert.part.0>
}
 2ab:	31 c0                	xor    %eax,%eax
 2ad:	c9                   	leave  
 2ae:	c3                   	ret    
 2af:	90                   	nop

000002b0 <second>:
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	83 ec 08             	sub    $0x8,%esp
	while(thread_ids[0]<0); //wait for the first thread to be created
 2b6:	a1 2c 11 00 00       	mov    0x112c,%eax
 2bb:	90                   	nop
 2bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2c0:	85 c0                	test   %eax,%eax
 2c2:	78 fc                	js     2c0 <second+0x10>
	ASSERT(kthread_join(thread_ids[0]) >= 0, "failed to join thread 1");
 2c4:	83 ec 0c             	sub    $0xc,%esp
 2c7:	50                   	push   %eax
 2c8:	e8 4d 04 00 00       	call   71a <kthread_join>
	if(!assumption)
 2cd:	83 c4 10             	add    $0x10,%esp
 2d0:	85 c0                	test   %eax,%eax
 2d2:	78 3c                	js     310 <second+0x60>
	printf(stdout, "%s\n", "thread 2 says hello");
 2d4:	83 ec 04             	sub    $0x4,%esp
 2d7:	68 9e 0b 00 00       	push   $0xb9e
 2dc:	68 61 0b 00 00       	push   $0xb61
 2e1:	ff 35 38 11 00 00    	pushl  0x1138
 2e7:	e8 04 05 00 00       	call   7f0 <printf>
  sleep(2 * TIME_SLICE); //sleep for some scheduling rounds instead of immediately exiting so that others can join
 2ec:	c7 04 24 14 00 00 00 	movl   $0x14,(%esp)
 2f3:	e8 fa 03 00 00       	call   6f2 <sleep>
	kthread_exit();
 2f8:	e8 15 04 00 00       	call   712 <kthread_exit>
 2fd:	b8 84 0c 00 00       	mov    $0xc84,%eax
 302:	ba 2f 00 00 00       	mov    $0x2f,%edx
 307:	e8 04 ff ff ff       	call   210 <assert.part.0>
}
 30c:	31 c0                	xor    %eax,%eax
 30e:	c9                   	leave  
 30f:	c3                   	ret    
 310:	ba 29 00 00 00       	mov    $0x29,%edx
 315:	b8 86 0b 00 00       	mov    $0xb86,%eax
 31a:	e8 f1 fe ff ff       	call   210 <assert.part.0>
 31f:	eb b3                	jmp    2d4 <second+0x24>
 321:	eb 0d                	jmp    330 <third>
 323:	90                   	nop
 324:	90                   	nop
 325:	90                   	nop
 326:	90                   	nop
 327:	90                   	nop
 328:	90                   	nop
 329:	90                   	nop
 32a:	90                   	nop
 32b:	90                   	nop
 32c:	90                   	nop
 32d:	90                   	nop
 32e:	90                   	nop
 32f:	90                   	nop

00000330 <third>:
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	83 ec 08             	sub    $0x8,%esp
	while(thread_ids[0]<0 && thread_ids[1]<0); //wait for the first two threads to be created
 336:	a1 2c 11 00 00       	mov    0x112c,%eax
 33b:	8b 15 30 11 00 00    	mov    0x1130,%edx
 341:	eb 09                	jmp    34c <third+0x1c>
 343:	90                   	nop
 344:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 348:	85 d2                	test   %edx,%edx
 34a:	79 04                	jns    350 <third+0x20>
 34c:	85 c0                	test   %eax,%eax
 34e:	78 f8                	js     348 <third+0x18>
	ASSERT(kthread_join(thread_ids[0]) >= 0, "failed to join thread 1");
 350:	83 ec 0c             	sub    $0xc,%esp
 353:	50                   	push   %eax
 354:	e8 c1 03 00 00       	call   71a <kthread_join>
	if(!assumption)
 359:	83 c4 10             	add    $0x10,%esp
 35c:	85 c0                	test   %eax,%eax
 35e:	78 70                	js     3d0 <third+0xa0>
	ASSERT(kthread_join(thread_ids[1]) >= 0, "failed to join thread 2");
 360:	83 ec 0c             	sub    $0xc,%esp
 363:	ff 35 30 11 00 00    	pushl  0x1130
 369:	e8 ac 03 00 00       	call   71a <kthread_join>
	if(!assumption)
 36e:	83 c4 10             	add    $0x10,%esp
 371:	85 c0                	test   %eax,%eax
 373:	78 43                	js     3b8 <third+0x88>
	printf(stdout, "%s\n", "thread 3 says hello");
 375:	83 ec 04             	sub    $0x4,%esp
 378:	68 ca 0b 00 00       	push   $0xbca
 37d:	68 61 0b 00 00       	push   $0xb61
 382:	ff 35 38 11 00 00    	pushl  0x1138
 388:	e8 63 04 00 00       	call   7f0 <printf>
  sleep(2 * TIME_SLICE); //sleep for some scheduling rounds instead of immediately exiting so that others can join
 38d:	c7 04 24 14 00 00 00 	movl   $0x14,(%esp)
 394:	e8 59 03 00 00       	call   6f2 <sleep>
	kthread_exit();
 399:	e8 74 03 00 00       	call   712 <kthread_exit>
 39e:	b8 b0 0c 00 00       	mov    $0xcb0,%eax
 3a3:	ba 3e 00 00 00       	mov    $0x3e,%edx
 3a8:	e8 63 fe ff ff       	call   210 <assert.part.0>
}
 3ad:	31 c0                	xor    %eax,%eax
 3af:	c9                   	leave  
 3b0:	c3                   	ret    
 3b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3b8:	ba 38 00 00 00       	mov    $0x38,%edx
 3bd:	b8 b2 0b 00 00       	mov    $0xbb2,%eax
 3c2:	e8 49 fe ff ff       	call   210 <assert.part.0>
 3c7:	eb ac                	jmp    375 <third+0x45>
 3c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3d0:	ba 37 00 00 00       	mov    $0x37,%edx
 3d5:	b8 86 0b 00 00       	mov    $0xb86,%eax
 3da:	e8 31 fe ff ff       	call   210 <assert.part.0>
 3df:	e9 7c ff ff ff       	jmp    360 <third+0x30>
 3e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000003f0 <assert>:
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
	if(!assumption)
 3f3:	80 7d 08 00          	cmpb   $0x0,0x8(%ebp)
{
 3f7:	8b 45 0c             	mov    0xc(%ebp),%eax
 3fa:	8b 55 10             	mov    0x10(%ebp),%edx
	if(!assumption)
 3fd:	74 09                	je     408 <assert+0x18>
}
 3ff:	5d                   	pop    %ebp
 400:	c3                   	ret    
 401:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 408:	5d                   	pop    %ebp
 409:	e9 02 fe ff ff       	jmp    210 <assert.part.0>
 40e:	66 90                	xchg   %ax,%ax

00000410 <strcpy>:
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	53                   	push   %ebx
 414:	8b 45 08             	mov    0x8(%ebp),%eax
 417:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 41a:	89 c2                	mov    %eax,%edx
 41c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 420:	83 c1 01             	add    $0x1,%ecx
 423:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 427:	83 c2 01             	add    $0x1,%edx
 42a:	84 db                	test   %bl,%bl
 42c:	88 5a ff             	mov    %bl,-0x1(%edx)
 42f:	75 ef                	jne    420 <strcpy+0x10>
 431:	5b                   	pop    %ebx
 432:	5d                   	pop    %ebp
 433:	c3                   	ret    
 434:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 43a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000440 <strcmp>:
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	53                   	push   %ebx
 444:	8b 55 08             	mov    0x8(%ebp),%edx
 447:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 44a:	0f b6 02             	movzbl (%edx),%eax
 44d:	0f b6 19             	movzbl (%ecx),%ebx
 450:	84 c0                	test   %al,%al
 452:	75 1c                	jne    470 <strcmp+0x30>
 454:	eb 2a                	jmp    480 <strcmp+0x40>
 456:	8d 76 00             	lea    0x0(%esi),%esi
 459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 460:	83 c2 01             	add    $0x1,%edx
 463:	0f b6 02             	movzbl (%edx),%eax
 466:	83 c1 01             	add    $0x1,%ecx
 469:	0f b6 19             	movzbl (%ecx),%ebx
 46c:	84 c0                	test   %al,%al
 46e:	74 10                	je     480 <strcmp+0x40>
 470:	38 d8                	cmp    %bl,%al
 472:	74 ec                	je     460 <strcmp+0x20>
 474:	29 d8                	sub    %ebx,%eax
 476:	5b                   	pop    %ebx
 477:	5d                   	pop    %ebp
 478:	c3                   	ret    
 479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 480:	31 c0                	xor    %eax,%eax
 482:	29 d8                	sub    %ebx,%eax
 484:	5b                   	pop    %ebx
 485:	5d                   	pop    %ebp
 486:	c3                   	ret    
 487:	89 f6                	mov    %esi,%esi
 489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000490 <strlen>:
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	8b 4d 08             	mov    0x8(%ebp),%ecx
 496:	80 39 00             	cmpb   $0x0,(%ecx)
 499:	74 15                	je     4b0 <strlen+0x20>
 49b:	31 d2                	xor    %edx,%edx
 49d:	8d 76 00             	lea    0x0(%esi),%esi
 4a0:	83 c2 01             	add    $0x1,%edx
 4a3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 4a7:	89 d0                	mov    %edx,%eax
 4a9:	75 f5                	jne    4a0 <strlen+0x10>
 4ab:	5d                   	pop    %ebp
 4ac:	c3                   	ret    
 4ad:	8d 76 00             	lea    0x0(%esi),%esi
 4b0:	31 c0                	xor    %eax,%eax
 4b2:	5d                   	pop    %ebp
 4b3:	c3                   	ret    
 4b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 4ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000004c0 <memset>:
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	57                   	push   %edi
 4c4:	8b 55 08             	mov    0x8(%ebp),%edx
 4c7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 4ca:	8b 45 0c             	mov    0xc(%ebp),%eax
 4cd:	89 d7                	mov    %edx,%edi
 4cf:	fc                   	cld    
 4d0:	f3 aa                	rep stos %al,%es:(%edi)
 4d2:	89 d0                	mov    %edx,%eax
 4d4:	5f                   	pop    %edi
 4d5:	5d                   	pop    %ebp
 4d6:	c3                   	ret    
 4d7:	89 f6                	mov    %esi,%esi
 4d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004e0 <strchr>:
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	53                   	push   %ebx
 4e4:	8b 45 08             	mov    0x8(%ebp),%eax
 4e7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 4ea:	0f b6 10             	movzbl (%eax),%edx
 4ed:	84 d2                	test   %dl,%dl
 4ef:	74 1d                	je     50e <strchr+0x2e>
 4f1:	38 d3                	cmp    %dl,%bl
 4f3:	89 d9                	mov    %ebx,%ecx
 4f5:	75 0d                	jne    504 <strchr+0x24>
 4f7:	eb 17                	jmp    510 <strchr+0x30>
 4f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 500:	38 ca                	cmp    %cl,%dl
 502:	74 0c                	je     510 <strchr+0x30>
 504:	83 c0 01             	add    $0x1,%eax
 507:	0f b6 10             	movzbl (%eax),%edx
 50a:	84 d2                	test   %dl,%dl
 50c:	75 f2                	jne    500 <strchr+0x20>
 50e:	31 c0                	xor    %eax,%eax
 510:	5b                   	pop    %ebx
 511:	5d                   	pop    %ebp
 512:	c3                   	ret    
 513:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000520 <gets>:
 520:	55                   	push   %ebp
 521:	89 e5                	mov    %esp,%ebp
 523:	57                   	push   %edi
 524:	56                   	push   %esi
 525:	53                   	push   %ebx
 526:	31 f6                	xor    %esi,%esi
 528:	89 f3                	mov    %esi,%ebx
 52a:	83 ec 1c             	sub    $0x1c,%esp
 52d:	8b 7d 08             	mov    0x8(%ebp),%edi
 530:	eb 2f                	jmp    561 <gets+0x41>
 532:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 538:	8d 45 e7             	lea    -0x19(%ebp),%eax
 53b:	83 ec 04             	sub    $0x4,%esp
 53e:	6a 01                	push   $0x1
 540:	50                   	push   %eax
 541:	6a 00                	push   $0x0
 543:	e8 32 01 00 00       	call   67a <read>
 548:	83 c4 10             	add    $0x10,%esp
 54b:	85 c0                	test   %eax,%eax
 54d:	7e 1c                	jle    56b <gets+0x4b>
 54f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 553:	83 c7 01             	add    $0x1,%edi
 556:	88 47 ff             	mov    %al,-0x1(%edi)
 559:	3c 0a                	cmp    $0xa,%al
 55b:	74 23                	je     580 <gets+0x60>
 55d:	3c 0d                	cmp    $0xd,%al
 55f:	74 1f                	je     580 <gets+0x60>
 561:	83 c3 01             	add    $0x1,%ebx
 564:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 567:	89 fe                	mov    %edi,%esi
 569:	7c cd                	jl     538 <gets+0x18>
 56b:	89 f3                	mov    %esi,%ebx
 56d:	8b 45 08             	mov    0x8(%ebp),%eax
 570:	c6 03 00             	movb   $0x0,(%ebx)
 573:	8d 65 f4             	lea    -0xc(%ebp),%esp
 576:	5b                   	pop    %ebx
 577:	5e                   	pop    %esi
 578:	5f                   	pop    %edi
 579:	5d                   	pop    %ebp
 57a:	c3                   	ret    
 57b:	90                   	nop
 57c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 580:	8b 75 08             	mov    0x8(%ebp),%esi
 583:	8b 45 08             	mov    0x8(%ebp),%eax
 586:	01 de                	add    %ebx,%esi
 588:	89 f3                	mov    %esi,%ebx
 58a:	c6 03 00             	movb   $0x0,(%ebx)
 58d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 590:	5b                   	pop    %ebx
 591:	5e                   	pop    %esi
 592:	5f                   	pop    %edi
 593:	5d                   	pop    %ebp
 594:	c3                   	ret    
 595:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000005a0 <stat>:
 5a0:	55                   	push   %ebp
 5a1:	89 e5                	mov    %esp,%ebp
 5a3:	56                   	push   %esi
 5a4:	53                   	push   %ebx
 5a5:	83 ec 08             	sub    $0x8,%esp
 5a8:	6a 00                	push   $0x0
 5aa:	ff 75 08             	pushl  0x8(%ebp)
 5ad:	e8 f0 00 00 00       	call   6a2 <open>
 5b2:	83 c4 10             	add    $0x10,%esp
 5b5:	85 c0                	test   %eax,%eax
 5b7:	78 27                	js     5e0 <stat+0x40>
 5b9:	83 ec 08             	sub    $0x8,%esp
 5bc:	ff 75 0c             	pushl  0xc(%ebp)
 5bf:	89 c3                	mov    %eax,%ebx
 5c1:	50                   	push   %eax
 5c2:	e8 f3 00 00 00       	call   6ba <fstat>
 5c7:	89 1c 24             	mov    %ebx,(%esp)
 5ca:	89 c6                	mov    %eax,%esi
 5cc:	e8 b9 00 00 00       	call   68a <close>
 5d1:	83 c4 10             	add    $0x10,%esp
 5d4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 5d7:	89 f0                	mov    %esi,%eax
 5d9:	5b                   	pop    %ebx
 5da:	5e                   	pop    %esi
 5db:	5d                   	pop    %ebp
 5dc:	c3                   	ret    
 5dd:	8d 76 00             	lea    0x0(%esi),%esi
 5e0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 5e5:	eb ed                	jmp    5d4 <stat+0x34>
 5e7:	89 f6                	mov    %esi,%esi
 5e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000005f0 <atoi>:
 5f0:	55                   	push   %ebp
 5f1:	89 e5                	mov    %esp,%ebp
 5f3:	53                   	push   %ebx
 5f4:	8b 4d 08             	mov    0x8(%ebp),%ecx
 5f7:	0f be 11             	movsbl (%ecx),%edx
 5fa:	8d 42 d0             	lea    -0x30(%edx),%eax
 5fd:	3c 09                	cmp    $0x9,%al
 5ff:	b8 00 00 00 00       	mov    $0x0,%eax
 604:	77 1f                	ja     625 <atoi+0x35>
 606:	8d 76 00             	lea    0x0(%esi),%esi
 609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 610:	8d 04 80             	lea    (%eax,%eax,4),%eax
 613:	83 c1 01             	add    $0x1,%ecx
 616:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
 61a:	0f be 11             	movsbl (%ecx),%edx
 61d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 620:	80 fb 09             	cmp    $0x9,%bl
 623:	76 eb                	jbe    610 <atoi+0x20>
 625:	5b                   	pop    %ebx
 626:	5d                   	pop    %ebp
 627:	c3                   	ret    
 628:	90                   	nop
 629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000630 <memmove>:
 630:	55                   	push   %ebp
 631:	89 e5                	mov    %esp,%ebp
 633:	56                   	push   %esi
 634:	53                   	push   %ebx
 635:	8b 5d 10             	mov    0x10(%ebp),%ebx
 638:	8b 45 08             	mov    0x8(%ebp),%eax
 63b:	8b 75 0c             	mov    0xc(%ebp),%esi
 63e:	85 db                	test   %ebx,%ebx
 640:	7e 14                	jle    656 <memmove+0x26>
 642:	31 d2                	xor    %edx,%edx
 644:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 648:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 64c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 64f:	83 c2 01             	add    $0x1,%edx
 652:	39 d3                	cmp    %edx,%ebx
 654:	75 f2                	jne    648 <memmove+0x18>
 656:	5b                   	pop    %ebx
 657:	5e                   	pop    %esi
 658:	5d                   	pop    %ebp
 659:	c3                   	ret    

0000065a <fork>:
 65a:	b8 01 00 00 00       	mov    $0x1,%eax
 65f:	cd 40                	int    $0x40
 661:	c3                   	ret    

00000662 <exit>:
 662:	b8 02 00 00 00       	mov    $0x2,%eax
 667:	cd 40                	int    $0x40
 669:	c3                   	ret    

0000066a <wait>:
 66a:	b8 03 00 00 00       	mov    $0x3,%eax
 66f:	cd 40                	int    $0x40
 671:	c3                   	ret    

00000672 <pipe>:
 672:	b8 04 00 00 00       	mov    $0x4,%eax
 677:	cd 40                	int    $0x40
 679:	c3                   	ret    

0000067a <read>:
 67a:	b8 05 00 00 00       	mov    $0x5,%eax
 67f:	cd 40                	int    $0x40
 681:	c3                   	ret    

00000682 <write>:
 682:	b8 10 00 00 00       	mov    $0x10,%eax
 687:	cd 40                	int    $0x40
 689:	c3                   	ret    

0000068a <close>:
 68a:	b8 15 00 00 00       	mov    $0x15,%eax
 68f:	cd 40                	int    $0x40
 691:	c3                   	ret    

00000692 <kill>:
 692:	b8 06 00 00 00       	mov    $0x6,%eax
 697:	cd 40                	int    $0x40
 699:	c3                   	ret    

0000069a <exec>:
 69a:	b8 07 00 00 00       	mov    $0x7,%eax
 69f:	cd 40                	int    $0x40
 6a1:	c3                   	ret    

000006a2 <open>:
 6a2:	b8 0f 00 00 00       	mov    $0xf,%eax
 6a7:	cd 40                	int    $0x40
 6a9:	c3                   	ret    

000006aa <mknod>:
 6aa:	b8 11 00 00 00       	mov    $0x11,%eax
 6af:	cd 40                	int    $0x40
 6b1:	c3                   	ret    

000006b2 <unlink>:
 6b2:	b8 12 00 00 00       	mov    $0x12,%eax
 6b7:	cd 40                	int    $0x40
 6b9:	c3                   	ret    

000006ba <fstat>:
 6ba:	b8 08 00 00 00       	mov    $0x8,%eax
 6bf:	cd 40                	int    $0x40
 6c1:	c3                   	ret    

000006c2 <link>:
 6c2:	b8 13 00 00 00       	mov    $0x13,%eax
 6c7:	cd 40                	int    $0x40
 6c9:	c3                   	ret    

000006ca <mkdir>:
 6ca:	b8 14 00 00 00       	mov    $0x14,%eax
 6cf:	cd 40                	int    $0x40
 6d1:	c3                   	ret    

000006d2 <chdir>:
 6d2:	b8 09 00 00 00       	mov    $0x9,%eax
 6d7:	cd 40                	int    $0x40
 6d9:	c3                   	ret    

000006da <dup>:
 6da:	b8 0a 00 00 00       	mov    $0xa,%eax
 6df:	cd 40                	int    $0x40
 6e1:	c3                   	ret    

000006e2 <getpid>:
 6e2:	b8 0b 00 00 00       	mov    $0xb,%eax
 6e7:	cd 40                	int    $0x40
 6e9:	c3                   	ret    

000006ea <sbrk>:
 6ea:	b8 0c 00 00 00       	mov    $0xc,%eax
 6ef:	cd 40                	int    $0x40
 6f1:	c3                   	ret    

000006f2 <sleep>:
 6f2:	b8 0d 00 00 00       	mov    $0xd,%eax
 6f7:	cd 40                	int    $0x40
 6f9:	c3                   	ret    

000006fa <uptime>:
 6fa:	b8 0e 00 00 00       	mov    $0xe,%eax
 6ff:	cd 40                	int    $0x40
 701:	c3                   	ret    

00000702 <kthread_create>:
 702:	b8 16 00 00 00       	mov    $0x16,%eax
 707:	cd 40                	int    $0x40
 709:	c3                   	ret    

0000070a <kthread_id>:
 70a:	b8 17 00 00 00       	mov    $0x17,%eax
 70f:	cd 40                	int    $0x40
 711:	c3                   	ret    

00000712 <kthread_exit>:
 712:	b8 18 00 00 00       	mov    $0x18,%eax
 717:	cd 40                	int    $0x40
 719:	c3                   	ret    

0000071a <kthread_join>:
 71a:	b8 19 00 00 00       	mov    $0x19,%eax
 71f:	cd 40                	int    $0x40
 721:	c3                   	ret    

00000722 <kthread_mutex_alloc>:
 722:	b8 1a 00 00 00       	mov    $0x1a,%eax
 727:	cd 40                	int    $0x40
 729:	c3                   	ret    

0000072a <kthread_mutex_dealloc>:
 72a:	b8 1b 00 00 00       	mov    $0x1b,%eax
 72f:	cd 40                	int    $0x40
 731:	c3                   	ret    

00000732 <kthread_mutex_lock>:
 732:	b8 1c 00 00 00       	mov    $0x1c,%eax
 737:	cd 40                	int    $0x40
 739:	c3                   	ret    

0000073a <kthread_mutex_unlock>:
 73a:	b8 1d 00 00 00       	mov    $0x1d,%eax
 73f:	cd 40                	int    $0x40
 741:	c3                   	ret    

00000742 <procdump>:
 742:	b8 1e 00 00 00       	mov    $0x1e,%eax
 747:	cd 40                	int    $0x40
 749:	c3                   	ret    
 74a:	66 90                	xchg   %ax,%ax
 74c:	66 90                	xchg   %ax,%ax
 74e:	66 90                	xchg   %ax,%ax

00000750 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 750:	55                   	push   %ebp
 751:	89 e5                	mov    %esp,%ebp
 753:	57                   	push   %edi
 754:	56                   	push   %esi
 755:	53                   	push   %ebx
 756:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 759:	85 d2                	test   %edx,%edx
{
 75b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 75e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 760:	79 76                	jns    7d8 <printint+0x88>
 762:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 766:	74 70                	je     7d8 <printint+0x88>
    x = -xx;
 768:	f7 d8                	neg    %eax
    neg = 1;
 76a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 771:	31 f6                	xor    %esi,%esi
 773:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 776:	eb 0a                	jmp    782 <printint+0x32>
 778:	90                   	nop
 779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 780:	89 fe                	mov    %edi,%esi
 782:	31 d2                	xor    %edx,%edx
 784:	8d 7e 01             	lea    0x1(%esi),%edi
 787:	f7 f1                	div    %ecx
 789:	0f b6 92 c8 0d 00 00 	movzbl 0xdc8(%edx),%edx
  }while((x /= base) != 0);
 790:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 792:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 795:	75 e9                	jne    780 <printint+0x30>
  if(neg)
 797:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 79a:	85 c0                	test   %eax,%eax
 79c:	74 08                	je     7a6 <printint+0x56>
    buf[i++] = '-';
 79e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 7a3:	8d 7e 02             	lea    0x2(%esi),%edi
 7a6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 7aa:	8b 7d c0             	mov    -0x40(%ebp),%edi
 7ad:	8d 76 00             	lea    0x0(%esi),%esi
 7b0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 7b3:	83 ec 04             	sub    $0x4,%esp
 7b6:	83 ee 01             	sub    $0x1,%esi
 7b9:	6a 01                	push   $0x1
 7bb:	53                   	push   %ebx
 7bc:	57                   	push   %edi
 7bd:	88 45 d7             	mov    %al,-0x29(%ebp)
 7c0:	e8 bd fe ff ff       	call   682 <write>

  while(--i >= 0)
 7c5:	83 c4 10             	add    $0x10,%esp
 7c8:	39 de                	cmp    %ebx,%esi
 7ca:	75 e4                	jne    7b0 <printint+0x60>
    putc(fd, buf[i]);
}
 7cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7cf:	5b                   	pop    %ebx
 7d0:	5e                   	pop    %esi
 7d1:	5f                   	pop    %edi
 7d2:	5d                   	pop    %ebp
 7d3:	c3                   	ret    
 7d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 7d8:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 7df:	eb 90                	jmp    771 <printint+0x21>
 7e1:	eb 0d                	jmp    7f0 <printf>
 7e3:	90                   	nop
 7e4:	90                   	nop
 7e5:	90                   	nop
 7e6:	90                   	nop
 7e7:	90                   	nop
 7e8:	90                   	nop
 7e9:	90                   	nop
 7ea:	90                   	nop
 7eb:	90                   	nop
 7ec:	90                   	nop
 7ed:	90                   	nop
 7ee:	90                   	nop
 7ef:	90                   	nop

000007f0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 7f0:	55                   	push   %ebp
 7f1:	89 e5                	mov    %esp,%ebp
 7f3:	57                   	push   %edi
 7f4:	56                   	push   %esi
 7f5:	53                   	push   %ebx
 7f6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 7f9:	8b 75 0c             	mov    0xc(%ebp),%esi
 7fc:	0f b6 1e             	movzbl (%esi),%ebx
 7ff:	84 db                	test   %bl,%bl
 801:	0f 84 b3 00 00 00    	je     8ba <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 807:	8d 45 10             	lea    0x10(%ebp),%eax
 80a:	83 c6 01             	add    $0x1,%esi
  state = 0;
 80d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 80f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 812:	eb 2f                	jmp    843 <printf+0x53>
 814:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 818:	83 f8 25             	cmp    $0x25,%eax
 81b:	0f 84 a7 00 00 00    	je     8c8 <printf+0xd8>
  write(fd, &c, 1);
 821:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 824:	83 ec 04             	sub    $0x4,%esp
 827:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 82a:	6a 01                	push   $0x1
 82c:	50                   	push   %eax
 82d:	ff 75 08             	pushl  0x8(%ebp)
 830:	e8 4d fe ff ff       	call   682 <write>
 835:	83 c4 10             	add    $0x10,%esp
 838:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 83b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 83f:	84 db                	test   %bl,%bl
 841:	74 77                	je     8ba <printf+0xca>
    if(state == 0){
 843:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 845:	0f be cb             	movsbl %bl,%ecx
 848:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 84b:	74 cb                	je     818 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 84d:	83 ff 25             	cmp    $0x25,%edi
 850:	75 e6                	jne    838 <printf+0x48>
      if(c == 'd'){
 852:	83 f8 64             	cmp    $0x64,%eax
 855:	0f 84 05 01 00 00    	je     960 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 85b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 861:	83 f9 70             	cmp    $0x70,%ecx
 864:	74 72                	je     8d8 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 866:	83 f8 73             	cmp    $0x73,%eax
 869:	0f 84 99 00 00 00    	je     908 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 86f:	83 f8 63             	cmp    $0x63,%eax
 872:	0f 84 08 01 00 00    	je     980 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 878:	83 f8 25             	cmp    $0x25,%eax
 87b:	0f 84 ef 00 00 00    	je     970 <printf+0x180>
  write(fd, &c, 1);
 881:	8d 45 e7             	lea    -0x19(%ebp),%eax
 884:	83 ec 04             	sub    $0x4,%esp
 887:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 88b:	6a 01                	push   $0x1
 88d:	50                   	push   %eax
 88e:	ff 75 08             	pushl  0x8(%ebp)
 891:	e8 ec fd ff ff       	call   682 <write>
 896:	83 c4 0c             	add    $0xc,%esp
 899:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 89c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 89f:	6a 01                	push   $0x1
 8a1:	50                   	push   %eax
 8a2:	ff 75 08             	pushl  0x8(%ebp)
 8a5:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 8a8:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 8aa:	e8 d3 fd ff ff       	call   682 <write>
  for(i = 0; fmt[i]; i++){
 8af:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 8b3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 8b6:	84 db                	test   %bl,%bl
 8b8:	75 89                	jne    843 <printf+0x53>
    }
  }
}
 8ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8bd:	5b                   	pop    %ebx
 8be:	5e                   	pop    %esi
 8bf:	5f                   	pop    %edi
 8c0:	5d                   	pop    %ebp
 8c1:	c3                   	ret    
 8c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 8c8:	bf 25 00 00 00       	mov    $0x25,%edi
 8cd:	e9 66 ff ff ff       	jmp    838 <printf+0x48>
 8d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 8d8:	83 ec 0c             	sub    $0xc,%esp
 8db:	b9 10 00 00 00       	mov    $0x10,%ecx
 8e0:	6a 00                	push   $0x0
 8e2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 8e5:	8b 45 08             	mov    0x8(%ebp),%eax
 8e8:	8b 17                	mov    (%edi),%edx
 8ea:	e8 61 fe ff ff       	call   750 <printint>
        ap++;
 8ef:	89 f8                	mov    %edi,%eax
 8f1:	83 c4 10             	add    $0x10,%esp
      state = 0;
 8f4:	31 ff                	xor    %edi,%edi
        ap++;
 8f6:	83 c0 04             	add    $0x4,%eax
 8f9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 8fc:	e9 37 ff ff ff       	jmp    838 <printf+0x48>
 901:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 908:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 90b:	8b 08                	mov    (%eax),%ecx
        ap++;
 90d:	83 c0 04             	add    $0x4,%eax
 910:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 913:	85 c9                	test   %ecx,%ecx
 915:	0f 84 8e 00 00 00    	je     9a9 <printf+0x1b9>
        while(*s != 0){
 91b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 91e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 920:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 922:	84 c0                	test   %al,%al
 924:	0f 84 0e ff ff ff    	je     838 <printf+0x48>
 92a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 92d:	89 de                	mov    %ebx,%esi
 92f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 932:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 935:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 938:	83 ec 04             	sub    $0x4,%esp
          s++;
 93b:	83 c6 01             	add    $0x1,%esi
 93e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 941:	6a 01                	push   $0x1
 943:	57                   	push   %edi
 944:	53                   	push   %ebx
 945:	e8 38 fd ff ff       	call   682 <write>
        while(*s != 0){
 94a:	0f b6 06             	movzbl (%esi),%eax
 94d:	83 c4 10             	add    $0x10,%esp
 950:	84 c0                	test   %al,%al
 952:	75 e4                	jne    938 <printf+0x148>
 954:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 957:	31 ff                	xor    %edi,%edi
 959:	e9 da fe ff ff       	jmp    838 <printf+0x48>
 95e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 960:	83 ec 0c             	sub    $0xc,%esp
 963:	b9 0a 00 00 00       	mov    $0xa,%ecx
 968:	6a 01                	push   $0x1
 96a:	e9 73 ff ff ff       	jmp    8e2 <printf+0xf2>
 96f:	90                   	nop
  write(fd, &c, 1);
 970:	83 ec 04             	sub    $0x4,%esp
 973:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 976:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 979:	6a 01                	push   $0x1
 97b:	e9 21 ff ff ff       	jmp    8a1 <printf+0xb1>
        putc(fd, *ap);
 980:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 983:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 986:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 988:	6a 01                	push   $0x1
        ap++;
 98a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 98d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 990:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 993:	50                   	push   %eax
 994:	ff 75 08             	pushl  0x8(%ebp)
 997:	e8 e6 fc ff ff       	call   682 <write>
        ap++;
 99c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 99f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 9a2:	31 ff                	xor    %edi,%edi
 9a4:	e9 8f fe ff ff       	jmp    838 <printf+0x48>
          s = "(null)";
 9a9:	bb c0 0d 00 00       	mov    $0xdc0,%ebx
        while(*s != 0){
 9ae:	b8 28 00 00 00       	mov    $0x28,%eax
 9b3:	e9 72 ff ff ff       	jmp    92a <printf+0x13a>
 9b8:	66 90                	xchg   %ax,%ax
 9ba:	66 90                	xchg   %ax,%ax
 9bc:	66 90                	xchg   %ax,%ax
 9be:	66 90                	xchg   %ax,%ax

000009c0 <free>:
 9c0:	55                   	push   %ebp
 9c1:	a1 3c 11 00 00       	mov    0x113c,%eax
 9c6:	89 e5                	mov    %esp,%ebp
 9c8:	57                   	push   %edi
 9c9:	56                   	push   %esi
 9ca:	53                   	push   %ebx
 9cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 9ce:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 9d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 9d8:	39 c8                	cmp    %ecx,%eax
 9da:	8b 10                	mov    (%eax),%edx
 9dc:	73 32                	jae    a10 <free+0x50>
 9de:	39 d1                	cmp    %edx,%ecx
 9e0:	72 04                	jb     9e6 <free+0x26>
 9e2:	39 d0                	cmp    %edx,%eax
 9e4:	72 32                	jb     a18 <free+0x58>
 9e6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 9e9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 9ec:	39 fa                	cmp    %edi,%edx
 9ee:	74 30                	je     a20 <free+0x60>
 9f0:	89 53 f8             	mov    %edx,-0x8(%ebx)
 9f3:	8b 50 04             	mov    0x4(%eax),%edx
 9f6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 9f9:	39 f1                	cmp    %esi,%ecx
 9fb:	74 3a                	je     a37 <free+0x77>
 9fd:	89 08                	mov    %ecx,(%eax)
 9ff:	a3 3c 11 00 00       	mov    %eax,0x113c
 a04:	5b                   	pop    %ebx
 a05:	5e                   	pop    %esi
 a06:	5f                   	pop    %edi
 a07:	5d                   	pop    %ebp
 a08:	c3                   	ret    
 a09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a10:	39 d0                	cmp    %edx,%eax
 a12:	72 04                	jb     a18 <free+0x58>
 a14:	39 d1                	cmp    %edx,%ecx
 a16:	72 ce                	jb     9e6 <free+0x26>
 a18:	89 d0                	mov    %edx,%eax
 a1a:	eb bc                	jmp    9d8 <free+0x18>
 a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 a20:	03 72 04             	add    0x4(%edx),%esi
 a23:	89 73 fc             	mov    %esi,-0x4(%ebx)
 a26:	8b 10                	mov    (%eax),%edx
 a28:	8b 12                	mov    (%edx),%edx
 a2a:	89 53 f8             	mov    %edx,-0x8(%ebx)
 a2d:	8b 50 04             	mov    0x4(%eax),%edx
 a30:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 a33:	39 f1                	cmp    %esi,%ecx
 a35:	75 c6                	jne    9fd <free+0x3d>
 a37:	03 53 fc             	add    -0x4(%ebx),%edx
 a3a:	a3 3c 11 00 00       	mov    %eax,0x113c
 a3f:	89 50 04             	mov    %edx,0x4(%eax)
 a42:	8b 53 f8             	mov    -0x8(%ebx),%edx
 a45:	89 10                	mov    %edx,(%eax)
 a47:	5b                   	pop    %ebx
 a48:	5e                   	pop    %esi
 a49:	5f                   	pop    %edi
 a4a:	5d                   	pop    %ebp
 a4b:	c3                   	ret    
 a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000a50 <malloc>:
 a50:	55                   	push   %ebp
 a51:	89 e5                	mov    %esp,%ebp
 a53:	57                   	push   %edi
 a54:	56                   	push   %esi
 a55:	53                   	push   %ebx
 a56:	83 ec 0c             	sub    $0xc,%esp
 a59:	8b 45 08             	mov    0x8(%ebp),%eax
 a5c:	8b 15 3c 11 00 00    	mov    0x113c,%edx
 a62:	8d 78 07             	lea    0x7(%eax),%edi
 a65:	c1 ef 03             	shr    $0x3,%edi
 a68:	83 c7 01             	add    $0x1,%edi
 a6b:	85 d2                	test   %edx,%edx
 a6d:	0f 84 9d 00 00 00    	je     b10 <malloc+0xc0>
 a73:	8b 02                	mov    (%edx),%eax
 a75:	8b 48 04             	mov    0x4(%eax),%ecx
 a78:	39 cf                	cmp    %ecx,%edi
 a7a:	76 6c                	jbe    ae8 <malloc+0x98>
 a7c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 a82:	bb 00 10 00 00       	mov    $0x1000,%ebx
 a87:	0f 43 df             	cmovae %edi,%ebx
 a8a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 a91:	eb 0e                	jmp    aa1 <malloc+0x51>
 a93:	90                   	nop
 a94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 a98:	8b 02                	mov    (%edx),%eax
 a9a:	8b 48 04             	mov    0x4(%eax),%ecx
 a9d:	39 f9                	cmp    %edi,%ecx
 a9f:	73 47                	jae    ae8 <malloc+0x98>
 aa1:	39 05 3c 11 00 00    	cmp    %eax,0x113c
 aa7:	89 c2                	mov    %eax,%edx
 aa9:	75 ed                	jne    a98 <malloc+0x48>
 aab:	83 ec 0c             	sub    $0xc,%esp
 aae:	56                   	push   %esi
 aaf:	e8 36 fc ff ff       	call   6ea <sbrk>
 ab4:	83 c4 10             	add    $0x10,%esp
 ab7:	83 f8 ff             	cmp    $0xffffffff,%eax
 aba:	74 1c                	je     ad8 <malloc+0x88>
 abc:	89 58 04             	mov    %ebx,0x4(%eax)
 abf:	83 ec 0c             	sub    $0xc,%esp
 ac2:	83 c0 08             	add    $0x8,%eax
 ac5:	50                   	push   %eax
 ac6:	e8 f5 fe ff ff       	call   9c0 <free>
 acb:	8b 15 3c 11 00 00    	mov    0x113c,%edx
 ad1:	83 c4 10             	add    $0x10,%esp
 ad4:	85 d2                	test   %edx,%edx
 ad6:	75 c0                	jne    a98 <malloc+0x48>
 ad8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 adb:	31 c0                	xor    %eax,%eax
 add:	5b                   	pop    %ebx
 ade:	5e                   	pop    %esi
 adf:	5f                   	pop    %edi
 ae0:	5d                   	pop    %ebp
 ae1:	c3                   	ret    
 ae2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 ae8:	39 cf                	cmp    %ecx,%edi
 aea:	74 54                	je     b40 <malloc+0xf0>
 aec:	29 f9                	sub    %edi,%ecx
 aee:	89 48 04             	mov    %ecx,0x4(%eax)
 af1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
 af4:	89 78 04             	mov    %edi,0x4(%eax)
 af7:	89 15 3c 11 00 00    	mov    %edx,0x113c
 afd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 b00:	83 c0 08             	add    $0x8,%eax
 b03:	5b                   	pop    %ebx
 b04:	5e                   	pop    %esi
 b05:	5f                   	pop    %edi
 b06:	5d                   	pop    %ebp
 b07:	c3                   	ret    
 b08:	90                   	nop
 b09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 b10:	c7 05 3c 11 00 00 40 	movl   $0x1140,0x113c
 b17:	11 00 00 
 b1a:	c7 05 40 11 00 00 40 	movl   $0x1140,0x1140
 b21:	11 00 00 
 b24:	b8 40 11 00 00       	mov    $0x1140,%eax
 b29:	c7 05 44 11 00 00 00 	movl   $0x0,0x1144
 b30:	00 00 00 
 b33:	e9 44 ff ff ff       	jmp    a7c <malloc+0x2c>
 b38:	90                   	nop
 b39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 b40:	8b 08                	mov    (%eax),%ecx
 b42:	89 0a                	mov    %ecx,(%edx)
 b44:	eb b1                	jmp    af7 <malloc+0xa7>
