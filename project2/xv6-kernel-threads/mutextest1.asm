
_mutextest1:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
	kthread_exit();
	printf(1,"Error: returned from exit !!");
}

int main(int argc, char** argv)
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
	printf(1,"~~~~~~~~~~~~~~~~~~ mutex test 1 ~~~~~~~~~~~~~~~~~~\n");
  13:	68 fc 09 00 00       	push   $0x9fc
  18:	6a 01                	push   $0x1
  1a:	e8 41 06 00 00       	call   660 <printf>
	int input,i;
	mutex = kthread_mutex_alloc();
  1f:	e8 6e 05 00 00       	call   592 <kthread_mutex_alloc>

	if(mutex<0) {
  24:	83 c4 10             	add    $0x10,%esp
  27:	85 c0                	test   %eax,%eax
	mutex = kthread_mutex_alloc();
  29:	a3 58 0e 00 00       	mov    %eax,0xe58
	if(mutex<0) {
  2e:	0f 88 73 01 00 00    	js     1a7 <main+0x1a7>
{
  34:	be 0f 00 00 00       	mov    $0xf,%esi
  39:	eb 58                	jmp    93 <main+0x93>
  3b:	90                   	nop
  3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

		printf(1,"joining on thread %d\n",tid);

		if(test) { printf(1,"Error: mutex didnt prevent writing!\n"); }

		input = kthread_mutex_unlock(mutex);
  40:	83 ec 0c             	sub    $0xc,%esp
  43:	ff 35 58 0e 00 00    	pushl  0xe58
  49:	e8 5c 05 00 00       	call   5aa <kthread_mutex_unlock>

		if(input<0) { printf(1,"Error: mutex didnt unlock!\n"); }
  4e:	83 c4 10             	add    $0x10,%esp
  51:	85 c0                	test   %eax,%eax
  53:	0f 88 ef 00 00 00    	js     148 <main+0x148>

		kthread_join(tid);
  59:	83 ec 0c             	sub    $0xc,%esp
  5c:	53                   	push   %ebx
  5d:	e8 28 05 00 00       	call   58a <kthread_join>

		if(!test) { printf(1,"Error: thread didnt run!\n"); }
  62:	8b 0d 5c 0e 00 00    	mov    0xe5c,%ecx
  68:	83 c4 10             	add    $0x10,%esp
  6b:	85 c9                	test   %ecx,%ecx
  6d:	0f 84 a5 00 00 00    	je     118 <main+0x118>

		printf(1,"finished join\n");
  73:	83 ec 08             	sub    $0x8,%esp
  76:	68 3c 0b 00 00       	push   $0xb3c
  7b:	6a 01                	push   $0x1
  7d:	e8 de 05 00 00       	call   660 <printf>
	for(i = 0; i<15; i++) {
  82:	83 c4 10             	add    $0x10,%esp
  85:	83 ee 01             	sub    $0x1,%esi
  88:	0f 84 f2 00 00 00    	je     180 <main+0x180>
  8e:	a1 58 0e 00 00       	mov    0xe58,%eax
		input = kthread_mutex_lock(mutex);
  93:	83 ec 0c             	sub    $0xc,%esp
		test=0;
  96:	c7 05 5c 0e 00 00 00 	movl   $0x0,0xe5c
  9d:	00 00 00 
		input = kthread_mutex_lock(mutex);
  a0:	50                   	push   %eax
  a1:	e8 fc 04 00 00       	call   5a2 <kthread_mutex_lock>
		if(input<0) {
  a6:	83 c4 10             	add    $0x10,%esp
  a9:	85 c0                	test   %eax,%eax
  ab:	0f 88 af 00 00 00    	js     160 <main+0x160>
		char* stack = malloc(1024);
  b1:	83 ec 0c             	sub    $0xc,%esp
  b4:	68 00 04 00 00       	push   $0x400
  b9:	e8 02 08 00 00       	call   8c0 <malloc>
		int tid = kthread_create((void*)printer, stack, 1024);
  be:	83 c4 0c             	add    $0xc,%esp
  c1:	68 00 04 00 00       	push   $0x400
  c6:	50                   	push   %eax
  c7:	68 e0 01 00 00       	push   $0x1e0
  cc:	e8 a1 04 00 00       	call   572 <kthread_create>
		if(tid<0) { printf(1,"Thread wasnt created correctly! (%d)\n",tid); }
  d1:	83 c4 10             	add    $0x10,%esp
  d4:	85 c0                	test   %eax,%eax
		int tid = kthread_create((void*)printer, stack, 1024);
  d6:	89 c3                	mov    %eax,%ebx
		if(tid<0) { printf(1,"Thread wasnt created correctly! (%d)\n",tid); }
  d8:	78 56                	js     130 <main+0x130>
		printf(1,"joining on thread %d\n",tid);
  da:	83 ec 04             	sub    $0x4,%esp
  dd:	53                   	push   %ebx
  de:	68 f0 0a 00 00       	push   $0xaf0
  e3:	6a 01                	push   $0x1
  e5:	e8 76 05 00 00       	call   660 <printf>
		if(test) { printf(1,"Error: mutex didnt prevent writing!\n"); }
  ea:	a1 5c 0e 00 00       	mov    0xe5c,%eax
  ef:	83 c4 10             	add    $0x10,%esp
  f2:	85 c0                	test   %eax,%eax
  f4:	0f 84 46 ff ff ff    	je     40 <main+0x40>
  fa:	83 ec 08             	sub    $0x8,%esp
  fd:	68 98 0a 00 00       	push   $0xa98
 102:	6a 01                	push   $0x1
 104:	e8 57 05 00 00       	call   660 <printf>
 109:	83 c4 10             	add    $0x10,%esp
 10c:	e9 2f ff ff ff       	jmp    40 <main+0x40>
 111:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		if(!test) { printf(1,"Error: thread didnt run!\n"); }
 118:	83 ec 08             	sub    $0x8,%esp
 11b:	68 22 0b 00 00       	push   $0xb22
 120:	6a 01                	push   $0x1
 122:	e8 39 05 00 00       	call   660 <printf>
 127:	83 c4 10             	add    $0x10,%esp
 12a:	e9 44 ff ff ff       	jmp    73 <main+0x73>
 12f:	90                   	nop
		if(tid<0) { printf(1,"Thread wasnt created correctly! (%d)\n",tid); }
 130:	83 ec 04             	sub    $0x4,%esp
 133:	50                   	push   %eax
 134:	68 70 0a 00 00       	push   $0xa70
 139:	6a 01                	push   $0x1
 13b:	e8 20 05 00 00       	call   660 <printf>
 140:	83 c4 10             	add    $0x10,%esp
 143:	eb 95                	jmp    da <main+0xda>
 145:	8d 76 00             	lea    0x0(%esi),%esi
		if(input<0) { printf(1,"Error: mutex didnt unlock!\n"); }
 148:	83 ec 08             	sub    $0x8,%esp
 14b:	68 06 0b 00 00       	push   $0xb06
 150:	6a 01                	push   $0x1
 152:	e8 09 05 00 00       	call   660 <printf>
 157:	83 c4 10             	add    $0x10,%esp
 15a:	e9 fa fe ff ff       	jmp    59 <main+0x59>
 15f:	90                   	nop
			printf(1,"Error: mutex didnt lock! (%d)\n",input);
 160:	83 ec 04             	sub    $0x4,%esp
 163:	50                   	push   %eax
 164:	68 50 0a 00 00       	push   $0xa50
 169:	6a 01                	push   $0x1
 16b:	e8 f0 04 00 00       	call   660 <printf>
 170:	83 c4 10             	add    $0x10,%esp
 173:	e9 39 ff ff ff       	jmp    b1 <main+0xb1>
 178:	90                   	nop
 179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	}

	printf(1,"Finished.\n");
 180:	83 ec 08             	sub    $0x8,%esp
 183:	68 4b 0b 00 00       	push   $0xb4b
 188:	6a 01                	push   $0x1
 18a:	e8 d1 04 00 00       	call   660 <printf>

	input = kthread_mutex_dealloc(mutex);
 18f:	5a                   	pop    %edx
 190:	ff 35 58 0e 00 00    	pushl  0xe58
 196:	e8 ff 03 00 00       	call   59a <kthread_mutex_dealloc>

	if(input<0) {
 19b:	83 c4 10             	add    $0x10,%esp
 19e:	85 c0                	test   %eax,%eax
 1a0:	78 20                	js     1c2 <main+0x1c2>
		printf(1,"Error: mutex didnt dealloc!\n");
	}

	exit();
 1a2:	e8 2b 03 00 00       	call   4d2 <exit>
		printf(1,"Error: mutex didnt alloc! (%d)\n",mutex);
 1a7:	52                   	push   %edx
 1a8:	50                   	push   %eax
 1a9:	68 30 0a 00 00       	push   $0xa30
 1ae:	6a 01                	push   $0x1
 1b0:	e8 ab 04 00 00       	call   660 <printf>
 1b5:	a1 58 0e 00 00       	mov    0xe58,%eax
 1ba:	83 c4 10             	add    $0x10,%esp
 1bd:	e9 72 fe ff ff       	jmp    34 <main+0x34>
		printf(1,"Error: mutex didnt dealloc!\n");
 1c2:	50                   	push   %eax
 1c3:	50                   	push   %eax
 1c4:	68 56 0b 00 00       	push   $0xb56
 1c9:	6a 01                	push   $0x1
 1cb:	e8 90 04 00 00       	call   660 <printf>
 1d0:	83 c4 10             	add    $0x10,%esp
 1d3:	eb cd                	jmp    1a2 <main+0x1a2>
 1d5:	66 90                	xchg   %ax,%ax
 1d7:	66 90                	xchg   %ax,%ax
 1d9:	66 90                	xchg   %ax,%ax
 1db:	66 90                	xchg   %ax,%ax
 1dd:	66 90                	xchg   %ax,%ax
 1df:	90                   	nop

000001e0 <printer>:
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	83 ec 14             	sub    $0x14,%esp
	input = kthread_mutex_lock(mutex);
 1e6:	ff 35 58 0e 00 00    	pushl  0xe58
 1ec:	e8 b1 03 00 00       	call   5a2 <kthread_mutex_lock>
	if(input<0) {
 1f1:	83 c4 10             	add    $0x10,%esp
 1f4:	85 c0                	test   %eax,%eax
 1f6:	78 68                	js     260 <printer+0x80>
	printf(1,"thread %d said hi\n",kthread_id());
 1f8:	e8 7d 03 00 00       	call   57a <kthread_id>
 1fd:	83 ec 04             	sub    $0x4,%esp
 200:	50                   	push   %eax
 201:	68 c0 0a 00 00       	push   $0xac0
 206:	6a 01                	push   $0x1
 208:	e8 53 04 00 00       	call   660 <printf>
	input = kthread_mutex_unlock(mutex);
 20d:	58                   	pop    %eax
 20e:	ff 35 58 0e 00 00    	pushl  0xe58
	test=1;
 214:	c7 05 5c 0e 00 00 01 	movl   $0x1,0xe5c
 21b:	00 00 00 
	input = kthread_mutex_unlock(mutex);
 21e:	e8 87 03 00 00       	call   5aa <kthread_mutex_unlock>
	if(input<0) {
 223:	83 c4 10             	add    $0x10,%esp
 226:	85 c0                	test   %eax,%eax
 228:	78 1e                	js     248 <printer+0x68>
	kthread_exit();
 22a:	e8 53 03 00 00       	call   582 <kthread_exit>
	printf(1,"Error: returned from exit !!");
 22f:	83 ec 08             	sub    $0x8,%esp
 232:	68 d3 0a 00 00       	push   $0xad3
 237:	6a 01                	push   $0x1
 239:	e8 22 04 00 00       	call   660 <printf>
}
 23e:	83 c4 10             	add    $0x10,%esp
 241:	c9                   	leave  
 242:	c3                   	ret    
 243:	90                   	nop
 244:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		printf(1,"Error: thread mutex didnt unlock!");
 248:	83 ec 08             	sub    $0x8,%esp
 24b:	68 d8 09 00 00       	push   $0x9d8
 250:	6a 01                	push   $0x1
 252:	e8 09 04 00 00       	call   660 <printf>
 257:	83 c4 10             	add    $0x10,%esp
 25a:	eb ce                	jmp    22a <printer+0x4a>
 25c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		printf(1,"Error: thread mutex didnt lock!");
 260:	83 ec 08             	sub    $0x8,%esp
 263:	68 b8 09 00 00       	push   $0x9b8
 268:	6a 01                	push   $0x1
 26a:	e8 f1 03 00 00       	call   660 <printf>
 26f:	83 c4 10             	add    $0x10,%esp
 272:	eb 84                	jmp    1f8 <printer+0x18>
 274:	66 90                	xchg   %ax,%ax
 276:	66 90                	xchg   %ax,%ax
 278:	66 90                	xchg   %ax,%ax
 27a:	66 90                	xchg   %ax,%ax
 27c:	66 90                	xchg   %ax,%ax
 27e:	66 90                	xchg   %ax,%ax

00000280 <strcpy>:
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	53                   	push   %ebx
 284:	8b 45 08             	mov    0x8(%ebp),%eax
 287:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 28a:	89 c2                	mov    %eax,%edx
 28c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 290:	83 c1 01             	add    $0x1,%ecx
 293:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 297:	83 c2 01             	add    $0x1,%edx
 29a:	84 db                	test   %bl,%bl
 29c:	88 5a ff             	mov    %bl,-0x1(%edx)
 29f:	75 ef                	jne    290 <strcpy+0x10>
 2a1:	5b                   	pop    %ebx
 2a2:	5d                   	pop    %ebp
 2a3:	c3                   	ret    
 2a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000002b0 <strcmp>:
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	53                   	push   %ebx
 2b4:	8b 55 08             	mov    0x8(%ebp),%edx
 2b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 2ba:	0f b6 02             	movzbl (%edx),%eax
 2bd:	0f b6 19             	movzbl (%ecx),%ebx
 2c0:	84 c0                	test   %al,%al
 2c2:	75 1c                	jne    2e0 <strcmp+0x30>
 2c4:	eb 2a                	jmp    2f0 <strcmp+0x40>
 2c6:	8d 76 00             	lea    0x0(%esi),%esi
 2c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 2d0:	83 c2 01             	add    $0x1,%edx
 2d3:	0f b6 02             	movzbl (%edx),%eax
 2d6:	83 c1 01             	add    $0x1,%ecx
 2d9:	0f b6 19             	movzbl (%ecx),%ebx
 2dc:	84 c0                	test   %al,%al
 2de:	74 10                	je     2f0 <strcmp+0x40>
 2e0:	38 d8                	cmp    %bl,%al
 2e2:	74 ec                	je     2d0 <strcmp+0x20>
 2e4:	29 d8                	sub    %ebx,%eax
 2e6:	5b                   	pop    %ebx
 2e7:	5d                   	pop    %ebp
 2e8:	c3                   	ret    
 2e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2f0:	31 c0                	xor    %eax,%eax
 2f2:	29 d8                	sub    %ebx,%eax
 2f4:	5b                   	pop    %ebx
 2f5:	5d                   	pop    %ebp
 2f6:	c3                   	ret    
 2f7:	89 f6                	mov    %esi,%esi
 2f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000300 <strlen>:
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	8b 4d 08             	mov    0x8(%ebp),%ecx
 306:	80 39 00             	cmpb   $0x0,(%ecx)
 309:	74 15                	je     320 <strlen+0x20>
 30b:	31 d2                	xor    %edx,%edx
 30d:	8d 76 00             	lea    0x0(%esi),%esi
 310:	83 c2 01             	add    $0x1,%edx
 313:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 317:	89 d0                	mov    %edx,%eax
 319:	75 f5                	jne    310 <strlen+0x10>
 31b:	5d                   	pop    %ebp
 31c:	c3                   	ret    
 31d:	8d 76 00             	lea    0x0(%esi),%esi
 320:	31 c0                	xor    %eax,%eax
 322:	5d                   	pop    %ebp
 323:	c3                   	ret    
 324:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 32a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000330 <memset>:
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	57                   	push   %edi
 334:	8b 55 08             	mov    0x8(%ebp),%edx
 337:	8b 4d 10             	mov    0x10(%ebp),%ecx
 33a:	8b 45 0c             	mov    0xc(%ebp),%eax
 33d:	89 d7                	mov    %edx,%edi
 33f:	fc                   	cld    
 340:	f3 aa                	rep stos %al,%es:(%edi)
 342:	89 d0                	mov    %edx,%eax
 344:	5f                   	pop    %edi
 345:	5d                   	pop    %ebp
 346:	c3                   	ret    
 347:	89 f6                	mov    %esi,%esi
 349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000350 <strchr>:
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	53                   	push   %ebx
 354:	8b 45 08             	mov    0x8(%ebp),%eax
 357:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 35a:	0f b6 10             	movzbl (%eax),%edx
 35d:	84 d2                	test   %dl,%dl
 35f:	74 1d                	je     37e <strchr+0x2e>
 361:	38 d3                	cmp    %dl,%bl
 363:	89 d9                	mov    %ebx,%ecx
 365:	75 0d                	jne    374 <strchr+0x24>
 367:	eb 17                	jmp    380 <strchr+0x30>
 369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 370:	38 ca                	cmp    %cl,%dl
 372:	74 0c                	je     380 <strchr+0x30>
 374:	83 c0 01             	add    $0x1,%eax
 377:	0f b6 10             	movzbl (%eax),%edx
 37a:	84 d2                	test   %dl,%dl
 37c:	75 f2                	jne    370 <strchr+0x20>
 37e:	31 c0                	xor    %eax,%eax
 380:	5b                   	pop    %ebx
 381:	5d                   	pop    %ebp
 382:	c3                   	ret    
 383:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000390 <gets>:
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	57                   	push   %edi
 394:	56                   	push   %esi
 395:	53                   	push   %ebx
 396:	31 f6                	xor    %esi,%esi
 398:	89 f3                	mov    %esi,%ebx
 39a:	83 ec 1c             	sub    $0x1c,%esp
 39d:	8b 7d 08             	mov    0x8(%ebp),%edi
 3a0:	eb 2f                	jmp    3d1 <gets+0x41>
 3a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3a8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 3ab:	83 ec 04             	sub    $0x4,%esp
 3ae:	6a 01                	push   $0x1
 3b0:	50                   	push   %eax
 3b1:	6a 00                	push   $0x0
 3b3:	e8 32 01 00 00       	call   4ea <read>
 3b8:	83 c4 10             	add    $0x10,%esp
 3bb:	85 c0                	test   %eax,%eax
 3bd:	7e 1c                	jle    3db <gets+0x4b>
 3bf:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 3c3:	83 c7 01             	add    $0x1,%edi
 3c6:	88 47 ff             	mov    %al,-0x1(%edi)
 3c9:	3c 0a                	cmp    $0xa,%al
 3cb:	74 23                	je     3f0 <gets+0x60>
 3cd:	3c 0d                	cmp    $0xd,%al
 3cf:	74 1f                	je     3f0 <gets+0x60>
 3d1:	83 c3 01             	add    $0x1,%ebx
 3d4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 3d7:	89 fe                	mov    %edi,%esi
 3d9:	7c cd                	jl     3a8 <gets+0x18>
 3db:	89 f3                	mov    %esi,%ebx
 3dd:	8b 45 08             	mov    0x8(%ebp),%eax
 3e0:	c6 03 00             	movb   $0x0,(%ebx)
 3e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3e6:	5b                   	pop    %ebx
 3e7:	5e                   	pop    %esi
 3e8:	5f                   	pop    %edi
 3e9:	5d                   	pop    %ebp
 3ea:	c3                   	ret    
 3eb:	90                   	nop
 3ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3f0:	8b 75 08             	mov    0x8(%ebp),%esi
 3f3:	8b 45 08             	mov    0x8(%ebp),%eax
 3f6:	01 de                	add    %ebx,%esi
 3f8:	89 f3                	mov    %esi,%ebx
 3fa:	c6 03 00             	movb   $0x0,(%ebx)
 3fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 400:	5b                   	pop    %ebx
 401:	5e                   	pop    %esi
 402:	5f                   	pop    %edi
 403:	5d                   	pop    %ebp
 404:	c3                   	ret    
 405:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000410 <stat>:
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	56                   	push   %esi
 414:	53                   	push   %ebx
 415:	83 ec 08             	sub    $0x8,%esp
 418:	6a 00                	push   $0x0
 41a:	ff 75 08             	pushl  0x8(%ebp)
 41d:	e8 f0 00 00 00       	call   512 <open>
 422:	83 c4 10             	add    $0x10,%esp
 425:	85 c0                	test   %eax,%eax
 427:	78 27                	js     450 <stat+0x40>
 429:	83 ec 08             	sub    $0x8,%esp
 42c:	ff 75 0c             	pushl  0xc(%ebp)
 42f:	89 c3                	mov    %eax,%ebx
 431:	50                   	push   %eax
 432:	e8 f3 00 00 00       	call   52a <fstat>
 437:	89 1c 24             	mov    %ebx,(%esp)
 43a:	89 c6                	mov    %eax,%esi
 43c:	e8 b9 00 00 00       	call   4fa <close>
 441:	83 c4 10             	add    $0x10,%esp
 444:	8d 65 f8             	lea    -0x8(%ebp),%esp
 447:	89 f0                	mov    %esi,%eax
 449:	5b                   	pop    %ebx
 44a:	5e                   	pop    %esi
 44b:	5d                   	pop    %ebp
 44c:	c3                   	ret    
 44d:	8d 76 00             	lea    0x0(%esi),%esi
 450:	be ff ff ff ff       	mov    $0xffffffff,%esi
 455:	eb ed                	jmp    444 <stat+0x34>
 457:	89 f6                	mov    %esi,%esi
 459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000460 <atoi>:
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	53                   	push   %ebx
 464:	8b 4d 08             	mov    0x8(%ebp),%ecx
 467:	0f be 11             	movsbl (%ecx),%edx
 46a:	8d 42 d0             	lea    -0x30(%edx),%eax
 46d:	3c 09                	cmp    $0x9,%al
 46f:	b8 00 00 00 00       	mov    $0x0,%eax
 474:	77 1f                	ja     495 <atoi+0x35>
 476:	8d 76 00             	lea    0x0(%esi),%esi
 479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 480:	8d 04 80             	lea    (%eax,%eax,4),%eax
 483:	83 c1 01             	add    $0x1,%ecx
 486:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
 48a:	0f be 11             	movsbl (%ecx),%edx
 48d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 490:	80 fb 09             	cmp    $0x9,%bl
 493:	76 eb                	jbe    480 <atoi+0x20>
 495:	5b                   	pop    %ebx
 496:	5d                   	pop    %ebp
 497:	c3                   	ret    
 498:	90                   	nop
 499:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000004a0 <memmove>:
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	56                   	push   %esi
 4a4:	53                   	push   %ebx
 4a5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4a8:	8b 45 08             	mov    0x8(%ebp),%eax
 4ab:	8b 75 0c             	mov    0xc(%ebp),%esi
 4ae:	85 db                	test   %ebx,%ebx
 4b0:	7e 14                	jle    4c6 <memmove+0x26>
 4b2:	31 d2                	xor    %edx,%edx
 4b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4b8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 4bc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 4bf:	83 c2 01             	add    $0x1,%edx
 4c2:	39 d3                	cmp    %edx,%ebx
 4c4:	75 f2                	jne    4b8 <memmove+0x18>
 4c6:	5b                   	pop    %ebx
 4c7:	5e                   	pop    %esi
 4c8:	5d                   	pop    %ebp
 4c9:	c3                   	ret    

000004ca <fork>:
 4ca:	b8 01 00 00 00       	mov    $0x1,%eax
 4cf:	cd 40                	int    $0x40
 4d1:	c3                   	ret    

000004d2 <exit>:
 4d2:	b8 02 00 00 00       	mov    $0x2,%eax
 4d7:	cd 40                	int    $0x40
 4d9:	c3                   	ret    

000004da <wait>:
 4da:	b8 03 00 00 00       	mov    $0x3,%eax
 4df:	cd 40                	int    $0x40
 4e1:	c3                   	ret    

000004e2 <pipe>:
 4e2:	b8 04 00 00 00       	mov    $0x4,%eax
 4e7:	cd 40                	int    $0x40
 4e9:	c3                   	ret    

000004ea <read>:
 4ea:	b8 05 00 00 00       	mov    $0x5,%eax
 4ef:	cd 40                	int    $0x40
 4f1:	c3                   	ret    

000004f2 <write>:
 4f2:	b8 10 00 00 00       	mov    $0x10,%eax
 4f7:	cd 40                	int    $0x40
 4f9:	c3                   	ret    

000004fa <close>:
 4fa:	b8 15 00 00 00       	mov    $0x15,%eax
 4ff:	cd 40                	int    $0x40
 501:	c3                   	ret    

00000502 <kill>:
 502:	b8 06 00 00 00       	mov    $0x6,%eax
 507:	cd 40                	int    $0x40
 509:	c3                   	ret    

0000050a <exec>:
 50a:	b8 07 00 00 00       	mov    $0x7,%eax
 50f:	cd 40                	int    $0x40
 511:	c3                   	ret    

00000512 <open>:
 512:	b8 0f 00 00 00       	mov    $0xf,%eax
 517:	cd 40                	int    $0x40
 519:	c3                   	ret    

0000051a <mknod>:
 51a:	b8 11 00 00 00       	mov    $0x11,%eax
 51f:	cd 40                	int    $0x40
 521:	c3                   	ret    

00000522 <unlink>:
 522:	b8 12 00 00 00       	mov    $0x12,%eax
 527:	cd 40                	int    $0x40
 529:	c3                   	ret    

0000052a <fstat>:
 52a:	b8 08 00 00 00       	mov    $0x8,%eax
 52f:	cd 40                	int    $0x40
 531:	c3                   	ret    

00000532 <link>:
 532:	b8 13 00 00 00       	mov    $0x13,%eax
 537:	cd 40                	int    $0x40
 539:	c3                   	ret    

0000053a <mkdir>:
 53a:	b8 14 00 00 00       	mov    $0x14,%eax
 53f:	cd 40                	int    $0x40
 541:	c3                   	ret    

00000542 <chdir>:
 542:	b8 09 00 00 00       	mov    $0x9,%eax
 547:	cd 40                	int    $0x40
 549:	c3                   	ret    

0000054a <dup>:
 54a:	b8 0a 00 00 00       	mov    $0xa,%eax
 54f:	cd 40                	int    $0x40
 551:	c3                   	ret    

00000552 <getpid>:
 552:	b8 0b 00 00 00       	mov    $0xb,%eax
 557:	cd 40                	int    $0x40
 559:	c3                   	ret    

0000055a <sbrk>:
 55a:	b8 0c 00 00 00       	mov    $0xc,%eax
 55f:	cd 40                	int    $0x40
 561:	c3                   	ret    

00000562 <sleep>:
 562:	b8 0d 00 00 00       	mov    $0xd,%eax
 567:	cd 40                	int    $0x40
 569:	c3                   	ret    

0000056a <uptime>:
 56a:	b8 0e 00 00 00       	mov    $0xe,%eax
 56f:	cd 40                	int    $0x40
 571:	c3                   	ret    

00000572 <kthread_create>:
 572:	b8 16 00 00 00       	mov    $0x16,%eax
 577:	cd 40                	int    $0x40
 579:	c3                   	ret    

0000057a <kthread_id>:
 57a:	b8 17 00 00 00       	mov    $0x17,%eax
 57f:	cd 40                	int    $0x40
 581:	c3                   	ret    

00000582 <kthread_exit>:
 582:	b8 18 00 00 00       	mov    $0x18,%eax
 587:	cd 40                	int    $0x40
 589:	c3                   	ret    

0000058a <kthread_join>:
 58a:	b8 19 00 00 00       	mov    $0x19,%eax
 58f:	cd 40                	int    $0x40
 591:	c3                   	ret    

00000592 <kthread_mutex_alloc>:
 592:	b8 1a 00 00 00       	mov    $0x1a,%eax
 597:	cd 40                	int    $0x40
 599:	c3                   	ret    

0000059a <kthread_mutex_dealloc>:
 59a:	b8 1b 00 00 00       	mov    $0x1b,%eax
 59f:	cd 40                	int    $0x40
 5a1:	c3                   	ret    

000005a2 <kthread_mutex_lock>:
 5a2:	b8 1c 00 00 00       	mov    $0x1c,%eax
 5a7:	cd 40                	int    $0x40
 5a9:	c3                   	ret    

000005aa <kthread_mutex_unlock>:
 5aa:	b8 1d 00 00 00       	mov    $0x1d,%eax
 5af:	cd 40                	int    $0x40
 5b1:	c3                   	ret    

000005b2 <procdump>:
 5b2:	b8 1e 00 00 00       	mov    $0x1e,%eax
 5b7:	cd 40                	int    $0x40
 5b9:	c3                   	ret    
 5ba:	66 90                	xchg   %ax,%ax
 5bc:	66 90                	xchg   %ax,%ax
 5be:	66 90                	xchg   %ax,%ax

000005c0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 5c0:	55                   	push   %ebp
 5c1:	89 e5                	mov    %esp,%ebp
 5c3:	57                   	push   %edi
 5c4:	56                   	push   %esi
 5c5:	53                   	push   %ebx
 5c6:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5c9:	85 d2                	test   %edx,%edx
{
 5cb:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 5ce:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 5d0:	79 76                	jns    648 <printint+0x88>
 5d2:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 5d6:	74 70                	je     648 <printint+0x88>
    x = -xx;
 5d8:	f7 d8                	neg    %eax
    neg = 1;
 5da:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 5e1:	31 f6                	xor    %esi,%esi
 5e3:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 5e6:	eb 0a                	jmp    5f2 <printint+0x32>
 5e8:	90                   	nop
 5e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 5f0:	89 fe                	mov    %edi,%esi
 5f2:	31 d2                	xor    %edx,%edx
 5f4:	8d 7e 01             	lea    0x1(%esi),%edi
 5f7:	f7 f1                	div    %ecx
 5f9:	0f b6 92 7c 0b 00 00 	movzbl 0xb7c(%edx),%edx
  }while((x /= base) != 0);
 600:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 602:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 605:	75 e9                	jne    5f0 <printint+0x30>
  if(neg)
 607:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 60a:	85 c0                	test   %eax,%eax
 60c:	74 08                	je     616 <printint+0x56>
    buf[i++] = '-';
 60e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 613:	8d 7e 02             	lea    0x2(%esi),%edi
 616:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 61a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 61d:	8d 76 00             	lea    0x0(%esi),%esi
 620:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 623:	83 ec 04             	sub    $0x4,%esp
 626:	83 ee 01             	sub    $0x1,%esi
 629:	6a 01                	push   $0x1
 62b:	53                   	push   %ebx
 62c:	57                   	push   %edi
 62d:	88 45 d7             	mov    %al,-0x29(%ebp)
 630:	e8 bd fe ff ff       	call   4f2 <write>

  while(--i >= 0)
 635:	83 c4 10             	add    $0x10,%esp
 638:	39 de                	cmp    %ebx,%esi
 63a:	75 e4                	jne    620 <printint+0x60>
    putc(fd, buf[i]);
}
 63c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 63f:	5b                   	pop    %ebx
 640:	5e                   	pop    %esi
 641:	5f                   	pop    %edi
 642:	5d                   	pop    %ebp
 643:	c3                   	ret    
 644:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 648:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 64f:	eb 90                	jmp    5e1 <printint+0x21>
 651:	eb 0d                	jmp    660 <printf>
 653:	90                   	nop
 654:	90                   	nop
 655:	90                   	nop
 656:	90                   	nop
 657:	90                   	nop
 658:	90                   	nop
 659:	90                   	nop
 65a:	90                   	nop
 65b:	90                   	nop
 65c:	90                   	nop
 65d:	90                   	nop
 65e:	90                   	nop
 65f:	90                   	nop

00000660 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 660:	55                   	push   %ebp
 661:	89 e5                	mov    %esp,%ebp
 663:	57                   	push   %edi
 664:	56                   	push   %esi
 665:	53                   	push   %ebx
 666:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 669:	8b 75 0c             	mov    0xc(%ebp),%esi
 66c:	0f b6 1e             	movzbl (%esi),%ebx
 66f:	84 db                	test   %bl,%bl
 671:	0f 84 b3 00 00 00    	je     72a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 677:	8d 45 10             	lea    0x10(%ebp),%eax
 67a:	83 c6 01             	add    $0x1,%esi
  state = 0;
 67d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 67f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 682:	eb 2f                	jmp    6b3 <printf+0x53>
 684:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 688:	83 f8 25             	cmp    $0x25,%eax
 68b:	0f 84 a7 00 00 00    	je     738 <printf+0xd8>
  write(fd, &c, 1);
 691:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 694:	83 ec 04             	sub    $0x4,%esp
 697:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 69a:	6a 01                	push   $0x1
 69c:	50                   	push   %eax
 69d:	ff 75 08             	pushl  0x8(%ebp)
 6a0:	e8 4d fe ff ff       	call   4f2 <write>
 6a5:	83 c4 10             	add    $0x10,%esp
 6a8:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 6ab:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 6af:	84 db                	test   %bl,%bl
 6b1:	74 77                	je     72a <printf+0xca>
    if(state == 0){
 6b3:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 6b5:	0f be cb             	movsbl %bl,%ecx
 6b8:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 6bb:	74 cb                	je     688 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6bd:	83 ff 25             	cmp    $0x25,%edi
 6c0:	75 e6                	jne    6a8 <printf+0x48>
      if(c == 'd'){
 6c2:	83 f8 64             	cmp    $0x64,%eax
 6c5:	0f 84 05 01 00 00    	je     7d0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 6cb:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 6d1:	83 f9 70             	cmp    $0x70,%ecx
 6d4:	74 72                	je     748 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 6d6:	83 f8 73             	cmp    $0x73,%eax
 6d9:	0f 84 99 00 00 00    	je     778 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6df:	83 f8 63             	cmp    $0x63,%eax
 6e2:	0f 84 08 01 00 00    	je     7f0 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 6e8:	83 f8 25             	cmp    $0x25,%eax
 6eb:	0f 84 ef 00 00 00    	je     7e0 <printf+0x180>
  write(fd, &c, 1);
 6f1:	8d 45 e7             	lea    -0x19(%ebp),%eax
 6f4:	83 ec 04             	sub    $0x4,%esp
 6f7:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 6fb:	6a 01                	push   $0x1
 6fd:	50                   	push   %eax
 6fe:	ff 75 08             	pushl  0x8(%ebp)
 701:	e8 ec fd ff ff       	call   4f2 <write>
 706:	83 c4 0c             	add    $0xc,%esp
 709:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 70c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 70f:	6a 01                	push   $0x1
 711:	50                   	push   %eax
 712:	ff 75 08             	pushl  0x8(%ebp)
 715:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 718:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 71a:	e8 d3 fd ff ff       	call   4f2 <write>
  for(i = 0; fmt[i]; i++){
 71f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 723:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 726:	84 db                	test   %bl,%bl
 728:	75 89                	jne    6b3 <printf+0x53>
    }
  }
}
 72a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 72d:	5b                   	pop    %ebx
 72e:	5e                   	pop    %esi
 72f:	5f                   	pop    %edi
 730:	5d                   	pop    %ebp
 731:	c3                   	ret    
 732:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 738:	bf 25 00 00 00       	mov    $0x25,%edi
 73d:	e9 66 ff ff ff       	jmp    6a8 <printf+0x48>
 742:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 748:	83 ec 0c             	sub    $0xc,%esp
 74b:	b9 10 00 00 00       	mov    $0x10,%ecx
 750:	6a 00                	push   $0x0
 752:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 755:	8b 45 08             	mov    0x8(%ebp),%eax
 758:	8b 17                	mov    (%edi),%edx
 75a:	e8 61 fe ff ff       	call   5c0 <printint>
        ap++;
 75f:	89 f8                	mov    %edi,%eax
 761:	83 c4 10             	add    $0x10,%esp
      state = 0;
 764:	31 ff                	xor    %edi,%edi
        ap++;
 766:	83 c0 04             	add    $0x4,%eax
 769:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 76c:	e9 37 ff ff ff       	jmp    6a8 <printf+0x48>
 771:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 778:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 77b:	8b 08                	mov    (%eax),%ecx
        ap++;
 77d:	83 c0 04             	add    $0x4,%eax
 780:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 783:	85 c9                	test   %ecx,%ecx
 785:	0f 84 8e 00 00 00    	je     819 <printf+0x1b9>
        while(*s != 0){
 78b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 78e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 790:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 792:	84 c0                	test   %al,%al
 794:	0f 84 0e ff ff ff    	je     6a8 <printf+0x48>
 79a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 79d:	89 de                	mov    %ebx,%esi
 79f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 7a2:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 7a5:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 7a8:	83 ec 04             	sub    $0x4,%esp
          s++;
 7ab:	83 c6 01             	add    $0x1,%esi
 7ae:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 7b1:	6a 01                	push   $0x1
 7b3:	57                   	push   %edi
 7b4:	53                   	push   %ebx
 7b5:	e8 38 fd ff ff       	call   4f2 <write>
        while(*s != 0){
 7ba:	0f b6 06             	movzbl (%esi),%eax
 7bd:	83 c4 10             	add    $0x10,%esp
 7c0:	84 c0                	test   %al,%al
 7c2:	75 e4                	jne    7a8 <printf+0x148>
 7c4:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 7c7:	31 ff                	xor    %edi,%edi
 7c9:	e9 da fe ff ff       	jmp    6a8 <printf+0x48>
 7ce:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 7d0:	83 ec 0c             	sub    $0xc,%esp
 7d3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 7d8:	6a 01                	push   $0x1
 7da:	e9 73 ff ff ff       	jmp    752 <printf+0xf2>
 7df:	90                   	nop
  write(fd, &c, 1);
 7e0:	83 ec 04             	sub    $0x4,%esp
 7e3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 7e6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 7e9:	6a 01                	push   $0x1
 7eb:	e9 21 ff ff ff       	jmp    711 <printf+0xb1>
        putc(fd, *ap);
 7f0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 7f3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 7f6:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 7f8:	6a 01                	push   $0x1
        ap++;
 7fa:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 7fd:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 800:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 803:	50                   	push   %eax
 804:	ff 75 08             	pushl  0x8(%ebp)
 807:	e8 e6 fc ff ff       	call   4f2 <write>
        ap++;
 80c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 80f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 812:	31 ff                	xor    %edi,%edi
 814:	e9 8f fe ff ff       	jmp    6a8 <printf+0x48>
          s = "(null)";
 819:	bb 73 0b 00 00       	mov    $0xb73,%ebx
        while(*s != 0){
 81e:	b8 28 00 00 00       	mov    $0x28,%eax
 823:	e9 72 ff ff ff       	jmp    79a <printf+0x13a>
 828:	66 90                	xchg   %ax,%ax
 82a:	66 90                	xchg   %ax,%ax
 82c:	66 90                	xchg   %ax,%ax
 82e:	66 90                	xchg   %ax,%ax

00000830 <free>:
 830:	55                   	push   %ebp
 831:	a1 4c 0e 00 00       	mov    0xe4c,%eax
 836:	89 e5                	mov    %esp,%ebp
 838:	57                   	push   %edi
 839:	56                   	push   %esi
 83a:	53                   	push   %ebx
 83b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 83e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 841:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 848:	39 c8                	cmp    %ecx,%eax
 84a:	8b 10                	mov    (%eax),%edx
 84c:	73 32                	jae    880 <free+0x50>
 84e:	39 d1                	cmp    %edx,%ecx
 850:	72 04                	jb     856 <free+0x26>
 852:	39 d0                	cmp    %edx,%eax
 854:	72 32                	jb     888 <free+0x58>
 856:	8b 73 fc             	mov    -0x4(%ebx),%esi
 859:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 85c:	39 fa                	cmp    %edi,%edx
 85e:	74 30                	je     890 <free+0x60>
 860:	89 53 f8             	mov    %edx,-0x8(%ebx)
 863:	8b 50 04             	mov    0x4(%eax),%edx
 866:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 869:	39 f1                	cmp    %esi,%ecx
 86b:	74 3a                	je     8a7 <free+0x77>
 86d:	89 08                	mov    %ecx,(%eax)
 86f:	a3 4c 0e 00 00       	mov    %eax,0xe4c
 874:	5b                   	pop    %ebx
 875:	5e                   	pop    %esi
 876:	5f                   	pop    %edi
 877:	5d                   	pop    %ebp
 878:	c3                   	ret    
 879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 880:	39 d0                	cmp    %edx,%eax
 882:	72 04                	jb     888 <free+0x58>
 884:	39 d1                	cmp    %edx,%ecx
 886:	72 ce                	jb     856 <free+0x26>
 888:	89 d0                	mov    %edx,%eax
 88a:	eb bc                	jmp    848 <free+0x18>
 88c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 890:	03 72 04             	add    0x4(%edx),%esi
 893:	89 73 fc             	mov    %esi,-0x4(%ebx)
 896:	8b 10                	mov    (%eax),%edx
 898:	8b 12                	mov    (%edx),%edx
 89a:	89 53 f8             	mov    %edx,-0x8(%ebx)
 89d:	8b 50 04             	mov    0x4(%eax),%edx
 8a0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 8a3:	39 f1                	cmp    %esi,%ecx
 8a5:	75 c6                	jne    86d <free+0x3d>
 8a7:	03 53 fc             	add    -0x4(%ebx),%edx
 8aa:	a3 4c 0e 00 00       	mov    %eax,0xe4c
 8af:	89 50 04             	mov    %edx,0x4(%eax)
 8b2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 8b5:	89 10                	mov    %edx,(%eax)
 8b7:	5b                   	pop    %ebx
 8b8:	5e                   	pop    %esi
 8b9:	5f                   	pop    %edi
 8ba:	5d                   	pop    %ebp
 8bb:	c3                   	ret    
 8bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000008c0 <malloc>:
 8c0:	55                   	push   %ebp
 8c1:	89 e5                	mov    %esp,%ebp
 8c3:	57                   	push   %edi
 8c4:	56                   	push   %esi
 8c5:	53                   	push   %ebx
 8c6:	83 ec 0c             	sub    $0xc,%esp
 8c9:	8b 45 08             	mov    0x8(%ebp),%eax
 8cc:	8b 15 4c 0e 00 00    	mov    0xe4c,%edx
 8d2:	8d 78 07             	lea    0x7(%eax),%edi
 8d5:	c1 ef 03             	shr    $0x3,%edi
 8d8:	83 c7 01             	add    $0x1,%edi
 8db:	85 d2                	test   %edx,%edx
 8dd:	0f 84 9d 00 00 00    	je     980 <malloc+0xc0>
 8e3:	8b 02                	mov    (%edx),%eax
 8e5:	8b 48 04             	mov    0x4(%eax),%ecx
 8e8:	39 cf                	cmp    %ecx,%edi
 8ea:	76 6c                	jbe    958 <malloc+0x98>
 8ec:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 8f2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 8f7:	0f 43 df             	cmovae %edi,%ebx
 8fa:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 901:	eb 0e                	jmp    911 <malloc+0x51>
 903:	90                   	nop
 904:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 908:	8b 02                	mov    (%edx),%eax
 90a:	8b 48 04             	mov    0x4(%eax),%ecx
 90d:	39 f9                	cmp    %edi,%ecx
 90f:	73 47                	jae    958 <malloc+0x98>
 911:	39 05 4c 0e 00 00    	cmp    %eax,0xe4c
 917:	89 c2                	mov    %eax,%edx
 919:	75 ed                	jne    908 <malloc+0x48>
 91b:	83 ec 0c             	sub    $0xc,%esp
 91e:	56                   	push   %esi
 91f:	e8 36 fc ff ff       	call   55a <sbrk>
 924:	83 c4 10             	add    $0x10,%esp
 927:	83 f8 ff             	cmp    $0xffffffff,%eax
 92a:	74 1c                	je     948 <malloc+0x88>
 92c:	89 58 04             	mov    %ebx,0x4(%eax)
 92f:	83 ec 0c             	sub    $0xc,%esp
 932:	83 c0 08             	add    $0x8,%eax
 935:	50                   	push   %eax
 936:	e8 f5 fe ff ff       	call   830 <free>
 93b:	8b 15 4c 0e 00 00    	mov    0xe4c,%edx
 941:	83 c4 10             	add    $0x10,%esp
 944:	85 d2                	test   %edx,%edx
 946:	75 c0                	jne    908 <malloc+0x48>
 948:	8d 65 f4             	lea    -0xc(%ebp),%esp
 94b:	31 c0                	xor    %eax,%eax
 94d:	5b                   	pop    %ebx
 94e:	5e                   	pop    %esi
 94f:	5f                   	pop    %edi
 950:	5d                   	pop    %ebp
 951:	c3                   	ret    
 952:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 958:	39 cf                	cmp    %ecx,%edi
 95a:	74 54                	je     9b0 <malloc+0xf0>
 95c:	29 f9                	sub    %edi,%ecx
 95e:	89 48 04             	mov    %ecx,0x4(%eax)
 961:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
 964:	89 78 04             	mov    %edi,0x4(%eax)
 967:	89 15 4c 0e 00 00    	mov    %edx,0xe4c
 96d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 970:	83 c0 08             	add    $0x8,%eax
 973:	5b                   	pop    %ebx
 974:	5e                   	pop    %esi
 975:	5f                   	pop    %edi
 976:	5d                   	pop    %ebp
 977:	c3                   	ret    
 978:	90                   	nop
 979:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 980:	c7 05 4c 0e 00 00 50 	movl   $0xe50,0xe4c
 987:	0e 00 00 
 98a:	c7 05 50 0e 00 00 50 	movl   $0xe50,0xe50
 991:	0e 00 00 
 994:	b8 50 0e 00 00       	mov    $0xe50,%eax
 999:	c7 05 54 0e 00 00 00 	movl   $0x0,0xe54
 9a0:	00 00 00 
 9a3:	e9 44 ff ff ff       	jmp    8ec <malloc+0x2c>
 9a8:	90                   	nop
 9a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 9b0:	8b 08                	mov    (%eax),%ecx
 9b2:	89 0a                	mov    %ecx,(%edx)
 9b4:	eb b1                	jmp    967 <malloc+0xa7>
