
_mutextest2:     file format elf32-i386


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
   d:	56                   	push   %esi
   e:	53                   	push   %ebx
   f:	51                   	push   %ecx
  10:	83 ec 14             	sub    $0x14,%esp
	printf(stdout, "~~~~~~~~~~~~~~~~~~ mutex test 2 ~~~~~~~~~~~~~~~~~~\n");
  13:	68 2c 10 00 00       	push   $0x102c
  18:	ff 35 fc 14 00 00    	pushl  0x14fc
  1e:	e8 ad 0b 00 00       	call   bd0 <printf>

	int thread;
	pid = getpid();
  23:	e8 9a 0a 00 00       	call   ac2 <getpid>
	int expected;

	//attempt to lock a nonexistent mutex
	ASSERT(kthread_mutex_lock(-10) < 0, "locking an invalid mutex returns success");
  28:	c7 04 24 f6 ff ff ff 	movl   $0xfffffff6,(%esp)
	pid = getpid();
  2f:	a3 0c 15 00 00       	mov    %eax,0x150c
	ASSERT(kthread_mutex_lock(-10) < 0, "locking an invalid mutex returns success");
  34:	e8 d9 0a 00 00       	call   b12 <kthread_mutex_lock>
	if(!assumption)
  39:	83 c4 10             	add    $0x10,%esp
  3c:	85 c0                	test   %eax,%eax
  3e:	78 0f                	js     4f <main+0x4f>
  40:	ba 56 00 00 00       	mov    $0x56,%edx
  45:	b8 60 10 00 00       	mov    $0x1060,%eax
  4a:	e8 31 05 00 00       	call   580 <assert.part.0>
	//attempt to unlock a nonexistent mutex
	ASSERT(kthread_mutex_unlock(-10) < 0, "unlocking an invalid mutex returns success");
  4f:	83 ec 0c             	sub    $0xc,%esp
  52:	6a f6                	push   $0xfffffff6
  54:	e8 c1 0a 00 00       	call   b1a <kthread_mutex_unlock>
	if(!assumption)
  59:	83 c4 10             	add    $0x10,%esp
  5c:	85 c0                	test   %eax,%eax
  5e:	78 0f                	js     6f <main+0x6f>
  60:	ba 58 00 00 00       	mov    $0x58,%edx
  65:	b8 8c 10 00 00       	mov    $0x108c,%eax
  6a:	e8 11 05 00 00       	call   580 <assert.part.0>
{
  6f:	bb 03 00 00 00       	mov    $0x3,%ebx
	//allocate and deallocate
	for(int i=0; i<3; i++)
	{
		int dummy = kthread_mutex_alloc();
  74:	e8 89 0a 00 00       	call   b02 <kthread_mutex_alloc>
	if(!assumption)
  79:	85 c0                	test   %eax,%eax
		int dummy = kthread_mutex_alloc();
  7b:	89 c6                	mov    %eax,%esi
	if(!assumption)
  7d:	0f 88 05 04 00 00    	js     488 <main+0x488>
		ASSERT(dummy >= 0, "failed to allocate mutex");
		ASSERT(kthread_mutex_dealloc(dummy) >= 0, "failed to deallocate mutex");
  83:	83 ec 0c             	sub    $0xc,%esp
  86:	56                   	push   %esi
  87:	e8 7e 0a 00 00       	call   b0a <kthread_mutex_dealloc>
	if(!assumption)
  8c:	83 c4 10             	add    $0x10,%esp
  8f:	85 c0                	test   %eax,%eax
  91:	0f 88 dd 03 00 00    	js     474 <main+0x474>
	for(int i=0; i<3; i++)
  97:	83 eb 01             	sub    $0x1,%ebx
  9a:	75 d8                	jne    74 <main+0x74>
	}


	mutex = kthread_mutex_alloc();
  9c:	e8 61 0a 00 00       	call   b02 <kthread_mutex_alloc>
	if(!assumption)
  a1:	85 c0                	test   %eax,%eax
	mutex = kthread_mutex_alloc();
  a3:	a3 24 15 00 00       	mov    %eax,0x1524
	if(!assumption)
  a8:	0f 88 b6 04 00 00    	js     564 <main+0x564>
	ASSERT(mutex >= 0, "failed to allocate mutex");
	//attempt to unlock before mutex is locked
	ASSERT(kthread_mutex_unlock(mutex) < 0, "unlocking unlocked mutex returns success");
  ae:	83 ec 0c             	sub    $0xc,%esp
  b1:	50                   	push   %eax
  b2:	e8 63 0a 00 00       	call   b1a <kthread_mutex_unlock>
	if(!assumption)
  b7:	83 c4 10             	add    $0x10,%esp
  ba:	85 c0                	test   %eax,%eax
  bc:	78 0f                	js     cd <main+0xcd>
  be:	ba 65 00 00 00       	mov    $0x65,%edx
  c3:	b8 b8 10 00 00       	mov    $0x10b8,%eax
  c8:	e8 b3 04 00 00       	call   580 <assert.part.0>
	ASSERT(kthread_mutex_lock(mutex) >= 0, "failed to lock mutex");
  cd:	83 ec 0c             	sub    $0xc,%esp
  d0:	ff 35 24 15 00 00    	pushl  0x1524
  d6:	e8 37 0a 00 00       	call   b12 <kthread_mutex_lock>
	if(!assumption)
  db:	83 c4 10             	add    $0x10,%esp
  de:	85 c0                	test   %eax,%eax
  e0:	0f 88 6a 04 00 00    	js     550 <main+0x550>
	//attempt to deallocate when mutex is locked
	ASSERT(kthread_mutex_dealloc(mutex) < 0, "deallocating a locked mutex returns success");
  e6:	83 ec 0c             	sub    $0xc,%esp
  e9:	ff 35 24 15 00 00    	pushl  0x1524
  ef:	e8 16 0a 00 00       	call   b0a <kthread_mutex_dealloc>
	if(!assumption)
  f4:	83 c4 10             	add    $0x10,%esp
  f7:	85 c0                	test   %eax,%eax
  f9:	78 0f                	js     10a <main+0x10a>
  fb:	ba 68 00 00 00       	mov    $0x68,%edx
 100:	b8 e4 10 00 00       	mov    $0x10e4,%eax
 105:	e8 76 04 00 00       	call   580 <assert.part.0>
	ASSERT(kthread_mutex_unlock(mutex) >= 0, "failed to unlock mutex");
 10a:	83 ec 0c             	sub    $0xc,%esp
 10d:	ff 35 24 15 00 00    	pushl  0x1524
 113:	e8 02 0a 00 00       	call   b1a <kthread_mutex_unlock>
	if(!assumption)
 118:	83 c4 10             	add    $0x10,%esp
 11b:	85 c0                	test   %eax,%eax
 11d:	0f 88 19 04 00 00    	js     53c <main+0x53c>
	ASSERT(kthread_mutex_dealloc(mutex) >= 0, "failed to deallocate mutex");
 123:	83 ec 0c             	sub    $0xc,%esp
 126:	ff 35 24 15 00 00    	pushl  0x1524
 12c:	e8 d9 09 00 00       	call   b0a <kthread_mutex_dealloc>
	if(!assumption)
 131:	83 c4 10             	add    $0x10,%esp
 134:	85 c0                	test   %eax,%eax
 136:	0f 88 ec 03 00 00    	js     528 <main+0x528>

	thread = kthread_create(allocate_and_lock, malloc(MAX_STACK_SIZE), MAX_STACK_SIZE);
 13c:	83 ec 0c             	sub    $0xc,%esp
 13f:	68 00 04 00 00       	push   $0x400
 144:	e8 e7 0c 00 00       	call   e30 <malloc>
 149:	83 c4 0c             	add    $0xc,%esp
 14c:	68 00 04 00 00       	push   $0x400
 151:	50                   	push   %eax
 152:	68 e0 05 00 00       	push   $0x5e0
 157:	e8 86 09 00 00       	call   ae2 <kthread_create>
	if(!assumption)
 15c:	83 c4 10             	add    $0x10,%esp
 15f:	85 c0                	test   %eax,%eax
	thread = kthread_create(allocate_and_lock, malloc(MAX_STACK_SIZE), MAX_STACK_SIZE);
 161:	89 c3                	mov    %eax,%ebx
	if(!assumption)
 163:	0f 88 ab 03 00 00    	js     514 <main+0x514>
  	ASSERT(thread >= 0, "failed to create thread");
  	ASSERT(kthread_join(thread) >= 0, "failed to join thread");
 169:	83 ec 0c             	sub    $0xc,%esp
 16c:	53                   	push   %ebx
 16d:	e8 88 09 00 00       	call   afa <kthread_join>
	if(!assumption)
 172:	83 c4 10             	add    $0x10,%esp
 175:	85 c0                	test   %eax,%eax
 177:	0f 88 83 03 00 00    	js     500 <main+0x500>
	//attempt to unlock a mutex that's locked by another thread
	ASSERT(kthread_mutex_unlock(mutex) >= 0, "failed to unlock mutex");
 17d:	83 ec 0c             	sub    $0xc,%esp
 180:	ff 35 24 15 00 00    	pushl  0x1524
 186:	e8 8f 09 00 00       	call   b1a <kthread_mutex_unlock>
	if(!assumption)
 18b:	83 c4 10             	add    $0x10,%esp
 18e:	85 c0                	test   %eax,%eax
 190:	0f 88 56 03 00 00    	js     4ec <main+0x4ec>

	//shared variable test #1
	ASSERT(kthread_mutex_lock(mutex) >= 0, "failed to lock mutex");
 196:	83 ec 0c             	sub    $0xc,%esp
 199:	ff 35 24 15 00 00    	pushl  0x1524
 19f:	e8 6e 09 00 00       	call   b12 <kthread_mutex_lock>
	if(!assumption)
 1a4:	83 c4 10             	add    $0x10,%esp
 1a7:	85 c0                	test   %eax,%eax
 1a9:	0f 88 29 03 00 00    	js     4d8 <main+0x4d8>
	shared = 0;
 1af:	c7 05 28 15 00 00 00 	movl   $0x0,0x1528
 1b6:	00 00 00 

	for(int i=0; i<5; i++)
 1b9:	31 db                	xor    %ebx,%ebx
	{
	  	thread = kthread_create(increment, malloc(MAX_STACK_SIZE), MAX_STACK_SIZE);
 1bb:	83 ec 0c             	sub    $0xc,%esp
 1be:	68 00 04 00 00       	push   $0x400
 1c3:	e8 68 0c 00 00       	call   e30 <malloc>
 1c8:	83 c4 0c             	add    $0xc,%esp
 1cb:	68 00 04 00 00       	push   $0x400
 1d0:	50                   	push   %eax
 1d1:	68 50 06 00 00       	push   $0x650
 1d6:	e8 07 09 00 00       	call   ae2 <kthread_create>
	if(!assumption)
 1db:	83 c4 10             	add    $0x10,%esp
 1de:	85 c0                	test   %eax,%eax
	  	thread = kthread_create(increment, malloc(MAX_STACK_SIZE), MAX_STACK_SIZE);
 1e0:	89 c6                	mov    %eax,%esi
	if(!assumption)
 1e2:	0f 88 78 02 00 00    	js     460 <main+0x460>
  		ASSERT(thread >= 0, "failed to create thread");
  		thread_ids[i] = thread;
 1e8:	89 34 9d 10 15 00 00 	mov    %esi,0x1510(,%ebx,4)
	for(int i=0; i<5; i++)
 1ef:	83 c3 01             	add    $0x1,%ebx
 1f2:	83 fb 05             	cmp    $0x5,%ebx
 1f5:	75 c4                	jne    1bb <main+0x1bb>
	}

	sleep(6 * TIME_SLICE); //sleep with lock held for a while
 1f7:	83 ec 0c             	sub    $0xc,%esp
 1fa:	6a 3c                	push   $0x3c
 1fc:	e8 d1 08 00 00       	call   ad2 <sleep>
	ASSERT(shared == 0, "mutex failed to prevent writing to shared");
 201:	a1 28 15 00 00       	mov    0x1528,%eax
	if(!assumption)
 206:	83 c4 10             	add    $0x10,%esp
 209:	85 c0                	test   %eax,%eax
 20b:	0f 85 9f 02 00 00    	jne    4b0 <main+0x4b0>
	ASSERT(kthread_mutex_unlock(mutex) >= 0, "failed to unlock mutex");
 211:	83 ec 0c             	sub    $0xc,%esp
 214:	ff 35 24 15 00 00    	pushl  0x1524
 21a:	e8 fb 08 00 00       	call   b1a <kthread_mutex_unlock>
	if(!assumption)
 21f:	83 c4 10             	add    $0x10,%esp
 222:	85 c0                	test   %eax,%eax
 224:	0f 88 72 02 00 00    	js     49c <main+0x49c>
	for(int i=0; i<5; i++)
 22a:	31 db                	xor    %ebx,%ebx

	for(int i=0; i<5; i++)
	{
		ASSERT(kthread_join(thread_ids[i]) >= 0, "failed to join thread");
 22c:	83 ec 0c             	sub    $0xc,%esp
 22f:	ff 34 9d 10 15 00 00 	pushl  0x1510(,%ebx,4)
 236:	e8 bf 08 00 00       	call   afa <kthread_join>
	if(!assumption)
 23b:	83 c4 10             	add    $0x10,%esp
 23e:	85 c0                	test   %eax,%eax
 240:	0f 88 02 02 00 00    	js     448 <main+0x448>
	for(int i=0; i<5; i++)
 246:	83 c3 01             	add    $0x1,%ebx
 249:	83 fb 05             	cmp    $0x5,%ebx
 24c:	75 de                	jne    22c <main+0x22c>
	}

	expected = 5;
	if(shared != expected)
 24e:	a1 28 15 00 00       	mov    0x1528,%eax
 253:	83 f8 05             	cmp    $0x5,%eax
 256:	74 1b                	je     273 <main+0x273>
	{
		printf(stdout, "value=%d, expected=%d\n", shared, expected);
 258:	a1 28 15 00 00       	mov    0x1528,%eax
 25d:	6a 05                	push   $0x5
 25f:	50                   	push   %eax
 260:	68 df 0f 00 00       	push   $0xfdf
 265:	ff 35 fc 14 00 00    	pushl  0x14fc
 26b:	e8 60 09 00 00       	call   bd0 <printf>
 270:	83 c4 10             	add    $0x10,%esp
	}
	ASSERT(shared == expected, "shared variable does not have a correct value");
 273:	a1 28 15 00 00       	mov    0x1528,%eax
	if(!assumption)
 278:	83 f8 05             	cmp    $0x5,%eax
 27b:	74 0f                	je     28c <main+0x28c>
 27d:	ba 8b 00 00 00       	mov    $0x8b,%edx
 282:	b8 3c 11 00 00       	mov    $0x113c,%eax
 287:	e8 f4 02 00 00       	call   580 <assert.part.0>
	for(int i=0; i<5; i++)
 28c:	bb 05 00 00 00       	mov    $0x5,%ebx
	//loop 5 times
	//for each iteration, correct order: *5 then +3
	for(int i=0; i<5; i++)
	{
		//make sure plus_three is blocked
		ASSERT(kthread_mutex_lock(mutex) >= 0, "failed to lock mutex");
 291:	83 ec 0c             	sub    $0xc,%esp
 294:	ff 35 24 15 00 00    	pushl  0x1524
 29a:	e8 73 08 00 00       	call   b12 <kthread_mutex_lock>
	if(!assumption)
 29f:	83 c4 10             	add    $0x10,%esp
 2a2:	85 c0                	test   %eax,%eax
 2a4:	0f 88 86 01 00 00    	js     430 <main+0x430>

		thread = kthread_create(plus_three, malloc(MAX_STACK_SIZE), MAX_STACK_SIZE);
 2aa:	83 ec 0c             	sub    $0xc,%esp
 2ad:	68 00 04 00 00       	push   $0x400
 2b2:	e8 79 0b 00 00       	call   e30 <malloc>
 2b7:	83 c4 0c             	add    $0xc,%esp
 2ba:	68 00 04 00 00       	push   $0x400
 2bf:	50                   	push   %eax
 2c0:	68 e0 06 00 00       	push   $0x6e0
 2c5:	e8 18 08 00 00       	call   ae2 <kthread_create>
	if(!assumption)
 2ca:	83 c4 10             	add    $0x10,%esp
 2cd:	85 c0                	test   %eax,%eax
		thread = kthread_create(plus_three, malloc(MAX_STACK_SIZE), MAX_STACK_SIZE);
 2cf:	89 c6                	mov    %eax,%esi
	if(!assumption)
 2d1:	0f 88 41 01 00 00    	js     418 <main+0x418>
		ASSERT(thread >= 0, "failed to create thread");
		thread_ids[0] = thread;

		thread = kthread_create(times_five, malloc(MAX_STACK_SIZE), MAX_STACK_SIZE);
 2d7:	83 ec 0c             	sub    $0xc,%esp
		thread_ids[0] = thread;
 2da:	89 35 10 15 00 00    	mov    %esi,0x1510
		thread = kthread_create(times_five, malloc(MAX_STACK_SIZE), MAX_STACK_SIZE);
 2e0:	68 00 04 00 00       	push   $0x400
 2e5:	e8 46 0b 00 00       	call   e30 <malloc>
 2ea:	83 c4 0c             	add    $0xc,%esp
 2ed:	68 00 04 00 00       	push   $0x400
 2f2:	50                   	push   %eax
 2f3:	68 70 07 00 00       	push   $0x770
 2f8:	e8 e5 07 00 00       	call   ae2 <kthread_create>
	if(!assumption)
 2fd:	83 c4 10             	add    $0x10,%esp
 300:	85 c0                	test   %eax,%eax
		thread = kthread_create(times_five, malloc(MAX_STACK_SIZE), MAX_STACK_SIZE);
 302:	89 c6                	mov    %eax,%esi
	if(!assumption)
 304:	0f 88 f6 00 00 00    	js     400 <main+0x400>
		ASSERT(thread >= 0, "failed to create thread");
		thread_ids[1] = thread;

		ASSERT(kthread_join(thread_ids[0]) >= 0, "failed to join thread");
 30a:	83 ec 0c             	sub    $0xc,%esp
 30d:	ff 35 10 15 00 00    	pushl  0x1510
		thread_ids[1] = thread;
 313:	89 35 14 15 00 00    	mov    %esi,0x1514
		ASSERT(kthread_join(thread_ids[0]) >= 0, "failed to join thread");
 319:	e8 dc 07 00 00       	call   afa <kthread_join>
	if(!assumption)
 31e:	83 c4 10             	add    $0x10,%esp
 321:	85 c0                	test   %eax,%eax
 323:	0f 88 bf 00 00 00    	js     3e8 <main+0x3e8>
		ASSERT(kthread_join(thread_ids[1]) >= 0, "failed to join thread");
 329:	83 ec 0c             	sub    $0xc,%esp
 32c:	ff 35 14 15 00 00    	pushl  0x1514
 332:	e8 c3 07 00 00       	call   afa <kthread_join>
	if(!assumption)
 337:	83 c4 10             	add    $0x10,%esp
 33a:	85 c0                	test   %eax,%eax
 33c:	0f 88 8e 00 00 00    	js     3d0 <main+0x3d0>
	for(int i=0; i<5; i++)
 342:	83 eb 01             	sub    $0x1,%ebx
 345:	0f 85 46 ff ff ff    	jne    291 <main+0x291>
	}

	expected = 17968;
	if(shared != expected)
 34b:	a1 28 15 00 00       	mov    0x1528,%eax
 350:	3d 30 46 00 00       	cmp    $0x4630,%eax
 355:	74 1e                	je     375 <main+0x375>
	{
		printf(stdout, "value=%d, expected=%d\n", shared, expected);
 357:	a1 28 15 00 00       	mov    0x1528,%eax
 35c:	68 30 46 00 00       	push   $0x4630
 361:	50                   	push   %eax
 362:	68 df 0f 00 00       	push   $0xfdf
 367:	ff 35 fc 14 00 00    	pushl  0x14fc
 36d:	e8 5e 08 00 00       	call   bd0 <printf>
 372:	83 c4 10             	add    $0x10,%esp
	}
	ASSERT(shared == expected, "shared variable does not have a correct value");
 375:	a1 28 15 00 00       	mov    0x1528,%eax
	if(!assumption)
 37a:	3d 30 46 00 00       	cmp    $0x4630,%eax
 37f:	74 0f                	je     390 <main+0x390>
 381:	ba a7 00 00 00       	mov    $0xa7,%edx
 386:	b8 3c 11 00 00       	mov    $0x113c,%eax
 38b:	e8 f0 01 00 00       	call   580 <assert.part.0>

	ASSERT(kthread_mutex_dealloc(mutex) >= 0, "failed to deallocate mutex");
 390:	83 ec 0c             	sub    $0xc,%esp
 393:	ff 35 24 15 00 00    	pushl  0x1524
 399:	e8 6c 07 00 00       	call   b0a <kthread_mutex_dealloc>
	if(!assumption)
 39e:	83 c4 10             	add    $0x10,%esp
 3a1:	85 c0                	test   %eax,%eax
 3a3:	0f 88 1b 01 00 00    	js     4c4 <main+0x4c4>
	printf(stdout, "%s\n", "test passed");
 3a9:	83 ec 04             	sub    $0x4,%esp
 3ac:	68 f6 0f 00 00       	push   $0xff6
 3b1:	68 40 0f 00 00       	push   $0xf40
 3b6:	ff 35 fc 14 00 00    	pushl  0x14fc
 3bc:	e8 0f 08 00 00       	call   bd0 <printf>
	exit();
 3c1:	e8 7c 06 00 00       	call   a42 <exit>
 3c6:	8d 76 00             	lea    0x0(%esi),%esi
 3c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 3d0:	ba 9f 00 00 00       	mov    $0x9f,%edx
 3d5:	b8 c9 0f 00 00       	mov    $0xfc9,%eax
 3da:	e8 a1 01 00 00       	call   580 <assert.part.0>
 3df:	e9 5e ff ff ff       	jmp    342 <main+0x342>
 3e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3e8:	ba 9e 00 00 00       	mov    $0x9e,%edx
 3ed:	b8 c9 0f 00 00       	mov    $0xfc9,%eax
 3f2:	e8 89 01 00 00       	call   580 <assert.part.0>
 3f7:	e9 2d ff ff ff       	jmp    329 <main+0x329>
 3fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 400:	ba 9b 00 00 00       	mov    $0x9b,%edx
 405:	b8 b1 0f 00 00       	mov    $0xfb1,%eax
 40a:	e8 71 01 00 00       	call   580 <assert.part.0>
 40f:	e9 f6 fe ff ff       	jmp    30a <main+0x30a>
 414:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 418:	ba 97 00 00 00       	mov    $0x97,%edx
 41d:	b8 b1 0f 00 00       	mov    $0xfb1,%eax
 422:	e8 59 01 00 00       	call   580 <assert.part.0>
 427:	e9 ab fe ff ff       	jmp    2d7 <main+0x2d7>
 42c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 430:	ba 94 00 00 00       	mov    $0x94,%edx
 435:	b8 6a 0f 00 00       	mov    $0xf6a,%eax
 43a:	e8 41 01 00 00       	call   580 <assert.part.0>
 43f:	e9 66 fe ff ff       	jmp    2aa <main+0x2aa>
 444:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 448:	ba 83 00 00 00       	mov    $0x83,%edx
 44d:	b8 c9 0f 00 00       	mov    $0xfc9,%eax
 452:	e8 29 01 00 00       	call   580 <assert.part.0>
 457:	e9 ea fd ff ff       	jmp    246 <main+0x246>
 45c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 460:	ba 79 00 00 00       	mov    $0x79,%edx
 465:	b8 b1 0f 00 00       	mov    $0xfb1,%eax
 46a:	e8 11 01 00 00       	call   580 <assert.part.0>
 46f:	e9 74 fd ff ff       	jmp    1e8 <main+0x1e8>
 474:	ba 5e 00 00 00       	mov    $0x5e,%edx
 479:	b8 96 0f 00 00       	mov    $0xf96,%eax
 47e:	e8 fd 00 00 00       	call   580 <assert.part.0>
 483:	e9 0f fc ff ff       	jmp    97 <main+0x97>
 488:	ba 5d 00 00 00       	mov    $0x5d,%edx
 48d:	b8 51 0f 00 00       	mov    $0xf51,%eax
 492:	e8 e9 00 00 00       	call   580 <assert.part.0>
 497:	e9 e7 fb ff ff       	jmp    83 <main+0x83>
 49c:	ba 7f 00 00 00       	mov    $0x7f,%edx
 4a1:	b8 7f 0f 00 00       	mov    $0xf7f,%eax
 4a6:	e8 d5 00 00 00       	call   580 <assert.part.0>
 4ab:	e9 7a fd ff ff       	jmp    22a <main+0x22a>
 4b0:	ba 7e 00 00 00       	mov    $0x7e,%edx
 4b5:	b8 10 11 00 00       	mov    $0x1110,%eax
 4ba:	e8 c1 00 00 00       	call   580 <assert.part.0>
 4bf:	e9 4d fd ff ff       	jmp    211 <main+0x211>
 4c4:	ba a9 00 00 00       	mov    $0xa9,%edx
 4c9:	b8 96 0f 00 00       	mov    $0xf96,%eax
 4ce:	e8 ad 00 00 00       	call   580 <assert.part.0>
 4d3:	e9 d1 fe ff ff       	jmp    3a9 <main+0x3a9>
 4d8:	ba 73 00 00 00       	mov    $0x73,%edx
 4dd:	b8 6a 0f 00 00       	mov    $0xf6a,%eax
 4e2:	e8 99 00 00 00       	call   580 <assert.part.0>
 4e7:	e9 c3 fc ff ff       	jmp    1af <main+0x1af>
 4ec:	ba 70 00 00 00       	mov    $0x70,%edx
 4f1:	b8 7f 0f 00 00       	mov    $0xf7f,%eax
 4f6:	e8 85 00 00 00       	call   580 <assert.part.0>
 4fb:	e9 96 fc ff ff       	jmp    196 <main+0x196>
 500:	ba 6e 00 00 00       	mov    $0x6e,%edx
 505:	b8 c9 0f 00 00       	mov    $0xfc9,%eax
 50a:	e8 71 00 00 00       	call   580 <assert.part.0>
 50f:	e9 69 fc ff ff       	jmp    17d <main+0x17d>
 514:	ba 6d 00 00 00       	mov    $0x6d,%edx
 519:	b8 b1 0f 00 00       	mov    $0xfb1,%eax
 51e:	e8 5d 00 00 00       	call   580 <assert.part.0>
 523:	e9 41 fc ff ff       	jmp    169 <main+0x169>
 528:	ba 6a 00 00 00       	mov    $0x6a,%edx
 52d:	b8 96 0f 00 00       	mov    $0xf96,%eax
 532:	e8 49 00 00 00       	call   580 <assert.part.0>
 537:	e9 00 fc ff ff       	jmp    13c <main+0x13c>
 53c:	ba 69 00 00 00       	mov    $0x69,%edx
 541:	b8 7f 0f 00 00       	mov    $0xf7f,%eax
 546:	e8 35 00 00 00       	call   580 <assert.part.0>
 54b:	e9 d3 fb ff ff       	jmp    123 <main+0x123>
 550:	ba 66 00 00 00       	mov    $0x66,%edx
 555:	b8 6a 0f 00 00       	mov    $0xf6a,%eax
 55a:	e8 21 00 00 00       	call   580 <assert.part.0>
 55f:	e9 82 fb ff ff       	jmp    e6 <main+0xe6>
 564:	b8 51 0f 00 00       	mov    $0xf51,%eax
 569:	ba 63 00 00 00       	mov    $0x63,%edx
 56e:	e8 0d 00 00 00       	call   580 <assert.part.0>
 573:	a1 24 15 00 00       	mov    0x1524,%eax
 578:	e9 31 fb ff ff       	jmp    ae <main+0xae>
 57d:	66 90                	xchg   %ax,%ax
 57f:	90                   	nop

00000580 <assert.part.0>:
assert(_Bool assumption, char* errMsg, int curLine)
 580:	55                   	push   %ebp
 581:	89 e5                	mov    %esp,%ebp
 583:	53                   	push   %ebx
 584:	89 c3                	mov    %eax,%ebx
 586:	83 ec 04             	sub    $0x4,%esp
		printf(stdout, "at %s:%d, ", __FILE__, curLine);
 589:	52                   	push   %edx
 58a:	68 28 0f 00 00       	push   $0xf28
 58f:	68 35 0f 00 00       	push   $0xf35
 594:	ff 35 fc 14 00 00    	pushl  0x14fc
 59a:	e8 31 06 00 00       	call   bd0 <printf>
		printf(stdout, "%s\n", errMsg);
 59f:	83 c4 0c             	add    $0xc,%esp
 5a2:	53                   	push   %ebx
 5a3:	68 40 0f 00 00       	push   $0xf40
 5a8:	ff 35 fc 14 00 00    	pushl  0x14fc
 5ae:	e8 1d 06 00 00       	call   bd0 <printf>
		printf(stdout, "test failed\n");
 5b3:	58                   	pop    %eax
 5b4:	5a                   	pop    %edx
 5b5:	68 44 0f 00 00       	push   $0xf44
 5ba:	ff 35 fc 14 00 00    	pushl  0x14fc
 5c0:	e8 0b 06 00 00       	call   bd0 <printf>
		kill(pid);
 5c5:	59                   	pop    %ecx
 5c6:	ff 35 0c 15 00 00    	pushl  0x150c
 5cc:	e8 a1 04 00 00       	call   a72 <kill>
 5d1:	83 c4 10             	add    $0x10,%esp
}
 5d4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 5d7:	c9                   	leave  
 5d8:	c3                   	ret    
 5d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000005e0 <allocate_and_lock>:
{
 5e0:	55                   	push   %ebp
 5e1:	89 e5                	mov    %esp,%ebp
 5e3:	83 ec 08             	sub    $0x8,%esp
	mutex = kthread_mutex_alloc();
 5e6:	e8 17 05 00 00       	call   b02 <kthread_mutex_alloc>
	if(!assumption)
 5eb:	85 c0                	test   %eax,%eax
	mutex = kthread_mutex_alloc();
 5ed:	a3 24 15 00 00       	mov    %eax,0x1524
	if(!assumption)
 5f2:	78 44                	js     638 <allocate_and_lock+0x58>
	ASSERT(kthread_mutex_lock(mutex) >= 0, "failed to lock mutex");
 5f4:	83 ec 0c             	sub    $0xc,%esp
 5f7:	50                   	push   %eax
 5f8:	e8 15 05 00 00       	call   b12 <kthread_mutex_lock>
	if(!assumption)
 5fd:	83 c4 10             	add    $0x10,%esp
 600:	85 c0                	test   %eax,%eax
 602:	78 1c                	js     620 <allocate_and_lock+0x40>
	kthread_exit();
 604:	e8 e9 04 00 00       	call   af2 <kthread_exit>
 609:	b8 04 10 00 00       	mov    $0x1004,%eax
 60e:	ba 23 00 00 00       	mov    $0x23,%edx
 613:	e8 68 ff ff ff       	call   580 <assert.part.0>
}
 618:	31 c0                	xor    %eax,%eax
 61a:	c9                   	leave  
 61b:	c3                   	ret    
 61c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 620:	ba 21 00 00 00       	mov    $0x21,%edx
 625:	b8 6a 0f 00 00       	mov    $0xf6a,%eax
 62a:	e8 51 ff ff ff       	call   580 <assert.part.0>
 62f:	eb d3                	jmp    604 <allocate_and_lock+0x24>
 631:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 638:	b8 51 0f 00 00       	mov    $0xf51,%eax
 63d:	ba 20 00 00 00       	mov    $0x20,%edx
 642:	e8 39 ff ff ff       	call   580 <assert.part.0>
 647:	a1 24 15 00 00       	mov    0x1524,%eax
 64c:	eb a6                	jmp    5f4 <allocate_and_lock+0x14>
 64e:	66 90                	xchg   %ax,%ax

00000650 <increment>:
{
 650:	55                   	push   %ebp
 651:	89 e5                	mov    %esp,%ebp
 653:	83 ec 14             	sub    $0x14,%esp
	ASSERT(kthread_mutex_lock(mutex) >= 0, "failed to lock mutex");
 656:	ff 35 24 15 00 00    	pushl  0x1524
 65c:	e8 b1 04 00 00       	call   b12 <kthread_mutex_lock>
	if(!assumption)
 661:	83 c4 10             	add    $0x10,%esp
 664:	85 c0                	test   %eax,%eax
 666:	78 58                	js     6c0 <increment+0x70>
	shared++;
 668:	a1 28 15 00 00       	mov    0x1528,%eax
	ASSERT(kthread_mutex_unlock(mutex) >= 0, "failed to unlock mutex");
 66d:	83 ec 0c             	sub    $0xc,%esp
 670:	ff 35 24 15 00 00    	pushl  0x1524
	shared++;
 676:	83 c0 01             	add    $0x1,%eax
 679:	a3 28 15 00 00       	mov    %eax,0x1528
	ASSERT(kthread_mutex_unlock(mutex) >= 0, "failed to unlock mutex");
 67e:	e8 97 04 00 00       	call   b1a <kthread_mutex_unlock>
	if(!assumption)
 683:	83 c4 10             	add    $0x10,%esp
 686:	85 c0                	test   %eax,%eax
 688:	78 1e                	js     6a8 <increment+0x58>
	kthread_exit();
 68a:	e8 63 04 00 00       	call   af2 <kthread_exit>
 68f:	b8 04 10 00 00       	mov    $0x1004,%eax
 694:	ba 2f 00 00 00       	mov    $0x2f,%edx
 699:	e8 e2 fe ff ff       	call   580 <assert.part.0>
}
 69e:	31 c0                	xor    %eax,%eax
 6a0:	c9                   	leave  
 6a1:	c3                   	ret    
 6a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 6a8:	ba 2c 00 00 00       	mov    $0x2c,%edx
 6ad:	b8 7f 0f 00 00       	mov    $0xf7f,%eax
 6b2:	e8 c9 fe ff ff       	call   580 <assert.part.0>
 6b7:	eb d1                	jmp    68a <increment+0x3a>
 6b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6c0:	ba 2a 00 00 00       	mov    $0x2a,%edx
 6c5:	b8 6a 0f 00 00       	mov    $0xf6a,%eax
 6ca:	e8 b1 fe ff ff       	call   580 <assert.part.0>
 6cf:	eb 97                	jmp    668 <increment+0x18>
 6d1:	eb 0d                	jmp    6e0 <plus_three>
 6d3:	90                   	nop
 6d4:	90                   	nop
 6d5:	90                   	nop
 6d6:	90                   	nop
 6d7:	90                   	nop
 6d8:	90                   	nop
 6d9:	90                   	nop
 6da:	90                   	nop
 6db:	90                   	nop
 6dc:	90                   	nop
 6dd:	90                   	nop
 6de:	90                   	nop
 6df:	90                   	nop

000006e0 <plus_three>:
{
 6e0:	55                   	push   %ebp
 6e1:	89 e5                	mov    %esp,%ebp
 6e3:	83 ec 14             	sub    $0x14,%esp
	ASSERT(kthread_mutex_lock(mutex) >= 0, "failed to lock mutex");
 6e6:	ff 35 24 15 00 00    	pushl  0x1524
 6ec:	e8 21 04 00 00       	call   b12 <kthread_mutex_lock>
	if(!assumption)
 6f1:	83 c4 10             	add    $0x10,%esp
 6f4:	85 c0                	test   %eax,%eax
 6f6:	78 58                	js     750 <plus_three+0x70>
	shared += 3;
 6f8:	a1 28 15 00 00       	mov    0x1528,%eax
	ASSERT(kthread_mutex_unlock(mutex) >= 0, "failed to unlock mutex"); 
 6fd:	83 ec 0c             	sub    $0xc,%esp
 700:	ff 35 24 15 00 00    	pushl  0x1524
	shared += 3;
 706:	83 c0 03             	add    $0x3,%eax
 709:	a3 28 15 00 00       	mov    %eax,0x1528
	ASSERT(kthread_mutex_unlock(mutex) >= 0, "failed to unlock mutex"); 
 70e:	e8 07 04 00 00       	call   b1a <kthread_mutex_unlock>
	if(!assumption)
 713:	83 c4 10             	add    $0x10,%esp
 716:	85 c0                	test   %eax,%eax
 718:	78 1e                	js     738 <plus_three+0x58>
	kthread_exit();
 71a:	e8 d3 03 00 00       	call   af2 <kthread_exit>
 71f:	b8 04 10 00 00       	mov    $0x1004,%eax
 724:	ba 3c 00 00 00       	mov    $0x3c,%edx
 729:	e8 52 fe ff ff       	call   580 <assert.part.0>
}
 72e:	31 c0                	xor    %eax,%eax
 730:	c9                   	leave  
 731:	c3                   	ret    
 732:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 738:	ba 39 00 00 00       	mov    $0x39,%edx
 73d:	b8 7f 0f 00 00       	mov    $0xf7f,%eax
 742:	e8 39 fe ff ff       	call   580 <assert.part.0>
 747:	eb d1                	jmp    71a <plus_three+0x3a>
 749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 750:	ba 37 00 00 00       	mov    $0x37,%edx
 755:	b8 6a 0f 00 00       	mov    $0xf6a,%eax
 75a:	e8 21 fe ff ff       	call   580 <assert.part.0>
 75f:	eb 97                	jmp    6f8 <plus_three+0x18>
 761:	eb 0d                	jmp    770 <times_five>
 763:	90                   	nop
 764:	90                   	nop
 765:	90                   	nop
 766:	90                   	nop
 767:	90                   	nop
 768:	90                   	nop
 769:	90                   	nop
 76a:	90                   	nop
 76b:	90                   	nop
 76c:	90                   	nop
 76d:	90                   	nop
 76e:	90                   	nop
 76f:	90                   	nop

00000770 <times_five>:
{
 770:	55                   	push   %ebp
 771:	89 e5                	mov    %esp,%ebp
 773:	83 ec 14             	sub    $0x14,%esp
	shared *= 5;
 776:	a1 28 15 00 00       	mov    0x1528,%eax
	ASSERT(kthread_mutex_unlock(mutex) >= 0, "failed to unlock mutex"); 
 77b:	ff 35 24 15 00 00    	pushl  0x1524
	shared *= 5;
 781:	8d 04 80             	lea    (%eax,%eax,4),%eax
 784:	a3 28 15 00 00       	mov    %eax,0x1528
	ASSERT(kthread_mutex_unlock(mutex) >= 0, "failed to unlock mutex"); 
 789:	e8 8c 03 00 00       	call   b1a <kthread_mutex_unlock>
	if(!assumption)
 78e:	83 c4 10             	add    $0x10,%esp
 791:	85 c0                	test   %eax,%eax
 793:	78 1b                	js     7b0 <times_five+0x40>
	kthread_exit();
 795:	e8 58 03 00 00       	call   af2 <kthread_exit>
 79a:	b8 04 10 00 00       	mov    $0x1004,%eax
 79f:	ba 48 00 00 00       	mov    $0x48,%edx
 7a4:	e8 d7 fd ff ff       	call   580 <assert.part.0>
}
 7a9:	31 c0                	xor    %eax,%eax
 7ab:	c9                   	leave  
 7ac:	c3                   	ret    
 7ad:	8d 76 00             	lea    0x0(%esi),%esi
 7b0:	ba 45 00 00 00       	mov    $0x45,%edx
 7b5:	b8 7f 0f 00 00       	mov    $0xf7f,%eax
 7ba:	e8 c1 fd ff ff       	call   580 <assert.part.0>
 7bf:	eb d4                	jmp    795 <times_five+0x25>
 7c1:	eb 0d                	jmp    7d0 <assert>
 7c3:	90                   	nop
 7c4:	90                   	nop
 7c5:	90                   	nop
 7c6:	90                   	nop
 7c7:	90                   	nop
 7c8:	90                   	nop
 7c9:	90                   	nop
 7ca:	90                   	nop
 7cb:	90                   	nop
 7cc:	90                   	nop
 7cd:	90                   	nop
 7ce:	90                   	nop
 7cf:	90                   	nop

000007d0 <assert>:
{
 7d0:	55                   	push   %ebp
 7d1:	89 e5                	mov    %esp,%ebp
	if(!assumption)
 7d3:	80 7d 08 00          	cmpb   $0x0,0x8(%ebp)
{
 7d7:	8b 45 0c             	mov    0xc(%ebp),%eax
 7da:	8b 55 10             	mov    0x10(%ebp),%edx
	if(!assumption)
 7dd:	74 09                	je     7e8 <assert+0x18>
}
 7df:	5d                   	pop    %ebp
 7e0:	c3                   	ret    
 7e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7e8:	5d                   	pop    %ebp
 7e9:	e9 92 fd ff ff       	jmp    580 <assert.part.0>
 7ee:	66 90                	xchg   %ax,%ax

000007f0 <strcpy>:
 7f0:	55                   	push   %ebp
 7f1:	89 e5                	mov    %esp,%ebp
 7f3:	53                   	push   %ebx
 7f4:	8b 45 08             	mov    0x8(%ebp),%eax
 7f7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 7fa:	89 c2                	mov    %eax,%edx
 7fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 800:	83 c1 01             	add    $0x1,%ecx
 803:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 807:	83 c2 01             	add    $0x1,%edx
 80a:	84 db                	test   %bl,%bl
 80c:	88 5a ff             	mov    %bl,-0x1(%edx)
 80f:	75 ef                	jne    800 <strcpy+0x10>
 811:	5b                   	pop    %ebx
 812:	5d                   	pop    %ebp
 813:	c3                   	ret    
 814:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 81a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000820 <strcmp>:
 820:	55                   	push   %ebp
 821:	89 e5                	mov    %esp,%ebp
 823:	53                   	push   %ebx
 824:	8b 55 08             	mov    0x8(%ebp),%edx
 827:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 82a:	0f b6 02             	movzbl (%edx),%eax
 82d:	0f b6 19             	movzbl (%ecx),%ebx
 830:	84 c0                	test   %al,%al
 832:	75 1c                	jne    850 <strcmp+0x30>
 834:	eb 2a                	jmp    860 <strcmp+0x40>
 836:	8d 76 00             	lea    0x0(%esi),%esi
 839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 840:	83 c2 01             	add    $0x1,%edx
 843:	0f b6 02             	movzbl (%edx),%eax
 846:	83 c1 01             	add    $0x1,%ecx
 849:	0f b6 19             	movzbl (%ecx),%ebx
 84c:	84 c0                	test   %al,%al
 84e:	74 10                	je     860 <strcmp+0x40>
 850:	38 d8                	cmp    %bl,%al
 852:	74 ec                	je     840 <strcmp+0x20>
 854:	29 d8                	sub    %ebx,%eax
 856:	5b                   	pop    %ebx
 857:	5d                   	pop    %ebp
 858:	c3                   	ret    
 859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 860:	31 c0                	xor    %eax,%eax
 862:	29 d8                	sub    %ebx,%eax
 864:	5b                   	pop    %ebx
 865:	5d                   	pop    %ebp
 866:	c3                   	ret    
 867:	89 f6                	mov    %esi,%esi
 869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000870 <strlen>:
 870:	55                   	push   %ebp
 871:	89 e5                	mov    %esp,%ebp
 873:	8b 4d 08             	mov    0x8(%ebp),%ecx
 876:	80 39 00             	cmpb   $0x0,(%ecx)
 879:	74 15                	je     890 <strlen+0x20>
 87b:	31 d2                	xor    %edx,%edx
 87d:	8d 76 00             	lea    0x0(%esi),%esi
 880:	83 c2 01             	add    $0x1,%edx
 883:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 887:	89 d0                	mov    %edx,%eax
 889:	75 f5                	jne    880 <strlen+0x10>
 88b:	5d                   	pop    %ebp
 88c:	c3                   	ret    
 88d:	8d 76 00             	lea    0x0(%esi),%esi
 890:	31 c0                	xor    %eax,%eax
 892:	5d                   	pop    %ebp
 893:	c3                   	ret    
 894:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 89a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000008a0 <memset>:
 8a0:	55                   	push   %ebp
 8a1:	89 e5                	mov    %esp,%ebp
 8a3:	57                   	push   %edi
 8a4:	8b 55 08             	mov    0x8(%ebp),%edx
 8a7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 8aa:	8b 45 0c             	mov    0xc(%ebp),%eax
 8ad:	89 d7                	mov    %edx,%edi
 8af:	fc                   	cld    
 8b0:	f3 aa                	rep stos %al,%es:(%edi)
 8b2:	89 d0                	mov    %edx,%eax
 8b4:	5f                   	pop    %edi
 8b5:	5d                   	pop    %ebp
 8b6:	c3                   	ret    
 8b7:	89 f6                	mov    %esi,%esi
 8b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000008c0 <strchr>:
 8c0:	55                   	push   %ebp
 8c1:	89 e5                	mov    %esp,%ebp
 8c3:	53                   	push   %ebx
 8c4:	8b 45 08             	mov    0x8(%ebp),%eax
 8c7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 8ca:	0f b6 10             	movzbl (%eax),%edx
 8cd:	84 d2                	test   %dl,%dl
 8cf:	74 1d                	je     8ee <strchr+0x2e>
 8d1:	38 d3                	cmp    %dl,%bl
 8d3:	89 d9                	mov    %ebx,%ecx
 8d5:	75 0d                	jne    8e4 <strchr+0x24>
 8d7:	eb 17                	jmp    8f0 <strchr+0x30>
 8d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8e0:	38 ca                	cmp    %cl,%dl
 8e2:	74 0c                	je     8f0 <strchr+0x30>
 8e4:	83 c0 01             	add    $0x1,%eax
 8e7:	0f b6 10             	movzbl (%eax),%edx
 8ea:	84 d2                	test   %dl,%dl
 8ec:	75 f2                	jne    8e0 <strchr+0x20>
 8ee:	31 c0                	xor    %eax,%eax
 8f0:	5b                   	pop    %ebx
 8f1:	5d                   	pop    %ebp
 8f2:	c3                   	ret    
 8f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 8f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000900 <gets>:
 900:	55                   	push   %ebp
 901:	89 e5                	mov    %esp,%ebp
 903:	57                   	push   %edi
 904:	56                   	push   %esi
 905:	53                   	push   %ebx
 906:	31 f6                	xor    %esi,%esi
 908:	89 f3                	mov    %esi,%ebx
 90a:	83 ec 1c             	sub    $0x1c,%esp
 90d:	8b 7d 08             	mov    0x8(%ebp),%edi
 910:	eb 2f                	jmp    941 <gets+0x41>
 912:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 918:	8d 45 e7             	lea    -0x19(%ebp),%eax
 91b:	83 ec 04             	sub    $0x4,%esp
 91e:	6a 01                	push   $0x1
 920:	50                   	push   %eax
 921:	6a 00                	push   $0x0
 923:	e8 32 01 00 00       	call   a5a <read>
 928:	83 c4 10             	add    $0x10,%esp
 92b:	85 c0                	test   %eax,%eax
 92d:	7e 1c                	jle    94b <gets+0x4b>
 92f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 933:	83 c7 01             	add    $0x1,%edi
 936:	88 47 ff             	mov    %al,-0x1(%edi)
 939:	3c 0a                	cmp    $0xa,%al
 93b:	74 23                	je     960 <gets+0x60>
 93d:	3c 0d                	cmp    $0xd,%al
 93f:	74 1f                	je     960 <gets+0x60>
 941:	83 c3 01             	add    $0x1,%ebx
 944:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 947:	89 fe                	mov    %edi,%esi
 949:	7c cd                	jl     918 <gets+0x18>
 94b:	89 f3                	mov    %esi,%ebx
 94d:	8b 45 08             	mov    0x8(%ebp),%eax
 950:	c6 03 00             	movb   $0x0,(%ebx)
 953:	8d 65 f4             	lea    -0xc(%ebp),%esp
 956:	5b                   	pop    %ebx
 957:	5e                   	pop    %esi
 958:	5f                   	pop    %edi
 959:	5d                   	pop    %ebp
 95a:	c3                   	ret    
 95b:	90                   	nop
 95c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 960:	8b 75 08             	mov    0x8(%ebp),%esi
 963:	8b 45 08             	mov    0x8(%ebp),%eax
 966:	01 de                	add    %ebx,%esi
 968:	89 f3                	mov    %esi,%ebx
 96a:	c6 03 00             	movb   $0x0,(%ebx)
 96d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 970:	5b                   	pop    %ebx
 971:	5e                   	pop    %esi
 972:	5f                   	pop    %edi
 973:	5d                   	pop    %ebp
 974:	c3                   	ret    
 975:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000980 <stat>:
 980:	55                   	push   %ebp
 981:	89 e5                	mov    %esp,%ebp
 983:	56                   	push   %esi
 984:	53                   	push   %ebx
 985:	83 ec 08             	sub    $0x8,%esp
 988:	6a 00                	push   $0x0
 98a:	ff 75 08             	pushl  0x8(%ebp)
 98d:	e8 f0 00 00 00       	call   a82 <open>
 992:	83 c4 10             	add    $0x10,%esp
 995:	85 c0                	test   %eax,%eax
 997:	78 27                	js     9c0 <stat+0x40>
 999:	83 ec 08             	sub    $0x8,%esp
 99c:	ff 75 0c             	pushl  0xc(%ebp)
 99f:	89 c3                	mov    %eax,%ebx
 9a1:	50                   	push   %eax
 9a2:	e8 f3 00 00 00       	call   a9a <fstat>
 9a7:	89 1c 24             	mov    %ebx,(%esp)
 9aa:	89 c6                	mov    %eax,%esi
 9ac:	e8 b9 00 00 00       	call   a6a <close>
 9b1:	83 c4 10             	add    $0x10,%esp
 9b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 9b7:	89 f0                	mov    %esi,%eax
 9b9:	5b                   	pop    %ebx
 9ba:	5e                   	pop    %esi
 9bb:	5d                   	pop    %ebp
 9bc:	c3                   	ret    
 9bd:	8d 76 00             	lea    0x0(%esi),%esi
 9c0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 9c5:	eb ed                	jmp    9b4 <stat+0x34>
 9c7:	89 f6                	mov    %esi,%esi
 9c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000009d0 <atoi>:
 9d0:	55                   	push   %ebp
 9d1:	89 e5                	mov    %esp,%ebp
 9d3:	53                   	push   %ebx
 9d4:	8b 4d 08             	mov    0x8(%ebp),%ecx
 9d7:	0f be 11             	movsbl (%ecx),%edx
 9da:	8d 42 d0             	lea    -0x30(%edx),%eax
 9dd:	3c 09                	cmp    $0x9,%al
 9df:	b8 00 00 00 00       	mov    $0x0,%eax
 9e4:	77 1f                	ja     a05 <atoi+0x35>
 9e6:	8d 76 00             	lea    0x0(%esi),%esi
 9e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 9f0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 9f3:	83 c1 01             	add    $0x1,%ecx
 9f6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
 9fa:	0f be 11             	movsbl (%ecx),%edx
 9fd:	8d 5a d0             	lea    -0x30(%edx),%ebx
 a00:	80 fb 09             	cmp    $0x9,%bl
 a03:	76 eb                	jbe    9f0 <atoi+0x20>
 a05:	5b                   	pop    %ebx
 a06:	5d                   	pop    %ebp
 a07:	c3                   	ret    
 a08:	90                   	nop
 a09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000a10 <memmove>:
 a10:	55                   	push   %ebp
 a11:	89 e5                	mov    %esp,%ebp
 a13:	56                   	push   %esi
 a14:	53                   	push   %ebx
 a15:	8b 5d 10             	mov    0x10(%ebp),%ebx
 a18:	8b 45 08             	mov    0x8(%ebp),%eax
 a1b:	8b 75 0c             	mov    0xc(%ebp),%esi
 a1e:	85 db                	test   %ebx,%ebx
 a20:	7e 14                	jle    a36 <memmove+0x26>
 a22:	31 d2                	xor    %edx,%edx
 a24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 a28:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 a2c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 a2f:	83 c2 01             	add    $0x1,%edx
 a32:	39 d3                	cmp    %edx,%ebx
 a34:	75 f2                	jne    a28 <memmove+0x18>
 a36:	5b                   	pop    %ebx
 a37:	5e                   	pop    %esi
 a38:	5d                   	pop    %ebp
 a39:	c3                   	ret    

00000a3a <fork>:
 a3a:	b8 01 00 00 00       	mov    $0x1,%eax
 a3f:	cd 40                	int    $0x40
 a41:	c3                   	ret    

00000a42 <exit>:
 a42:	b8 02 00 00 00       	mov    $0x2,%eax
 a47:	cd 40                	int    $0x40
 a49:	c3                   	ret    

00000a4a <wait>:
 a4a:	b8 03 00 00 00       	mov    $0x3,%eax
 a4f:	cd 40                	int    $0x40
 a51:	c3                   	ret    

00000a52 <pipe>:
 a52:	b8 04 00 00 00       	mov    $0x4,%eax
 a57:	cd 40                	int    $0x40
 a59:	c3                   	ret    

00000a5a <read>:
 a5a:	b8 05 00 00 00       	mov    $0x5,%eax
 a5f:	cd 40                	int    $0x40
 a61:	c3                   	ret    

00000a62 <write>:
 a62:	b8 10 00 00 00       	mov    $0x10,%eax
 a67:	cd 40                	int    $0x40
 a69:	c3                   	ret    

00000a6a <close>:
 a6a:	b8 15 00 00 00       	mov    $0x15,%eax
 a6f:	cd 40                	int    $0x40
 a71:	c3                   	ret    

00000a72 <kill>:
 a72:	b8 06 00 00 00       	mov    $0x6,%eax
 a77:	cd 40                	int    $0x40
 a79:	c3                   	ret    

00000a7a <exec>:
 a7a:	b8 07 00 00 00       	mov    $0x7,%eax
 a7f:	cd 40                	int    $0x40
 a81:	c3                   	ret    

00000a82 <open>:
 a82:	b8 0f 00 00 00       	mov    $0xf,%eax
 a87:	cd 40                	int    $0x40
 a89:	c3                   	ret    

00000a8a <mknod>:
 a8a:	b8 11 00 00 00       	mov    $0x11,%eax
 a8f:	cd 40                	int    $0x40
 a91:	c3                   	ret    

00000a92 <unlink>:
 a92:	b8 12 00 00 00       	mov    $0x12,%eax
 a97:	cd 40                	int    $0x40
 a99:	c3                   	ret    

00000a9a <fstat>:
 a9a:	b8 08 00 00 00       	mov    $0x8,%eax
 a9f:	cd 40                	int    $0x40
 aa1:	c3                   	ret    

00000aa2 <link>:
 aa2:	b8 13 00 00 00       	mov    $0x13,%eax
 aa7:	cd 40                	int    $0x40
 aa9:	c3                   	ret    

00000aaa <mkdir>:
 aaa:	b8 14 00 00 00       	mov    $0x14,%eax
 aaf:	cd 40                	int    $0x40
 ab1:	c3                   	ret    

00000ab2 <chdir>:
 ab2:	b8 09 00 00 00       	mov    $0x9,%eax
 ab7:	cd 40                	int    $0x40
 ab9:	c3                   	ret    

00000aba <dup>:
 aba:	b8 0a 00 00 00       	mov    $0xa,%eax
 abf:	cd 40                	int    $0x40
 ac1:	c3                   	ret    

00000ac2 <getpid>:
 ac2:	b8 0b 00 00 00       	mov    $0xb,%eax
 ac7:	cd 40                	int    $0x40
 ac9:	c3                   	ret    

00000aca <sbrk>:
 aca:	b8 0c 00 00 00       	mov    $0xc,%eax
 acf:	cd 40                	int    $0x40
 ad1:	c3                   	ret    

00000ad2 <sleep>:
 ad2:	b8 0d 00 00 00       	mov    $0xd,%eax
 ad7:	cd 40                	int    $0x40
 ad9:	c3                   	ret    

00000ada <uptime>:
 ada:	b8 0e 00 00 00       	mov    $0xe,%eax
 adf:	cd 40                	int    $0x40
 ae1:	c3                   	ret    

00000ae2 <kthread_create>:
 ae2:	b8 16 00 00 00       	mov    $0x16,%eax
 ae7:	cd 40                	int    $0x40
 ae9:	c3                   	ret    

00000aea <kthread_id>:
 aea:	b8 17 00 00 00       	mov    $0x17,%eax
 aef:	cd 40                	int    $0x40
 af1:	c3                   	ret    

00000af2 <kthread_exit>:
 af2:	b8 18 00 00 00       	mov    $0x18,%eax
 af7:	cd 40                	int    $0x40
 af9:	c3                   	ret    

00000afa <kthread_join>:
 afa:	b8 19 00 00 00       	mov    $0x19,%eax
 aff:	cd 40                	int    $0x40
 b01:	c3                   	ret    

00000b02 <kthread_mutex_alloc>:
 b02:	b8 1a 00 00 00       	mov    $0x1a,%eax
 b07:	cd 40                	int    $0x40
 b09:	c3                   	ret    

00000b0a <kthread_mutex_dealloc>:
 b0a:	b8 1b 00 00 00       	mov    $0x1b,%eax
 b0f:	cd 40                	int    $0x40
 b11:	c3                   	ret    

00000b12 <kthread_mutex_lock>:
 b12:	b8 1c 00 00 00       	mov    $0x1c,%eax
 b17:	cd 40                	int    $0x40
 b19:	c3                   	ret    

00000b1a <kthread_mutex_unlock>:
 b1a:	b8 1d 00 00 00       	mov    $0x1d,%eax
 b1f:	cd 40                	int    $0x40
 b21:	c3                   	ret    

00000b22 <procdump>:
 b22:	b8 1e 00 00 00       	mov    $0x1e,%eax
 b27:	cd 40                	int    $0x40
 b29:	c3                   	ret    
 b2a:	66 90                	xchg   %ax,%ax
 b2c:	66 90                	xchg   %ax,%ax
 b2e:	66 90                	xchg   %ax,%ax

00000b30 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 b30:	55                   	push   %ebp
 b31:	89 e5                	mov    %esp,%ebp
 b33:	57                   	push   %edi
 b34:	56                   	push   %esi
 b35:	53                   	push   %ebx
 b36:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 b39:	85 d2                	test   %edx,%edx
{
 b3b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 b3e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 b40:	79 76                	jns    bb8 <printint+0x88>
 b42:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 b46:	74 70                	je     bb8 <printint+0x88>
    x = -xx;
 b48:	f7 d8                	neg    %eax
    neg = 1;
 b4a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 b51:	31 f6                	xor    %esi,%esi
 b53:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 b56:	eb 0a                	jmp    b62 <printint+0x32>
 b58:	90                   	nop
 b59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 b60:	89 fe                	mov    %edi,%esi
 b62:	31 d2                	xor    %edx,%edx
 b64:	8d 7e 01             	lea    0x1(%esi),%edi
 b67:	f7 f1                	div    %ecx
 b69:	0f b6 92 74 11 00 00 	movzbl 0x1174(%edx),%edx
  }while((x /= base) != 0);
 b70:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 b72:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 b75:	75 e9                	jne    b60 <printint+0x30>
  if(neg)
 b77:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 b7a:	85 c0                	test   %eax,%eax
 b7c:	74 08                	je     b86 <printint+0x56>
    buf[i++] = '-';
 b7e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 b83:	8d 7e 02             	lea    0x2(%esi),%edi
 b86:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 b8a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 b8d:	8d 76 00             	lea    0x0(%esi),%esi
 b90:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 b93:	83 ec 04             	sub    $0x4,%esp
 b96:	83 ee 01             	sub    $0x1,%esi
 b99:	6a 01                	push   $0x1
 b9b:	53                   	push   %ebx
 b9c:	57                   	push   %edi
 b9d:	88 45 d7             	mov    %al,-0x29(%ebp)
 ba0:	e8 bd fe ff ff       	call   a62 <write>

  while(--i >= 0)
 ba5:	83 c4 10             	add    $0x10,%esp
 ba8:	39 de                	cmp    %ebx,%esi
 baa:	75 e4                	jne    b90 <printint+0x60>
    putc(fd, buf[i]);
}
 bac:	8d 65 f4             	lea    -0xc(%ebp),%esp
 baf:	5b                   	pop    %ebx
 bb0:	5e                   	pop    %esi
 bb1:	5f                   	pop    %edi
 bb2:	5d                   	pop    %ebp
 bb3:	c3                   	ret    
 bb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 bb8:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 bbf:	eb 90                	jmp    b51 <printint+0x21>
 bc1:	eb 0d                	jmp    bd0 <printf>
 bc3:	90                   	nop
 bc4:	90                   	nop
 bc5:	90                   	nop
 bc6:	90                   	nop
 bc7:	90                   	nop
 bc8:	90                   	nop
 bc9:	90                   	nop
 bca:	90                   	nop
 bcb:	90                   	nop
 bcc:	90                   	nop
 bcd:	90                   	nop
 bce:	90                   	nop
 bcf:	90                   	nop

00000bd0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 bd0:	55                   	push   %ebp
 bd1:	89 e5                	mov    %esp,%ebp
 bd3:	57                   	push   %edi
 bd4:	56                   	push   %esi
 bd5:	53                   	push   %ebx
 bd6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 bd9:	8b 75 0c             	mov    0xc(%ebp),%esi
 bdc:	0f b6 1e             	movzbl (%esi),%ebx
 bdf:	84 db                	test   %bl,%bl
 be1:	0f 84 b3 00 00 00    	je     c9a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 be7:	8d 45 10             	lea    0x10(%ebp),%eax
 bea:	83 c6 01             	add    $0x1,%esi
  state = 0;
 bed:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 bef:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 bf2:	eb 2f                	jmp    c23 <printf+0x53>
 bf4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 bf8:	83 f8 25             	cmp    $0x25,%eax
 bfb:	0f 84 a7 00 00 00    	je     ca8 <printf+0xd8>
  write(fd, &c, 1);
 c01:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 c04:	83 ec 04             	sub    $0x4,%esp
 c07:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 c0a:	6a 01                	push   $0x1
 c0c:	50                   	push   %eax
 c0d:	ff 75 08             	pushl  0x8(%ebp)
 c10:	e8 4d fe ff ff       	call   a62 <write>
 c15:	83 c4 10             	add    $0x10,%esp
 c18:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 c1b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 c1f:	84 db                	test   %bl,%bl
 c21:	74 77                	je     c9a <printf+0xca>
    if(state == 0){
 c23:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 c25:	0f be cb             	movsbl %bl,%ecx
 c28:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 c2b:	74 cb                	je     bf8 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 c2d:	83 ff 25             	cmp    $0x25,%edi
 c30:	75 e6                	jne    c18 <printf+0x48>
      if(c == 'd'){
 c32:	83 f8 64             	cmp    $0x64,%eax
 c35:	0f 84 05 01 00 00    	je     d40 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 c3b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 c41:	83 f9 70             	cmp    $0x70,%ecx
 c44:	74 72                	je     cb8 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 c46:	83 f8 73             	cmp    $0x73,%eax
 c49:	0f 84 99 00 00 00    	je     ce8 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 c4f:	83 f8 63             	cmp    $0x63,%eax
 c52:	0f 84 08 01 00 00    	je     d60 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 c58:	83 f8 25             	cmp    $0x25,%eax
 c5b:	0f 84 ef 00 00 00    	je     d50 <printf+0x180>
  write(fd, &c, 1);
 c61:	8d 45 e7             	lea    -0x19(%ebp),%eax
 c64:	83 ec 04             	sub    $0x4,%esp
 c67:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 c6b:	6a 01                	push   $0x1
 c6d:	50                   	push   %eax
 c6e:	ff 75 08             	pushl  0x8(%ebp)
 c71:	e8 ec fd ff ff       	call   a62 <write>
 c76:	83 c4 0c             	add    $0xc,%esp
 c79:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 c7c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 c7f:	6a 01                	push   $0x1
 c81:	50                   	push   %eax
 c82:	ff 75 08             	pushl  0x8(%ebp)
 c85:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 c88:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 c8a:	e8 d3 fd ff ff       	call   a62 <write>
  for(i = 0; fmt[i]; i++){
 c8f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 c93:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 c96:	84 db                	test   %bl,%bl
 c98:	75 89                	jne    c23 <printf+0x53>
    }
  }
}
 c9a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 c9d:	5b                   	pop    %ebx
 c9e:	5e                   	pop    %esi
 c9f:	5f                   	pop    %edi
 ca0:	5d                   	pop    %ebp
 ca1:	c3                   	ret    
 ca2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 ca8:	bf 25 00 00 00       	mov    $0x25,%edi
 cad:	e9 66 ff ff ff       	jmp    c18 <printf+0x48>
 cb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 cb8:	83 ec 0c             	sub    $0xc,%esp
 cbb:	b9 10 00 00 00       	mov    $0x10,%ecx
 cc0:	6a 00                	push   $0x0
 cc2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 cc5:	8b 45 08             	mov    0x8(%ebp),%eax
 cc8:	8b 17                	mov    (%edi),%edx
 cca:	e8 61 fe ff ff       	call   b30 <printint>
        ap++;
 ccf:	89 f8                	mov    %edi,%eax
 cd1:	83 c4 10             	add    $0x10,%esp
      state = 0;
 cd4:	31 ff                	xor    %edi,%edi
        ap++;
 cd6:	83 c0 04             	add    $0x4,%eax
 cd9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 cdc:	e9 37 ff ff ff       	jmp    c18 <printf+0x48>
 ce1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 ce8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 ceb:	8b 08                	mov    (%eax),%ecx
        ap++;
 ced:	83 c0 04             	add    $0x4,%eax
 cf0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 cf3:	85 c9                	test   %ecx,%ecx
 cf5:	0f 84 8e 00 00 00    	je     d89 <printf+0x1b9>
        while(*s != 0){
 cfb:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 cfe:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 d00:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 d02:	84 c0                	test   %al,%al
 d04:	0f 84 0e ff ff ff    	je     c18 <printf+0x48>
 d0a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 d0d:	89 de                	mov    %ebx,%esi
 d0f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 d12:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 d15:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 d18:	83 ec 04             	sub    $0x4,%esp
          s++;
 d1b:	83 c6 01             	add    $0x1,%esi
 d1e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 d21:	6a 01                	push   $0x1
 d23:	57                   	push   %edi
 d24:	53                   	push   %ebx
 d25:	e8 38 fd ff ff       	call   a62 <write>
        while(*s != 0){
 d2a:	0f b6 06             	movzbl (%esi),%eax
 d2d:	83 c4 10             	add    $0x10,%esp
 d30:	84 c0                	test   %al,%al
 d32:	75 e4                	jne    d18 <printf+0x148>
 d34:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 d37:	31 ff                	xor    %edi,%edi
 d39:	e9 da fe ff ff       	jmp    c18 <printf+0x48>
 d3e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 d40:	83 ec 0c             	sub    $0xc,%esp
 d43:	b9 0a 00 00 00       	mov    $0xa,%ecx
 d48:	6a 01                	push   $0x1
 d4a:	e9 73 ff ff ff       	jmp    cc2 <printf+0xf2>
 d4f:	90                   	nop
  write(fd, &c, 1);
 d50:	83 ec 04             	sub    $0x4,%esp
 d53:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 d56:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 d59:	6a 01                	push   $0x1
 d5b:	e9 21 ff ff ff       	jmp    c81 <printf+0xb1>
        putc(fd, *ap);
 d60:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 d63:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 d66:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 d68:	6a 01                	push   $0x1
        ap++;
 d6a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 d6d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 d70:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 d73:	50                   	push   %eax
 d74:	ff 75 08             	pushl  0x8(%ebp)
 d77:	e8 e6 fc ff ff       	call   a62 <write>
        ap++;
 d7c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 d7f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 d82:	31 ff                	xor    %edi,%edi
 d84:	e9 8f fe ff ff       	jmp    c18 <printf+0x48>
          s = "(null)";
 d89:	bb 6c 11 00 00       	mov    $0x116c,%ebx
        while(*s != 0){
 d8e:	b8 28 00 00 00       	mov    $0x28,%eax
 d93:	e9 72 ff ff ff       	jmp    d0a <printf+0x13a>
 d98:	66 90                	xchg   %ax,%ax
 d9a:	66 90                	xchg   %ax,%ax
 d9c:	66 90                	xchg   %ax,%ax
 d9e:	66 90                	xchg   %ax,%ax

00000da0 <free>:
 da0:	55                   	push   %ebp
 da1:	a1 00 15 00 00       	mov    0x1500,%eax
 da6:	89 e5                	mov    %esp,%ebp
 da8:	57                   	push   %edi
 da9:	56                   	push   %esi
 daa:	53                   	push   %ebx
 dab:	8b 5d 08             	mov    0x8(%ebp),%ebx
 dae:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 db1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 db8:	39 c8                	cmp    %ecx,%eax
 dba:	8b 10                	mov    (%eax),%edx
 dbc:	73 32                	jae    df0 <free+0x50>
 dbe:	39 d1                	cmp    %edx,%ecx
 dc0:	72 04                	jb     dc6 <free+0x26>
 dc2:	39 d0                	cmp    %edx,%eax
 dc4:	72 32                	jb     df8 <free+0x58>
 dc6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 dc9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 dcc:	39 fa                	cmp    %edi,%edx
 dce:	74 30                	je     e00 <free+0x60>
 dd0:	89 53 f8             	mov    %edx,-0x8(%ebx)
 dd3:	8b 50 04             	mov    0x4(%eax),%edx
 dd6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 dd9:	39 f1                	cmp    %esi,%ecx
 ddb:	74 3a                	je     e17 <free+0x77>
 ddd:	89 08                	mov    %ecx,(%eax)
 ddf:	a3 00 15 00 00       	mov    %eax,0x1500
 de4:	5b                   	pop    %ebx
 de5:	5e                   	pop    %esi
 de6:	5f                   	pop    %edi
 de7:	5d                   	pop    %ebp
 de8:	c3                   	ret    
 de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 df0:	39 d0                	cmp    %edx,%eax
 df2:	72 04                	jb     df8 <free+0x58>
 df4:	39 d1                	cmp    %edx,%ecx
 df6:	72 ce                	jb     dc6 <free+0x26>
 df8:	89 d0                	mov    %edx,%eax
 dfa:	eb bc                	jmp    db8 <free+0x18>
 dfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 e00:	03 72 04             	add    0x4(%edx),%esi
 e03:	89 73 fc             	mov    %esi,-0x4(%ebx)
 e06:	8b 10                	mov    (%eax),%edx
 e08:	8b 12                	mov    (%edx),%edx
 e0a:	89 53 f8             	mov    %edx,-0x8(%ebx)
 e0d:	8b 50 04             	mov    0x4(%eax),%edx
 e10:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 e13:	39 f1                	cmp    %esi,%ecx
 e15:	75 c6                	jne    ddd <free+0x3d>
 e17:	03 53 fc             	add    -0x4(%ebx),%edx
 e1a:	a3 00 15 00 00       	mov    %eax,0x1500
 e1f:	89 50 04             	mov    %edx,0x4(%eax)
 e22:	8b 53 f8             	mov    -0x8(%ebx),%edx
 e25:	89 10                	mov    %edx,(%eax)
 e27:	5b                   	pop    %ebx
 e28:	5e                   	pop    %esi
 e29:	5f                   	pop    %edi
 e2a:	5d                   	pop    %ebp
 e2b:	c3                   	ret    
 e2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000e30 <malloc>:
 e30:	55                   	push   %ebp
 e31:	89 e5                	mov    %esp,%ebp
 e33:	57                   	push   %edi
 e34:	56                   	push   %esi
 e35:	53                   	push   %ebx
 e36:	83 ec 0c             	sub    $0xc,%esp
 e39:	8b 45 08             	mov    0x8(%ebp),%eax
 e3c:	8b 15 00 15 00 00    	mov    0x1500,%edx
 e42:	8d 78 07             	lea    0x7(%eax),%edi
 e45:	c1 ef 03             	shr    $0x3,%edi
 e48:	83 c7 01             	add    $0x1,%edi
 e4b:	85 d2                	test   %edx,%edx
 e4d:	0f 84 9d 00 00 00    	je     ef0 <malloc+0xc0>
 e53:	8b 02                	mov    (%edx),%eax
 e55:	8b 48 04             	mov    0x4(%eax),%ecx
 e58:	39 cf                	cmp    %ecx,%edi
 e5a:	76 6c                	jbe    ec8 <malloc+0x98>
 e5c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 e62:	bb 00 10 00 00       	mov    $0x1000,%ebx
 e67:	0f 43 df             	cmovae %edi,%ebx
 e6a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 e71:	eb 0e                	jmp    e81 <malloc+0x51>
 e73:	90                   	nop
 e74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 e78:	8b 02                	mov    (%edx),%eax
 e7a:	8b 48 04             	mov    0x4(%eax),%ecx
 e7d:	39 f9                	cmp    %edi,%ecx
 e7f:	73 47                	jae    ec8 <malloc+0x98>
 e81:	39 05 00 15 00 00    	cmp    %eax,0x1500
 e87:	89 c2                	mov    %eax,%edx
 e89:	75 ed                	jne    e78 <malloc+0x48>
 e8b:	83 ec 0c             	sub    $0xc,%esp
 e8e:	56                   	push   %esi
 e8f:	e8 36 fc ff ff       	call   aca <sbrk>
 e94:	83 c4 10             	add    $0x10,%esp
 e97:	83 f8 ff             	cmp    $0xffffffff,%eax
 e9a:	74 1c                	je     eb8 <malloc+0x88>
 e9c:	89 58 04             	mov    %ebx,0x4(%eax)
 e9f:	83 ec 0c             	sub    $0xc,%esp
 ea2:	83 c0 08             	add    $0x8,%eax
 ea5:	50                   	push   %eax
 ea6:	e8 f5 fe ff ff       	call   da0 <free>
 eab:	8b 15 00 15 00 00    	mov    0x1500,%edx
 eb1:	83 c4 10             	add    $0x10,%esp
 eb4:	85 d2                	test   %edx,%edx
 eb6:	75 c0                	jne    e78 <malloc+0x48>
 eb8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 ebb:	31 c0                	xor    %eax,%eax
 ebd:	5b                   	pop    %ebx
 ebe:	5e                   	pop    %esi
 ebf:	5f                   	pop    %edi
 ec0:	5d                   	pop    %ebp
 ec1:	c3                   	ret    
 ec2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 ec8:	39 cf                	cmp    %ecx,%edi
 eca:	74 54                	je     f20 <malloc+0xf0>
 ecc:	29 f9                	sub    %edi,%ecx
 ece:	89 48 04             	mov    %ecx,0x4(%eax)
 ed1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
 ed4:	89 78 04             	mov    %edi,0x4(%eax)
 ed7:	89 15 00 15 00 00    	mov    %edx,0x1500
 edd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 ee0:	83 c0 08             	add    $0x8,%eax
 ee3:	5b                   	pop    %ebx
 ee4:	5e                   	pop    %esi
 ee5:	5f                   	pop    %edi
 ee6:	5d                   	pop    %ebp
 ee7:	c3                   	ret    
 ee8:	90                   	nop
 ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 ef0:	c7 05 00 15 00 00 04 	movl   $0x1504,0x1500
 ef7:	15 00 00 
 efa:	c7 05 04 15 00 00 04 	movl   $0x1504,0x1504
 f01:	15 00 00 
 f04:	b8 04 15 00 00       	mov    $0x1504,%eax
 f09:	c7 05 08 15 00 00 00 	movl   $0x0,0x1508
 f10:	00 00 00 
 f13:	e9 44 ff ff ff       	jmp    e5c <malloc+0x2c>
 f18:	90                   	nop
 f19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 f20:	8b 08                	mov    (%eax),%ecx
 f22:	89 0a                	mov    %ecx,(%edx)
 f24:	eb b1                	jmp    ed7 <malloc+0xa7>
