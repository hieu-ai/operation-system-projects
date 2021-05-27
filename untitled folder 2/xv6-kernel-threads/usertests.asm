
_usertests:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 0c             	sub    $0xc,%esp
      11:	68 d3 4c 00 00       	push   $0x4cd3
      16:	6a 01                	push   $0x1
      18:	e8 93 39 00 00       	call   39b0 <printf>
      1d:	59                   	pop    %ecx
      1e:	58                   	pop    %eax
      1f:	6a 00                	push   $0x0
      21:	68 e7 4c 00 00       	push   $0x4ce7
      26:	e8 37 38 00 00       	call   3862 <open>
      2b:	83 c4 10             	add    $0x10,%esp
      2e:	85 c0                	test   %eax,%eax
      30:	78 13                	js     45 <main+0x45>
      32:	52                   	push   %edx
      33:	52                   	push   %edx
      34:	68 50 54 00 00       	push   $0x5450
      39:	6a 01                	push   $0x1
      3b:	e8 70 39 00 00       	call   39b0 <printf>
      40:	e8 dd 37 00 00       	call   3822 <exit>
      45:	50                   	push   %eax
      46:	50                   	push   %eax
      47:	68 00 02 00 00       	push   $0x200
      4c:	68 e7 4c 00 00       	push   $0x4ce7
      51:	e8 0c 38 00 00       	call   3862 <open>
      56:	89 04 24             	mov    %eax,(%esp)
      59:	e8 ec 37 00 00       	call   384a <close>
      5e:	e8 9d 11 00 00       	call   1200 <createdelete>
      63:	e8 58 1a 00 00       	call   1ac0 <linkunlink>
      68:	e8 53 17 00 00       	call   17c0 <concreate>
      6d:	e8 8e 0f 00 00       	call   1000 <fourfiles>
      72:	e8 c9 0d 00 00       	call   e40 <sharedfd>
      77:	e8 f4 31 00 00       	call   3270 <bigargtest>
      7c:	e8 5f 23 00 00       	call   23e0 <bigwrite>
      81:	e8 ea 31 00 00       	call   3270 <bigargtest>
      86:	e8 65 31 00 00       	call   31f0 <bsstest>
      8b:	e8 90 2c 00 00       	call   2d20 <sbrktest>
      90:	e8 ab 30 00 00       	call   3140 <validatetest>
      95:	e8 46 03 00 00       	call   3e0 <opentest>
      9a:	e8 d1 03 00 00       	call   470 <writetest>
      9f:	e8 ac 05 00 00       	call   650 <writetest1>
      a4:	e8 77 07 00 00       	call   820 <createtest>
      a9:	e8 32 02 00 00       	call   2e0 <openiputtest>
      ae:	e8 3d 01 00 00       	call   1f0 <exitiputtest>
      b3:	e8 58 00 00 00       	call   110 <iputtest>
      b8:	e8 b3 0c 00 00       	call   d70 <mem>
      bd:	e8 3e 09 00 00       	call   a00 <pipe1>
      c2:	e8 d9 0a 00 00       	call   ba0 <preempt>
      c7:	e8 14 0c 00 00       	call   ce0 <exitwait>
      cc:	e8 ff 26 00 00       	call   27d0 <rmdot>
      d1:	e8 ba 25 00 00       	call   2690 <fourteen>
      d6:	e8 e5 23 00 00       	call   24c0 <bigfile>
      db:	e8 20 1c 00 00       	call   1d00 <subdir>
      e0:	e8 cb 14 00 00       	call   15b0 <linktest>
      e5:	e8 36 13 00 00       	call   1420 <unlinkread>
      ea:	e8 61 28 00 00       	call   2950 <dirfile>
      ef:	e8 5c 2a 00 00       	call   2b50 <iref>
      f4:	e8 77 2b 00 00       	call   2c70 <forktest>
      f9:	e8 d2 1a 00 00       	call   1bd0 <bigdir>
      fe:	e8 3d 34 00 00       	call   3540 <uio>
     103:	e8 a8 08 00 00       	call   9b0 <exectest>
     108:	e8 15 37 00 00       	call   3822 <exit>
     10d:	66 90                	xchg   %ax,%ax
     10f:	90                   	nop

00000110 <iputtest>:
     110:	55                   	push   %ebp
     111:	89 e5                	mov    %esp,%ebp
     113:	83 ec 10             	sub    $0x10,%esp
     116:	68 9c 3d 00 00       	push   $0x3d9c
     11b:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     121:	e8 8a 38 00 00       	call   39b0 <printf>
     126:	c7 04 24 2f 3d 00 00 	movl   $0x3d2f,(%esp)
     12d:	e8 58 37 00 00       	call   388a <mkdir>
     132:	83 c4 10             	add    $0x10,%esp
     135:	85 c0                	test   %eax,%eax
     137:	78 58                	js     191 <iputtest+0x81>
     139:	83 ec 0c             	sub    $0xc,%esp
     13c:	68 2f 3d 00 00       	push   $0x3d2f
     141:	e8 4c 37 00 00       	call   3892 <chdir>
     146:	83 c4 10             	add    $0x10,%esp
     149:	85 c0                	test   %eax,%eax
     14b:	0f 88 85 00 00 00    	js     1d6 <iputtest+0xc6>
     151:	83 ec 0c             	sub    $0xc,%esp
     154:	68 2c 3d 00 00       	push   $0x3d2c
     159:	e8 14 37 00 00       	call   3872 <unlink>
     15e:	83 c4 10             	add    $0x10,%esp
     161:	85 c0                	test   %eax,%eax
     163:	78 5a                	js     1bf <iputtest+0xaf>
     165:	83 ec 0c             	sub    $0xc,%esp
     168:	68 51 3d 00 00       	push   $0x3d51
     16d:	e8 20 37 00 00       	call   3892 <chdir>
     172:	83 c4 10             	add    $0x10,%esp
     175:	85 c0                	test   %eax,%eax
     177:	78 2f                	js     1a8 <iputtest+0x98>
     179:	83 ec 08             	sub    $0x8,%esp
     17c:	68 d4 3d 00 00       	push   $0x3dd4
     181:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     187:	e8 24 38 00 00       	call   39b0 <printf>
     18c:	83 c4 10             	add    $0x10,%esp
     18f:	c9                   	leave  
     190:	c3                   	ret    
     191:	50                   	push   %eax
     192:	50                   	push   %eax
     193:	68 08 3d 00 00       	push   $0x3d08
     198:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     19e:	e8 0d 38 00 00       	call   39b0 <printf>
     1a3:	e8 7a 36 00 00       	call   3822 <exit>
     1a8:	50                   	push   %eax
     1a9:	50                   	push   %eax
     1aa:	68 53 3d 00 00       	push   $0x3d53
     1af:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     1b5:	e8 f6 37 00 00       	call   39b0 <printf>
     1ba:	e8 63 36 00 00       	call   3822 <exit>
     1bf:	52                   	push   %edx
     1c0:	52                   	push   %edx
     1c1:	68 37 3d 00 00       	push   $0x3d37
     1c6:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     1cc:	e8 df 37 00 00       	call   39b0 <printf>
     1d1:	e8 4c 36 00 00       	call   3822 <exit>
     1d6:	51                   	push   %ecx
     1d7:	51                   	push   %ecx
     1d8:	68 16 3d 00 00       	push   $0x3d16
     1dd:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     1e3:	e8 c8 37 00 00       	call   39b0 <printf>
     1e8:	e8 35 36 00 00       	call   3822 <exit>
     1ed:	8d 76 00             	lea    0x0(%esi),%esi

000001f0 <exitiputtest>:
     1f0:	55                   	push   %ebp
     1f1:	89 e5                	mov    %esp,%ebp
     1f3:	83 ec 10             	sub    $0x10,%esp
     1f6:	68 63 3d 00 00       	push   $0x3d63
     1fb:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     201:	e8 aa 37 00 00       	call   39b0 <printf>
     206:	e8 0f 36 00 00       	call   381a <fork>
     20b:	83 c4 10             	add    $0x10,%esp
     20e:	85 c0                	test   %eax,%eax
     210:	0f 88 82 00 00 00    	js     298 <exitiputtest+0xa8>
     216:	75 48                	jne    260 <exitiputtest+0x70>
     218:	83 ec 0c             	sub    $0xc,%esp
     21b:	68 2f 3d 00 00       	push   $0x3d2f
     220:	e8 65 36 00 00       	call   388a <mkdir>
     225:	83 c4 10             	add    $0x10,%esp
     228:	85 c0                	test   %eax,%eax
     22a:	0f 88 96 00 00 00    	js     2c6 <exitiputtest+0xd6>
     230:	83 ec 0c             	sub    $0xc,%esp
     233:	68 2f 3d 00 00       	push   $0x3d2f
     238:	e8 55 36 00 00       	call   3892 <chdir>
     23d:	83 c4 10             	add    $0x10,%esp
     240:	85 c0                	test   %eax,%eax
     242:	78 6b                	js     2af <exitiputtest+0xbf>
     244:	83 ec 0c             	sub    $0xc,%esp
     247:	68 2c 3d 00 00       	push   $0x3d2c
     24c:	e8 21 36 00 00       	call   3872 <unlink>
     251:	83 c4 10             	add    $0x10,%esp
     254:	85 c0                	test   %eax,%eax
     256:	78 28                	js     280 <exitiputtest+0x90>
     258:	e8 c5 35 00 00       	call   3822 <exit>
     25d:	8d 76 00             	lea    0x0(%esi),%esi
     260:	e8 c5 35 00 00       	call   382a <wait>
     265:	83 ec 08             	sub    $0x8,%esp
     268:	68 86 3d 00 00       	push   $0x3d86
     26d:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     273:	e8 38 37 00 00       	call   39b0 <printf>
     278:	83 c4 10             	add    $0x10,%esp
     27b:	c9                   	leave  
     27c:	c3                   	ret    
     27d:	8d 76 00             	lea    0x0(%esi),%esi
     280:	83 ec 08             	sub    $0x8,%esp
     283:	68 37 3d 00 00       	push   $0x3d37
     288:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     28e:	e8 1d 37 00 00       	call   39b0 <printf>
     293:	e8 8a 35 00 00       	call   3822 <exit>
     298:	51                   	push   %ecx
     299:	51                   	push   %ecx
     29a:	68 49 4c 00 00       	push   $0x4c49
     29f:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     2a5:	e8 06 37 00 00       	call   39b0 <printf>
     2aa:	e8 73 35 00 00       	call   3822 <exit>
     2af:	50                   	push   %eax
     2b0:	50                   	push   %eax
     2b1:	68 72 3d 00 00       	push   $0x3d72
     2b6:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     2bc:	e8 ef 36 00 00       	call   39b0 <printf>
     2c1:	e8 5c 35 00 00       	call   3822 <exit>
     2c6:	52                   	push   %edx
     2c7:	52                   	push   %edx
     2c8:	68 08 3d 00 00       	push   $0x3d08
     2cd:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     2d3:	e8 d8 36 00 00       	call   39b0 <printf>
     2d8:	e8 45 35 00 00       	call   3822 <exit>
     2dd:	8d 76 00             	lea    0x0(%esi),%esi

000002e0 <openiputtest>:
     2e0:	55                   	push   %ebp
     2e1:	89 e5                	mov    %esp,%ebp
     2e3:	83 ec 10             	sub    $0x10,%esp
     2e6:	68 98 3d 00 00       	push   $0x3d98
     2eb:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     2f1:	e8 ba 36 00 00       	call   39b0 <printf>
     2f6:	c7 04 24 a7 3d 00 00 	movl   $0x3da7,(%esp)
     2fd:	e8 88 35 00 00       	call   388a <mkdir>
     302:	83 c4 10             	add    $0x10,%esp
     305:	85 c0                	test   %eax,%eax
     307:	0f 88 88 00 00 00    	js     395 <openiputtest+0xb5>
     30d:	e8 08 35 00 00       	call   381a <fork>
     312:	85 c0                	test   %eax,%eax
     314:	0f 88 92 00 00 00    	js     3ac <openiputtest+0xcc>
     31a:	75 34                	jne    350 <openiputtest+0x70>
     31c:	83 ec 08             	sub    $0x8,%esp
     31f:	6a 02                	push   $0x2
     321:	68 a7 3d 00 00       	push   $0x3da7
     326:	e8 37 35 00 00       	call   3862 <open>
     32b:	83 c4 10             	add    $0x10,%esp
     32e:	85 c0                	test   %eax,%eax
     330:	78 5e                	js     390 <openiputtest+0xb0>
     332:	83 ec 08             	sub    $0x8,%esp
     335:	68 08 4d 00 00       	push   $0x4d08
     33a:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     340:	e8 6b 36 00 00       	call   39b0 <printf>
     345:	e8 d8 34 00 00       	call   3822 <exit>
     34a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     350:	83 ec 0c             	sub    $0xc,%esp
     353:	6a 01                	push   $0x1
     355:	e8 58 35 00 00       	call   38b2 <sleep>
     35a:	c7 04 24 a7 3d 00 00 	movl   $0x3da7,(%esp)
     361:	e8 0c 35 00 00       	call   3872 <unlink>
     366:	83 c4 10             	add    $0x10,%esp
     369:	85 c0                	test   %eax,%eax
     36b:	75 56                	jne    3c3 <openiputtest+0xe3>
     36d:	e8 b8 34 00 00       	call   382a <wait>
     372:	83 ec 08             	sub    $0x8,%esp
     375:	68 d0 3d 00 00       	push   $0x3dd0
     37a:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     380:	e8 2b 36 00 00       	call   39b0 <printf>
     385:	83 c4 10             	add    $0x10,%esp
     388:	c9                   	leave  
     389:	c3                   	ret    
     38a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     390:	e8 8d 34 00 00       	call   3822 <exit>
     395:	51                   	push   %ecx
     396:	51                   	push   %ecx
     397:	68 ad 3d 00 00       	push   $0x3dad
     39c:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     3a2:	e8 09 36 00 00       	call   39b0 <printf>
     3a7:	e8 76 34 00 00       	call   3822 <exit>
     3ac:	52                   	push   %edx
     3ad:	52                   	push   %edx
     3ae:	68 49 4c 00 00       	push   $0x4c49
     3b3:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     3b9:	e8 f2 35 00 00       	call   39b0 <printf>
     3be:	e8 5f 34 00 00       	call   3822 <exit>
     3c3:	50                   	push   %eax
     3c4:	50                   	push   %eax
     3c5:	68 c1 3d 00 00       	push   $0x3dc1
     3ca:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     3d0:	e8 db 35 00 00       	call   39b0 <printf>
     3d5:	e8 48 34 00 00       	call   3822 <exit>
     3da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003e0 <opentest>:
     3e0:	55                   	push   %ebp
     3e1:	89 e5                	mov    %esp,%ebp
     3e3:	83 ec 10             	sub    $0x10,%esp
     3e6:	68 e2 3d 00 00       	push   $0x3de2
     3eb:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     3f1:	e8 ba 35 00 00       	call   39b0 <printf>
     3f6:	58                   	pop    %eax
     3f7:	5a                   	pop    %edx
     3f8:	6a 00                	push   $0x0
     3fa:	68 ed 3d 00 00       	push   $0x3ded
     3ff:	e8 5e 34 00 00       	call   3862 <open>
     404:	83 c4 10             	add    $0x10,%esp
     407:	85 c0                	test   %eax,%eax
     409:	78 36                	js     441 <opentest+0x61>
     40b:	83 ec 0c             	sub    $0xc,%esp
     40e:	50                   	push   %eax
     40f:	e8 36 34 00 00       	call   384a <close>
     414:	5a                   	pop    %edx
     415:	59                   	pop    %ecx
     416:	6a 00                	push   $0x0
     418:	68 05 3e 00 00       	push   $0x3e05
     41d:	e8 40 34 00 00       	call   3862 <open>
     422:	83 c4 10             	add    $0x10,%esp
     425:	85 c0                	test   %eax,%eax
     427:	79 2f                	jns    458 <opentest+0x78>
     429:	83 ec 08             	sub    $0x8,%esp
     42c:	68 30 3e 00 00       	push   $0x3e30
     431:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     437:	e8 74 35 00 00       	call   39b0 <printf>
     43c:	83 c4 10             	add    $0x10,%esp
     43f:	c9                   	leave  
     440:	c3                   	ret    
     441:	50                   	push   %eax
     442:	50                   	push   %eax
     443:	68 f2 3d 00 00       	push   $0x3df2
     448:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     44e:	e8 5d 35 00 00       	call   39b0 <printf>
     453:	e8 ca 33 00 00       	call   3822 <exit>
     458:	50                   	push   %eax
     459:	50                   	push   %eax
     45a:	68 12 3e 00 00       	push   $0x3e12
     45f:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     465:	e8 46 35 00 00       	call   39b0 <printf>
     46a:	e8 b3 33 00 00       	call   3822 <exit>
     46f:	90                   	nop

00000470 <writetest>:
     470:	55                   	push   %ebp
     471:	89 e5                	mov    %esp,%ebp
     473:	56                   	push   %esi
     474:	53                   	push   %ebx
     475:	83 ec 08             	sub    $0x8,%esp
     478:	68 3e 3e 00 00       	push   $0x3e3e
     47d:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     483:	e8 28 35 00 00       	call   39b0 <printf>
     488:	58                   	pop    %eax
     489:	5a                   	pop    %edx
     48a:	68 02 02 00 00       	push   $0x202
     48f:	68 4f 3e 00 00       	push   $0x3e4f
     494:	e8 c9 33 00 00       	call   3862 <open>
     499:	83 c4 10             	add    $0x10,%esp
     49c:	85 c0                	test   %eax,%eax
     49e:	0f 88 88 01 00 00    	js     62c <writetest+0x1bc>
     4a4:	83 ec 08             	sub    $0x8,%esp
     4a7:	89 c6                	mov    %eax,%esi
     4a9:	31 db                	xor    %ebx,%ebx
     4ab:	68 55 3e 00 00       	push   $0x3e55
     4b0:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     4b6:	e8 f5 34 00 00       	call   39b0 <printf>
     4bb:	83 c4 10             	add    $0x10,%esp
     4be:	66 90                	xchg   %ax,%ax
     4c0:	83 ec 04             	sub    $0x4,%esp
     4c3:	6a 0a                	push   $0xa
     4c5:	68 8c 3e 00 00       	push   $0x3e8c
     4ca:	56                   	push   %esi
     4cb:	e8 72 33 00 00       	call   3842 <write>
     4d0:	83 c4 10             	add    $0x10,%esp
     4d3:	83 f8 0a             	cmp    $0xa,%eax
     4d6:	0f 85 d9 00 00 00    	jne    5b5 <writetest+0x145>
     4dc:	83 ec 04             	sub    $0x4,%esp
     4df:	6a 0a                	push   $0xa
     4e1:	68 97 3e 00 00       	push   $0x3e97
     4e6:	56                   	push   %esi
     4e7:	e8 56 33 00 00       	call   3842 <write>
     4ec:	83 c4 10             	add    $0x10,%esp
     4ef:	83 f8 0a             	cmp    $0xa,%eax
     4f2:	0f 85 d6 00 00 00    	jne    5ce <writetest+0x15e>
     4f8:	83 c3 01             	add    $0x1,%ebx
     4fb:	83 fb 64             	cmp    $0x64,%ebx
     4fe:	75 c0                	jne    4c0 <writetest+0x50>
     500:	83 ec 08             	sub    $0x8,%esp
     503:	68 a2 3e 00 00       	push   $0x3ea2
     508:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     50e:	e8 9d 34 00 00       	call   39b0 <printf>
     513:	89 34 24             	mov    %esi,(%esp)
     516:	e8 2f 33 00 00       	call   384a <close>
     51b:	5b                   	pop    %ebx
     51c:	5e                   	pop    %esi
     51d:	6a 00                	push   $0x0
     51f:	68 4f 3e 00 00       	push   $0x3e4f
     524:	e8 39 33 00 00       	call   3862 <open>
     529:	83 c4 10             	add    $0x10,%esp
     52c:	85 c0                	test   %eax,%eax
     52e:	89 c3                	mov    %eax,%ebx
     530:	0f 88 b1 00 00 00    	js     5e7 <writetest+0x177>
     536:	83 ec 08             	sub    $0x8,%esp
     539:	68 ad 3e 00 00       	push   $0x3ead
     53e:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     544:	e8 67 34 00 00       	call   39b0 <printf>
     549:	83 c4 0c             	add    $0xc,%esp
     54c:	68 d0 07 00 00       	push   $0x7d0
     551:	68 60 85 00 00       	push   $0x8560
     556:	53                   	push   %ebx
     557:	e8 de 32 00 00       	call   383a <read>
     55c:	83 c4 10             	add    $0x10,%esp
     55f:	3d d0 07 00 00       	cmp    $0x7d0,%eax
     564:	0f 85 94 00 00 00    	jne    5fe <writetest+0x18e>
     56a:	83 ec 08             	sub    $0x8,%esp
     56d:	68 e1 3e 00 00       	push   $0x3ee1
     572:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     578:	e8 33 34 00 00       	call   39b0 <printf>
     57d:	89 1c 24             	mov    %ebx,(%esp)
     580:	e8 c5 32 00 00       	call   384a <close>
     585:	c7 04 24 4f 3e 00 00 	movl   $0x3e4f,(%esp)
     58c:	e8 e1 32 00 00       	call   3872 <unlink>
     591:	83 c4 10             	add    $0x10,%esp
     594:	85 c0                	test   %eax,%eax
     596:	78 7d                	js     615 <writetest+0x1a5>
     598:	83 ec 08             	sub    $0x8,%esp
     59b:	68 09 3f 00 00       	push   $0x3f09
     5a0:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     5a6:	e8 05 34 00 00       	call   39b0 <printf>
     5ab:	83 c4 10             	add    $0x10,%esp
     5ae:	8d 65 f8             	lea    -0x8(%ebp),%esp
     5b1:	5b                   	pop    %ebx
     5b2:	5e                   	pop    %esi
     5b3:	5d                   	pop    %ebp
     5b4:	c3                   	ret    
     5b5:	83 ec 04             	sub    $0x4,%esp
     5b8:	53                   	push   %ebx
     5b9:	68 2c 4d 00 00       	push   $0x4d2c
     5be:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     5c4:	e8 e7 33 00 00       	call   39b0 <printf>
     5c9:	e8 54 32 00 00       	call   3822 <exit>
     5ce:	83 ec 04             	sub    $0x4,%esp
     5d1:	53                   	push   %ebx
     5d2:	68 50 4d 00 00       	push   $0x4d50
     5d7:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     5dd:	e8 ce 33 00 00       	call   39b0 <printf>
     5e2:	e8 3b 32 00 00       	call   3822 <exit>
     5e7:	51                   	push   %ecx
     5e8:	51                   	push   %ecx
     5e9:	68 c6 3e 00 00       	push   $0x3ec6
     5ee:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     5f4:	e8 b7 33 00 00       	call   39b0 <printf>
     5f9:	e8 24 32 00 00       	call   3822 <exit>
     5fe:	52                   	push   %edx
     5ff:	52                   	push   %edx
     600:	68 0d 42 00 00       	push   $0x420d
     605:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     60b:	e8 a0 33 00 00       	call   39b0 <printf>
     610:	e8 0d 32 00 00       	call   3822 <exit>
     615:	50                   	push   %eax
     616:	50                   	push   %eax
     617:	68 f4 3e 00 00       	push   $0x3ef4
     61c:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     622:	e8 89 33 00 00       	call   39b0 <printf>
     627:	e8 f6 31 00 00       	call   3822 <exit>
     62c:	50                   	push   %eax
     62d:	50                   	push   %eax
     62e:	68 70 3e 00 00       	push   $0x3e70
     633:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     639:	e8 72 33 00 00       	call   39b0 <printf>
     63e:	e8 df 31 00 00       	call   3822 <exit>
     643:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000650 <writetest1>:
     650:	55                   	push   %ebp
     651:	89 e5                	mov    %esp,%ebp
     653:	56                   	push   %esi
     654:	53                   	push   %ebx
     655:	83 ec 08             	sub    $0x8,%esp
     658:	68 1d 3f 00 00       	push   $0x3f1d
     65d:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     663:	e8 48 33 00 00       	call   39b0 <printf>
     668:	58                   	pop    %eax
     669:	5a                   	pop    %edx
     66a:	68 02 02 00 00       	push   $0x202
     66f:	68 97 3f 00 00       	push   $0x3f97
     674:	e8 e9 31 00 00       	call   3862 <open>
     679:	83 c4 10             	add    $0x10,%esp
     67c:	85 c0                	test   %eax,%eax
     67e:	0f 88 61 01 00 00    	js     7e5 <writetest1+0x195>
     684:	89 c6                	mov    %eax,%esi
     686:	31 db                	xor    %ebx,%ebx
     688:	90                   	nop
     689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     690:	83 ec 04             	sub    $0x4,%esp
     693:	89 1d 60 85 00 00    	mov    %ebx,0x8560
     699:	68 00 02 00 00       	push   $0x200
     69e:	68 60 85 00 00       	push   $0x8560
     6a3:	56                   	push   %esi
     6a4:	e8 99 31 00 00       	call   3842 <write>
     6a9:	83 c4 10             	add    $0x10,%esp
     6ac:	3d 00 02 00 00       	cmp    $0x200,%eax
     6b1:	0f 85 b3 00 00 00    	jne    76a <writetest1+0x11a>
     6b7:	83 c3 01             	add    $0x1,%ebx
     6ba:	81 fb 8c 00 00 00    	cmp    $0x8c,%ebx
     6c0:	75 ce                	jne    690 <writetest1+0x40>
     6c2:	83 ec 0c             	sub    $0xc,%esp
     6c5:	56                   	push   %esi
     6c6:	e8 7f 31 00 00       	call   384a <close>
     6cb:	5b                   	pop    %ebx
     6cc:	5e                   	pop    %esi
     6cd:	6a 00                	push   $0x0
     6cf:	68 97 3f 00 00       	push   $0x3f97
     6d4:	e8 89 31 00 00       	call   3862 <open>
     6d9:	83 c4 10             	add    $0x10,%esp
     6dc:	85 c0                	test   %eax,%eax
     6de:	89 c6                	mov    %eax,%esi
     6e0:	0f 88 e8 00 00 00    	js     7ce <writetest1+0x17e>
     6e6:	31 db                	xor    %ebx,%ebx
     6e8:	eb 1d                	jmp    707 <writetest1+0xb7>
     6ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     6f0:	3d 00 02 00 00       	cmp    $0x200,%eax
     6f5:	0f 85 9f 00 00 00    	jne    79a <writetest1+0x14a>
     6fb:	a1 60 85 00 00       	mov    0x8560,%eax
     700:	39 d8                	cmp    %ebx,%eax
     702:	75 7f                	jne    783 <writetest1+0x133>
     704:	83 c3 01             	add    $0x1,%ebx
     707:	83 ec 04             	sub    $0x4,%esp
     70a:	68 00 02 00 00       	push   $0x200
     70f:	68 60 85 00 00       	push   $0x8560
     714:	56                   	push   %esi
     715:	e8 20 31 00 00       	call   383a <read>
     71a:	83 c4 10             	add    $0x10,%esp
     71d:	85 c0                	test   %eax,%eax
     71f:	75 cf                	jne    6f0 <writetest1+0xa0>
     721:	81 fb 8b 00 00 00    	cmp    $0x8b,%ebx
     727:	0f 84 86 00 00 00    	je     7b3 <writetest1+0x163>
     72d:	83 ec 0c             	sub    $0xc,%esp
     730:	56                   	push   %esi
     731:	e8 14 31 00 00       	call   384a <close>
     736:	c7 04 24 97 3f 00 00 	movl   $0x3f97,(%esp)
     73d:	e8 30 31 00 00       	call   3872 <unlink>
     742:	83 c4 10             	add    $0x10,%esp
     745:	85 c0                	test   %eax,%eax
     747:	0f 88 af 00 00 00    	js     7fc <writetest1+0x1ac>
     74d:	83 ec 08             	sub    $0x8,%esp
     750:	68 be 3f 00 00       	push   $0x3fbe
     755:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     75b:	e8 50 32 00 00       	call   39b0 <printf>
     760:	83 c4 10             	add    $0x10,%esp
     763:	8d 65 f8             	lea    -0x8(%ebp),%esp
     766:	5b                   	pop    %ebx
     767:	5e                   	pop    %esi
     768:	5d                   	pop    %ebp
     769:	c3                   	ret    
     76a:	83 ec 04             	sub    $0x4,%esp
     76d:	53                   	push   %ebx
     76e:	68 47 3f 00 00       	push   $0x3f47
     773:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     779:	e8 32 32 00 00       	call   39b0 <printf>
     77e:	e8 9f 30 00 00       	call   3822 <exit>
     783:	50                   	push   %eax
     784:	53                   	push   %ebx
     785:	68 74 4d 00 00       	push   $0x4d74
     78a:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     790:	e8 1b 32 00 00       	call   39b0 <printf>
     795:	e8 88 30 00 00       	call   3822 <exit>
     79a:	83 ec 04             	sub    $0x4,%esp
     79d:	50                   	push   %eax
     79e:	68 9b 3f 00 00       	push   $0x3f9b
     7a3:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     7a9:	e8 02 32 00 00       	call   39b0 <printf>
     7ae:	e8 6f 30 00 00       	call   3822 <exit>
     7b3:	52                   	push   %edx
     7b4:	68 8b 00 00 00       	push   $0x8b
     7b9:	68 7e 3f 00 00       	push   $0x3f7e
     7be:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     7c4:	e8 e7 31 00 00       	call   39b0 <printf>
     7c9:	e8 54 30 00 00       	call   3822 <exit>
     7ce:	51                   	push   %ecx
     7cf:	51                   	push   %ecx
     7d0:	68 65 3f 00 00       	push   $0x3f65
     7d5:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     7db:	e8 d0 31 00 00       	call   39b0 <printf>
     7e0:	e8 3d 30 00 00       	call   3822 <exit>
     7e5:	50                   	push   %eax
     7e6:	50                   	push   %eax
     7e7:	68 2d 3f 00 00       	push   $0x3f2d
     7ec:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     7f2:	e8 b9 31 00 00       	call   39b0 <printf>
     7f7:	e8 26 30 00 00       	call   3822 <exit>
     7fc:	50                   	push   %eax
     7fd:	50                   	push   %eax
     7fe:	68 ab 3f 00 00       	push   $0x3fab
     803:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     809:	e8 a2 31 00 00       	call   39b0 <printf>
     80e:	e8 0f 30 00 00       	call   3822 <exit>
     813:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000820 <createtest>:
     820:	55                   	push   %ebp
     821:	89 e5                	mov    %esp,%ebp
     823:	53                   	push   %ebx
     824:	bb 30 00 00 00       	mov    $0x30,%ebx
     829:	83 ec 0c             	sub    $0xc,%esp
     82c:	68 94 4d 00 00       	push   $0x4d94
     831:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     837:	e8 74 31 00 00       	call   39b0 <printf>
     83c:	c6 05 60 a5 00 00 61 	movb   $0x61,0xa560
     843:	c6 05 62 a5 00 00 00 	movb   $0x0,0xa562
     84a:	83 c4 10             	add    $0x10,%esp
     84d:	8d 76 00             	lea    0x0(%esi),%esi
     850:	83 ec 08             	sub    $0x8,%esp
     853:	88 1d 61 a5 00 00    	mov    %bl,0xa561
     859:	83 c3 01             	add    $0x1,%ebx
     85c:	68 02 02 00 00       	push   $0x202
     861:	68 60 a5 00 00       	push   $0xa560
     866:	e8 f7 2f 00 00       	call   3862 <open>
     86b:	89 04 24             	mov    %eax,(%esp)
     86e:	e8 d7 2f 00 00       	call   384a <close>
     873:	83 c4 10             	add    $0x10,%esp
     876:	80 fb 64             	cmp    $0x64,%bl
     879:	75 d5                	jne    850 <createtest+0x30>
     87b:	c6 05 60 a5 00 00 61 	movb   $0x61,0xa560
     882:	c6 05 62 a5 00 00 00 	movb   $0x0,0xa562
     889:	bb 30 00 00 00       	mov    $0x30,%ebx
     88e:	66 90                	xchg   %ax,%ax
     890:	83 ec 0c             	sub    $0xc,%esp
     893:	88 1d 61 a5 00 00    	mov    %bl,0xa561
     899:	83 c3 01             	add    $0x1,%ebx
     89c:	68 60 a5 00 00       	push   $0xa560
     8a1:	e8 cc 2f 00 00       	call   3872 <unlink>
     8a6:	83 c4 10             	add    $0x10,%esp
     8a9:	80 fb 64             	cmp    $0x64,%bl
     8ac:	75 e2                	jne    890 <createtest+0x70>
     8ae:	83 ec 08             	sub    $0x8,%esp
     8b1:	68 bc 4d 00 00       	push   $0x4dbc
     8b6:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     8bc:	e8 ef 30 00 00       	call   39b0 <printf>
     8c1:	83 c4 10             	add    $0x10,%esp
     8c4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     8c7:	c9                   	leave  
     8c8:	c3                   	ret    
     8c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000008d0 <dirtest>:
     8d0:	55                   	push   %ebp
     8d1:	89 e5                	mov    %esp,%ebp
     8d3:	83 ec 10             	sub    $0x10,%esp
     8d6:	68 cc 3f 00 00       	push   $0x3fcc
     8db:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     8e1:	e8 ca 30 00 00       	call   39b0 <printf>
     8e6:	c7 04 24 d8 3f 00 00 	movl   $0x3fd8,(%esp)
     8ed:	e8 98 2f 00 00       	call   388a <mkdir>
     8f2:	83 c4 10             	add    $0x10,%esp
     8f5:	85 c0                	test   %eax,%eax
     8f7:	78 58                	js     951 <dirtest+0x81>
     8f9:	83 ec 0c             	sub    $0xc,%esp
     8fc:	68 d8 3f 00 00       	push   $0x3fd8
     901:	e8 8c 2f 00 00       	call   3892 <chdir>
     906:	83 c4 10             	add    $0x10,%esp
     909:	85 c0                	test   %eax,%eax
     90b:	0f 88 85 00 00 00    	js     996 <dirtest+0xc6>
     911:	83 ec 0c             	sub    $0xc,%esp
     914:	68 7d 45 00 00       	push   $0x457d
     919:	e8 74 2f 00 00       	call   3892 <chdir>
     91e:	83 c4 10             	add    $0x10,%esp
     921:	85 c0                	test   %eax,%eax
     923:	78 5a                	js     97f <dirtest+0xaf>
     925:	83 ec 0c             	sub    $0xc,%esp
     928:	68 d8 3f 00 00       	push   $0x3fd8
     92d:	e8 40 2f 00 00       	call   3872 <unlink>
     932:	83 c4 10             	add    $0x10,%esp
     935:	85 c0                	test   %eax,%eax
     937:	78 2f                	js     968 <dirtest+0x98>
     939:	83 ec 08             	sub    $0x8,%esp
     93c:	68 15 40 00 00       	push   $0x4015
     941:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     947:	e8 64 30 00 00       	call   39b0 <printf>
     94c:	83 c4 10             	add    $0x10,%esp
     94f:	c9                   	leave  
     950:	c3                   	ret    
     951:	50                   	push   %eax
     952:	50                   	push   %eax
     953:	68 08 3d 00 00       	push   $0x3d08
     958:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     95e:	e8 4d 30 00 00       	call   39b0 <printf>
     963:	e8 ba 2e 00 00       	call   3822 <exit>
     968:	50                   	push   %eax
     969:	50                   	push   %eax
     96a:	68 01 40 00 00       	push   $0x4001
     96f:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     975:	e8 36 30 00 00       	call   39b0 <printf>
     97a:	e8 a3 2e 00 00       	call   3822 <exit>
     97f:	52                   	push   %edx
     980:	52                   	push   %edx
     981:	68 f0 3f 00 00       	push   $0x3ff0
     986:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     98c:	e8 1f 30 00 00       	call   39b0 <printf>
     991:	e8 8c 2e 00 00       	call   3822 <exit>
     996:	51                   	push   %ecx
     997:	51                   	push   %ecx
     998:	68 dd 3f 00 00       	push   $0x3fdd
     99d:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     9a3:	e8 08 30 00 00       	call   39b0 <printf>
     9a8:	e8 75 2e 00 00       	call   3822 <exit>
     9ad:	8d 76 00             	lea    0x0(%esi),%esi

000009b0 <exectest>:
     9b0:	55                   	push   %ebp
     9b1:	89 e5                	mov    %esp,%ebp
     9b3:	83 ec 10             	sub    $0x10,%esp
     9b6:	68 24 40 00 00       	push   $0x4024
     9bb:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     9c1:	e8 ea 2f 00 00       	call   39b0 <printf>
     9c6:	5a                   	pop    %edx
     9c7:	59                   	pop    %ecx
     9c8:	68 70 5d 00 00       	push   $0x5d70
     9cd:	68 ed 3d 00 00       	push   $0x3ded
     9d2:	e8 83 2e 00 00       	call   385a <exec>
     9d7:	83 c4 10             	add    $0x10,%esp
     9da:	85 c0                	test   %eax,%eax
     9dc:	78 02                	js     9e0 <exectest+0x30>
     9de:	c9                   	leave  
     9df:	c3                   	ret    
     9e0:	50                   	push   %eax
     9e1:	50                   	push   %eax
     9e2:	68 2f 40 00 00       	push   $0x402f
     9e7:	ff 35 6c 5d 00 00    	pushl  0x5d6c
     9ed:	e8 be 2f 00 00       	call   39b0 <printf>
     9f2:	e8 2b 2e 00 00       	call   3822 <exit>
     9f7:	89 f6                	mov    %esi,%esi
     9f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a00 <pipe1>:
     a00:	55                   	push   %ebp
     a01:	89 e5                	mov    %esp,%ebp
     a03:	57                   	push   %edi
     a04:	56                   	push   %esi
     a05:	53                   	push   %ebx
     a06:	8d 45 e0             	lea    -0x20(%ebp),%eax
     a09:	83 ec 38             	sub    $0x38,%esp
     a0c:	50                   	push   %eax
     a0d:	e8 20 2e 00 00       	call   3832 <pipe>
     a12:	83 c4 10             	add    $0x10,%esp
     a15:	85 c0                	test   %eax,%eax
     a17:	0f 85 3e 01 00 00    	jne    b5b <pipe1+0x15b>
     a1d:	89 c3                	mov    %eax,%ebx
     a1f:	e8 f6 2d 00 00       	call   381a <fork>
     a24:	83 f8 00             	cmp    $0x0,%eax
     a27:	0f 84 84 00 00 00    	je     ab1 <pipe1+0xb1>
     a2d:	0f 8e 3b 01 00 00    	jle    b6e <pipe1+0x16e>
     a33:	83 ec 0c             	sub    $0xc,%esp
     a36:	ff 75 e4             	pushl  -0x1c(%ebp)
     a39:	bf 01 00 00 00       	mov    $0x1,%edi
     a3e:	e8 07 2e 00 00       	call   384a <close>
     a43:	83 c4 10             	add    $0x10,%esp
     a46:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
     a4d:	83 ec 04             	sub    $0x4,%esp
     a50:	57                   	push   %edi
     a51:	68 60 85 00 00       	push   $0x8560
     a56:	ff 75 e0             	pushl  -0x20(%ebp)
     a59:	e8 dc 2d 00 00       	call   383a <read>
     a5e:	83 c4 10             	add    $0x10,%esp
     a61:	85 c0                	test   %eax,%eax
     a63:	0f 8e ab 00 00 00    	jle    b14 <pipe1+0x114>
     a69:	89 d9                	mov    %ebx,%ecx
     a6b:	8d 34 18             	lea    (%eax,%ebx,1),%esi
     a6e:	f7 d9                	neg    %ecx
     a70:	38 9c 0b 60 85 00 00 	cmp    %bl,0x8560(%ebx,%ecx,1)
     a77:	8d 53 01             	lea    0x1(%ebx),%edx
     a7a:	75 1b                	jne    a97 <pipe1+0x97>
     a7c:	39 f2                	cmp    %esi,%edx
     a7e:	89 d3                	mov    %edx,%ebx
     a80:	75 ee                	jne    a70 <pipe1+0x70>
     a82:	01 ff                	add    %edi,%edi
     a84:	01 45 d4             	add    %eax,-0x2c(%ebp)
     a87:	b8 00 20 00 00       	mov    $0x2000,%eax
     a8c:	81 ff 00 20 00 00    	cmp    $0x2000,%edi
     a92:	0f 4f f8             	cmovg  %eax,%edi
     a95:	eb b6                	jmp    a4d <pipe1+0x4d>
     a97:	83 ec 08             	sub    $0x8,%esp
     a9a:	68 5e 40 00 00       	push   $0x405e
     a9f:	6a 01                	push   $0x1
     aa1:	e8 0a 2f 00 00       	call   39b0 <printf>
     aa6:	83 c4 10             	add    $0x10,%esp
     aa9:	8d 65 f4             	lea    -0xc(%ebp),%esp
     aac:	5b                   	pop    %ebx
     aad:	5e                   	pop    %esi
     aae:	5f                   	pop    %edi
     aaf:	5d                   	pop    %ebp
     ab0:	c3                   	ret    
     ab1:	83 ec 0c             	sub    $0xc,%esp
     ab4:	ff 75 e0             	pushl  -0x20(%ebp)
     ab7:	31 db                	xor    %ebx,%ebx
     ab9:	be 09 04 00 00       	mov    $0x409,%esi
     abe:	e8 87 2d 00 00       	call   384a <close>
     ac3:	83 c4 10             	add    $0x10,%esp
     ac6:	89 d8                	mov    %ebx,%eax
     ac8:	89 f2                	mov    %esi,%edx
     aca:	f7 d8                	neg    %eax
     acc:	29 da                	sub    %ebx,%edx
     ace:	66 90                	xchg   %ax,%ax
     ad0:	88 84 03 60 85 00 00 	mov    %al,0x8560(%ebx,%eax,1)
     ad7:	83 c0 01             	add    $0x1,%eax
     ada:	39 d0                	cmp    %edx,%eax
     adc:	75 f2                	jne    ad0 <pipe1+0xd0>
     ade:	83 ec 04             	sub    $0x4,%esp
     ae1:	68 09 04 00 00       	push   $0x409
     ae6:	68 60 85 00 00       	push   $0x8560
     aeb:	ff 75 e4             	pushl  -0x1c(%ebp)
     aee:	e8 4f 2d 00 00       	call   3842 <write>
     af3:	83 c4 10             	add    $0x10,%esp
     af6:	3d 09 04 00 00       	cmp    $0x409,%eax
     afb:	0f 85 80 00 00 00    	jne    b81 <pipe1+0x181>
     b01:	81 eb 09 04 00 00    	sub    $0x409,%ebx
     b07:	81 fb d3 eb ff ff    	cmp    $0xffffebd3,%ebx
     b0d:	75 b7                	jne    ac6 <pipe1+0xc6>
     b0f:	e8 0e 2d 00 00       	call   3822 <exit>
     b14:	81 7d d4 2d 14 00 00 	cmpl   $0x142d,-0x2c(%ebp)
     b1b:	75 29                	jne    b46 <pipe1+0x146>
     b1d:	83 ec 0c             	sub    $0xc,%esp
     b20:	ff 75 e0             	pushl  -0x20(%ebp)
     b23:	e8 22 2d 00 00       	call   384a <close>
     b28:	e8 fd 2c 00 00       	call   382a <wait>
     b2d:	5a                   	pop    %edx
     b2e:	59                   	pop    %ecx
     b2f:	68 83 40 00 00       	push   $0x4083
     b34:	6a 01                	push   $0x1
     b36:	e8 75 2e 00 00       	call   39b0 <printf>
     b3b:	83 c4 10             	add    $0x10,%esp
     b3e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b41:	5b                   	pop    %ebx
     b42:	5e                   	pop    %esi
     b43:	5f                   	pop    %edi
     b44:	5d                   	pop    %ebp
     b45:	c3                   	ret    
     b46:	53                   	push   %ebx
     b47:	ff 75 d4             	pushl  -0x2c(%ebp)
     b4a:	68 6c 40 00 00       	push   $0x406c
     b4f:	6a 01                	push   $0x1
     b51:	e8 5a 2e 00 00       	call   39b0 <printf>
     b56:	e8 c7 2c 00 00       	call   3822 <exit>
     b5b:	57                   	push   %edi
     b5c:	57                   	push   %edi
     b5d:	68 41 40 00 00       	push   $0x4041
     b62:	6a 01                	push   $0x1
     b64:	e8 47 2e 00 00       	call   39b0 <printf>
     b69:	e8 b4 2c 00 00       	call   3822 <exit>
     b6e:	50                   	push   %eax
     b6f:	50                   	push   %eax
     b70:	68 8d 40 00 00       	push   $0x408d
     b75:	6a 01                	push   $0x1
     b77:	e8 34 2e 00 00       	call   39b0 <printf>
     b7c:	e8 a1 2c 00 00       	call   3822 <exit>
     b81:	56                   	push   %esi
     b82:	56                   	push   %esi
     b83:	68 50 40 00 00       	push   $0x4050
     b88:	6a 01                	push   $0x1
     b8a:	e8 21 2e 00 00       	call   39b0 <printf>
     b8f:	e8 8e 2c 00 00       	call   3822 <exit>
     b94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     b9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000ba0 <preempt>:
     ba0:	55                   	push   %ebp
     ba1:	89 e5                	mov    %esp,%ebp
     ba3:	57                   	push   %edi
     ba4:	56                   	push   %esi
     ba5:	53                   	push   %ebx
     ba6:	83 ec 24             	sub    $0x24,%esp
     ba9:	68 9c 40 00 00       	push   $0x409c
     bae:	6a 01                	push   $0x1
     bb0:	e8 fb 2d 00 00       	call   39b0 <printf>
     bb5:	e8 60 2c 00 00       	call   381a <fork>
     bba:	83 c4 10             	add    $0x10,%esp
     bbd:	85 c0                	test   %eax,%eax
     bbf:	75 02                	jne    bc3 <preempt+0x23>
     bc1:	eb fe                	jmp    bc1 <preempt+0x21>
     bc3:	89 c7                	mov    %eax,%edi
     bc5:	e8 50 2c 00 00       	call   381a <fork>
     bca:	85 c0                	test   %eax,%eax
     bcc:	89 c6                	mov    %eax,%esi
     bce:	75 02                	jne    bd2 <preempt+0x32>
     bd0:	eb fe                	jmp    bd0 <preempt+0x30>
     bd2:	8d 45 e0             	lea    -0x20(%ebp),%eax
     bd5:	83 ec 0c             	sub    $0xc,%esp
     bd8:	50                   	push   %eax
     bd9:	e8 54 2c 00 00       	call   3832 <pipe>
     bde:	e8 37 2c 00 00       	call   381a <fork>
     be3:	83 c4 10             	add    $0x10,%esp
     be6:	85 c0                	test   %eax,%eax
     be8:	89 c3                	mov    %eax,%ebx
     bea:	75 46                	jne    c32 <preempt+0x92>
     bec:	83 ec 0c             	sub    $0xc,%esp
     bef:	ff 75 e0             	pushl  -0x20(%ebp)
     bf2:	e8 53 2c 00 00       	call   384a <close>
     bf7:	83 c4 0c             	add    $0xc,%esp
     bfa:	6a 01                	push   $0x1
     bfc:	68 61 46 00 00       	push   $0x4661
     c01:	ff 75 e4             	pushl  -0x1c(%ebp)
     c04:	e8 39 2c 00 00       	call   3842 <write>
     c09:	83 c4 10             	add    $0x10,%esp
     c0c:	83 e8 01             	sub    $0x1,%eax
     c0f:	74 11                	je     c22 <preempt+0x82>
     c11:	50                   	push   %eax
     c12:	50                   	push   %eax
     c13:	68 a6 40 00 00       	push   $0x40a6
     c18:	6a 01                	push   $0x1
     c1a:	e8 91 2d 00 00       	call   39b0 <printf>
     c1f:	83 c4 10             	add    $0x10,%esp
     c22:	83 ec 0c             	sub    $0xc,%esp
     c25:	ff 75 e4             	pushl  -0x1c(%ebp)
     c28:	e8 1d 2c 00 00       	call   384a <close>
     c2d:	83 c4 10             	add    $0x10,%esp
     c30:	eb fe                	jmp    c30 <preempt+0x90>
     c32:	83 ec 0c             	sub    $0xc,%esp
     c35:	ff 75 e4             	pushl  -0x1c(%ebp)
     c38:	e8 0d 2c 00 00       	call   384a <close>
     c3d:	83 c4 0c             	add    $0xc,%esp
     c40:	68 00 20 00 00       	push   $0x2000
     c45:	68 60 85 00 00       	push   $0x8560
     c4a:	ff 75 e0             	pushl  -0x20(%ebp)
     c4d:	e8 e8 2b 00 00       	call   383a <read>
     c52:	83 c4 10             	add    $0x10,%esp
     c55:	83 e8 01             	sub    $0x1,%eax
     c58:	74 19                	je     c73 <preempt+0xd3>
     c5a:	50                   	push   %eax
     c5b:	50                   	push   %eax
     c5c:	68 ba 40 00 00       	push   $0x40ba
     c61:	6a 01                	push   $0x1
     c63:	e8 48 2d 00 00       	call   39b0 <printf>
     c68:	83 c4 10             	add    $0x10,%esp
     c6b:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c6e:	5b                   	pop    %ebx
     c6f:	5e                   	pop    %esi
     c70:	5f                   	pop    %edi
     c71:	5d                   	pop    %ebp
     c72:	c3                   	ret    
     c73:	83 ec 0c             	sub    $0xc,%esp
     c76:	ff 75 e0             	pushl  -0x20(%ebp)
     c79:	e8 cc 2b 00 00       	call   384a <close>
     c7e:	58                   	pop    %eax
     c7f:	5a                   	pop    %edx
     c80:	68 cd 40 00 00       	push   $0x40cd
     c85:	6a 01                	push   $0x1
     c87:	e8 24 2d 00 00       	call   39b0 <printf>
     c8c:	89 3c 24             	mov    %edi,(%esp)
     c8f:	e8 be 2b 00 00       	call   3852 <kill>
     c94:	89 34 24             	mov    %esi,(%esp)
     c97:	e8 b6 2b 00 00       	call   3852 <kill>
     c9c:	89 1c 24             	mov    %ebx,(%esp)
     c9f:	e8 ae 2b 00 00       	call   3852 <kill>
     ca4:	59                   	pop    %ecx
     ca5:	5b                   	pop    %ebx
     ca6:	68 d6 40 00 00       	push   $0x40d6
     cab:	6a 01                	push   $0x1
     cad:	e8 fe 2c 00 00       	call   39b0 <printf>
     cb2:	e8 73 2b 00 00       	call   382a <wait>
     cb7:	e8 6e 2b 00 00       	call   382a <wait>
     cbc:	e8 69 2b 00 00       	call   382a <wait>
     cc1:	5e                   	pop    %esi
     cc2:	5f                   	pop    %edi
     cc3:	68 df 40 00 00       	push   $0x40df
     cc8:	6a 01                	push   $0x1
     cca:	e8 e1 2c 00 00       	call   39b0 <printf>
     ccf:	83 c4 10             	add    $0x10,%esp
     cd2:	eb 97                	jmp    c6b <preempt+0xcb>
     cd4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     cda:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000ce0 <exitwait>:
     ce0:	55                   	push   %ebp
     ce1:	89 e5                	mov    %esp,%ebp
     ce3:	56                   	push   %esi
     ce4:	be 64 00 00 00       	mov    $0x64,%esi
     ce9:	53                   	push   %ebx
     cea:	eb 14                	jmp    d00 <exitwait+0x20>
     cec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     cf0:	74 6f                	je     d61 <exitwait+0x81>
     cf2:	e8 33 2b 00 00       	call   382a <wait>
     cf7:	39 d8                	cmp    %ebx,%eax
     cf9:	75 2d                	jne    d28 <exitwait+0x48>
     cfb:	83 ee 01             	sub    $0x1,%esi
     cfe:	74 48                	je     d48 <exitwait+0x68>
     d00:	e8 15 2b 00 00       	call   381a <fork>
     d05:	85 c0                	test   %eax,%eax
     d07:	89 c3                	mov    %eax,%ebx
     d09:	79 e5                	jns    cf0 <exitwait+0x10>
     d0b:	83 ec 08             	sub    $0x8,%esp
     d0e:	68 49 4c 00 00       	push   $0x4c49
     d13:	6a 01                	push   $0x1
     d15:	e8 96 2c 00 00       	call   39b0 <printf>
     d1a:	83 c4 10             	add    $0x10,%esp
     d1d:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d20:	5b                   	pop    %ebx
     d21:	5e                   	pop    %esi
     d22:	5d                   	pop    %ebp
     d23:	c3                   	ret    
     d24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     d28:	83 ec 08             	sub    $0x8,%esp
     d2b:	68 eb 40 00 00       	push   $0x40eb
     d30:	6a 01                	push   $0x1
     d32:	e8 79 2c 00 00       	call   39b0 <printf>
     d37:	83 c4 10             	add    $0x10,%esp
     d3a:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d3d:	5b                   	pop    %ebx
     d3e:	5e                   	pop    %esi
     d3f:	5d                   	pop    %ebp
     d40:	c3                   	ret    
     d41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     d48:	83 ec 08             	sub    $0x8,%esp
     d4b:	68 fb 40 00 00       	push   $0x40fb
     d50:	6a 01                	push   $0x1
     d52:	e8 59 2c 00 00       	call   39b0 <printf>
     d57:	83 c4 10             	add    $0x10,%esp
     d5a:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d5d:	5b                   	pop    %ebx
     d5e:	5e                   	pop    %esi
     d5f:	5d                   	pop    %ebp
     d60:	c3                   	ret    
     d61:	e8 bc 2a 00 00       	call   3822 <exit>
     d66:	8d 76 00             	lea    0x0(%esi),%esi
     d69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000d70 <mem>:
     d70:	55                   	push   %ebp
     d71:	89 e5                	mov    %esp,%ebp
     d73:	57                   	push   %edi
     d74:	56                   	push   %esi
     d75:	53                   	push   %ebx
     d76:	31 db                	xor    %ebx,%ebx
     d78:	83 ec 14             	sub    $0x14,%esp
     d7b:	68 08 41 00 00       	push   $0x4108
     d80:	6a 01                	push   $0x1
     d82:	e8 29 2c 00 00       	call   39b0 <printf>
     d87:	e8 16 2b 00 00       	call   38a2 <getpid>
     d8c:	89 c6                	mov    %eax,%esi
     d8e:	e8 87 2a 00 00       	call   381a <fork>
     d93:	83 c4 10             	add    $0x10,%esp
     d96:	85 c0                	test   %eax,%eax
     d98:	74 0a                	je     da4 <mem+0x34>
     d9a:	e9 89 00 00 00       	jmp    e28 <mem+0xb8>
     d9f:	90                   	nop
     da0:	89 18                	mov    %ebx,(%eax)
     da2:	89 c3                	mov    %eax,%ebx
     da4:	83 ec 0c             	sub    $0xc,%esp
     da7:	68 11 27 00 00       	push   $0x2711
     dac:	e8 5f 2e 00 00       	call   3c10 <malloc>
     db1:	83 c4 10             	add    $0x10,%esp
     db4:	85 c0                	test   %eax,%eax
     db6:	75 e8                	jne    da0 <mem+0x30>
     db8:	85 db                	test   %ebx,%ebx
     dba:	74 18                	je     dd4 <mem+0x64>
     dbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     dc0:	8b 3b                	mov    (%ebx),%edi
     dc2:	83 ec 0c             	sub    $0xc,%esp
     dc5:	53                   	push   %ebx
     dc6:	89 fb                	mov    %edi,%ebx
     dc8:	e8 b3 2d 00 00       	call   3b80 <free>
     dcd:	83 c4 10             	add    $0x10,%esp
     dd0:	85 db                	test   %ebx,%ebx
     dd2:	75 ec                	jne    dc0 <mem+0x50>
     dd4:	83 ec 0c             	sub    $0xc,%esp
     dd7:	68 00 50 00 00       	push   $0x5000
     ddc:	e8 2f 2e 00 00       	call   3c10 <malloc>
     de1:	83 c4 10             	add    $0x10,%esp
     de4:	85 c0                	test   %eax,%eax
     de6:	74 20                	je     e08 <mem+0x98>
     de8:	83 ec 0c             	sub    $0xc,%esp
     deb:	50                   	push   %eax
     dec:	e8 8f 2d 00 00       	call   3b80 <free>
     df1:	58                   	pop    %eax
     df2:	5a                   	pop    %edx
     df3:	68 2c 41 00 00       	push   $0x412c
     df8:	6a 01                	push   $0x1
     dfa:	e8 b1 2b 00 00       	call   39b0 <printf>
     dff:	e8 1e 2a 00 00       	call   3822 <exit>
     e04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     e08:	83 ec 08             	sub    $0x8,%esp
     e0b:	68 12 41 00 00       	push   $0x4112
     e10:	6a 01                	push   $0x1
     e12:	e8 99 2b 00 00       	call   39b0 <printf>
     e17:	89 34 24             	mov    %esi,(%esp)
     e1a:	e8 33 2a 00 00       	call   3852 <kill>
     e1f:	e8 fe 29 00 00       	call   3822 <exit>
     e24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     e28:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e2b:	5b                   	pop    %ebx
     e2c:	5e                   	pop    %esi
     e2d:	5f                   	pop    %edi
     e2e:	5d                   	pop    %ebp
     e2f:	e9 f6 29 00 00       	jmp    382a <wait>
     e34:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     e3a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000e40 <sharedfd>:
     e40:	55                   	push   %ebp
     e41:	89 e5                	mov    %esp,%ebp
     e43:	57                   	push   %edi
     e44:	56                   	push   %esi
     e45:	53                   	push   %ebx
     e46:	83 ec 34             	sub    $0x34,%esp
     e49:	68 34 41 00 00       	push   $0x4134
     e4e:	6a 01                	push   $0x1
     e50:	e8 5b 2b 00 00       	call   39b0 <printf>
     e55:	c7 04 24 43 41 00 00 	movl   $0x4143,(%esp)
     e5c:	e8 11 2a 00 00       	call   3872 <unlink>
     e61:	59                   	pop    %ecx
     e62:	5b                   	pop    %ebx
     e63:	68 02 02 00 00       	push   $0x202
     e68:	68 43 41 00 00       	push   $0x4143
     e6d:	e8 f0 29 00 00       	call   3862 <open>
     e72:	83 c4 10             	add    $0x10,%esp
     e75:	85 c0                	test   %eax,%eax
     e77:	0f 88 33 01 00 00    	js     fb0 <sharedfd+0x170>
     e7d:	89 c6                	mov    %eax,%esi
     e7f:	bb e8 03 00 00       	mov    $0x3e8,%ebx
     e84:	e8 91 29 00 00       	call   381a <fork>
     e89:	83 f8 01             	cmp    $0x1,%eax
     e8c:	89 c7                	mov    %eax,%edi
     e8e:	19 c0                	sbb    %eax,%eax
     e90:	83 ec 04             	sub    $0x4,%esp
     e93:	83 e0 f3             	and    $0xfffffff3,%eax
     e96:	6a 0a                	push   $0xa
     e98:	83 c0 70             	add    $0x70,%eax
     e9b:	50                   	push   %eax
     e9c:	8d 45 de             	lea    -0x22(%ebp),%eax
     e9f:	50                   	push   %eax
     ea0:	e8 db 27 00 00       	call   3680 <memset>
     ea5:	83 c4 10             	add    $0x10,%esp
     ea8:	eb 0b                	jmp    eb5 <sharedfd+0x75>
     eaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     eb0:	83 eb 01             	sub    $0x1,%ebx
     eb3:	74 29                	je     ede <sharedfd+0x9e>
     eb5:	8d 45 de             	lea    -0x22(%ebp),%eax
     eb8:	83 ec 04             	sub    $0x4,%esp
     ebb:	6a 0a                	push   $0xa
     ebd:	50                   	push   %eax
     ebe:	56                   	push   %esi
     ebf:	e8 7e 29 00 00       	call   3842 <write>
     ec4:	83 c4 10             	add    $0x10,%esp
     ec7:	83 f8 0a             	cmp    $0xa,%eax
     eca:	74 e4                	je     eb0 <sharedfd+0x70>
     ecc:	83 ec 08             	sub    $0x8,%esp
     ecf:	68 10 4e 00 00       	push   $0x4e10
     ed4:	6a 01                	push   $0x1
     ed6:	e8 d5 2a 00 00       	call   39b0 <printf>
     edb:	83 c4 10             	add    $0x10,%esp
     ede:	85 ff                	test   %edi,%edi
     ee0:	0f 84 fe 00 00 00    	je     fe4 <sharedfd+0x1a4>
     ee6:	e8 3f 29 00 00       	call   382a <wait>
     eeb:	83 ec 0c             	sub    $0xc,%esp
     eee:	31 db                	xor    %ebx,%ebx
     ef0:	31 ff                	xor    %edi,%edi
     ef2:	56                   	push   %esi
     ef3:	8d 75 e8             	lea    -0x18(%ebp),%esi
     ef6:	e8 4f 29 00 00       	call   384a <close>
     efb:	58                   	pop    %eax
     efc:	5a                   	pop    %edx
     efd:	6a 00                	push   $0x0
     eff:	68 43 41 00 00       	push   $0x4143
     f04:	e8 59 29 00 00       	call   3862 <open>
     f09:	83 c4 10             	add    $0x10,%esp
     f0c:	85 c0                	test   %eax,%eax
     f0e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     f11:	0f 88 b3 00 00 00    	js     fca <sharedfd+0x18a>
     f17:	89 f8                	mov    %edi,%eax
     f19:	89 df                	mov    %ebx,%edi
     f1b:	89 c3                	mov    %eax,%ebx
     f1d:	8d 76 00             	lea    0x0(%esi),%esi
     f20:	8d 45 de             	lea    -0x22(%ebp),%eax
     f23:	83 ec 04             	sub    $0x4,%esp
     f26:	6a 0a                	push   $0xa
     f28:	50                   	push   %eax
     f29:	ff 75 d4             	pushl  -0x2c(%ebp)
     f2c:	e8 09 29 00 00       	call   383a <read>
     f31:	83 c4 10             	add    $0x10,%esp
     f34:	85 c0                	test   %eax,%eax
     f36:	7e 28                	jle    f60 <sharedfd+0x120>
     f38:	8d 45 de             	lea    -0x22(%ebp),%eax
     f3b:	eb 15                	jmp    f52 <sharedfd+0x112>
     f3d:	8d 76 00             	lea    0x0(%esi),%esi
     f40:	80 fa 70             	cmp    $0x70,%dl
     f43:	0f 94 c2             	sete   %dl
     f46:	0f b6 d2             	movzbl %dl,%edx
     f49:	01 d7                	add    %edx,%edi
     f4b:	83 c0 01             	add    $0x1,%eax
     f4e:	39 f0                	cmp    %esi,%eax
     f50:	74 ce                	je     f20 <sharedfd+0xe0>
     f52:	0f b6 10             	movzbl (%eax),%edx
     f55:	80 fa 63             	cmp    $0x63,%dl
     f58:	75 e6                	jne    f40 <sharedfd+0x100>
     f5a:	83 c3 01             	add    $0x1,%ebx
     f5d:	eb ec                	jmp    f4b <sharedfd+0x10b>
     f5f:	90                   	nop
     f60:	83 ec 0c             	sub    $0xc,%esp
     f63:	89 d8                	mov    %ebx,%eax
     f65:	ff 75 d4             	pushl  -0x2c(%ebp)
     f68:	89 fb                	mov    %edi,%ebx
     f6a:	89 c7                	mov    %eax,%edi
     f6c:	e8 d9 28 00 00       	call   384a <close>
     f71:	c7 04 24 43 41 00 00 	movl   $0x4143,(%esp)
     f78:	e8 f5 28 00 00       	call   3872 <unlink>
     f7d:	83 c4 10             	add    $0x10,%esp
     f80:	81 ff 10 27 00 00    	cmp    $0x2710,%edi
     f86:	75 61                	jne    fe9 <sharedfd+0x1a9>
     f88:	81 fb 10 27 00 00    	cmp    $0x2710,%ebx
     f8e:	75 59                	jne    fe9 <sharedfd+0x1a9>
     f90:	83 ec 08             	sub    $0x8,%esp
     f93:	68 4c 41 00 00       	push   $0x414c
     f98:	6a 01                	push   $0x1
     f9a:	e8 11 2a 00 00       	call   39b0 <printf>
     f9f:	83 c4 10             	add    $0x10,%esp
     fa2:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fa5:	5b                   	pop    %ebx
     fa6:	5e                   	pop    %esi
     fa7:	5f                   	pop    %edi
     fa8:	5d                   	pop    %ebp
     fa9:	c3                   	ret    
     faa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     fb0:	83 ec 08             	sub    $0x8,%esp
     fb3:	68 e4 4d 00 00       	push   $0x4de4
     fb8:	6a 01                	push   $0x1
     fba:	e8 f1 29 00 00       	call   39b0 <printf>
     fbf:	83 c4 10             	add    $0x10,%esp
     fc2:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fc5:	5b                   	pop    %ebx
     fc6:	5e                   	pop    %esi
     fc7:	5f                   	pop    %edi
     fc8:	5d                   	pop    %ebp
     fc9:	c3                   	ret    
     fca:	83 ec 08             	sub    $0x8,%esp
     fcd:	68 30 4e 00 00       	push   $0x4e30
     fd2:	6a 01                	push   $0x1
     fd4:	e8 d7 29 00 00       	call   39b0 <printf>
     fd9:	83 c4 10             	add    $0x10,%esp
     fdc:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fdf:	5b                   	pop    %ebx
     fe0:	5e                   	pop    %esi
     fe1:	5f                   	pop    %edi
     fe2:	5d                   	pop    %ebp
     fe3:	c3                   	ret    
     fe4:	e8 39 28 00 00       	call   3822 <exit>
     fe9:	53                   	push   %ebx
     fea:	57                   	push   %edi
     feb:	68 59 41 00 00       	push   $0x4159
     ff0:	6a 01                	push   $0x1
     ff2:	e8 b9 29 00 00       	call   39b0 <printf>
     ff7:	e8 26 28 00 00       	call   3822 <exit>
     ffc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001000 <fourfiles>:
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	57                   	push   %edi
    1004:	56                   	push   %esi
    1005:	53                   	push   %ebx
    1006:	be 6e 41 00 00       	mov    $0x416e,%esi
    100b:	31 db                	xor    %ebx,%ebx
    100d:	83 ec 34             	sub    $0x34,%esp
    1010:	c7 45 d8 6e 41 00 00 	movl   $0x416e,-0x28(%ebp)
    1017:	c7 45 dc b7 42 00 00 	movl   $0x42b7,-0x24(%ebp)
    101e:	68 74 41 00 00       	push   $0x4174
    1023:	6a 01                	push   $0x1
    1025:	c7 45 e0 bb 42 00 00 	movl   $0x42bb,-0x20(%ebp)
    102c:	c7 45 e4 71 41 00 00 	movl   $0x4171,-0x1c(%ebp)
    1033:	e8 78 29 00 00       	call   39b0 <printf>
    1038:	83 c4 10             	add    $0x10,%esp
    103b:	83 ec 0c             	sub    $0xc,%esp
    103e:	56                   	push   %esi
    103f:	e8 2e 28 00 00       	call   3872 <unlink>
    1044:	e8 d1 27 00 00       	call   381a <fork>
    1049:	83 c4 10             	add    $0x10,%esp
    104c:	85 c0                	test   %eax,%eax
    104e:	0f 88 68 01 00 00    	js     11bc <fourfiles+0x1bc>
    1054:	0f 84 df 00 00 00    	je     1139 <fourfiles+0x139>
    105a:	83 c3 01             	add    $0x1,%ebx
    105d:	83 fb 04             	cmp    $0x4,%ebx
    1060:	74 06                	je     1068 <fourfiles+0x68>
    1062:	8b 74 9d d8          	mov    -0x28(%ebp,%ebx,4),%esi
    1066:	eb d3                	jmp    103b <fourfiles+0x3b>
    1068:	e8 bd 27 00 00       	call   382a <wait>
    106d:	31 ff                	xor    %edi,%edi
    106f:	e8 b6 27 00 00       	call   382a <wait>
    1074:	e8 b1 27 00 00       	call   382a <wait>
    1079:	e8 ac 27 00 00       	call   382a <wait>
    107e:	c7 45 d0 6e 41 00 00 	movl   $0x416e,-0x30(%ebp)
    1085:	83 ec 08             	sub    $0x8,%esp
    1088:	31 db                	xor    %ebx,%ebx
    108a:	6a 00                	push   $0x0
    108c:	ff 75 d0             	pushl  -0x30(%ebp)
    108f:	e8 ce 27 00 00       	call   3862 <open>
    1094:	83 c4 10             	add    $0x10,%esp
    1097:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    109a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    10a0:	83 ec 04             	sub    $0x4,%esp
    10a3:	68 00 20 00 00       	push   $0x2000
    10a8:	68 60 85 00 00       	push   $0x8560
    10ad:	ff 75 d4             	pushl  -0x2c(%ebp)
    10b0:	e8 85 27 00 00       	call   383a <read>
    10b5:	83 c4 10             	add    $0x10,%esp
    10b8:	85 c0                	test   %eax,%eax
    10ba:	7e 26                	jle    10e2 <fourfiles+0xe2>
    10bc:	31 d2                	xor    %edx,%edx
    10be:	66 90                	xchg   %ax,%ax
    10c0:	0f be b2 60 85 00 00 	movsbl 0x8560(%edx),%esi
    10c7:	83 ff 01             	cmp    $0x1,%edi
    10ca:	19 c9                	sbb    %ecx,%ecx
    10cc:	83 c1 31             	add    $0x31,%ecx
    10cf:	39 ce                	cmp    %ecx,%esi
    10d1:	0f 85 be 00 00 00    	jne    1195 <fourfiles+0x195>
    10d7:	83 c2 01             	add    $0x1,%edx
    10da:	39 d0                	cmp    %edx,%eax
    10dc:	75 e2                	jne    10c0 <fourfiles+0xc0>
    10de:	01 c3                	add    %eax,%ebx
    10e0:	eb be                	jmp    10a0 <fourfiles+0xa0>
    10e2:	83 ec 0c             	sub    $0xc,%esp
    10e5:	ff 75 d4             	pushl  -0x2c(%ebp)
    10e8:	e8 5d 27 00 00       	call   384a <close>
    10ed:	83 c4 10             	add    $0x10,%esp
    10f0:	81 fb 70 17 00 00    	cmp    $0x1770,%ebx
    10f6:	0f 85 d3 00 00 00    	jne    11cf <fourfiles+0x1cf>
    10fc:	83 ec 0c             	sub    $0xc,%esp
    10ff:	ff 75 d0             	pushl  -0x30(%ebp)
    1102:	e8 6b 27 00 00       	call   3872 <unlink>
    1107:	83 c4 10             	add    $0x10,%esp
    110a:	83 ff 01             	cmp    $0x1,%edi
    110d:	75 1a                	jne    1129 <fourfiles+0x129>
    110f:	83 ec 08             	sub    $0x8,%esp
    1112:	68 b2 41 00 00       	push   $0x41b2
    1117:	6a 01                	push   $0x1
    1119:	e8 92 28 00 00       	call   39b0 <printf>
    111e:	83 c4 10             	add    $0x10,%esp
    1121:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1124:	5b                   	pop    %ebx
    1125:	5e                   	pop    %esi
    1126:	5f                   	pop    %edi
    1127:	5d                   	pop    %ebp
    1128:	c3                   	ret    
    1129:	8b 45 dc             	mov    -0x24(%ebp),%eax
    112c:	bf 01 00 00 00       	mov    $0x1,%edi
    1131:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1134:	e9 4c ff ff ff       	jmp    1085 <fourfiles+0x85>
    1139:	83 ec 08             	sub    $0x8,%esp
    113c:	68 02 02 00 00       	push   $0x202
    1141:	56                   	push   %esi
    1142:	e8 1b 27 00 00       	call   3862 <open>
    1147:	83 c4 10             	add    $0x10,%esp
    114a:	85 c0                	test   %eax,%eax
    114c:	89 c6                	mov    %eax,%esi
    114e:	78 59                	js     11a9 <fourfiles+0x1a9>
    1150:	83 ec 04             	sub    $0x4,%esp
    1153:	83 c3 30             	add    $0x30,%ebx
    1156:	68 00 02 00 00       	push   $0x200
    115b:	53                   	push   %ebx
    115c:	bb 0c 00 00 00       	mov    $0xc,%ebx
    1161:	68 60 85 00 00       	push   $0x8560
    1166:	e8 15 25 00 00       	call   3680 <memset>
    116b:	83 c4 10             	add    $0x10,%esp
    116e:	83 ec 04             	sub    $0x4,%esp
    1171:	68 f4 01 00 00       	push   $0x1f4
    1176:	68 60 85 00 00       	push   $0x8560
    117b:	56                   	push   %esi
    117c:	e8 c1 26 00 00       	call   3842 <write>
    1181:	83 c4 10             	add    $0x10,%esp
    1184:	3d f4 01 00 00       	cmp    $0x1f4,%eax
    1189:	75 57                	jne    11e2 <fourfiles+0x1e2>
    118b:	83 eb 01             	sub    $0x1,%ebx
    118e:	75 de                	jne    116e <fourfiles+0x16e>
    1190:	e8 8d 26 00 00       	call   3822 <exit>
    1195:	83 ec 08             	sub    $0x8,%esp
    1198:	68 95 41 00 00       	push   $0x4195
    119d:	6a 01                	push   $0x1
    119f:	e8 0c 28 00 00       	call   39b0 <printf>
    11a4:	e8 79 26 00 00       	call   3822 <exit>
    11a9:	51                   	push   %ecx
    11aa:	51                   	push   %ecx
    11ab:	68 0f 44 00 00       	push   $0x440f
    11b0:	6a 01                	push   $0x1
    11b2:	e8 f9 27 00 00       	call   39b0 <printf>
    11b7:	e8 66 26 00 00       	call   3822 <exit>
    11bc:	53                   	push   %ebx
    11bd:	53                   	push   %ebx
    11be:	68 49 4c 00 00       	push   $0x4c49
    11c3:	6a 01                	push   $0x1
    11c5:	e8 e6 27 00 00       	call   39b0 <printf>
    11ca:	e8 53 26 00 00       	call   3822 <exit>
    11cf:	50                   	push   %eax
    11d0:	53                   	push   %ebx
    11d1:	68 a1 41 00 00       	push   $0x41a1
    11d6:	6a 01                	push   $0x1
    11d8:	e8 d3 27 00 00       	call   39b0 <printf>
    11dd:	e8 40 26 00 00       	call   3822 <exit>
    11e2:	52                   	push   %edx
    11e3:	50                   	push   %eax
    11e4:	68 84 41 00 00       	push   $0x4184
    11e9:	6a 01                	push   $0x1
    11eb:	e8 c0 27 00 00       	call   39b0 <printf>
    11f0:	e8 2d 26 00 00       	call   3822 <exit>
    11f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    11f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001200 <createdelete>:
    1200:	55                   	push   %ebp
    1201:	89 e5                	mov    %esp,%ebp
    1203:	57                   	push   %edi
    1204:	56                   	push   %esi
    1205:	53                   	push   %ebx
    1206:	31 db                	xor    %ebx,%ebx
    1208:	83 ec 44             	sub    $0x44,%esp
    120b:	68 c0 41 00 00       	push   $0x41c0
    1210:	6a 01                	push   $0x1
    1212:	e8 99 27 00 00       	call   39b0 <printf>
    1217:	83 c4 10             	add    $0x10,%esp
    121a:	e8 fb 25 00 00       	call   381a <fork>
    121f:	85 c0                	test   %eax,%eax
    1221:	0f 88 be 01 00 00    	js     13e5 <createdelete+0x1e5>
    1227:	0f 84 0b 01 00 00    	je     1338 <createdelete+0x138>
    122d:	83 c3 01             	add    $0x1,%ebx
    1230:	83 fb 04             	cmp    $0x4,%ebx
    1233:	75 e5                	jne    121a <createdelete+0x1a>
    1235:	8d 7d c8             	lea    -0x38(%ebp),%edi
    1238:	be ff ff ff ff       	mov    $0xffffffff,%esi
    123d:	e8 e8 25 00 00       	call   382a <wait>
    1242:	e8 e3 25 00 00       	call   382a <wait>
    1247:	e8 de 25 00 00       	call   382a <wait>
    124c:	e8 d9 25 00 00       	call   382a <wait>
    1251:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    1255:	8d 76 00             	lea    0x0(%esi),%esi
    1258:	8d 46 31             	lea    0x31(%esi),%eax
    125b:	88 45 c7             	mov    %al,-0x39(%ebp)
    125e:	8d 46 01             	lea    0x1(%esi),%eax
    1261:	83 f8 09             	cmp    $0x9,%eax
    1264:	89 45 c0             	mov    %eax,-0x40(%ebp)
    1267:	0f 9f c3             	setg   %bl
    126a:	85 c0                	test   %eax,%eax
    126c:	0f 94 c0             	sete   %al
    126f:	09 c3                	or     %eax,%ebx
    1271:	88 5d c6             	mov    %bl,-0x3a(%ebp)
    1274:	bb 70 00 00 00       	mov    $0x70,%ebx
    1279:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
    127d:	83 ec 08             	sub    $0x8,%esp
    1280:	88 5d c8             	mov    %bl,-0x38(%ebp)
    1283:	6a 00                	push   $0x0
    1285:	57                   	push   %edi
    1286:	88 45 c9             	mov    %al,-0x37(%ebp)
    1289:	e8 d4 25 00 00       	call   3862 <open>
    128e:	83 c4 10             	add    $0x10,%esp
    1291:	80 7d c6 00          	cmpb   $0x0,-0x3a(%ebp)
    1295:	0f 84 85 00 00 00    	je     1320 <createdelete+0x120>
    129b:	85 c0                	test   %eax,%eax
    129d:	0f 88 1a 01 00 00    	js     13bd <createdelete+0x1bd>
    12a3:	83 fe 08             	cmp    $0x8,%esi
    12a6:	0f 86 54 01 00 00    	jbe    1400 <createdelete+0x200>
    12ac:	83 ec 0c             	sub    $0xc,%esp
    12af:	50                   	push   %eax
    12b0:	e8 95 25 00 00       	call   384a <close>
    12b5:	83 c4 10             	add    $0x10,%esp
    12b8:	83 c3 01             	add    $0x1,%ebx
    12bb:	80 fb 74             	cmp    $0x74,%bl
    12be:	75 b9                	jne    1279 <createdelete+0x79>
    12c0:	8b 75 c0             	mov    -0x40(%ebp),%esi
    12c3:	83 fe 13             	cmp    $0x13,%esi
    12c6:	75 90                	jne    1258 <createdelete+0x58>
    12c8:	be 70 00 00 00       	mov    $0x70,%esi
    12cd:	8d 76 00             	lea    0x0(%esi),%esi
    12d0:	8d 46 c0             	lea    -0x40(%esi),%eax
    12d3:	bb 04 00 00 00       	mov    $0x4,%ebx
    12d8:	88 45 c7             	mov    %al,-0x39(%ebp)
    12db:	89 f0                	mov    %esi,%eax
    12dd:	83 ec 0c             	sub    $0xc,%esp
    12e0:	88 45 c8             	mov    %al,-0x38(%ebp)
    12e3:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
    12e7:	57                   	push   %edi
    12e8:	88 45 c9             	mov    %al,-0x37(%ebp)
    12eb:	e8 82 25 00 00       	call   3872 <unlink>
    12f0:	83 c4 10             	add    $0x10,%esp
    12f3:	83 eb 01             	sub    $0x1,%ebx
    12f6:	75 e3                	jne    12db <createdelete+0xdb>
    12f8:	83 c6 01             	add    $0x1,%esi
    12fb:	89 f0                	mov    %esi,%eax
    12fd:	3c 84                	cmp    $0x84,%al
    12ff:	75 cf                	jne    12d0 <createdelete+0xd0>
    1301:	83 ec 08             	sub    $0x8,%esp
    1304:	68 d3 41 00 00       	push   $0x41d3
    1309:	6a 01                	push   $0x1
    130b:	e8 a0 26 00 00       	call   39b0 <printf>
    1310:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1313:	5b                   	pop    %ebx
    1314:	5e                   	pop    %esi
    1315:	5f                   	pop    %edi
    1316:	5d                   	pop    %ebp
    1317:	c3                   	ret    
    1318:	90                   	nop
    1319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1320:	83 fe 08             	cmp    $0x8,%esi
    1323:	0f 86 cf 00 00 00    	jbe    13f8 <createdelete+0x1f8>
    1329:	85 c0                	test   %eax,%eax
    132b:	78 8b                	js     12b8 <createdelete+0xb8>
    132d:	e9 7a ff ff ff       	jmp    12ac <createdelete+0xac>
    1332:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1338:	83 c3 70             	add    $0x70,%ebx
    133b:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    133f:	8d 7d c8             	lea    -0x38(%ebp),%edi
    1342:	88 5d c8             	mov    %bl,-0x38(%ebp)
    1345:	31 db                	xor    %ebx,%ebx
    1347:	eb 0f                	jmp    1358 <createdelete+0x158>
    1349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1350:	83 fb 13             	cmp    $0x13,%ebx
    1353:	74 63                	je     13b8 <createdelete+0x1b8>
    1355:	83 c3 01             	add    $0x1,%ebx
    1358:	83 ec 08             	sub    $0x8,%esp
    135b:	8d 43 30             	lea    0x30(%ebx),%eax
    135e:	68 02 02 00 00       	push   $0x202
    1363:	57                   	push   %edi
    1364:	88 45 c9             	mov    %al,-0x37(%ebp)
    1367:	e8 f6 24 00 00       	call   3862 <open>
    136c:	83 c4 10             	add    $0x10,%esp
    136f:	85 c0                	test   %eax,%eax
    1371:	78 5f                	js     13d2 <createdelete+0x1d2>
    1373:	83 ec 0c             	sub    $0xc,%esp
    1376:	50                   	push   %eax
    1377:	e8 ce 24 00 00       	call   384a <close>
    137c:	83 c4 10             	add    $0x10,%esp
    137f:	85 db                	test   %ebx,%ebx
    1381:	74 d2                	je     1355 <createdelete+0x155>
    1383:	f6 c3 01             	test   $0x1,%bl
    1386:	75 c8                	jne    1350 <createdelete+0x150>
    1388:	83 ec 0c             	sub    $0xc,%esp
    138b:	89 d8                	mov    %ebx,%eax
    138d:	d1 f8                	sar    %eax
    138f:	57                   	push   %edi
    1390:	83 c0 30             	add    $0x30,%eax
    1393:	88 45 c9             	mov    %al,-0x37(%ebp)
    1396:	e8 d7 24 00 00       	call   3872 <unlink>
    139b:	83 c4 10             	add    $0x10,%esp
    139e:	85 c0                	test   %eax,%eax
    13a0:	79 ae                	jns    1350 <createdelete+0x150>
    13a2:	52                   	push   %edx
    13a3:	52                   	push   %edx
    13a4:	68 c1 3d 00 00       	push   $0x3dc1
    13a9:	6a 01                	push   $0x1
    13ab:	e8 00 26 00 00       	call   39b0 <printf>
    13b0:	e8 6d 24 00 00       	call   3822 <exit>
    13b5:	8d 76 00             	lea    0x0(%esi),%esi
    13b8:	e8 65 24 00 00       	call   3822 <exit>
    13bd:	83 ec 04             	sub    $0x4,%esp
    13c0:	57                   	push   %edi
    13c1:	68 5c 4e 00 00       	push   $0x4e5c
    13c6:	6a 01                	push   $0x1
    13c8:	e8 e3 25 00 00       	call   39b0 <printf>
    13cd:	e8 50 24 00 00       	call   3822 <exit>
    13d2:	51                   	push   %ecx
    13d3:	51                   	push   %ecx
    13d4:	68 0f 44 00 00       	push   $0x440f
    13d9:	6a 01                	push   $0x1
    13db:	e8 d0 25 00 00       	call   39b0 <printf>
    13e0:	e8 3d 24 00 00       	call   3822 <exit>
    13e5:	53                   	push   %ebx
    13e6:	53                   	push   %ebx
    13e7:	68 49 4c 00 00       	push   $0x4c49
    13ec:	6a 01                	push   $0x1
    13ee:	e8 bd 25 00 00       	call   39b0 <printf>
    13f3:	e8 2a 24 00 00       	call   3822 <exit>
    13f8:	85 c0                	test   %eax,%eax
    13fa:	0f 88 b8 fe ff ff    	js     12b8 <createdelete+0xb8>
    1400:	50                   	push   %eax
    1401:	57                   	push   %edi
    1402:	68 80 4e 00 00       	push   $0x4e80
    1407:	6a 01                	push   $0x1
    1409:	e8 a2 25 00 00       	call   39b0 <printf>
    140e:	e8 0f 24 00 00       	call   3822 <exit>
    1413:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001420 <unlinkread>:
    1420:	55                   	push   %ebp
    1421:	89 e5                	mov    %esp,%ebp
    1423:	56                   	push   %esi
    1424:	53                   	push   %ebx
    1425:	83 ec 08             	sub    $0x8,%esp
    1428:	68 e4 41 00 00       	push   $0x41e4
    142d:	6a 01                	push   $0x1
    142f:	e8 7c 25 00 00       	call   39b0 <printf>
    1434:	5b                   	pop    %ebx
    1435:	5e                   	pop    %esi
    1436:	68 02 02 00 00       	push   $0x202
    143b:	68 f5 41 00 00       	push   $0x41f5
    1440:	e8 1d 24 00 00       	call   3862 <open>
    1445:	83 c4 10             	add    $0x10,%esp
    1448:	85 c0                	test   %eax,%eax
    144a:	0f 88 e6 00 00 00    	js     1536 <unlinkread+0x116>
    1450:	83 ec 04             	sub    $0x4,%esp
    1453:	89 c3                	mov    %eax,%ebx
    1455:	6a 05                	push   $0x5
    1457:	68 1a 42 00 00       	push   $0x421a
    145c:	50                   	push   %eax
    145d:	e8 e0 23 00 00       	call   3842 <write>
    1462:	89 1c 24             	mov    %ebx,(%esp)
    1465:	e8 e0 23 00 00       	call   384a <close>
    146a:	58                   	pop    %eax
    146b:	5a                   	pop    %edx
    146c:	6a 02                	push   $0x2
    146e:	68 f5 41 00 00       	push   $0x41f5
    1473:	e8 ea 23 00 00       	call   3862 <open>
    1478:	83 c4 10             	add    $0x10,%esp
    147b:	85 c0                	test   %eax,%eax
    147d:	89 c3                	mov    %eax,%ebx
    147f:	0f 88 10 01 00 00    	js     1595 <unlinkread+0x175>
    1485:	83 ec 0c             	sub    $0xc,%esp
    1488:	68 f5 41 00 00       	push   $0x41f5
    148d:	e8 e0 23 00 00       	call   3872 <unlink>
    1492:	83 c4 10             	add    $0x10,%esp
    1495:	85 c0                	test   %eax,%eax
    1497:	0f 85 e5 00 00 00    	jne    1582 <unlinkread+0x162>
    149d:	83 ec 08             	sub    $0x8,%esp
    14a0:	68 02 02 00 00       	push   $0x202
    14a5:	68 f5 41 00 00       	push   $0x41f5
    14aa:	e8 b3 23 00 00       	call   3862 <open>
    14af:	83 c4 0c             	add    $0xc,%esp
    14b2:	89 c6                	mov    %eax,%esi
    14b4:	6a 03                	push   $0x3
    14b6:	68 52 42 00 00       	push   $0x4252
    14bb:	50                   	push   %eax
    14bc:	e8 81 23 00 00       	call   3842 <write>
    14c1:	89 34 24             	mov    %esi,(%esp)
    14c4:	e8 81 23 00 00       	call   384a <close>
    14c9:	83 c4 0c             	add    $0xc,%esp
    14cc:	68 00 20 00 00       	push   $0x2000
    14d1:	68 60 85 00 00       	push   $0x8560
    14d6:	53                   	push   %ebx
    14d7:	e8 5e 23 00 00       	call   383a <read>
    14dc:	83 c4 10             	add    $0x10,%esp
    14df:	83 f8 05             	cmp    $0x5,%eax
    14e2:	0f 85 87 00 00 00    	jne    156f <unlinkread+0x14f>
    14e8:	80 3d 60 85 00 00 68 	cmpb   $0x68,0x8560
    14ef:	75 6b                	jne    155c <unlinkread+0x13c>
    14f1:	83 ec 04             	sub    $0x4,%esp
    14f4:	6a 0a                	push   $0xa
    14f6:	68 60 85 00 00       	push   $0x8560
    14fb:	53                   	push   %ebx
    14fc:	e8 41 23 00 00       	call   3842 <write>
    1501:	83 c4 10             	add    $0x10,%esp
    1504:	83 f8 0a             	cmp    $0xa,%eax
    1507:	75 40                	jne    1549 <unlinkread+0x129>
    1509:	83 ec 0c             	sub    $0xc,%esp
    150c:	53                   	push   %ebx
    150d:	e8 38 23 00 00       	call   384a <close>
    1512:	c7 04 24 f5 41 00 00 	movl   $0x41f5,(%esp)
    1519:	e8 54 23 00 00       	call   3872 <unlink>
    151e:	58                   	pop    %eax
    151f:	5a                   	pop    %edx
    1520:	68 9d 42 00 00       	push   $0x429d
    1525:	6a 01                	push   $0x1
    1527:	e8 84 24 00 00       	call   39b0 <printf>
    152c:	83 c4 10             	add    $0x10,%esp
    152f:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1532:	5b                   	pop    %ebx
    1533:	5e                   	pop    %esi
    1534:	5d                   	pop    %ebp
    1535:	c3                   	ret    
    1536:	51                   	push   %ecx
    1537:	51                   	push   %ecx
    1538:	68 00 42 00 00       	push   $0x4200
    153d:	6a 01                	push   $0x1
    153f:	e8 6c 24 00 00       	call   39b0 <printf>
    1544:	e8 d9 22 00 00       	call   3822 <exit>
    1549:	51                   	push   %ecx
    154a:	51                   	push   %ecx
    154b:	68 84 42 00 00       	push   $0x4284
    1550:	6a 01                	push   $0x1
    1552:	e8 59 24 00 00       	call   39b0 <printf>
    1557:	e8 c6 22 00 00       	call   3822 <exit>
    155c:	53                   	push   %ebx
    155d:	53                   	push   %ebx
    155e:	68 6d 42 00 00       	push   $0x426d
    1563:	6a 01                	push   $0x1
    1565:	e8 46 24 00 00       	call   39b0 <printf>
    156a:	e8 b3 22 00 00       	call   3822 <exit>
    156f:	56                   	push   %esi
    1570:	56                   	push   %esi
    1571:	68 56 42 00 00       	push   $0x4256
    1576:	6a 01                	push   $0x1
    1578:	e8 33 24 00 00       	call   39b0 <printf>
    157d:	e8 a0 22 00 00       	call   3822 <exit>
    1582:	50                   	push   %eax
    1583:	50                   	push   %eax
    1584:	68 38 42 00 00       	push   $0x4238
    1589:	6a 01                	push   $0x1
    158b:	e8 20 24 00 00       	call   39b0 <printf>
    1590:	e8 8d 22 00 00       	call   3822 <exit>
    1595:	50                   	push   %eax
    1596:	50                   	push   %eax
    1597:	68 20 42 00 00       	push   $0x4220
    159c:	6a 01                	push   $0x1
    159e:	e8 0d 24 00 00       	call   39b0 <printf>
    15a3:	e8 7a 22 00 00       	call   3822 <exit>
    15a8:	90                   	nop
    15a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000015b0 <linktest>:
    15b0:	55                   	push   %ebp
    15b1:	89 e5                	mov    %esp,%ebp
    15b3:	53                   	push   %ebx
    15b4:	83 ec 0c             	sub    $0xc,%esp
    15b7:	68 ac 42 00 00       	push   $0x42ac
    15bc:	6a 01                	push   $0x1
    15be:	e8 ed 23 00 00       	call   39b0 <printf>
    15c3:	c7 04 24 b6 42 00 00 	movl   $0x42b6,(%esp)
    15ca:	e8 a3 22 00 00       	call   3872 <unlink>
    15cf:	c7 04 24 ba 42 00 00 	movl   $0x42ba,(%esp)
    15d6:	e8 97 22 00 00       	call   3872 <unlink>
    15db:	58                   	pop    %eax
    15dc:	5a                   	pop    %edx
    15dd:	68 02 02 00 00       	push   $0x202
    15e2:	68 b6 42 00 00       	push   $0x42b6
    15e7:	e8 76 22 00 00       	call   3862 <open>
    15ec:	83 c4 10             	add    $0x10,%esp
    15ef:	85 c0                	test   %eax,%eax
    15f1:	0f 88 1e 01 00 00    	js     1715 <linktest+0x165>
    15f7:	83 ec 04             	sub    $0x4,%esp
    15fa:	89 c3                	mov    %eax,%ebx
    15fc:	6a 05                	push   $0x5
    15fe:	68 1a 42 00 00       	push   $0x421a
    1603:	50                   	push   %eax
    1604:	e8 39 22 00 00       	call   3842 <write>
    1609:	83 c4 10             	add    $0x10,%esp
    160c:	83 f8 05             	cmp    $0x5,%eax
    160f:	0f 85 98 01 00 00    	jne    17ad <linktest+0x1fd>
    1615:	83 ec 0c             	sub    $0xc,%esp
    1618:	53                   	push   %ebx
    1619:	e8 2c 22 00 00       	call   384a <close>
    161e:	5b                   	pop    %ebx
    161f:	58                   	pop    %eax
    1620:	68 ba 42 00 00       	push   $0x42ba
    1625:	68 b6 42 00 00       	push   $0x42b6
    162a:	e8 53 22 00 00       	call   3882 <link>
    162f:	83 c4 10             	add    $0x10,%esp
    1632:	85 c0                	test   %eax,%eax
    1634:	0f 88 60 01 00 00    	js     179a <linktest+0x1ea>
    163a:	83 ec 0c             	sub    $0xc,%esp
    163d:	68 b6 42 00 00       	push   $0x42b6
    1642:	e8 2b 22 00 00       	call   3872 <unlink>
    1647:	58                   	pop    %eax
    1648:	5a                   	pop    %edx
    1649:	6a 00                	push   $0x0
    164b:	68 b6 42 00 00       	push   $0x42b6
    1650:	e8 0d 22 00 00       	call   3862 <open>
    1655:	83 c4 10             	add    $0x10,%esp
    1658:	85 c0                	test   %eax,%eax
    165a:	0f 89 27 01 00 00    	jns    1787 <linktest+0x1d7>
    1660:	83 ec 08             	sub    $0x8,%esp
    1663:	6a 00                	push   $0x0
    1665:	68 ba 42 00 00       	push   $0x42ba
    166a:	e8 f3 21 00 00       	call   3862 <open>
    166f:	83 c4 10             	add    $0x10,%esp
    1672:	85 c0                	test   %eax,%eax
    1674:	89 c3                	mov    %eax,%ebx
    1676:	0f 88 f8 00 00 00    	js     1774 <linktest+0x1c4>
    167c:	83 ec 04             	sub    $0x4,%esp
    167f:	68 00 20 00 00       	push   $0x2000
    1684:	68 60 85 00 00       	push   $0x8560
    1689:	50                   	push   %eax
    168a:	e8 ab 21 00 00       	call   383a <read>
    168f:	83 c4 10             	add    $0x10,%esp
    1692:	83 f8 05             	cmp    $0x5,%eax
    1695:	0f 85 c6 00 00 00    	jne    1761 <linktest+0x1b1>
    169b:	83 ec 0c             	sub    $0xc,%esp
    169e:	53                   	push   %ebx
    169f:	e8 a6 21 00 00       	call   384a <close>
    16a4:	58                   	pop    %eax
    16a5:	5a                   	pop    %edx
    16a6:	68 ba 42 00 00       	push   $0x42ba
    16ab:	68 ba 42 00 00       	push   $0x42ba
    16b0:	e8 cd 21 00 00       	call   3882 <link>
    16b5:	83 c4 10             	add    $0x10,%esp
    16b8:	85 c0                	test   %eax,%eax
    16ba:	0f 89 8e 00 00 00    	jns    174e <linktest+0x19e>
    16c0:	83 ec 0c             	sub    $0xc,%esp
    16c3:	68 ba 42 00 00       	push   $0x42ba
    16c8:	e8 a5 21 00 00       	call   3872 <unlink>
    16cd:	59                   	pop    %ecx
    16ce:	5b                   	pop    %ebx
    16cf:	68 b6 42 00 00       	push   $0x42b6
    16d4:	68 ba 42 00 00       	push   $0x42ba
    16d9:	e8 a4 21 00 00       	call   3882 <link>
    16de:	83 c4 10             	add    $0x10,%esp
    16e1:	85 c0                	test   %eax,%eax
    16e3:	79 56                	jns    173b <linktest+0x18b>
    16e5:	83 ec 08             	sub    $0x8,%esp
    16e8:	68 b6 42 00 00       	push   $0x42b6
    16ed:	68 7e 45 00 00       	push   $0x457e
    16f2:	e8 8b 21 00 00       	call   3882 <link>
    16f7:	83 c4 10             	add    $0x10,%esp
    16fa:	85 c0                	test   %eax,%eax
    16fc:	79 2a                	jns    1728 <linktest+0x178>
    16fe:	83 ec 08             	sub    $0x8,%esp
    1701:	68 54 43 00 00       	push   $0x4354
    1706:	6a 01                	push   $0x1
    1708:	e8 a3 22 00 00       	call   39b0 <printf>
    170d:	83 c4 10             	add    $0x10,%esp
    1710:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1713:	c9                   	leave  
    1714:	c3                   	ret    
    1715:	50                   	push   %eax
    1716:	50                   	push   %eax
    1717:	68 be 42 00 00       	push   $0x42be
    171c:	6a 01                	push   $0x1
    171e:	e8 8d 22 00 00       	call   39b0 <printf>
    1723:	e8 fa 20 00 00       	call   3822 <exit>
    1728:	50                   	push   %eax
    1729:	50                   	push   %eax
    172a:	68 38 43 00 00       	push   $0x4338
    172f:	6a 01                	push   $0x1
    1731:	e8 7a 22 00 00       	call   39b0 <printf>
    1736:	e8 e7 20 00 00       	call   3822 <exit>
    173b:	52                   	push   %edx
    173c:	52                   	push   %edx
    173d:	68 c8 4e 00 00       	push   $0x4ec8
    1742:	6a 01                	push   $0x1
    1744:	e8 67 22 00 00       	call   39b0 <printf>
    1749:	e8 d4 20 00 00       	call   3822 <exit>
    174e:	50                   	push   %eax
    174f:	50                   	push   %eax
    1750:	68 1a 43 00 00       	push   $0x431a
    1755:	6a 01                	push   $0x1
    1757:	e8 54 22 00 00       	call   39b0 <printf>
    175c:	e8 c1 20 00 00       	call   3822 <exit>
    1761:	51                   	push   %ecx
    1762:	51                   	push   %ecx
    1763:	68 09 43 00 00       	push   $0x4309
    1768:	6a 01                	push   $0x1
    176a:	e8 41 22 00 00       	call   39b0 <printf>
    176f:	e8 ae 20 00 00       	call   3822 <exit>
    1774:	53                   	push   %ebx
    1775:	53                   	push   %ebx
    1776:	68 f8 42 00 00       	push   $0x42f8
    177b:	6a 01                	push   $0x1
    177d:	e8 2e 22 00 00       	call   39b0 <printf>
    1782:	e8 9b 20 00 00       	call   3822 <exit>
    1787:	50                   	push   %eax
    1788:	50                   	push   %eax
    1789:	68 a0 4e 00 00       	push   $0x4ea0
    178e:	6a 01                	push   $0x1
    1790:	e8 1b 22 00 00       	call   39b0 <printf>
    1795:	e8 88 20 00 00       	call   3822 <exit>
    179a:	51                   	push   %ecx
    179b:	51                   	push   %ecx
    179c:	68 e3 42 00 00       	push   $0x42e3
    17a1:	6a 01                	push   $0x1
    17a3:	e8 08 22 00 00       	call   39b0 <printf>
    17a8:	e8 75 20 00 00       	call   3822 <exit>
    17ad:	50                   	push   %eax
    17ae:	50                   	push   %eax
    17af:	68 d1 42 00 00       	push   $0x42d1
    17b4:	6a 01                	push   $0x1
    17b6:	e8 f5 21 00 00       	call   39b0 <printf>
    17bb:	e8 62 20 00 00       	call   3822 <exit>

000017c0 <concreate>:
    17c0:	55                   	push   %ebp
    17c1:	89 e5                	mov    %esp,%ebp
    17c3:	57                   	push   %edi
    17c4:	56                   	push   %esi
    17c5:	53                   	push   %ebx
    17c6:	31 f6                	xor    %esi,%esi
    17c8:	8d 5d ad             	lea    -0x53(%ebp),%ebx
    17cb:	bf ab aa aa aa       	mov    $0xaaaaaaab,%edi
    17d0:	83 ec 64             	sub    $0x64,%esp
    17d3:	68 61 43 00 00       	push   $0x4361
    17d8:	6a 01                	push   $0x1
    17da:	e8 d1 21 00 00       	call   39b0 <printf>
    17df:	c6 45 ad 43          	movb   $0x43,-0x53(%ebp)
    17e3:	c6 45 af 00          	movb   $0x0,-0x51(%ebp)
    17e7:	83 c4 10             	add    $0x10,%esp
    17ea:	eb 4c                	jmp    1838 <concreate+0x78>
    17ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    17f0:	89 f0                	mov    %esi,%eax
    17f2:	89 f1                	mov    %esi,%ecx
    17f4:	f7 e7                	mul    %edi
    17f6:	d1 ea                	shr    %edx
    17f8:	8d 04 52             	lea    (%edx,%edx,2),%eax
    17fb:	29 c1                	sub    %eax,%ecx
    17fd:	83 f9 01             	cmp    $0x1,%ecx
    1800:	0f 84 ba 00 00 00    	je     18c0 <concreate+0x100>
    1806:	83 ec 08             	sub    $0x8,%esp
    1809:	68 02 02 00 00       	push   $0x202
    180e:	53                   	push   %ebx
    180f:	e8 4e 20 00 00       	call   3862 <open>
    1814:	83 c4 10             	add    $0x10,%esp
    1817:	85 c0                	test   %eax,%eax
    1819:	78 67                	js     1882 <concreate+0xc2>
    181b:	83 ec 0c             	sub    $0xc,%esp
    181e:	83 c6 01             	add    $0x1,%esi
    1821:	50                   	push   %eax
    1822:	e8 23 20 00 00       	call   384a <close>
    1827:	83 c4 10             	add    $0x10,%esp
    182a:	e8 fb 1f 00 00       	call   382a <wait>
    182f:	83 fe 28             	cmp    $0x28,%esi
    1832:	0f 84 aa 00 00 00    	je     18e2 <concreate+0x122>
    1838:	83 ec 0c             	sub    $0xc,%esp
    183b:	8d 46 30             	lea    0x30(%esi),%eax
    183e:	53                   	push   %ebx
    183f:	88 45 ae             	mov    %al,-0x52(%ebp)
    1842:	e8 2b 20 00 00       	call   3872 <unlink>
    1847:	e8 ce 1f 00 00       	call   381a <fork>
    184c:	83 c4 10             	add    $0x10,%esp
    184f:	85 c0                	test   %eax,%eax
    1851:	75 9d                	jne    17f0 <concreate+0x30>
    1853:	89 f0                	mov    %esi,%eax
    1855:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
    185a:	f7 e2                	mul    %edx
    185c:	c1 ea 02             	shr    $0x2,%edx
    185f:	8d 04 92             	lea    (%edx,%edx,4),%eax
    1862:	29 c6                	sub    %eax,%esi
    1864:	83 fe 01             	cmp    $0x1,%esi
    1867:	74 37                	je     18a0 <concreate+0xe0>
    1869:	83 ec 08             	sub    $0x8,%esp
    186c:	68 02 02 00 00       	push   $0x202
    1871:	53                   	push   %ebx
    1872:	e8 eb 1f 00 00       	call   3862 <open>
    1877:	83 c4 10             	add    $0x10,%esp
    187a:	85 c0                	test   %eax,%eax
    187c:	0f 89 28 02 00 00    	jns    1aaa <concreate+0x2ea>
    1882:	83 ec 04             	sub    $0x4,%esp
    1885:	53                   	push   %ebx
    1886:	68 74 43 00 00       	push   $0x4374
    188b:	6a 01                	push   $0x1
    188d:	e8 1e 21 00 00       	call   39b0 <printf>
    1892:	e8 8b 1f 00 00       	call   3822 <exit>
    1897:	89 f6                	mov    %esi,%esi
    1899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    18a0:	83 ec 08             	sub    $0x8,%esp
    18a3:	53                   	push   %ebx
    18a4:	68 71 43 00 00       	push   $0x4371
    18a9:	e8 d4 1f 00 00       	call   3882 <link>
    18ae:	83 c4 10             	add    $0x10,%esp
    18b1:	e8 6c 1f 00 00       	call   3822 <exit>
    18b6:	8d 76 00             	lea    0x0(%esi),%esi
    18b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    18c0:	83 ec 08             	sub    $0x8,%esp
    18c3:	83 c6 01             	add    $0x1,%esi
    18c6:	53                   	push   %ebx
    18c7:	68 71 43 00 00       	push   $0x4371
    18cc:	e8 b1 1f 00 00       	call   3882 <link>
    18d1:	83 c4 10             	add    $0x10,%esp
    18d4:	e8 51 1f 00 00       	call   382a <wait>
    18d9:	83 fe 28             	cmp    $0x28,%esi
    18dc:	0f 85 56 ff ff ff    	jne    1838 <concreate+0x78>
    18e2:	8d 45 c0             	lea    -0x40(%ebp),%eax
    18e5:	83 ec 04             	sub    $0x4,%esp
    18e8:	6a 28                	push   $0x28
    18ea:	6a 00                	push   $0x0
    18ec:	50                   	push   %eax
    18ed:	e8 8e 1d 00 00       	call   3680 <memset>
    18f2:	5f                   	pop    %edi
    18f3:	58                   	pop    %eax
    18f4:	6a 00                	push   $0x0
    18f6:	68 7e 45 00 00       	push   $0x457e
    18fb:	8d 7d b0             	lea    -0x50(%ebp),%edi
    18fe:	e8 5f 1f 00 00       	call   3862 <open>
    1903:	83 c4 10             	add    $0x10,%esp
    1906:	89 c6                	mov    %eax,%esi
    1908:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
    190f:	90                   	nop
    1910:	83 ec 04             	sub    $0x4,%esp
    1913:	6a 10                	push   $0x10
    1915:	57                   	push   %edi
    1916:	56                   	push   %esi
    1917:	e8 1e 1f 00 00       	call   383a <read>
    191c:	83 c4 10             	add    $0x10,%esp
    191f:	85 c0                	test   %eax,%eax
    1921:	7e 3d                	jle    1960 <concreate+0x1a0>
    1923:	66 83 7d b0 00       	cmpw   $0x0,-0x50(%ebp)
    1928:	74 e6                	je     1910 <concreate+0x150>
    192a:	80 7d b2 43          	cmpb   $0x43,-0x4e(%ebp)
    192e:	75 e0                	jne    1910 <concreate+0x150>
    1930:	80 7d b4 00          	cmpb   $0x0,-0x4c(%ebp)
    1934:	75 da                	jne    1910 <concreate+0x150>
    1936:	0f be 45 b3          	movsbl -0x4d(%ebp),%eax
    193a:	83 e8 30             	sub    $0x30,%eax
    193d:	83 f8 27             	cmp    $0x27,%eax
    1940:	0f 87 4e 01 00 00    	ja     1a94 <concreate+0x2d4>
    1946:	80 7c 05 c0 00       	cmpb   $0x0,-0x40(%ebp,%eax,1)
    194b:	0f 85 2d 01 00 00    	jne    1a7e <concreate+0x2be>
    1951:	c6 44 05 c0 01       	movb   $0x1,-0x40(%ebp,%eax,1)
    1956:	83 45 a4 01          	addl   $0x1,-0x5c(%ebp)
    195a:	eb b4                	jmp    1910 <concreate+0x150>
    195c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1960:	83 ec 0c             	sub    $0xc,%esp
    1963:	56                   	push   %esi
    1964:	e8 e1 1e 00 00       	call   384a <close>
    1969:	83 c4 10             	add    $0x10,%esp
    196c:	83 7d a4 28          	cmpl   $0x28,-0x5c(%ebp)
    1970:	0f 85 f5 00 00 00    	jne    1a6b <concreate+0x2ab>
    1976:	31 f6                	xor    %esi,%esi
    1978:	eb 48                	jmp    19c2 <concreate+0x202>
    197a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1980:	85 ff                	test   %edi,%edi
    1982:	74 05                	je     1989 <concreate+0x1c9>
    1984:	83 fa 01             	cmp    $0x1,%edx
    1987:	74 64                	je     19ed <concreate+0x22d>
    1989:	83 ec 0c             	sub    $0xc,%esp
    198c:	53                   	push   %ebx
    198d:	e8 e0 1e 00 00       	call   3872 <unlink>
    1992:	89 1c 24             	mov    %ebx,(%esp)
    1995:	e8 d8 1e 00 00       	call   3872 <unlink>
    199a:	89 1c 24             	mov    %ebx,(%esp)
    199d:	e8 d0 1e 00 00       	call   3872 <unlink>
    19a2:	89 1c 24             	mov    %ebx,(%esp)
    19a5:	e8 c8 1e 00 00       	call   3872 <unlink>
    19aa:	83 c4 10             	add    $0x10,%esp
    19ad:	85 ff                	test   %edi,%edi
    19af:	0f 84 fc fe ff ff    	je     18b1 <concreate+0xf1>
    19b5:	83 c6 01             	add    $0x1,%esi
    19b8:	e8 6d 1e 00 00       	call   382a <wait>
    19bd:	83 fe 28             	cmp    $0x28,%esi
    19c0:	74 7e                	je     1a40 <concreate+0x280>
    19c2:	8d 46 30             	lea    0x30(%esi),%eax
    19c5:	88 45 ae             	mov    %al,-0x52(%ebp)
    19c8:	e8 4d 1e 00 00       	call   381a <fork>
    19cd:	85 c0                	test   %eax,%eax
    19cf:	89 c7                	mov    %eax,%edi
    19d1:	0f 88 80 00 00 00    	js     1a57 <concreate+0x297>
    19d7:	b8 ab aa aa aa       	mov    $0xaaaaaaab,%eax
    19dc:	f7 e6                	mul    %esi
    19de:	d1 ea                	shr    %edx
    19e0:	8d 04 52             	lea    (%edx,%edx,2),%eax
    19e3:	89 f2                	mov    %esi,%edx
    19e5:	29 c2                	sub    %eax,%edx
    19e7:	89 d0                	mov    %edx,%eax
    19e9:	09 f8                	or     %edi,%eax
    19eb:	75 93                	jne    1980 <concreate+0x1c0>
    19ed:	83 ec 08             	sub    $0x8,%esp
    19f0:	6a 00                	push   $0x0
    19f2:	53                   	push   %ebx
    19f3:	e8 6a 1e 00 00       	call   3862 <open>
    19f8:	89 04 24             	mov    %eax,(%esp)
    19fb:	e8 4a 1e 00 00       	call   384a <close>
    1a00:	58                   	pop    %eax
    1a01:	5a                   	pop    %edx
    1a02:	6a 00                	push   $0x0
    1a04:	53                   	push   %ebx
    1a05:	e8 58 1e 00 00       	call   3862 <open>
    1a0a:	89 04 24             	mov    %eax,(%esp)
    1a0d:	e8 38 1e 00 00       	call   384a <close>
    1a12:	59                   	pop    %ecx
    1a13:	58                   	pop    %eax
    1a14:	6a 00                	push   $0x0
    1a16:	53                   	push   %ebx
    1a17:	e8 46 1e 00 00       	call   3862 <open>
    1a1c:	89 04 24             	mov    %eax,(%esp)
    1a1f:	e8 26 1e 00 00       	call   384a <close>
    1a24:	58                   	pop    %eax
    1a25:	5a                   	pop    %edx
    1a26:	6a 00                	push   $0x0
    1a28:	53                   	push   %ebx
    1a29:	e8 34 1e 00 00       	call   3862 <open>
    1a2e:	89 04 24             	mov    %eax,(%esp)
    1a31:	e8 14 1e 00 00       	call   384a <close>
    1a36:	83 c4 10             	add    $0x10,%esp
    1a39:	e9 6f ff ff ff       	jmp    19ad <concreate+0x1ed>
    1a3e:	66 90                	xchg   %ax,%ax
    1a40:	83 ec 08             	sub    $0x8,%esp
    1a43:	68 c6 43 00 00       	push   $0x43c6
    1a48:	6a 01                	push   $0x1
    1a4a:	e8 61 1f 00 00       	call   39b0 <printf>
    1a4f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1a52:	5b                   	pop    %ebx
    1a53:	5e                   	pop    %esi
    1a54:	5f                   	pop    %edi
    1a55:	5d                   	pop    %ebp
    1a56:	c3                   	ret    
    1a57:	83 ec 08             	sub    $0x8,%esp
    1a5a:	68 49 4c 00 00       	push   $0x4c49
    1a5f:	6a 01                	push   $0x1
    1a61:	e8 4a 1f 00 00       	call   39b0 <printf>
    1a66:	e8 b7 1d 00 00       	call   3822 <exit>
    1a6b:	51                   	push   %ecx
    1a6c:	51                   	push   %ecx
    1a6d:	68 ec 4e 00 00       	push   $0x4eec
    1a72:	6a 01                	push   $0x1
    1a74:	e8 37 1f 00 00       	call   39b0 <printf>
    1a79:	e8 a4 1d 00 00       	call   3822 <exit>
    1a7e:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1a81:	53                   	push   %ebx
    1a82:	50                   	push   %eax
    1a83:	68 a9 43 00 00       	push   $0x43a9
    1a88:	6a 01                	push   $0x1
    1a8a:	e8 21 1f 00 00       	call   39b0 <printf>
    1a8f:	e8 8e 1d 00 00       	call   3822 <exit>
    1a94:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1a97:	56                   	push   %esi
    1a98:	50                   	push   %eax
    1a99:	68 90 43 00 00       	push   $0x4390
    1a9e:	6a 01                	push   $0x1
    1aa0:	e8 0b 1f 00 00       	call   39b0 <printf>
    1aa5:	e8 78 1d 00 00       	call   3822 <exit>
    1aaa:	83 ec 0c             	sub    $0xc,%esp
    1aad:	50                   	push   %eax
    1aae:	e8 97 1d 00 00       	call   384a <close>
    1ab3:	83 c4 10             	add    $0x10,%esp
    1ab6:	e9 f6 fd ff ff       	jmp    18b1 <concreate+0xf1>
    1abb:	90                   	nop
    1abc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001ac0 <linkunlink>:
    1ac0:	55                   	push   %ebp
    1ac1:	89 e5                	mov    %esp,%ebp
    1ac3:	57                   	push   %edi
    1ac4:	56                   	push   %esi
    1ac5:	53                   	push   %ebx
    1ac6:	83 ec 24             	sub    $0x24,%esp
    1ac9:	68 d4 43 00 00       	push   $0x43d4
    1ace:	6a 01                	push   $0x1
    1ad0:	e8 db 1e 00 00       	call   39b0 <printf>
    1ad5:	c7 04 24 61 46 00 00 	movl   $0x4661,(%esp)
    1adc:	e8 91 1d 00 00       	call   3872 <unlink>
    1ae1:	e8 34 1d 00 00       	call   381a <fork>
    1ae6:	83 c4 10             	add    $0x10,%esp
    1ae9:	85 c0                	test   %eax,%eax
    1aeb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1aee:	0f 88 b6 00 00 00    	js     1baa <linkunlink+0xea>
    1af4:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
    1af8:	bb 64 00 00 00       	mov    $0x64,%ebx
    1afd:	be ab aa aa aa       	mov    $0xaaaaaaab,%esi
    1b02:	19 ff                	sbb    %edi,%edi
    1b04:	83 e7 60             	and    $0x60,%edi
    1b07:	83 c7 01             	add    $0x1,%edi
    1b0a:	eb 1e                	jmp    1b2a <linkunlink+0x6a>
    1b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1b10:	83 fa 01             	cmp    $0x1,%edx
    1b13:	74 7b                	je     1b90 <linkunlink+0xd0>
    1b15:	83 ec 0c             	sub    $0xc,%esp
    1b18:	68 61 46 00 00       	push   $0x4661
    1b1d:	e8 50 1d 00 00       	call   3872 <unlink>
    1b22:	83 c4 10             	add    $0x10,%esp
    1b25:	83 eb 01             	sub    $0x1,%ebx
    1b28:	74 3d                	je     1b67 <linkunlink+0xa7>
    1b2a:	69 cf 6d 4e c6 41    	imul   $0x41c64e6d,%edi,%ecx
    1b30:	8d b9 39 30 00 00    	lea    0x3039(%ecx),%edi
    1b36:	89 f8                	mov    %edi,%eax
    1b38:	f7 e6                	mul    %esi
    1b3a:	d1 ea                	shr    %edx
    1b3c:	8d 04 52             	lea    (%edx,%edx,2),%eax
    1b3f:	89 fa                	mov    %edi,%edx
    1b41:	29 c2                	sub    %eax,%edx
    1b43:	75 cb                	jne    1b10 <linkunlink+0x50>
    1b45:	83 ec 08             	sub    $0x8,%esp
    1b48:	68 02 02 00 00       	push   $0x202
    1b4d:	68 61 46 00 00       	push   $0x4661
    1b52:	e8 0b 1d 00 00       	call   3862 <open>
    1b57:	89 04 24             	mov    %eax,(%esp)
    1b5a:	e8 eb 1c 00 00       	call   384a <close>
    1b5f:	83 c4 10             	add    $0x10,%esp
    1b62:	83 eb 01             	sub    $0x1,%ebx
    1b65:	75 c3                	jne    1b2a <linkunlink+0x6a>
    1b67:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b6a:	85 c0                	test   %eax,%eax
    1b6c:	74 4f                	je     1bbd <linkunlink+0xfd>
    1b6e:	e8 b7 1c 00 00       	call   382a <wait>
    1b73:	83 ec 08             	sub    $0x8,%esp
    1b76:	68 e9 43 00 00       	push   $0x43e9
    1b7b:	6a 01                	push   $0x1
    1b7d:	e8 2e 1e 00 00       	call   39b0 <printf>
    1b82:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1b85:	5b                   	pop    %ebx
    1b86:	5e                   	pop    %esi
    1b87:	5f                   	pop    %edi
    1b88:	5d                   	pop    %ebp
    1b89:	c3                   	ret    
    1b8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1b90:	83 ec 08             	sub    $0x8,%esp
    1b93:	68 61 46 00 00       	push   $0x4661
    1b98:	68 e5 43 00 00       	push   $0x43e5
    1b9d:	e8 e0 1c 00 00       	call   3882 <link>
    1ba2:	83 c4 10             	add    $0x10,%esp
    1ba5:	e9 7b ff ff ff       	jmp    1b25 <linkunlink+0x65>
    1baa:	52                   	push   %edx
    1bab:	52                   	push   %edx
    1bac:	68 49 4c 00 00       	push   $0x4c49
    1bb1:	6a 01                	push   $0x1
    1bb3:	e8 f8 1d 00 00       	call   39b0 <printf>
    1bb8:	e8 65 1c 00 00       	call   3822 <exit>
    1bbd:	e8 60 1c 00 00       	call   3822 <exit>
    1bc2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001bd0 <bigdir>:
    1bd0:	55                   	push   %ebp
    1bd1:	89 e5                	mov    %esp,%ebp
    1bd3:	57                   	push   %edi
    1bd4:	56                   	push   %esi
    1bd5:	53                   	push   %ebx
    1bd6:	83 ec 24             	sub    $0x24,%esp
    1bd9:	68 f8 43 00 00       	push   $0x43f8
    1bde:	6a 01                	push   $0x1
    1be0:	e8 cb 1d 00 00       	call   39b0 <printf>
    1be5:	c7 04 24 05 44 00 00 	movl   $0x4405,(%esp)
    1bec:	e8 81 1c 00 00       	call   3872 <unlink>
    1bf1:	5a                   	pop    %edx
    1bf2:	59                   	pop    %ecx
    1bf3:	68 00 02 00 00       	push   $0x200
    1bf8:	68 05 44 00 00       	push   $0x4405
    1bfd:	e8 60 1c 00 00       	call   3862 <open>
    1c02:	83 c4 10             	add    $0x10,%esp
    1c05:	85 c0                	test   %eax,%eax
    1c07:	0f 88 de 00 00 00    	js     1ceb <bigdir+0x11b>
    1c0d:	83 ec 0c             	sub    $0xc,%esp
    1c10:	8d 7d de             	lea    -0x22(%ebp),%edi
    1c13:	31 f6                	xor    %esi,%esi
    1c15:	50                   	push   %eax
    1c16:	e8 2f 1c 00 00       	call   384a <close>
    1c1b:	83 c4 10             	add    $0x10,%esp
    1c1e:	66 90                	xchg   %ax,%ax
    1c20:	89 f0                	mov    %esi,%eax
    1c22:	83 ec 08             	sub    $0x8,%esp
    1c25:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    1c29:	c1 f8 06             	sar    $0x6,%eax
    1c2c:	57                   	push   %edi
    1c2d:	68 05 44 00 00       	push   $0x4405
    1c32:	83 c0 30             	add    $0x30,%eax
    1c35:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
    1c39:	88 45 df             	mov    %al,-0x21(%ebp)
    1c3c:	89 f0                	mov    %esi,%eax
    1c3e:	83 e0 3f             	and    $0x3f,%eax
    1c41:	83 c0 30             	add    $0x30,%eax
    1c44:	88 45 e0             	mov    %al,-0x20(%ebp)
    1c47:	e8 36 1c 00 00       	call   3882 <link>
    1c4c:	83 c4 10             	add    $0x10,%esp
    1c4f:	85 c0                	test   %eax,%eax
    1c51:	89 c3                	mov    %eax,%ebx
    1c53:	75 6e                	jne    1cc3 <bigdir+0xf3>
    1c55:	83 c6 01             	add    $0x1,%esi
    1c58:	81 fe f4 01 00 00    	cmp    $0x1f4,%esi
    1c5e:	75 c0                	jne    1c20 <bigdir+0x50>
    1c60:	83 ec 0c             	sub    $0xc,%esp
    1c63:	68 05 44 00 00       	push   $0x4405
    1c68:	e8 05 1c 00 00       	call   3872 <unlink>
    1c6d:	83 c4 10             	add    $0x10,%esp
    1c70:	89 d8                	mov    %ebx,%eax
    1c72:	83 ec 0c             	sub    $0xc,%esp
    1c75:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    1c79:	c1 f8 06             	sar    $0x6,%eax
    1c7c:	57                   	push   %edi
    1c7d:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
    1c81:	83 c0 30             	add    $0x30,%eax
    1c84:	88 45 df             	mov    %al,-0x21(%ebp)
    1c87:	89 d8                	mov    %ebx,%eax
    1c89:	83 e0 3f             	and    $0x3f,%eax
    1c8c:	83 c0 30             	add    $0x30,%eax
    1c8f:	88 45 e0             	mov    %al,-0x20(%ebp)
    1c92:	e8 db 1b 00 00       	call   3872 <unlink>
    1c97:	83 c4 10             	add    $0x10,%esp
    1c9a:	85 c0                	test   %eax,%eax
    1c9c:	75 39                	jne    1cd7 <bigdir+0x107>
    1c9e:	83 c3 01             	add    $0x1,%ebx
    1ca1:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    1ca7:	75 c7                	jne    1c70 <bigdir+0xa0>
    1ca9:	83 ec 08             	sub    $0x8,%esp
    1cac:	68 47 44 00 00       	push   $0x4447
    1cb1:	6a 01                	push   $0x1
    1cb3:	e8 f8 1c 00 00       	call   39b0 <printf>
    1cb8:	83 c4 10             	add    $0x10,%esp
    1cbb:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1cbe:	5b                   	pop    %ebx
    1cbf:	5e                   	pop    %esi
    1cc0:	5f                   	pop    %edi
    1cc1:	5d                   	pop    %ebp
    1cc2:	c3                   	ret    
    1cc3:	83 ec 08             	sub    $0x8,%esp
    1cc6:	68 1e 44 00 00       	push   $0x441e
    1ccb:	6a 01                	push   $0x1
    1ccd:	e8 de 1c 00 00       	call   39b0 <printf>
    1cd2:	e8 4b 1b 00 00       	call   3822 <exit>
    1cd7:	83 ec 08             	sub    $0x8,%esp
    1cda:	68 32 44 00 00       	push   $0x4432
    1cdf:	6a 01                	push   $0x1
    1ce1:	e8 ca 1c 00 00       	call   39b0 <printf>
    1ce6:	e8 37 1b 00 00       	call   3822 <exit>
    1ceb:	50                   	push   %eax
    1cec:	50                   	push   %eax
    1ced:	68 08 44 00 00       	push   $0x4408
    1cf2:	6a 01                	push   $0x1
    1cf4:	e8 b7 1c 00 00       	call   39b0 <printf>
    1cf9:	e8 24 1b 00 00       	call   3822 <exit>
    1cfe:	66 90                	xchg   %ax,%ax

00001d00 <subdir>:
    1d00:	55                   	push   %ebp
    1d01:	89 e5                	mov    %esp,%ebp
    1d03:	53                   	push   %ebx
    1d04:	83 ec 0c             	sub    $0xc,%esp
    1d07:	68 52 44 00 00       	push   $0x4452
    1d0c:	6a 01                	push   $0x1
    1d0e:	e8 9d 1c 00 00       	call   39b0 <printf>
    1d13:	c7 04 24 db 44 00 00 	movl   $0x44db,(%esp)
    1d1a:	e8 53 1b 00 00       	call   3872 <unlink>
    1d1f:	c7 04 24 78 45 00 00 	movl   $0x4578,(%esp)
    1d26:	e8 5f 1b 00 00       	call   388a <mkdir>
    1d2b:	83 c4 10             	add    $0x10,%esp
    1d2e:	85 c0                	test   %eax,%eax
    1d30:	0f 85 b3 05 00 00    	jne    22e9 <subdir+0x5e9>
    1d36:	83 ec 08             	sub    $0x8,%esp
    1d39:	68 02 02 00 00       	push   $0x202
    1d3e:	68 b1 44 00 00       	push   $0x44b1
    1d43:	e8 1a 1b 00 00       	call   3862 <open>
    1d48:	83 c4 10             	add    $0x10,%esp
    1d4b:	85 c0                	test   %eax,%eax
    1d4d:	89 c3                	mov    %eax,%ebx
    1d4f:	0f 88 81 05 00 00    	js     22d6 <subdir+0x5d6>
    1d55:	83 ec 04             	sub    $0x4,%esp
    1d58:	6a 02                	push   $0x2
    1d5a:	68 db 44 00 00       	push   $0x44db
    1d5f:	50                   	push   %eax
    1d60:	e8 dd 1a 00 00       	call   3842 <write>
    1d65:	89 1c 24             	mov    %ebx,(%esp)
    1d68:	e8 dd 1a 00 00       	call   384a <close>
    1d6d:	c7 04 24 78 45 00 00 	movl   $0x4578,(%esp)
    1d74:	e8 f9 1a 00 00       	call   3872 <unlink>
    1d79:	83 c4 10             	add    $0x10,%esp
    1d7c:	85 c0                	test   %eax,%eax
    1d7e:	0f 89 3f 05 00 00    	jns    22c3 <subdir+0x5c3>
    1d84:	83 ec 0c             	sub    $0xc,%esp
    1d87:	68 8c 44 00 00       	push   $0x448c
    1d8c:	e8 f9 1a 00 00       	call   388a <mkdir>
    1d91:	83 c4 10             	add    $0x10,%esp
    1d94:	85 c0                	test   %eax,%eax
    1d96:	0f 85 14 05 00 00    	jne    22b0 <subdir+0x5b0>
    1d9c:	83 ec 08             	sub    $0x8,%esp
    1d9f:	68 02 02 00 00       	push   $0x202
    1da4:	68 ae 44 00 00       	push   $0x44ae
    1da9:	e8 b4 1a 00 00       	call   3862 <open>
    1dae:	83 c4 10             	add    $0x10,%esp
    1db1:	85 c0                	test   %eax,%eax
    1db3:	89 c3                	mov    %eax,%ebx
    1db5:	0f 88 24 04 00 00    	js     21df <subdir+0x4df>
    1dbb:	83 ec 04             	sub    $0x4,%esp
    1dbe:	6a 02                	push   $0x2
    1dc0:	68 cf 44 00 00       	push   $0x44cf
    1dc5:	50                   	push   %eax
    1dc6:	e8 77 1a 00 00       	call   3842 <write>
    1dcb:	89 1c 24             	mov    %ebx,(%esp)
    1dce:	e8 77 1a 00 00       	call   384a <close>
    1dd3:	58                   	pop    %eax
    1dd4:	5a                   	pop    %edx
    1dd5:	6a 00                	push   $0x0
    1dd7:	68 d2 44 00 00       	push   $0x44d2
    1ddc:	e8 81 1a 00 00       	call   3862 <open>
    1de1:	83 c4 10             	add    $0x10,%esp
    1de4:	85 c0                	test   %eax,%eax
    1de6:	89 c3                	mov    %eax,%ebx
    1de8:	0f 88 de 03 00 00    	js     21cc <subdir+0x4cc>
    1dee:	83 ec 04             	sub    $0x4,%esp
    1df1:	68 00 20 00 00       	push   $0x2000
    1df6:	68 60 85 00 00       	push   $0x8560
    1dfb:	50                   	push   %eax
    1dfc:	e8 39 1a 00 00       	call   383a <read>
    1e01:	83 c4 10             	add    $0x10,%esp
    1e04:	83 f8 02             	cmp    $0x2,%eax
    1e07:	0f 85 3a 03 00 00    	jne    2147 <subdir+0x447>
    1e0d:	80 3d 60 85 00 00 66 	cmpb   $0x66,0x8560
    1e14:	0f 85 2d 03 00 00    	jne    2147 <subdir+0x447>
    1e1a:	83 ec 0c             	sub    $0xc,%esp
    1e1d:	53                   	push   %ebx
    1e1e:	e8 27 1a 00 00       	call   384a <close>
    1e23:	5b                   	pop    %ebx
    1e24:	58                   	pop    %eax
    1e25:	68 12 45 00 00       	push   $0x4512
    1e2a:	68 ae 44 00 00       	push   $0x44ae
    1e2f:	e8 4e 1a 00 00       	call   3882 <link>
    1e34:	83 c4 10             	add    $0x10,%esp
    1e37:	85 c0                	test   %eax,%eax
    1e39:	0f 85 c6 03 00 00    	jne    2205 <subdir+0x505>
    1e3f:	83 ec 0c             	sub    $0xc,%esp
    1e42:	68 ae 44 00 00       	push   $0x44ae
    1e47:	e8 26 1a 00 00       	call   3872 <unlink>
    1e4c:	83 c4 10             	add    $0x10,%esp
    1e4f:	85 c0                	test   %eax,%eax
    1e51:	0f 85 16 03 00 00    	jne    216d <subdir+0x46d>
    1e57:	83 ec 08             	sub    $0x8,%esp
    1e5a:	6a 00                	push   $0x0
    1e5c:	68 ae 44 00 00       	push   $0x44ae
    1e61:	e8 fc 19 00 00       	call   3862 <open>
    1e66:	83 c4 10             	add    $0x10,%esp
    1e69:	85 c0                	test   %eax,%eax
    1e6b:	0f 89 2c 04 00 00    	jns    229d <subdir+0x59d>
    1e71:	83 ec 0c             	sub    $0xc,%esp
    1e74:	68 78 45 00 00       	push   $0x4578
    1e79:	e8 14 1a 00 00       	call   3892 <chdir>
    1e7e:	83 c4 10             	add    $0x10,%esp
    1e81:	85 c0                	test   %eax,%eax
    1e83:	0f 85 01 04 00 00    	jne    228a <subdir+0x58a>
    1e89:	83 ec 0c             	sub    $0xc,%esp
    1e8c:	68 46 45 00 00       	push   $0x4546
    1e91:	e8 fc 19 00 00       	call   3892 <chdir>
    1e96:	83 c4 10             	add    $0x10,%esp
    1e99:	85 c0                	test   %eax,%eax
    1e9b:	0f 85 b9 02 00 00    	jne    215a <subdir+0x45a>
    1ea1:	83 ec 0c             	sub    $0xc,%esp
    1ea4:	68 6c 45 00 00       	push   $0x456c
    1ea9:	e8 e4 19 00 00       	call   3892 <chdir>
    1eae:	83 c4 10             	add    $0x10,%esp
    1eb1:	85 c0                	test   %eax,%eax
    1eb3:	0f 85 a1 02 00 00    	jne    215a <subdir+0x45a>
    1eb9:	83 ec 0c             	sub    $0xc,%esp
    1ebc:	68 7b 45 00 00       	push   $0x457b
    1ec1:	e8 cc 19 00 00       	call   3892 <chdir>
    1ec6:	83 c4 10             	add    $0x10,%esp
    1ec9:	85 c0                	test   %eax,%eax
    1ecb:	0f 85 21 03 00 00    	jne    21f2 <subdir+0x4f2>
    1ed1:	83 ec 08             	sub    $0x8,%esp
    1ed4:	6a 00                	push   $0x0
    1ed6:	68 12 45 00 00       	push   $0x4512
    1edb:	e8 82 19 00 00       	call   3862 <open>
    1ee0:	83 c4 10             	add    $0x10,%esp
    1ee3:	85 c0                	test   %eax,%eax
    1ee5:	89 c3                	mov    %eax,%ebx
    1ee7:	0f 88 e0 04 00 00    	js     23cd <subdir+0x6cd>
    1eed:	83 ec 04             	sub    $0x4,%esp
    1ef0:	68 00 20 00 00       	push   $0x2000
    1ef5:	68 60 85 00 00       	push   $0x8560
    1efa:	50                   	push   %eax
    1efb:	e8 3a 19 00 00       	call   383a <read>
    1f00:	83 c4 10             	add    $0x10,%esp
    1f03:	83 f8 02             	cmp    $0x2,%eax
    1f06:	0f 85 ae 04 00 00    	jne    23ba <subdir+0x6ba>
    1f0c:	83 ec 0c             	sub    $0xc,%esp
    1f0f:	53                   	push   %ebx
    1f10:	e8 35 19 00 00       	call   384a <close>
    1f15:	59                   	pop    %ecx
    1f16:	5b                   	pop    %ebx
    1f17:	6a 00                	push   $0x0
    1f19:	68 ae 44 00 00       	push   $0x44ae
    1f1e:	e8 3f 19 00 00       	call   3862 <open>
    1f23:	83 c4 10             	add    $0x10,%esp
    1f26:	85 c0                	test   %eax,%eax
    1f28:	0f 89 65 02 00 00    	jns    2193 <subdir+0x493>
    1f2e:	83 ec 08             	sub    $0x8,%esp
    1f31:	68 02 02 00 00       	push   $0x202
    1f36:	68 c6 45 00 00       	push   $0x45c6
    1f3b:	e8 22 19 00 00       	call   3862 <open>
    1f40:	83 c4 10             	add    $0x10,%esp
    1f43:	85 c0                	test   %eax,%eax
    1f45:	0f 89 35 02 00 00    	jns    2180 <subdir+0x480>
    1f4b:	83 ec 08             	sub    $0x8,%esp
    1f4e:	68 02 02 00 00       	push   $0x202
    1f53:	68 eb 45 00 00       	push   $0x45eb
    1f58:	e8 05 19 00 00       	call   3862 <open>
    1f5d:	83 c4 10             	add    $0x10,%esp
    1f60:	85 c0                	test   %eax,%eax
    1f62:	0f 89 0f 03 00 00    	jns    2277 <subdir+0x577>
    1f68:	83 ec 08             	sub    $0x8,%esp
    1f6b:	68 00 02 00 00       	push   $0x200
    1f70:	68 78 45 00 00       	push   $0x4578
    1f75:	e8 e8 18 00 00       	call   3862 <open>
    1f7a:	83 c4 10             	add    $0x10,%esp
    1f7d:	85 c0                	test   %eax,%eax
    1f7f:	0f 89 df 02 00 00    	jns    2264 <subdir+0x564>
    1f85:	83 ec 08             	sub    $0x8,%esp
    1f88:	6a 02                	push   $0x2
    1f8a:	68 78 45 00 00       	push   $0x4578
    1f8f:	e8 ce 18 00 00       	call   3862 <open>
    1f94:	83 c4 10             	add    $0x10,%esp
    1f97:	85 c0                	test   %eax,%eax
    1f99:	0f 89 b2 02 00 00    	jns    2251 <subdir+0x551>
    1f9f:	83 ec 08             	sub    $0x8,%esp
    1fa2:	6a 01                	push   $0x1
    1fa4:	68 78 45 00 00       	push   $0x4578
    1fa9:	e8 b4 18 00 00       	call   3862 <open>
    1fae:	83 c4 10             	add    $0x10,%esp
    1fb1:	85 c0                	test   %eax,%eax
    1fb3:	0f 89 85 02 00 00    	jns    223e <subdir+0x53e>
    1fb9:	83 ec 08             	sub    $0x8,%esp
    1fbc:	68 5a 46 00 00       	push   $0x465a
    1fc1:	68 c6 45 00 00       	push   $0x45c6
    1fc6:	e8 b7 18 00 00       	call   3882 <link>
    1fcb:	83 c4 10             	add    $0x10,%esp
    1fce:	85 c0                	test   %eax,%eax
    1fd0:	0f 84 55 02 00 00    	je     222b <subdir+0x52b>
    1fd6:	83 ec 08             	sub    $0x8,%esp
    1fd9:	68 5a 46 00 00       	push   $0x465a
    1fde:	68 eb 45 00 00       	push   $0x45eb
    1fe3:	e8 9a 18 00 00       	call   3882 <link>
    1fe8:	83 c4 10             	add    $0x10,%esp
    1feb:	85 c0                	test   %eax,%eax
    1fed:	0f 84 25 02 00 00    	je     2218 <subdir+0x518>
    1ff3:	83 ec 08             	sub    $0x8,%esp
    1ff6:	68 12 45 00 00       	push   $0x4512
    1ffb:	68 b1 44 00 00       	push   $0x44b1
    2000:	e8 7d 18 00 00       	call   3882 <link>
    2005:	83 c4 10             	add    $0x10,%esp
    2008:	85 c0                	test   %eax,%eax
    200a:	0f 84 a9 01 00 00    	je     21b9 <subdir+0x4b9>
    2010:	83 ec 0c             	sub    $0xc,%esp
    2013:	68 c6 45 00 00       	push   $0x45c6
    2018:	e8 6d 18 00 00       	call   388a <mkdir>
    201d:	83 c4 10             	add    $0x10,%esp
    2020:	85 c0                	test   %eax,%eax
    2022:	0f 84 7e 01 00 00    	je     21a6 <subdir+0x4a6>
    2028:	83 ec 0c             	sub    $0xc,%esp
    202b:	68 eb 45 00 00       	push   $0x45eb
    2030:	e8 55 18 00 00       	call   388a <mkdir>
    2035:	83 c4 10             	add    $0x10,%esp
    2038:	85 c0                	test   %eax,%eax
    203a:	0f 84 67 03 00 00    	je     23a7 <subdir+0x6a7>
    2040:	83 ec 0c             	sub    $0xc,%esp
    2043:	68 12 45 00 00       	push   $0x4512
    2048:	e8 3d 18 00 00       	call   388a <mkdir>
    204d:	83 c4 10             	add    $0x10,%esp
    2050:	85 c0                	test   %eax,%eax
    2052:	0f 84 3c 03 00 00    	je     2394 <subdir+0x694>
    2058:	83 ec 0c             	sub    $0xc,%esp
    205b:	68 eb 45 00 00       	push   $0x45eb
    2060:	e8 0d 18 00 00       	call   3872 <unlink>
    2065:	83 c4 10             	add    $0x10,%esp
    2068:	85 c0                	test   %eax,%eax
    206a:	0f 84 11 03 00 00    	je     2381 <subdir+0x681>
    2070:	83 ec 0c             	sub    $0xc,%esp
    2073:	68 c6 45 00 00       	push   $0x45c6
    2078:	e8 f5 17 00 00       	call   3872 <unlink>
    207d:	83 c4 10             	add    $0x10,%esp
    2080:	85 c0                	test   %eax,%eax
    2082:	0f 84 e6 02 00 00    	je     236e <subdir+0x66e>
    2088:	83 ec 0c             	sub    $0xc,%esp
    208b:	68 b1 44 00 00       	push   $0x44b1
    2090:	e8 fd 17 00 00       	call   3892 <chdir>
    2095:	83 c4 10             	add    $0x10,%esp
    2098:	85 c0                	test   %eax,%eax
    209a:	0f 84 bb 02 00 00    	je     235b <subdir+0x65b>
    20a0:	83 ec 0c             	sub    $0xc,%esp
    20a3:	68 5d 46 00 00       	push   $0x465d
    20a8:	e8 e5 17 00 00       	call   3892 <chdir>
    20ad:	83 c4 10             	add    $0x10,%esp
    20b0:	85 c0                	test   %eax,%eax
    20b2:	0f 84 90 02 00 00    	je     2348 <subdir+0x648>
    20b8:	83 ec 0c             	sub    $0xc,%esp
    20bb:	68 12 45 00 00       	push   $0x4512
    20c0:	e8 ad 17 00 00       	call   3872 <unlink>
    20c5:	83 c4 10             	add    $0x10,%esp
    20c8:	85 c0                	test   %eax,%eax
    20ca:	0f 85 9d 00 00 00    	jne    216d <subdir+0x46d>
    20d0:	83 ec 0c             	sub    $0xc,%esp
    20d3:	68 b1 44 00 00       	push   $0x44b1
    20d8:	e8 95 17 00 00       	call   3872 <unlink>
    20dd:	83 c4 10             	add    $0x10,%esp
    20e0:	85 c0                	test   %eax,%eax
    20e2:	0f 85 4d 02 00 00    	jne    2335 <subdir+0x635>
    20e8:	83 ec 0c             	sub    $0xc,%esp
    20eb:	68 78 45 00 00       	push   $0x4578
    20f0:	e8 7d 17 00 00       	call   3872 <unlink>
    20f5:	83 c4 10             	add    $0x10,%esp
    20f8:	85 c0                	test   %eax,%eax
    20fa:	0f 84 22 02 00 00    	je     2322 <subdir+0x622>
    2100:	83 ec 0c             	sub    $0xc,%esp
    2103:	68 8d 44 00 00       	push   $0x448d
    2108:	e8 65 17 00 00       	call   3872 <unlink>
    210d:	83 c4 10             	add    $0x10,%esp
    2110:	85 c0                	test   %eax,%eax
    2112:	0f 88 f7 01 00 00    	js     230f <subdir+0x60f>
    2118:	83 ec 0c             	sub    $0xc,%esp
    211b:	68 78 45 00 00       	push   $0x4578
    2120:	e8 4d 17 00 00       	call   3872 <unlink>
    2125:	83 c4 10             	add    $0x10,%esp
    2128:	85 c0                	test   %eax,%eax
    212a:	0f 88 cc 01 00 00    	js     22fc <subdir+0x5fc>
    2130:	83 ec 08             	sub    $0x8,%esp
    2133:	68 5a 47 00 00       	push   $0x475a
    2138:	6a 01                	push   $0x1
    213a:	e8 71 18 00 00       	call   39b0 <printf>
    213f:	83 c4 10             	add    $0x10,%esp
    2142:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2145:	c9                   	leave  
    2146:	c3                   	ret    
    2147:	50                   	push   %eax
    2148:	50                   	push   %eax
    2149:	68 f7 44 00 00       	push   $0x44f7
    214e:	6a 01                	push   $0x1
    2150:	e8 5b 18 00 00       	call   39b0 <printf>
    2155:	e8 c8 16 00 00       	call   3822 <exit>
    215a:	50                   	push   %eax
    215b:	50                   	push   %eax
    215c:	68 52 45 00 00       	push   $0x4552
    2161:	6a 01                	push   $0x1
    2163:	e8 48 18 00 00       	call   39b0 <printf>
    2168:	e8 b5 16 00 00       	call   3822 <exit>
    216d:	52                   	push   %edx
    216e:	52                   	push   %edx
    216f:	68 1d 45 00 00       	push   $0x451d
    2174:	6a 01                	push   $0x1
    2176:	e8 35 18 00 00       	call   39b0 <printf>
    217b:	e8 a2 16 00 00       	call   3822 <exit>
    2180:	50                   	push   %eax
    2181:	50                   	push   %eax
    2182:	68 cf 45 00 00       	push   $0x45cf
    2187:	6a 01                	push   $0x1
    2189:	e8 22 18 00 00       	call   39b0 <printf>
    218e:	e8 8f 16 00 00       	call   3822 <exit>
    2193:	52                   	push   %edx
    2194:	52                   	push   %edx
    2195:	68 90 4f 00 00       	push   $0x4f90
    219a:	6a 01                	push   $0x1
    219c:	e8 0f 18 00 00       	call   39b0 <printf>
    21a1:	e8 7c 16 00 00       	call   3822 <exit>
    21a6:	52                   	push   %edx
    21a7:	52                   	push   %edx
    21a8:	68 63 46 00 00       	push   $0x4663
    21ad:	6a 01                	push   $0x1
    21af:	e8 fc 17 00 00       	call   39b0 <printf>
    21b4:	e8 69 16 00 00       	call   3822 <exit>
    21b9:	51                   	push   %ecx
    21ba:	51                   	push   %ecx
    21bb:	68 00 50 00 00       	push   $0x5000
    21c0:	6a 01                	push   $0x1
    21c2:	e8 e9 17 00 00       	call   39b0 <printf>
    21c7:	e8 56 16 00 00       	call   3822 <exit>
    21cc:	50                   	push   %eax
    21cd:	50                   	push   %eax
    21ce:	68 de 44 00 00       	push   $0x44de
    21d3:	6a 01                	push   $0x1
    21d5:	e8 d6 17 00 00       	call   39b0 <printf>
    21da:	e8 43 16 00 00       	call   3822 <exit>
    21df:	51                   	push   %ecx
    21e0:	51                   	push   %ecx
    21e1:	68 b7 44 00 00       	push   $0x44b7
    21e6:	6a 01                	push   $0x1
    21e8:	e8 c3 17 00 00       	call   39b0 <printf>
    21ed:	e8 30 16 00 00       	call   3822 <exit>
    21f2:	50                   	push   %eax
    21f3:	50                   	push   %eax
    21f4:	68 80 45 00 00       	push   $0x4580
    21f9:	6a 01                	push   $0x1
    21fb:	e8 b0 17 00 00       	call   39b0 <printf>
    2200:	e8 1d 16 00 00       	call   3822 <exit>
    2205:	51                   	push   %ecx
    2206:	51                   	push   %ecx
    2207:	68 48 4f 00 00       	push   $0x4f48
    220c:	6a 01                	push   $0x1
    220e:	e8 9d 17 00 00       	call   39b0 <printf>
    2213:	e8 0a 16 00 00       	call   3822 <exit>
    2218:	53                   	push   %ebx
    2219:	53                   	push   %ebx
    221a:	68 dc 4f 00 00       	push   $0x4fdc
    221f:	6a 01                	push   $0x1
    2221:	e8 8a 17 00 00       	call   39b0 <printf>
    2226:	e8 f7 15 00 00       	call   3822 <exit>
    222b:	50                   	push   %eax
    222c:	50                   	push   %eax
    222d:	68 b8 4f 00 00       	push   $0x4fb8
    2232:	6a 01                	push   $0x1
    2234:	e8 77 17 00 00       	call   39b0 <printf>
    2239:	e8 e4 15 00 00       	call   3822 <exit>
    223e:	50                   	push   %eax
    223f:	50                   	push   %eax
    2240:	68 3f 46 00 00       	push   $0x463f
    2245:	6a 01                	push   $0x1
    2247:	e8 64 17 00 00       	call   39b0 <printf>
    224c:	e8 d1 15 00 00       	call   3822 <exit>
    2251:	50                   	push   %eax
    2252:	50                   	push   %eax
    2253:	68 26 46 00 00       	push   $0x4626
    2258:	6a 01                	push   $0x1
    225a:	e8 51 17 00 00       	call   39b0 <printf>
    225f:	e8 be 15 00 00       	call   3822 <exit>
    2264:	50                   	push   %eax
    2265:	50                   	push   %eax
    2266:	68 10 46 00 00       	push   $0x4610
    226b:	6a 01                	push   $0x1
    226d:	e8 3e 17 00 00       	call   39b0 <printf>
    2272:	e8 ab 15 00 00       	call   3822 <exit>
    2277:	50                   	push   %eax
    2278:	50                   	push   %eax
    2279:	68 f4 45 00 00       	push   $0x45f4
    227e:	6a 01                	push   $0x1
    2280:	e8 2b 17 00 00       	call   39b0 <printf>
    2285:	e8 98 15 00 00       	call   3822 <exit>
    228a:	50                   	push   %eax
    228b:	50                   	push   %eax
    228c:	68 35 45 00 00       	push   $0x4535
    2291:	6a 01                	push   $0x1
    2293:	e8 18 17 00 00       	call   39b0 <printf>
    2298:	e8 85 15 00 00       	call   3822 <exit>
    229d:	50                   	push   %eax
    229e:	50                   	push   %eax
    229f:	68 6c 4f 00 00       	push   $0x4f6c
    22a4:	6a 01                	push   $0x1
    22a6:	e8 05 17 00 00       	call   39b0 <printf>
    22ab:	e8 72 15 00 00       	call   3822 <exit>
    22b0:	53                   	push   %ebx
    22b1:	53                   	push   %ebx
    22b2:	68 93 44 00 00       	push   $0x4493
    22b7:	6a 01                	push   $0x1
    22b9:	e8 f2 16 00 00       	call   39b0 <printf>
    22be:	e8 5f 15 00 00       	call   3822 <exit>
    22c3:	50                   	push   %eax
    22c4:	50                   	push   %eax
    22c5:	68 20 4f 00 00       	push   $0x4f20
    22ca:	6a 01                	push   $0x1
    22cc:	e8 df 16 00 00       	call   39b0 <printf>
    22d1:	e8 4c 15 00 00       	call   3822 <exit>
    22d6:	50                   	push   %eax
    22d7:	50                   	push   %eax
    22d8:	68 77 44 00 00       	push   $0x4477
    22dd:	6a 01                	push   $0x1
    22df:	e8 cc 16 00 00       	call   39b0 <printf>
    22e4:	e8 39 15 00 00       	call   3822 <exit>
    22e9:	50                   	push   %eax
    22ea:	50                   	push   %eax
    22eb:	68 5f 44 00 00       	push   $0x445f
    22f0:	6a 01                	push   $0x1
    22f2:	e8 b9 16 00 00       	call   39b0 <printf>
    22f7:	e8 26 15 00 00       	call   3822 <exit>
    22fc:	50                   	push   %eax
    22fd:	50                   	push   %eax
    22fe:	68 48 47 00 00       	push   $0x4748
    2303:	6a 01                	push   $0x1
    2305:	e8 a6 16 00 00       	call   39b0 <printf>
    230a:	e8 13 15 00 00       	call   3822 <exit>
    230f:	52                   	push   %edx
    2310:	52                   	push   %edx
    2311:	68 33 47 00 00       	push   $0x4733
    2316:	6a 01                	push   $0x1
    2318:	e8 93 16 00 00       	call   39b0 <printf>
    231d:	e8 00 15 00 00       	call   3822 <exit>
    2322:	51                   	push   %ecx
    2323:	51                   	push   %ecx
    2324:	68 24 50 00 00       	push   $0x5024
    2329:	6a 01                	push   $0x1
    232b:	e8 80 16 00 00       	call   39b0 <printf>
    2330:	e8 ed 14 00 00       	call   3822 <exit>
    2335:	53                   	push   %ebx
    2336:	53                   	push   %ebx
    2337:	68 1e 47 00 00       	push   $0x471e
    233c:	6a 01                	push   $0x1
    233e:	e8 6d 16 00 00       	call   39b0 <printf>
    2343:	e8 da 14 00 00       	call   3822 <exit>
    2348:	50                   	push   %eax
    2349:	50                   	push   %eax
    234a:	68 06 47 00 00       	push   $0x4706
    234f:	6a 01                	push   $0x1
    2351:	e8 5a 16 00 00       	call   39b0 <printf>
    2356:	e8 c7 14 00 00       	call   3822 <exit>
    235b:	50                   	push   %eax
    235c:	50                   	push   %eax
    235d:	68 ee 46 00 00       	push   $0x46ee
    2362:	6a 01                	push   $0x1
    2364:	e8 47 16 00 00       	call   39b0 <printf>
    2369:	e8 b4 14 00 00       	call   3822 <exit>
    236e:	50                   	push   %eax
    236f:	50                   	push   %eax
    2370:	68 d2 46 00 00       	push   $0x46d2
    2375:	6a 01                	push   $0x1
    2377:	e8 34 16 00 00       	call   39b0 <printf>
    237c:	e8 a1 14 00 00       	call   3822 <exit>
    2381:	50                   	push   %eax
    2382:	50                   	push   %eax
    2383:	68 b6 46 00 00       	push   $0x46b6
    2388:	6a 01                	push   $0x1
    238a:	e8 21 16 00 00       	call   39b0 <printf>
    238f:	e8 8e 14 00 00       	call   3822 <exit>
    2394:	50                   	push   %eax
    2395:	50                   	push   %eax
    2396:	68 99 46 00 00       	push   $0x4699
    239b:	6a 01                	push   $0x1
    239d:	e8 0e 16 00 00       	call   39b0 <printf>
    23a2:	e8 7b 14 00 00       	call   3822 <exit>
    23a7:	50                   	push   %eax
    23a8:	50                   	push   %eax
    23a9:	68 7e 46 00 00       	push   $0x467e
    23ae:	6a 01                	push   $0x1
    23b0:	e8 fb 15 00 00       	call   39b0 <printf>
    23b5:	e8 68 14 00 00       	call   3822 <exit>
    23ba:	50                   	push   %eax
    23bb:	50                   	push   %eax
    23bc:	68 ab 45 00 00       	push   $0x45ab
    23c1:	6a 01                	push   $0x1
    23c3:	e8 e8 15 00 00       	call   39b0 <printf>
    23c8:	e8 55 14 00 00       	call   3822 <exit>
    23cd:	50                   	push   %eax
    23ce:	50                   	push   %eax
    23cf:	68 93 45 00 00       	push   $0x4593
    23d4:	6a 01                	push   $0x1
    23d6:	e8 d5 15 00 00       	call   39b0 <printf>
    23db:	e8 42 14 00 00       	call   3822 <exit>

000023e0 <bigwrite>:
    23e0:	55                   	push   %ebp
    23e1:	89 e5                	mov    %esp,%ebp
    23e3:	56                   	push   %esi
    23e4:	53                   	push   %ebx
    23e5:	bb f3 01 00 00       	mov    $0x1f3,%ebx
    23ea:	83 ec 08             	sub    $0x8,%esp
    23ed:	68 65 47 00 00       	push   $0x4765
    23f2:	6a 01                	push   $0x1
    23f4:	e8 b7 15 00 00       	call   39b0 <printf>
    23f9:	c7 04 24 74 47 00 00 	movl   $0x4774,(%esp)
    2400:	e8 6d 14 00 00       	call   3872 <unlink>
    2405:	83 c4 10             	add    $0x10,%esp
    2408:	90                   	nop
    2409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    2410:	83 ec 08             	sub    $0x8,%esp
    2413:	68 02 02 00 00       	push   $0x202
    2418:	68 74 47 00 00       	push   $0x4774
    241d:	e8 40 14 00 00       	call   3862 <open>
    2422:	83 c4 10             	add    $0x10,%esp
    2425:	85 c0                	test   %eax,%eax
    2427:	89 c6                	mov    %eax,%esi
    2429:	78 7e                	js     24a9 <bigwrite+0xc9>
    242b:	83 ec 04             	sub    $0x4,%esp
    242e:	53                   	push   %ebx
    242f:	68 60 85 00 00       	push   $0x8560
    2434:	50                   	push   %eax
    2435:	e8 08 14 00 00       	call   3842 <write>
    243a:	83 c4 10             	add    $0x10,%esp
    243d:	39 d8                	cmp    %ebx,%eax
    243f:	75 55                	jne    2496 <bigwrite+0xb6>
    2441:	83 ec 04             	sub    $0x4,%esp
    2444:	53                   	push   %ebx
    2445:	68 60 85 00 00       	push   $0x8560
    244a:	56                   	push   %esi
    244b:	e8 f2 13 00 00       	call   3842 <write>
    2450:	83 c4 10             	add    $0x10,%esp
    2453:	39 d8                	cmp    %ebx,%eax
    2455:	75 3f                	jne    2496 <bigwrite+0xb6>
    2457:	83 ec 0c             	sub    $0xc,%esp
    245a:	81 c3 d7 01 00 00    	add    $0x1d7,%ebx
    2460:	56                   	push   %esi
    2461:	e8 e4 13 00 00       	call   384a <close>
    2466:	c7 04 24 74 47 00 00 	movl   $0x4774,(%esp)
    246d:	e8 00 14 00 00       	call   3872 <unlink>
    2472:	83 c4 10             	add    $0x10,%esp
    2475:	81 fb 07 18 00 00    	cmp    $0x1807,%ebx
    247b:	75 93                	jne    2410 <bigwrite+0x30>
    247d:	83 ec 08             	sub    $0x8,%esp
    2480:	68 a7 47 00 00       	push   $0x47a7
    2485:	6a 01                	push   $0x1
    2487:	e8 24 15 00 00       	call   39b0 <printf>
    248c:	83 c4 10             	add    $0x10,%esp
    248f:	8d 65 f8             	lea    -0x8(%ebp),%esp
    2492:	5b                   	pop    %ebx
    2493:	5e                   	pop    %esi
    2494:	5d                   	pop    %ebp
    2495:	c3                   	ret    
    2496:	50                   	push   %eax
    2497:	53                   	push   %ebx
    2498:	68 95 47 00 00       	push   $0x4795
    249d:	6a 01                	push   $0x1
    249f:	e8 0c 15 00 00       	call   39b0 <printf>
    24a4:	e8 79 13 00 00       	call   3822 <exit>
    24a9:	83 ec 08             	sub    $0x8,%esp
    24ac:	68 7d 47 00 00       	push   $0x477d
    24b1:	6a 01                	push   $0x1
    24b3:	e8 f8 14 00 00       	call   39b0 <printf>
    24b8:	e8 65 13 00 00       	call   3822 <exit>
    24bd:	8d 76 00             	lea    0x0(%esi),%esi

000024c0 <bigfile>:
    24c0:	55                   	push   %ebp
    24c1:	89 e5                	mov    %esp,%ebp
    24c3:	57                   	push   %edi
    24c4:	56                   	push   %esi
    24c5:	53                   	push   %ebx
    24c6:	83 ec 14             	sub    $0x14,%esp
    24c9:	68 b4 47 00 00       	push   $0x47b4
    24ce:	6a 01                	push   $0x1
    24d0:	e8 db 14 00 00       	call   39b0 <printf>
    24d5:	c7 04 24 d0 47 00 00 	movl   $0x47d0,(%esp)
    24dc:	e8 91 13 00 00       	call   3872 <unlink>
    24e1:	58                   	pop    %eax
    24e2:	5a                   	pop    %edx
    24e3:	68 02 02 00 00       	push   $0x202
    24e8:	68 d0 47 00 00       	push   $0x47d0
    24ed:	e8 70 13 00 00       	call   3862 <open>
    24f2:	83 c4 10             	add    $0x10,%esp
    24f5:	85 c0                	test   %eax,%eax
    24f7:	0f 88 5e 01 00 00    	js     265b <bigfile+0x19b>
    24fd:	89 c6                	mov    %eax,%esi
    24ff:	31 db                	xor    %ebx,%ebx
    2501:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    2508:	83 ec 04             	sub    $0x4,%esp
    250b:	68 58 02 00 00       	push   $0x258
    2510:	53                   	push   %ebx
    2511:	68 60 85 00 00       	push   $0x8560
    2516:	e8 65 11 00 00       	call   3680 <memset>
    251b:	83 c4 0c             	add    $0xc,%esp
    251e:	68 58 02 00 00       	push   $0x258
    2523:	68 60 85 00 00       	push   $0x8560
    2528:	56                   	push   %esi
    2529:	e8 14 13 00 00       	call   3842 <write>
    252e:	83 c4 10             	add    $0x10,%esp
    2531:	3d 58 02 00 00       	cmp    $0x258,%eax
    2536:	0f 85 f8 00 00 00    	jne    2634 <bigfile+0x174>
    253c:	83 c3 01             	add    $0x1,%ebx
    253f:	83 fb 14             	cmp    $0x14,%ebx
    2542:	75 c4                	jne    2508 <bigfile+0x48>
    2544:	83 ec 0c             	sub    $0xc,%esp
    2547:	56                   	push   %esi
    2548:	e8 fd 12 00 00       	call   384a <close>
    254d:	5e                   	pop    %esi
    254e:	5f                   	pop    %edi
    254f:	6a 00                	push   $0x0
    2551:	68 d0 47 00 00       	push   $0x47d0
    2556:	e8 07 13 00 00       	call   3862 <open>
    255b:	83 c4 10             	add    $0x10,%esp
    255e:	85 c0                	test   %eax,%eax
    2560:	89 c6                	mov    %eax,%esi
    2562:	0f 88 e0 00 00 00    	js     2648 <bigfile+0x188>
    2568:	31 db                	xor    %ebx,%ebx
    256a:	31 ff                	xor    %edi,%edi
    256c:	eb 30                	jmp    259e <bigfile+0xde>
    256e:	66 90                	xchg   %ax,%ax
    2570:	3d 2c 01 00 00       	cmp    $0x12c,%eax
    2575:	0f 85 91 00 00 00    	jne    260c <bigfile+0x14c>
    257b:	0f be 05 60 85 00 00 	movsbl 0x8560,%eax
    2582:	89 fa                	mov    %edi,%edx
    2584:	d1 fa                	sar    %edx
    2586:	39 d0                	cmp    %edx,%eax
    2588:	75 6e                	jne    25f8 <bigfile+0x138>
    258a:	0f be 15 8b 86 00 00 	movsbl 0x868b,%edx
    2591:	39 d0                	cmp    %edx,%eax
    2593:	75 63                	jne    25f8 <bigfile+0x138>
    2595:	81 c3 2c 01 00 00    	add    $0x12c,%ebx
    259b:	83 c7 01             	add    $0x1,%edi
    259e:	83 ec 04             	sub    $0x4,%esp
    25a1:	68 2c 01 00 00       	push   $0x12c
    25a6:	68 60 85 00 00       	push   $0x8560
    25ab:	56                   	push   %esi
    25ac:	e8 89 12 00 00       	call   383a <read>
    25b1:	83 c4 10             	add    $0x10,%esp
    25b4:	85 c0                	test   %eax,%eax
    25b6:	78 68                	js     2620 <bigfile+0x160>
    25b8:	75 b6                	jne    2570 <bigfile+0xb0>
    25ba:	83 ec 0c             	sub    $0xc,%esp
    25bd:	56                   	push   %esi
    25be:	e8 87 12 00 00       	call   384a <close>
    25c3:	83 c4 10             	add    $0x10,%esp
    25c6:	81 fb e0 2e 00 00    	cmp    $0x2ee0,%ebx
    25cc:	0f 85 9c 00 00 00    	jne    266e <bigfile+0x1ae>
    25d2:	83 ec 0c             	sub    $0xc,%esp
    25d5:	68 d0 47 00 00       	push   $0x47d0
    25da:	e8 93 12 00 00       	call   3872 <unlink>
    25df:	58                   	pop    %eax
    25e0:	5a                   	pop    %edx
    25e1:	68 5f 48 00 00       	push   $0x485f
    25e6:	6a 01                	push   $0x1
    25e8:	e8 c3 13 00 00       	call   39b0 <printf>
    25ed:	83 c4 10             	add    $0x10,%esp
    25f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    25f3:	5b                   	pop    %ebx
    25f4:	5e                   	pop    %esi
    25f5:	5f                   	pop    %edi
    25f6:	5d                   	pop    %ebp
    25f7:	c3                   	ret    
    25f8:	83 ec 08             	sub    $0x8,%esp
    25fb:	68 2c 48 00 00       	push   $0x482c
    2600:	6a 01                	push   $0x1
    2602:	e8 a9 13 00 00       	call   39b0 <printf>
    2607:	e8 16 12 00 00       	call   3822 <exit>
    260c:	83 ec 08             	sub    $0x8,%esp
    260f:	68 18 48 00 00       	push   $0x4818
    2614:	6a 01                	push   $0x1
    2616:	e8 95 13 00 00       	call   39b0 <printf>
    261b:	e8 02 12 00 00       	call   3822 <exit>
    2620:	83 ec 08             	sub    $0x8,%esp
    2623:	68 03 48 00 00       	push   $0x4803
    2628:	6a 01                	push   $0x1
    262a:	e8 81 13 00 00       	call   39b0 <printf>
    262f:	e8 ee 11 00 00       	call   3822 <exit>
    2634:	83 ec 08             	sub    $0x8,%esp
    2637:	68 d8 47 00 00       	push   $0x47d8
    263c:	6a 01                	push   $0x1
    263e:	e8 6d 13 00 00       	call   39b0 <printf>
    2643:	e8 da 11 00 00       	call   3822 <exit>
    2648:	53                   	push   %ebx
    2649:	53                   	push   %ebx
    264a:	68 ee 47 00 00       	push   $0x47ee
    264f:	6a 01                	push   $0x1
    2651:	e8 5a 13 00 00       	call   39b0 <printf>
    2656:	e8 c7 11 00 00       	call   3822 <exit>
    265b:	50                   	push   %eax
    265c:	50                   	push   %eax
    265d:	68 c2 47 00 00       	push   $0x47c2
    2662:	6a 01                	push   $0x1
    2664:	e8 47 13 00 00       	call   39b0 <printf>
    2669:	e8 b4 11 00 00       	call   3822 <exit>
    266e:	51                   	push   %ecx
    266f:	51                   	push   %ecx
    2670:	68 45 48 00 00       	push   $0x4845
    2675:	6a 01                	push   $0x1
    2677:	e8 34 13 00 00       	call   39b0 <printf>
    267c:	e8 a1 11 00 00       	call   3822 <exit>
    2681:	eb 0d                	jmp    2690 <fourteen>
    2683:	90                   	nop
    2684:	90                   	nop
    2685:	90                   	nop
    2686:	90                   	nop
    2687:	90                   	nop
    2688:	90                   	nop
    2689:	90                   	nop
    268a:	90                   	nop
    268b:	90                   	nop
    268c:	90                   	nop
    268d:	90                   	nop
    268e:	90                   	nop
    268f:	90                   	nop

00002690 <fourteen>:
    2690:	55                   	push   %ebp
    2691:	89 e5                	mov    %esp,%ebp
    2693:	83 ec 10             	sub    $0x10,%esp
    2696:	68 70 48 00 00       	push   $0x4870
    269b:	6a 01                	push   $0x1
    269d:	e8 0e 13 00 00       	call   39b0 <printf>
    26a2:	c7 04 24 ab 48 00 00 	movl   $0x48ab,(%esp)
    26a9:	e8 dc 11 00 00       	call   388a <mkdir>
    26ae:	83 c4 10             	add    $0x10,%esp
    26b1:	85 c0                	test   %eax,%eax
    26b3:	0f 85 97 00 00 00    	jne    2750 <fourteen+0xc0>
    26b9:	83 ec 0c             	sub    $0xc,%esp
    26bc:	68 44 50 00 00       	push   $0x5044
    26c1:	e8 c4 11 00 00       	call   388a <mkdir>
    26c6:	83 c4 10             	add    $0x10,%esp
    26c9:	85 c0                	test   %eax,%eax
    26cb:	0f 85 de 00 00 00    	jne    27af <fourteen+0x11f>
    26d1:	83 ec 08             	sub    $0x8,%esp
    26d4:	68 00 02 00 00       	push   $0x200
    26d9:	68 94 50 00 00       	push   $0x5094
    26de:	e8 7f 11 00 00       	call   3862 <open>
    26e3:	83 c4 10             	add    $0x10,%esp
    26e6:	85 c0                	test   %eax,%eax
    26e8:	0f 88 ae 00 00 00    	js     279c <fourteen+0x10c>
    26ee:	83 ec 0c             	sub    $0xc,%esp
    26f1:	50                   	push   %eax
    26f2:	e8 53 11 00 00       	call   384a <close>
    26f7:	58                   	pop    %eax
    26f8:	5a                   	pop    %edx
    26f9:	6a 00                	push   $0x0
    26fb:	68 04 51 00 00       	push   $0x5104
    2700:	e8 5d 11 00 00       	call   3862 <open>
    2705:	83 c4 10             	add    $0x10,%esp
    2708:	85 c0                	test   %eax,%eax
    270a:	78 7d                	js     2789 <fourteen+0xf9>
    270c:	83 ec 0c             	sub    $0xc,%esp
    270f:	50                   	push   %eax
    2710:	e8 35 11 00 00       	call   384a <close>
    2715:	c7 04 24 9c 48 00 00 	movl   $0x489c,(%esp)
    271c:	e8 69 11 00 00       	call   388a <mkdir>
    2721:	83 c4 10             	add    $0x10,%esp
    2724:	85 c0                	test   %eax,%eax
    2726:	74 4e                	je     2776 <fourteen+0xe6>
    2728:	83 ec 0c             	sub    $0xc,%esp
    272b:	68 a0 51 00 00       	push   $0x51a0
    2730:	e8 55 11 00 00       	call   388a <mkdir>
    2735:	83 c4 10             	add    $0x10,%esp
    2738:	85 c0                	test   %eax,%eax
    273a:	74 27                	je     2763 <fourteen+0xd3>
    273c:	83 ec 08             	sub    $0x8,%esp
    273f:	68 ba 48 00 00       	push   $0x48ba
    2744:	6a 01                	push   $0x1
    2746:	e8 65 12 00 00       	call   39b0 <printf>
    274b:	83 c4 10             	add    $0x10,%esp
    274e:	c9                   	leave  
    274f:	c3                   	ret    
    2750:	50                   	push   %eax
    2751:	50                   	push   %eax
    2752:	68 7f 48 00 00       	push   $0x487f
    2757:	6a 01                	push   $0x1
    2759:	e8 52 12 00 00       	call   39b0 <printf>
    275e:	e8 bf 10 00 00       	call   3822 <exit>
    2763:	50                   	push   %eax
    2764:	50                   	push   %eax
    2765:	68 c0 51 00 00       	push   $0x51c0
    276a:	6a 01                	push   $0x1
    276c:	e8 3f 12 00 00       	call   39b0 <printf>
    2771:	e8 ac 10 00 00       	call   3822 <exit>
    2776:	52                   	push   %edx
    2777:	52                   	push   %edx
    2778:	68 70 51 00 00       	push   $0x5170
    277d:	6a 01                	push   $0x1
    277f:	e8 2c 12 00 00       	call   39b0 <printf>
    2784:	e8 99 10 00 00       	call   3822 <exit>
    2789:	51                   	push   %ecx
    278a:	51                   	push   %ecx
    278b:	68 34 51 00 00       	push   $0x5134
    2790:	6a 01                	push   $0x1
    2792:	e8 19 12 00 00       	call   39b0 <printf>
    2797:	e8 86 10 00 00       	call   3822 <exit>
    279c:	51                   	push   %ecx
    279d:	51                   	push   %ecx
    279e:	68 c4 50 00 00       	push   $0x50c4
    27a3:	6a 01                	push   $0x1
    27a5:	e8 06 12 00 00       	call   39b0 <printf>
    27aa:	e8 73 10 00 00       	call   3822 <exit>
    27af:	50                   	push   %eax
    27b0:	50                   	push   %eax
    27b1:	68 64 50 00 00       	push   $0x5064
    27b6:	6a 01                	push   $0x1
    27b8:	e8 f3 11 00 00       	call   39b0 <printf>
    27bd:	e8 60 10 00 00       	call   3822 <exit>
    27c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    27c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000027d0 <rmdot>:
    27d0:	55                   	push   %ebp
    27d1:	89 e5                	mov    %esp,%ebp
    27d3:	83 ec 10             	sub    $0x10,%esp
    27d6:	68 c7 48 00 00       	push   $0x48c7
    27db:	6a 01                	push   $0x1
    27dd:	e8 ce 11 00 00       	call   39b0 <printf>
    27e2:	c7 04 24 d3 48 00 00 	movl   $0x48d3,(%esp)
    27e9:	e8 9c 10 00 00       	call   388a <mkdir>
    27ee:	83 c4 10             	add    $0x10,%esp
    27f1:	85 c0                	test   %eax,%eax
    27f3:	0f 85 b0 00 00 00    	jne    28a9 <rmdot+0xd9>
    27f9:	83 ec 0c             	sub    $0xc,%esp
    27fc:	68 d3 48 00 00       	push   $0x48d3
    2801:	e8 8c 10 00 00       	call   3892 <chdir>
    2806:	83 c4 10             	add    $0x10,%esp
    2809:	85 c0                	test   %eax,%eax
    280b:	0f 85 1d 01 00 00    	jne    292e <rmdot+0x15e>
    2811:	83 ec 0c             	sub    $0xc,%esp
    2814:	68 7e 45 00 00       	push   $0x457e
    2819:	e8 54 10 00 00       	call   3872 <unlink>
    281e:	83 c4 10             	add    $0x10,%esp
    2821:	85 c0                	test   %eax,%eax
    2823:	0f 84 f2 00 00 00    	je     291b <rmdot+0x14b>
    2829:	83 ec 0c             	sub    $0xc,%esp
    282c:	68 7d 45 00 00       	push   $0x457d
    2831:	e8 3c 10 00 00       	call   3872 <unlink>
    2836:	83 c4 10             	add    $0x10,%esp
    2839:	85 c0                	test   %eax,%eax
    283b:	0f 84 c7 00 00 00    	je     2908 <rmdot+0x138>
    2841:	83 ec 0c             	sub    $0xc,%esp
    2844:	68 51 3d 00 00       	push   $0x3d51
    2849:	e8 44 10 00 00       	call   3892 <chdir>
    284e:	83 c4 10             	add    $0x10,%esp
    2851:	85 c0                	test   %eax,%eax
    2853:	0f 85 9c 00 00 00    	jne    28f5 <rmdot+0x125>
    2859:	83 ec 0c             	sub    $0xc,%esp
    285c:	68 1b 49 00 00       	push   $0x491b
    2861:	e8 0c 10 00 00       	call   3872 <unlink>
    2866:	83 c4 10             	add    $0x10,%esp
    2869:	85 c0                	test   %eax,%eax
    286b:	74 75                	je     28e2 <rmdot+0x112>
    286d:	83 ec 0c             	sub    $0xc,%esp
    2870:	68 39 49 00 00       	push   $0x4939
    2875:	e8 f8 0f 00 00       	call   3872 <unlink>
    287a:	83 c4 10             	add    $0x10,%esp
    287d:	85 c0                	test   %eax,%eax
    287f:	74 4e                	je     28cf <rmdot+0xff>
    2881:	83 ec 0c             	sub    $0xc,%esp
    2884:	68 d3 48 00 00       	push   $0x48d3
    2889:	e8 e4 0f 00 00       	call   3872 <unlink>
    288e:	83 c4 10             	add    $0x10,%esp
    2891:	85 c0                	test   %eax,%eax
    2893:	75 27                	jne    28bc <rmdot+0xec>
    2895:	83 ec 08             	sub    $0x8,%esp
    2898:	68 6e 49 00 00       	push   $0x496e
    289d:	6a 01                	push   $0x1
    289f:	e8 0c 11 00 00       	call   39b0 <printf>
    28a4:	83 c4 10             	add    $0x10,%esp
    28a7:	c9                   	leave  
    28a8:	c3                   	ret    
    28a9:	50                   	push   %eax
    28aa:	50                   	push   %eax
    28ab:	68 d8 48 00 00       	push   $0x48d8
    28b0:	6a 01                	push   $0x1
    28b2:	e8 f9 10 00 00       	call   39b0 <printf>
    28b7:	e8 66 0f 00 00       	call   3822 <exit>
    28bc:	50                   	push   %eax
    28bd:	50                   	push   %eax
    28be:	68 59 49 00 00       	push   $0x4959
    28c3:	6a 01                	push   $0x1
    28c5:	e8 e6 10 00 00       	call   39b0 <printf>
    28ca:	e8 53 0f 00 00       	call   3822 <exit>
    28cf:	52                   	push   %edx
    28d0:	52                   	push   %edx
    28d1:	68 41 49 00 00       	push   $0x4941
    28d6:	6a 01                	push   $0x1
    28d8:	e8 d3 10 00 00       	call   39b0 <printf>
    28dd:	e8 40 0f 00 00       	call   3822 <exit>
    28e2:	51                   	push   %ecx
    28e3:	51                   	push   %ecx
    28e4:	68 22 49 00 00       	push   $0x4922
    28e9:	6a 01                	push   $0x1
    28eb:	e8 c0 10 00 00       	call   39b0 <printf>
    28f0:	e8 2d 0f 00 00       	call   3822 <exit>
    28f5:	50                   	push   %eax
    28f6:	50                   	push   %eax
    28f7:	68 53 3d 00 00       	push   $0x3d53
    28fc:	6a 01                	push   $0x1
    28fe:	e8 ad 10 00 00       	call   39b0 <printf>
    2903:	e8 1a 0f 00 00       	call   3822 <exit>
    2908:	50                   	push   %eax
    2909:	50                   	push   %eax
    290a:	68 0c 49 00 00       	push   $0x490c
    290f:	6a 01                	push   $0x1
    2911:	e8 9a 10 00 00       	call   39b0 <printf>
    2916:	e8 07 0f 00 00       	call   3822 <exit>
    291b:	50                   	push   %eax
    291c:	50                   	push   %eax
    291d:	68 fe 48 00 00       	push   $0x48fe
    2922:	6a 01                	push   $0x1
    2924:	e8 87 10 00 00       	call   39b0 <printf>
    2929:	e8 f4 0e 00 00       	call   3822 <exit>
    292e:	50                   	push   %eax
    292f:	50                   	push   %eax
    2930:	68 eb 48 00 00       	push   $0x48eb
    2935:	6a 01                	push   $0x1
    2937:	e8 74 10 00 00       	call   39b0 <printf>
    293c:	e8 e1 0e 00 00       	call   3822 <exit>
    2941:	eb 0d                	jmp    2950 <dirfile>
    2943:	90                   	nop
    2944:	90                   	nop
    2945:	90                   	nop
    2946:	90                   	nop
    2947:	90                   	nop
    2948:	90                   	nop
    2949:	90                   	nop
    294a:	90                   	nop
    294b:	90                   	nop
    294c:	90                   	nop
    294d:	90                   	nop
    294e:	90                   	nop
    294f:	90                   	nop

00002950 <dirfile>:
    2950:	55                   	push   %ebp
    2951:	89 e5                	mov    %esp,%ebp
    2953:	53                   	push   %ebx
    2954:	83 ec 0c             	sub    $0xc,%esp
    2957:	68 78 49 00 00       	push   $0x4978
    295c:	6a 01                	push   $0x1
    295e:	e8 4d 10 00 00       	call   39b0 <printf>
    2963:	59                   	pop    %ecx
    2964:	5b                   	pop    %ebx
    2965:	68 00 02 00 00       	push   $0x200
    296a:	68 85 49 00 00       	push   $0x4985
    296f:	e8 ee 0e 00 00       	call   3862 <open>
    2974:	83 c4 10             	add    $0x10,%esp
    2977:	85 c0                	test   %eax,%eax
    2979:	0f 88 43 01 00 00    	js     2ac2 <dirfile+0x172>
    297f:	83 ec 0c             	sub    $0xc,%esp
    2982:	50                   	push   %eax
    2983:	e8 c2 0e 00 00       	call   384a <close>
    2988:	c7 04 24 85 49 00 00 	movl   $0x4985,(%esp)
    298f:	e8 fe 0e 00 00       	call   3892 <chdir>
    2994:	83 c4 10             	add    $0x10,%esp
    2997:	85 c0                	test   %eax,%eax
    2999:	0f 84 10 01 00 00    	je     2aaf <dirfile+0x15f>
    299f:	83 ec 08             	sub    $0x8,%esp
    29a2:	6a 00                	push   $0x0
    29a4:	68 be 49 00 00       	push   $0x49be
    29a9:	e8 b4 0e 00 00       	call   3862 <open>
    29ae:	83 c4 10             	add    $0x10,%esp
    29b1:	85 c0                	test   %eax,%eax
    29b3:	0f 89 e3 00 00 00    	jns    2a9c <dirfile+0x14c>
    29b9:	83 ec 08             	sub    $0x8,%esp
    29bc:	68 00 02 00 00       	push   $0x200
    29c1:	68 be 49 00 00       	push   $0x49be
    29c6:	e8 97 0e 00 00       	call   3862 <open>
    29cb:	83 c4 10             	add    $0x10,%esp
    29ce:	85 c0                	test   %eax,%eax
    29d0:	0f 89 c6 00 00 00    	jns    2a9c <dirfile+0x14c>
    29d6:	83 ec 0c             	sub    $0xc,%esp
    29d9:	68 be 49 00 00       	push   $0x49be
    29de:	e8 a7 0e 00 00       	call   388a <mkdir>
    29e3:	83 c4 10             	add    $0x10,%esp
    29e6:	85 c0                	test   %eax,%eax
    29e8:	0f 84 46 01 00 00    	je     2b34 <dirfile+0x1e4>
    29ee:	83 ec 0c             	sub    $0xc,%esp
    29f1:	68 be 49 00 00       	push   $0x49be
    29f6:	e8 77 0e 00 00       	call   3872 <unlink>
    29fb:	83 c4 10             	add    $0x10,%esp
    29fe:	85 c0                	test   %eax,%eax
    2a00:	0f 84 1b 01 00 00    	je     2b21 <dirfile+0x1d1>
    2a06:	83 ec 08             	sub    $0x8,%esp
    2a09:	68 be 49 00 00       	push   $0x49be
    2a0e:	68 22 4a 00 00       	push   $0x4a22
    2a13:	e8 6a 0e 00 00       	call   3882 <link>
    2a18:	83 c4 10             	add    $0x10,%esp
    2a1b:	85 c0                	test   %eax,%eax
    2a1d:	0f 84 eb 00 00 00    	je     2b0e <dirfile+0x1be>
    2a23:	83 ec 0c             	sub    $0xc,%esp
    2a26:	68 85 49 00 00       	push   $0x4985
    2a2b:	e8 42 0e 00 00       	call   3872 <unlink>
    2a30:	83 c4 10             	add    $0x10,%esp
    2a33:	85 c0                	test   %eax,%eax
    2a35:	0f 85 c0 00 00 00    	jne    2afb <dirfile+0x1ab>
    2a3b:	83 ec 08             	sub    $0x8,%esp
    2a3e:	6a 02                	push   $0x2
    2a40:	68 7e 45 00 00       	push   $0x457e
    2a45:	e8 18 0e 00 00       	call   3862 <open>
    2a4a:	83 c4 10             	add    $0x10,%esp
    2a4d:	85 c0                	test   %eax,%eax
    2a4f:	0f 89 93 00 00 00    	jns    2ae8 <dirfile+0x198>
    2a55:	83 ec 08             	sub    $0x8,%esp
    2a58:	6a 00                	push   $0x0
    2a5a:	68 7e 45 00 00       	push   $0x457e
    2a5f:	e8 fe 0d 00 00       	call   3862 <open>
    2a64:	83 c4 0c             	add    $0xc,%esp
    2a67:	89 c3                	mov    %eax,%ebx
    2a69:	6a 01                	push   $0x1
    2a6b:	68 61 46 00 00       	push   $0x4661
    2a70:	50                   	push   %eax
    2a71:	e8 cc 0d 00 00       	call   3842 <write>
    2a76:	83 c4 10             	add    $0x10,%esp
    2a79:	85 c0                	test   %eax,%eax
    2a7b:	7f 58                	jg     2ad5 <dirfile+0x185>
    2a7d:	83 ec 0c             	sub    $0xc,%esp
    2a80:	53                   	push   %ebx
    2a81:	e8 c4 0d 00 00       	call   384a <close>
    2a86:	58                   	pop    %eax
    2a87:	5a                   	pop    %edx
    2a88:	68 55 4a 00 00       	push   $0x4a55
    2a8d:	6a 01                	push   $0x1
    2a8f:	e8 1c 0f 00 00       	call   39b0 <printf>
    2a94:	83 c4 10             	add    $0x10,%esp
    2a97:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2a9a:	c9                   	leave  
    2a9b:	c3                   	ret    
    2a9c:	50                   	push   %eax
    2a9d:	50                   	push   %eax
    2a9e:	68 c9 49 00 00       	push   $0x49c9
    2aa3:	6a 01                	push   $0x1
    2aa5:	e8 06 0f 00 00       	call   39b0 <printf>
    2aaa:	e8 73 0d 00 00       	call   3822 <exit>
    2aaf:	50                   	push   %eax
    2ab0:	50                   	push   %eax
    2ab1:	68 a4 49 00 00       	push   $0x49a4
    2ab6:	6a 01                	push   $0x1
    2ab8:	e8 f3 0e 00 00       	call   39b0 <printf>
    2abd:	e8 60 0d 00 00       	call   3822 <exit>
    2ac2:	52                   	push   %edx
    2ac3:	52                   	push   %edx
    2ac4:	68 8d 49 00 00       	push   $0x498d
    2ac9:	6a 01                	push   $0x1
    2acb:	e8 e0 0e 00 00       	call   39b0 <printf>
    2ad0:	e8 4d 0d 00 00       	call   3822 <exit>
    2ad5:	51                   	push   %ecx
    2ad6:	51                   	push   %ecx
    2ad7:	68 41 4a 00 00       	push   $0x4a41
    2adc:	6a 01                	push   $0x1
    2ade:	e8 cd 0e 00 00       	call   39b0 <printf>
    2ae3:	e8 3a 0d 00 00       	call   3822 <exit>
    2ae8:	53                   	push   %ebx
    2ae9:	53                   	push   %ebx
    2aea:	68 14 52 00 00       	push   $0x5214
    2aef:	6a 01                	push   $0x1
    2af1:	e8 ba 0e 00 00       	call   39b0 <printf>
    2af6:	e8 27 0d 00 00       	call   3822 <exit>
    2afb:	50                   	push   %eax
    2afc:	50                   	push   %eax
    2afd:	68 29 4a 00 00       	push   $0x4a29
    2b02:	6a 01                	push   $0x1
    2b04:	e8 a7 0e 00 00       	call   39b0 <printf>
    2b09:	e8 14 0d 00 00       	call   3822 <exit>
    2b0e:	50                   	push   %eax
    2b0f:	50                   	push   %eax
    2b10:	68 f4 51 00 00       	push   $0x51f4
    2b15:	6a 01                	push   $0x1
    2b17:	e8 94 0e 00 00       	call   39b0 <printf>
    2b1c:	e8 01 0d 00 00       	call   3822 <exit>
    2b21:	50                   	push   %eax
    2b22:	50                   	push   %eax
    2b23:	68 04 4a 00 00       	push   $0x4a04
    2b28:	6a 01                	push   $0x1
    2b2a:	e8 81 0e 00 00       	call   39b0 <printf>
    2b2f:	e8 ee 0c 00 00       	call   3822 <exit>
    2b34:	50                   	push   %eax
    2b35:	50                   	push   %eax
    2b36:	68 e7 49 00 00       	push   $0x49e7
    2b3b:	6a 01                	push   $0x1
    2b3d:	e8 6e 0e 00 00       	call   39b0 <printf>
    2b42:	e8 db 0c 00 00       	call   3822 <exit>
    2b47:	89 f6                	mov    %esi,%esi
    2b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002b50 <iref>:
    2b50:	55                   	push   %ebp
    2b51:	89 e5                	mov    %esp,%ebp
    2b53:	53                   	push   %ebx
    2b54:	bb 33 00 00 00       	mov    $0x33,%ebx
    2b59:	83 ec 0c             	sub    $0xc,%esp
    2b5c:	68 65 4a 00 00       	push   $0x4a65
    2b61:	6a 01                	push   $0x1
    2b63:	e8 48 0e 00 00       	call   39b0 <printf>
    2b68:	83 c4 10             	add    $0x10,%esp
    2b6b:	90                   	nop
    2b6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2b70:	83 ec 0c             	sub    $0xc,%esp
    2b73:	68 76 4a 00 00       	push   $0x4a76
    2b78:	e8 0d 0d 00 00       	call   388a <mkdir>
    2b7d:	83 c4 10             	add    $0x10,%esp
    2b80:	85 c0                	test   %eax,%eax
    2b82:	0f 85 bb 00 00 00    	jne    2c43 <iref+0xf3>
    2b88:	83 ec 0c             	sub    $0xc,%esp
    2b8b:	68 76 4a 00 00       	push   $0x4a76
    2b90:	e8 fd 0c 00 00       	call   3892 <chdir>
    2b95:	83 c4 10             	add    $0x10,%esp
    2b98:	85 c0                	test   %eax,%eax
    2b9a:	0f 85 b7 00 00 00    	jne    2c57 <iref+0x107>
    2ba0:	83 ec 0c             	sub    $0xc,%esp
    2ba3:	68 2b 41 00 00       	push   $0x412b
    2ba8:	e8 dd 0c 00 00       	call   388a <mkdir>
    2bad:	59                   	pop    %ecx
    2bae:	58                   	pop    %eax
    2baf:	68 2b 41 00 00       	push   $0x412b
    2bb4:	68 22 4a 00 00       	push   $0x4a22
    2bb9:	e8 c4 0c 00 00       	call   3882 <link>
    2bbe:	58                   	pop    %eax
    2bbf:	5a                   	pop    %edx
    2bc0:	68 00 02 00 00       	push   $0x200
    2bc5:	68 2b 41 00 00       	push   $0x412b
    2bca:	e8 93 0c 00 00       	call   3862 <open>
    2bcf:	83 c4 10             	add    $0x10,%esp
    2bd2:	85 c0                	test   %eax,%eax
    2bd4:	78 0c                	js     2be2 <iref+0x92>
    2bd6:	83 ec 0c             	sub    $0xc,%esp
    2bd9:	50                   	push   %eax
    2bda:	e8 6b 0c 00 00       	call   384a <close>
    2bdf:	83 c4 10             	add    $0x10,%esp
    2be2:	83 ec 08             	sub    $0x8,%esp
    2be5:	68 00 02 00 00       	push   $0x200
    2bea:	68 60 46 00 00       	push   $0x4660
    2bef:	e8 6e 0c 00 00       	call   3862 <open>
    2bf4:	83 c4 10             	add    $0x10,%esp
    2bf7:	85 c0                	test   %eax,%eax
    2bf9:	78 0c                	js     2c07 <iref+0xb7>
    2bfb:	83 ec 0c             	sub    $0xc,%esp
    2bfe:	50                   	push   %eax
    2bff:	e8 46 0c 00 00       	call   384a <close>
    2c04:	83 c4 10             	add    $0x10,%esp
    2c07:	83 ec 0c             	sub    $0xc,%esp
    2c0a:	68 60 46 00 00       	push   $0x4660
    2c0f:	e8 5e 0c 00 00       	call   3872 <unlink>
    2c14:	83 c4 10             	add    $0x10,%esp
    2c17:	83 eb 01             	sub    $0x1,%ebx
    2c1a:	0f 85 50 ff ff ff    	jne    2b70 <iref+0x20>
    2c20:	83 ec 0c             	sub    $0xc,%esp
    2c23:	68 51 3d 00 00       	push   $0x3d51
    2c28:	e8 65 0c 00 00       	call   3892 <chdir>
    2c2d:	58                   	pop    %eax
    2c2e:	5a                   	pop    %edx
    2c2f:	68 a4 4a 00 00       	push   $0x4aa4
    2c34:	6a 01                	push   $0x1
    2c36:	e8 75 0d 00 00       	call   39b0 <printf>
    2c3b:	83 c4 10             	add    $0x10,%esp
    2c3e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2c41:	c9                   	leave  
    2c42:	c3                   	ret    
    2c43:	83 ec 08             	sub    $0x8,%esp
    2c46:	68 7c 4a 00 00       	push   $0x4a7c
    2c4b:	6a 01                	push   $0x1
    2c4d:	e8 5e 0d 00 00       	call   39b0 <printf>
    2c52:	e8 cb 0b 00 00       	call   3822 <exit>
    2c57:	83 ec 08             	sub    $0x8,%esp
    2c5a:	68 90 4a 00 00       	push   $0x4a90
    2c5f:	6a 01                	push   $0x1
    2c61:	e8 4a 0d 00 00       	call   39b0 <printf>
    2c66:	e8 b7 0b 00 00       	call   3822 <exit>
    2c6b:	90                   	nop
    2c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00002c70 <forktest>:
    2c70:	55                   	push   %ebp
    2c71:	89 e5                	mov    %esp,%ebp
    2c73:	53                   	push   %ebx
    2c74:	31 db                	xor    %ebx,%ebx
    2c76:	83 ec 0c             	sub    $0xc,%esp
    2c79:	68 b8 4a 00 00       	push   $0x4ab8
    2c7e:	6a 01                	push   $0x1
    2c80:	e8 2b 0d 00 00       	call   39b0 <printf>
    2c85:	83 c4 10             	add    $0x10,%esp
    2c88:	eb 13                	jmp    2c9d <forktest+0x2d>
    2c8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    2c90:	74 62                	je     2cf4 <forktest+0x84>
    2c92:	83 c3 01             	add    $0x1,%ebx
    2c95:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    2c9b:	74 43                	je     2ce0 <forktest+0x70>
    2c9d:	e8 78 0b 00 00       	call   381a <fork>
    2ca2:	85 c0                	test   %eax,%eax
    2ca4:	79 ea                	jns    2c90 <forktest+0x20>
    2ca6:	85 db                	test   %ebx,%ebx
    2ca8:	74 14                	je     2cbe <forktest+0x4e>
    2caa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    2cb0:	e8 75 0b 00 00       	call   382a <wait>
    2cb5:	85 c0                	test   %eax,%eax
    2cb7:	78 40                	js     2cf9 <forktest+0x89>
    2cb9:	83 eb 01             	sub    $0x1,%ebx
    2cbc:	75 f2                	jne    2cb0 <forktest+0x40>
    2cbe:	e8 67 0b 00 00       	call   382a <wait>
    2cc3:	83 f8 ff             	cmp    $0xffffffff,%eax
    2cc6:	75 45                	jne    2d0d <forktest+0x9d>
    2cc8:	83 ec 08             	sub    $0x8,%esp
    2ccb:	68 ea 4a 00 00       	push   $0x4aea
    2cd0:	6a 01                	push   $0x1
    2cd2:	e8 d9 0c 00 00       	call   39b0 <printf>
    2cd7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2cda:	c9                   	leave  
    2cdb:	c3                   	ret    
    2cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2ce0:	83 ec 08             	sub    $0x8,%esp
    2ce3:	68 34 52 00 00       	push   $0x5234
    2ce8:	6a 01                	push   $0x1
    2cea:	e8 c1 0c 00 00       	call   39b0 <printf>
    2cef:	e8 2e 0b 00 00       	call   3822 <exit>
    2cf4:	e8 29 0b 00 00       	call   3822 <exit>
    2cf9:	83 ec 08             	sub    $0x8,%esp
    2cfc:	68 c3 4a 00 00       	push   $0x4ac3
    2d01:	6a 01                	push   $0x1
    2d03:	e8 a8 0c 00 00       	call   39b0 <printf>
    2d08:	e8 15 0b 00 00       	call   3822 <exit>
    2d0d:	50                   	push   %eax
    2d0e:	50                   	push   %eax
    2d0f:	68 d7 4a 00 00       	push   $0x4ad7
    2d14:	6a 01                	push   $0x1
    2d16:	e8 95 0c 00 00       	call   39b0 <printf>
    2d1b:	e8 02 0b 00 00       	call   3822 <exit>

00002d20 <sbrktest>:
    2d20:	55                   	push   %ebp
    2d21:	89 e5                	mov    %esp,%ebp
    2d23:	57                   	push   %edi
    2d24:	56                   	push   %esi
    2d25:	53                   	push   %ebx
    2d26:	31 ff                	xor    %edi,%edi
    2d28:	83 ec 64             	sub    $0x64,%esp
    2d2b:	68 f8 4a 00 00       	push   $0x4af8
    2d30:	ff 35 6c 5d 00 00    	pushl  0x5d6c
    2d36:	e8 75 0c 00 00       	call   39b0 <printf>
    2d3b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2d42:	e8 63 0b 00 00       	call   38aa <sbrk>
    2d47:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2d4e:	89 c3                	mov    %eax,%ebx
    2d50:	e8 55 0b 00 00       	call   38aa <sbrk>
    2d55:	83 c4 10             	add    $0x10,%esp
    2d58:	89 c6                	mov    %eax,%esi
    2d5a:	eb 06                	jmp    2d62 <sbrktest+0x42>
    2d5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2d60:	89 c6                	mov    %eax,%esi
    2d62:	83 ec 0c             	sub    $0xc,%esp
    2d65:	6a 01                	push   $0x1
    2d67:	e8 3e 0b 00 00       	call   38aa <sbrk>
    2d6c:	83 c4 10             	add    $0x10,%esp
    2d6f:	39 f0                	cmp    %esi,%eax
    2d71:	0f 85 62 02 00 00    	jne    2fd9 <sbrktest+0x2b9>
    2d77:	83 c7 01             	add    $0x1,%edi
    2d7a:	c6 06 01             	movb   $0x1,(%esi)
    2d7d:	8d 46 01             	lea    0x1(%esi),%eax
    2d80:	81 ff 88 13 00 00    	cmp    $0x1388,%edi
    2d86:	75 d8                	jne    2d60 <sbrktest+0x40>
    2d88:	e8 8d 0a 00 00       	call   381a <fork>
    2d8d:	85 c0                	test   %eax,%eax
    2d8f:	89 c7                	mov    %eax,%edi
    2d91:	0f 88 82 03 00 00    	js     3119 <sbrktest+0x3f9>
    2d97:	83 ec 0c             	sub    $0xc,%esp
    2d9a:	83 c6 02             	add    $0x2,%esi
    2d9d:	6a 01                	push   $0x1
    2d9f:	e8 06 0b 00 00       	call   38aa <sbrk>
    2da4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2dab:	e8 fa 0a 00 00       	call   38aa <sbrk>
    2db0:	83 c4 10             	add    $0x10,%esp
    2db3:	39 f0                	cmp    %esi,%eax
    2db5:	0f 85 47 03 00 00    	jne    3102 <sbrktest+0x3e2>
    2dbb:	85 ff                	test   %edi,%edi
    2dbd:	0f 84 3a 03 00 00    	je     30fd <sbrktest+0x3dd>
    2dc3:	e8 62 0a 00 00       	call   382a <wait>
    2dc8:	83 ec 0c             	sub    $0xc,%esp
    2dcb:	6a 00                	push   $0x0
    2dcd:	e8 d8 0a 00 00       	call   38aa <sbrk>
    2dd2:	89 c6                	mov    %eax,%esi
    2dd4:	b8 00 00 40 06       	mov    $0x6400000,%eax
    2dd9:	29 f0                	sub    %esi,%eax
    2ddb:	89 04 24             	mov    %eax,(%esp)
    2dde:	e8 c7 0a 00 00       	call   38aa <sbrk>
    2de3:	83 c4 10             	add    $0x10,%esp
    2de6:	39 c6                	cmp    %eax,%esi
    2de8:	0f 85 f8 02 00 00    	jne    30e6 <sbrktest+0x3c6>
    2dee:	83 ec 0c             	sub    $0xc,%esp
    2df1:	c6 05 ff ff 3f 06 63 	movb   $0x63,0x63fffff
    2df8:	6a 00                	push   $0x0
    2dfa:	e8 ab 0a 00 00       	call   38aa <sbrk>
    2dff:	c7 04 24 00 f0 ff ff 	movl   $0xfffff000,(%esp)
    2e06:	89 c6                	mov    %eax,%esi
    2e08:	e8 9d 0a 00 00       	call   38aa <sbrk>
    2e0d:	83 c4 10             	add    $0x10,%esp
    2e10:	83 f8 ff             	cmp    $0xffffffff,%eax
    2e13:	0f 84 b6 02 00 00    	je     30cf <sbrktest+0x3af>
    2e19:	83 ec 0c             	sub    $0xc,%esp
    2e1c:	6a 00                	push   $0x0
    2e1e:	e8 87 0a 00 00       	call   38aa <sbrk>
    2e23:	8d 96 00 f0 ff ff    	lea    -0x1000(%esi),%edx
    2e29:	83 c4 10             	add    $0x10,%esp
    2e2c:	39 d0                	cmp    %edx,%eax
    2e2e:	0f 85 84 02 00 00    	jne    30b8 <sbrktest+0x398>
    2e34:	83 ec 0c             	sub    $0xc,%esp
    2e37:	6a 00                	push   $0x0
    2e39:	e8 6c 0a 00 00       	call   38aa <sbrk>
    2e3e:	89 c6                	mov    %eax,%esi
    2e40:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    2e47:	e8 5e 0a 00 00       	call   38aa <sbrk>
    2e4c:	83 c4 10             	add    $0x10,%esp
    2e4f:	39 c6                	cmp    %eax,%esi
    2e51:	89 c7                	mov    %eax,%edi
    2e53:	0f 85 48 02 00 00    	jne    30a1 <sbrktest+0x381>
    2e59:	83 ec 0c             	sub    $0xc,%esp
    2e5c:	6a 00                	push   $0x0
    2e5e:	e8 47 0a 00 00       	call   38aa <sbrk>
    2e63:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    2e69:	83 c4 10             	add    $0x10,%esp
    2e6c:	39 d0                	cmp    %edx,%eax
    2e6e:	0f 85 2d 02 00 00    	jne    30a1 <sbrktest+0x381>
    2e74:	80 3d ff ff 3f 06 63 	cmpb   $0x63,0x63fffff
    2e7b:	0f 84 09 02 00 00    	je     308a <sbrktest+0x36a>
    2e81:	83 ec 0c             	sub    $0xc,%esp
    2e84:	6a 00                	push   $0x0
    2e86:	e8 1f 0a 00 00       	call   38aa <sbrk>
    2e8b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2e92:	89 c6                	mov    %eax,%esi
    2e94:	e8 11 0a 00 00       	call   38aa <sbrk>
    2e99:	89 d9                	mov    %ebx,%ecx
    2e9b:	29 c1                	sub    %eax,%ecx
    2e9d:	89 0c 24             	mov    %ecx,(%esp)
    2ea0:	e8 05 0a 00 00       	call   38aa <sbrk>
    2ea5:	83 c4 10             	add    $0x10,%esp
    2ea8:	39 c6                	cmp    %eax,%esi
    2eaa:	0f 85 c3 01 00 00    	jne    3073 <sbrktest+0x353>
    2eb0:	be 00 00 00 80       	mov    $0x80000000,%esi
    2eb5:	e8 e8 09 00 00       	call   38a2 <getpid>
    2eba:	89 c7                	mov    %eax,%edi
    2ebc:	e8 59 09 00 00       	call   381a <fork>
    2ec1:	85 c0                	test   %eax,%eax
    2ec3:	0f 88 93 01 00 00    	js     305c <sbrktest+0x33c>
    2ec9:	0f 84 6b 01 00 00    	je     303a <sbrktest+0x31a>
    2ecf:	81 c6 50 c3 00 00    	add    $0xc350,%esi
    2ed5:	e8 50 09 00 00       	call   382a <wait>
    2eda:	81 fe 80 84 1e 80    	cmp    $0x801e8480,%esi
    2ee0:	75 d3                	jne    2eb5 <sbrktest+0x195>
    2ee2:	8d 45 b8             	lea    -0x48(%ebp),%eax
    2ee5:	83 ec 0c             	sub    $0xc,%esp
    2ee8:	50                   	push   %eax
    2ee9:	e8 44 09 00 00       	call   3832 <pipe>
    2eee:	83 c4 10             	add    $0x10,%esp
    2ef1:	85 c0                	test   %eax,%eax
    2ef3:	0f 85 2e 01 00 00    	jne    3027 <sbrktest+0x307>
    2ef9:	8d 7d c0             	lea    -0x40(%ebp),%edi
    2efc:	89 fe                	mov    %edi,%esi
    2efe:	eb 23                	jmp    2f23 <sbrktest+0x203>
    2f00:	83 f8 ff             	cmp    $0xffffffff,%eax
    2f03:	74 14                	je     2f19 <sbrktest+0x1f9>
    2f05:	8d 45 b7             	lea    -0x49(%ebp),%eax
    2f08:	83 ec 04             	sub    $0x4,%esp
    2f0b:	6a 01                	push   $0x1
    2f0d:	50                   	push   %eax
    2f0e:	ff 75 b8             	pushl  -0x48(%ebp)
    2f11:	e8 24 09 00 00       	call   383a <read>
    2f16:	83 c4 10             	add    $0x10,%esp
    2f19:	8d 45 e8             	lea    -0x18(%ebp),%eax
    2f1c:	83 c6 04             	add    $0x4,%esi
    2f1f:	39 c6                	cmp    %eax,%esi
    2f21:	74 4f                	je     2f72 <sbrktest+0x252>
    2f23:	e8 f2 08 00 00       	call   381a <fork>
    2f28:	85 c0                	test   %eax,%eax
    2f2a:	89 06                	mov    %eax,(%esi)
    2f2c:	75 d2                	jne    2f00 <sbrktest+0x1e0>
    2f2e:	83 ec 0c             	sub    $0xc,%esp
    2f31:	6a 00                	push   $0x0
    2f33:	e8 72 09 00 00       	call   38aa <sbrk>
    2f38:	ba 00 00 40 06       	mov    $0x6400000,%edx
    2f3d:	29 c2                	sub    %eax,%edx
    2f3f:	89 14 24             	mov    %edx,(%esp)
    2f42:	e8 63 09 00 00       	call   38aa <sbrk>
    2f47:	83 c4 0c             	add    $0xc,%esp
    2f4a:	6a 01                	push   $0x1
    2f4c:	68 61 46 00 00       	push   $0x4661
    2f51:	ff 75 bc             	pushl  -0x44(%ebp)
    2f54:	e8 e9 08 00 00       	call   3842 <write>
    2f59:	83 c4 10             	add    $0x10,%esp
    2f5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2f60:	83 ec 0c             	sub    $0xc,%esp
    2f63:	68 e8 03 00 00       	push   $0x3e8
    2f68:	e8 45 09 00 00       	call   38b2 <sleep>
    2f6d:	83 c4 10             	add    $0x10,%esp
    2f70:	eb ee                	jmp    2f60 <sbrktest+0x240>
    2f72:	83 ec 0c             	sub    $0xc,%esp
    2f75:	68 00 10 00 00       	push   $0x1000
    2f7a:	e8 2b 09 00 00       	call   38aa <sbrk>
    2f7f:	83 c4 10             	add    $0x10,%esp
    2f82:	89 45 a4             	mov    %eax,-0x5c(%ebp)
    2f85:	8b 07                	mov    (%edi),%eax
    2f87:	83 f8 ff             	cmp    $0xffffffff,%eax
    2f8a:	74 11                	je     2f9d <sbrktest+0x27d>
    2f8c:	83 ec 0c             	sub    $0xc,%esp
    2f8f:	50                   	push   %eax
    2f90:	e8 bd 08 00 00       	call   3852 <kill>
    2f95:	e8 90 08 00 00       	call   382a <wait>
    2f9a:	83 c4 10             	add    $0x10,%esp
    2f9d:	83 c7 04             	add    $0x4,%edi
    2fa0:	39 fe                	cmp    %edi,%esi
    2fa2:	75 e1                	jne    2f85 <sbrktest+0x265>
    2fa4:	83 7d a4 ff          	cmpl   $0xffffffff,-0x5c(%ebp)
    2fa8:	74 66                	je     3010 <sbrktest+0x2f0>
    2faa:	83 ec 0c             	sub    $0xc,%esp
    2fad:	6a 00                	push   $0x0
    2faf:	e8 f6 08 00 00       	call   38aa <sbrk>
    2fb4:	83 c4 10             	add    $0x10,%esp
    2fb7:	39 d8                	cmp    %ebx,%eax
    2fb9:	77 3c                	ja     2ff7 <sbrktest+0x2d7>
    2fbb:	83 ec 08             	sub    $0x8,%esp
    2fbe:	68 a0 4b 00 00       	push   $0x4ba0
    2fc3:	ff 35 6c 5d 00 00    	pushl  0x5d6c
    2fc9:	e8 e2 09 00 00       	call   39b0 <printf>
    2fce:	83 c4 10             	add    $0x10,%esp
    2fd1:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2fd4:	5b                   	pop    %ebx
    2fd5:	5e                   	pop    %esi
    2fd6:	5f                   	pop    %edi
    2fd7:	5d                   	pop    %ebp
    2fd8:	c3                   	ret    
    2fd9:	83 ec 0c             	sub    $0xc,%esp
    2fdc:	50                   	push   %eax
    2fdd:	56                   	push   %esi
    2fde:	57                   	push   %edi
    2fdf:	68 03 4b 00 00       	push   $0x4b03
    2fe4:	ff 35 6c 5d 00 00    	pushl  0x5d6c
    2fea:	e8 c1 09 00 00       	call   39b0 <printf>
    2fef:	83 c4 20             	add    $0x20,%esp
    2ff2:	e8 2b 08 00 00       	call   3822 <exit>
    2ff7:	83 ec 0c             	sub    $0xc,%esp
    2ffa:	6a 00                	push   $0x0
    2ffc:	e8 a9 08 00 00       	call   38aa <sbrk>
    3001:	29 c3                	sub    %eax,%ebx
    3003:	89 1c 24             	mov    %ebx,(%esp)
    3006:	e8 9f 08 00 00       	call   38aa <sbrk>
    300b:	83 c4 10             	add    $0x10,%esp
    300e:	eb ab                	jmp    2fbb <sbrktest+0x29b>
    3010:	50                   	push   %eax
    3011:	50                   	push   %eax
    3012:	68 85 4b 00 00       	push   $0x4b85
    3017:	ff 35 6c 5d 00 00    	pushl  0x5d6c
    301d:	e8 8e 09 00 00       	call   39b0 <printf>
    3022:	e8 fb 07 00 00       	call   3822 <exit>
    3027:	52                   	push   %edx
    3028:	52                   	push   %edx
    3029:	68 41 40 00 00       	push   $0x4041
    302e:	6a 01                	push   $0x1
    3030:	e8 7b 09 00 00       	call   39b0 <printf>
    3035:	e8 e8 07 00 00       	call   3822 <exit>
    303a:	0f be 06             	movsbl (%esi),%eax
    303d:	50                   	push   %eax
    303e:	56                   	push   %esi
    303f:	68 6c 4b 00 00       	push   $0x4b6c
    3044:	ff 35 6c 5d 00 00    	pushl  0x5d6c
    304a:	e8 61 09 00 00       	call   39b0 <printf>
    304f:	89 3c 24             	mov    %edi,(%esp)
    3052:	e8 fb 07 00 00       	call   3852 <kill>
    3057:	e8 c6 07 00 00       	call   3822 <exit>
    305c:	51                   	push   %ecx
    305d:	51                   	push   %ecx
    305e:	68 49 4c 00 00       	push   $0x4c49
    3063:	ff 35 6c 5d 00 00    	pushl  0x5d6c
    3069:	e8 42 09 00 00       	call   39b0 <printf>
    306e:	e8 af 07 00 00       	call   3822 <exit>
    3073:	50                   	push   %eax
    3074:	56                   	push   %esi
    3075:	68 28 53 00 00       	push   $0x5328
    307a:	ff 35 6c 5d 00 00    	pushl  0x5d6c
    3080:	e8 2b 09 00 00       	call   39b0 <printf>
    3085:	e8 98 07 00 00       	call   3822 <exit>
    308a:	53                   	push   %ebx
    308b:	53                   	push   %ebx
    308c:	68 f8 52 00 00       	push   $0x52f8
    3091:	ff 35 6c 5d 00 00    	pushl  0x5d6c
    3097:	e8 14 09 00 00       	call   39b0 <printf>
    309c:	e8 81 07 00 00       	call   3822 <exit>
    30a1:	57                   	push   %edi
    30a2:	56                   	push   %esi
    30a3:	68 d0 52 00 00       	push   $0x52d0
    30a8:	ff 35 6c 5d 00 00    	pushl  0x5d6c
    30ae:	e8 fd 08 00 00       	call   39b0 <printf>
    30b3:	e8 6a 07 00 00       	call   3822 <exit>
    30b8:	50                   	push   %eax
    30b9:	56                   	push   %esi
    30ba:	68 98 52 00 00       	push   $0x5298
    30bf:	ff 35 6c 5d 00 00    	pushl  0x5d6c
    30c5:	e8 e6 08 00 00       	call   39b0 <printf>
    30ca:	e8 53 07 00 00       	call   3822 <exit>
    30cf:	56                   	push   %esi
    30d0:	56                   	push   %esi
    30d1:	68 51 4b 00 00       	push   $0x4b51
    30d6:	ff 35 6c 5d 00 00    	pushl  0x5d6c
    30dc:	e8 cf 08 00 00       	call   39b0 <printf>
    30e1:	e8 3c 07 00 00       	call   3822 <exit>
    30e6:	57                   	push   %edi
    30e7:	57                   	push   %edi
    30e8:	68 58 52 00 00       	push   $0x5258
    30ed:	ff 35 6c 5d 00 00    	pushl  0x5d6c
    30f3:	e8 b8 08 00 00       	call   39b0 <printf>
    30f8:	e8 25 07 00 00       	call   3822 <exit>
    30fd:	e8 20 07 00 00       	call   3822 <exit>
    3102:	50                   	push   %eax
    3103:	50                   	push   %eax
    3104:	68 35 4b 00 00       	push   $0x4b35
    3109:	ff 35 6c 5d 00 00    	pushl  0x5d6c
    310f:	e8 9c 08 00 00       	call   39b0 <printf>
    3114:	e8 09 07 00 00       	call   3822 <exit>
    3119:	50                   	push   %eax
    311a:	50                   	push   %eax
    311b:	68 1e 4b 00 00       	push   $0x4b1e
    3120:	ff 35 6c 5d 00 00    	pushl  0x5d6c
    3126:	e8 85 08 00 00       	call   39b0 <printf>
    312b:	e8 f2 06 00 00       	call   3822 <exit>

00003130 <validateint>:
    3130:	55                   	push   %ebp
    3131:	89 e5                	mov    %esp,%ebp
    3133:	5d                   	pop    %ebp
    3134:	c3                   	ret    
    3135:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003140 <validatetest>:
    3140:	55                   	push   %ebp
    3141:	89 e5                	mov    %esp,%ebp
    3143:	56                   	push   %esi
    3144:	53                   	push   %ebx
    3145:	31 db                	xor    %ebx,%ebx
    3147:	83 ec 08             	sub    $0x8,%esp
    314a:	68 ae 4b 00 00       	push   $0x4bae
    314f:	ff 35 6c 5d 00 00    	pushl  0x5d6c
    3155:	e8 56 08 00 00       	call   39b0 <printf>
    315a:	83 c4 10             	add    $0x10,%esp
    315d:	8d 76 00             	lea    0x0(%esi),%esi
    3160:	e8 b5 06 00 00       	call   381a <fork>
    3165:	85 c0                	test   %eax,%eax
    3167:	89 c6                	mov    %eax,%esi
    3169:	74 63                	je     31ce <validatetest+0x8e>
    316b:	83 ec 0c             	sub    $0xc,%esp
    316e:	6a 00                	push   $0x0
    3170:	e8 3d 07 00 00       	call   38b2 <sleep>
    3175:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    317c:	e8 31 07 00 00       	call   38b2 <sleep>
    3181:	89 34 24             	mov    %esi,(%esp)
    3184:	e8 c9 06 00 00       	call   3852 <kill>
    3189:	e8 9c 06 00 00       	call   382a <wait>
    318e:	58                   	pop    %eax
    318f:	5a                   	pop    %edx
    3190:	53                   	push   %ebx
    3191:	68 bd 4b 00 00       	push   $0x4bbd
    3196:	e8 e7 06 00 00       	call   3882 <link>
    319b:	83 c4 10             	add    $0x10,%esp
    319e:	83 f8 ff             	cmp    $0xffffffff,%eax
    31a1:	75 30                	jne    31d3 <validatetest+0x93>
    31a3:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    31a9:	81 fb 00 40 11 00    	cmp    $0x114000,%ebx
    31af:	75 af                	jne    3160 <validatetest+0x20>
    31b1:	83 ec 08             	sub    $0x8,%esp
    31b4:	68 e1 4b 00 00       	push   $0x4be1
    31b9:	ff 35 6c 5d 00 00    	pushl  0x5d6c
    31bf:	e8 ec 07 00 00       	call   39b0 <printf>
    31c4:	83 c4 10             	add    $0x10,%esp
    31c7:	8d 65 f8             	lea    -0x8(%ebp),%esp
    31ca:	5b                   	pop    %ebx
    31cb:	5e                   	pop    %esi
    31cc:	5d                   	pop    %ebp
    31cd:	c3                   	ret    
    31ce:	e8 4f 06 00 00       	call   3822 <exit>
    31d3:	83 ec 08             	sub    $0x8,%esp
    31d6:	68 c8 4b 00 00       	push   $0x4bc8
    31db:	ff 35 6c 5d 00 00    	pushl  0x5d6c
    31e1:	e8 ca 07 00 00       	call   39b0 <printf>
    31e6:	e8 37 06 00 00       	call   3822 <exit>
    31eb:	90                   	nop
    31ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000031f0 <bsstest>:
    31f0:	55                   	push   %ebp
    31f1:	89 e5                	mov    %esp,%ebp
    31f3:	83 ec 10             	sub    $0x10,%esp
    31f6:	68 ee 4b 00 00       	push   $0x4bee
    31fb:	ff 35 6c 5d 00 00    	pushl  0x5d6c
    3201:	e8 aa 07 00 00       	call   39b0 <printf>
    3206:	83 c4 10             	add    $0x10,%esp
    3209:	80 3d 40 5e 00 00 00 	cmpb   $0x0,0x5e40
    3210:	75 39                	jne    324b <bsstest+0x5b>
    3212:	b8 01 00 00 00       	mov    $0x1,%eax
    3217:	89 f6                	mov    %esi,%esi
    3219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    3220:	80 b8 40 5e 00 00 00 	cmpb   $0x0,0x5e40(%eax)
    3227:	75 22                	jne    324b <bsstest+0x5b>
    3229:	83 c0 01             	add    $0x1,%eax
    322c:	3d 10 27 00 00       	cmp    $0x2710,%eax
    3231:	75 ed                	jne    3220 <bsstest+0x30>
    3233:	83 ec 08             	sub    $0x8,%esp
    3236:	68 09 4c 00 00       	push   $0x4c09
    323b:	ff 35 6c 5d 00 00    	pushl  0x5d6c
    3241:	e8 6a 07 00 00       	call   39b0 <printf>
    3246:	83 c4 10             	add    $0x10,%esp
    3249:	c9                   	leave  
    324a:	c3                   	ret    
    324b:	83 ec 08             	sub    $0x8,%esp
    324e:	68 f8 4b 00 00       	push   $0x4bf8
    3253:	ff 35 6c 5d 00 00    	pushl  0x5d6c
    3259:	e8 52 07 00 00       	call   39b0 <printf>
    325e:	e8 bf 05 00 00       	call   3822 <exit>
    3263:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003270 <bigargtest>:
    3270:	55                   	push   %ebp
    3271:	89 e5                	mov    %esp,%ebp
    3273:	83 ec 14             	sub    $0x14,%esp
    3276:	68 16 4c 00 00       	push   $0x4c16
    327b:	e8 f2 05 00 00       	call   3872 <unlink>
    3280:	e8 95 05 00 00       	call   381a <fork>
    3285:	83 c4 10             	add    $0x10,%esp
    3288:	85 c0                	test   %eax,%eax
    328a:	74 3f                	je     32cb <bigargtest+0x5b>
    328c:	0f 88 c2 00 00 00    	js     3354 <bigargtest+0xe4>
    3292:	e8 93 05 00 00       	call   382a <wait>
    3297:	83 ec 08             	sub    $0x8,%esp
    329a:	6a 00                	push   $0x0
    329c:	68 16 4c 00 00       	push   $0x4c16
    32a1:	e8 bc 05 00 00       	call   3862 <open>
    32a6:	83 c4 10             	add    $0x10,%esp
    32a9:	85 c0                	test   %eax,%eax
    32ab:	0f 88 8c 00 00 00    	js     333d <bigargtest+0xcd>
    32b1:	83 ec 0c             	sub    $0xc,%esp
    32b4:	50                   	push   %eax
    32b5:	e8 90 05 00 00       	call   384a <close>
    32ba:	c7 04 24 16 4c 00 00 	movl   $0x4c16,(%esp)
    32c1:	e8 ac 05 00 00       	call   3872 <unlink>
    32c6:	83 c4 10             	add    $0x10,%esp
    32c9:	c9                   	leave  
    32ca:	c3                   	ret    
    32cb:	b8 a0 5d 00 00       	mov    $0x5da0,%eax
    32d0:	c7 00 4c 53 00 00    	movl   $0x534c,(%eax)
    32d6:	83 c0 04             	add    $0x4,%eax
    32d9:	3d 1c 5e 00 00       	cmp    $0x5e1c,%eax
    32de:	75 f0                	jne    32d0 <bigargtest+0x60>
    32e0:	51                   	push   %ecx
    32e1:	51                   	push   %ecx
    32e2:	68 20 4c 00 00       	push   $0x4c20
    32e7:	ff 35 6c 5d 00 00    	pushl  0x5d6c
    32ed:	c7 05 1c 5e 00 00 00 	movl   $0x0,0x5e1c
    32f4:	00 00 00 
    32f7:	e8 b4 06 00 00       	call   39b0 <printf>
    32fc:	58                   	pop    %eax
    32fd:	5a                   	pop    %edx
    32fe:	68 a0 5d 00 00       	push   $0x5da0
    3303:	68 ed 3d 00 00       	push   $0x3ded
    3308:	e8 4d 05 00 00       	call   385a <exec>
    330d:	59                   	pop    %ecx
    330e:	58                   	pop    %eax
    330f:	68 2d 4c 00 00       	push   $0x4c2d
    3314:	ff 35 6c 5d 00 00    	pushl  0x5d6c
    331a:	e8 91 06 00 00       	call   39b0 <printf>
    331f:	58                   	pop    %eax
    3320:	5a                   	pop    %edx
    3321:	68 00 02 00 00       	push   $0x200
    3326:	68 16 4c 00 00       	push   $0x4c16
    332b:	e8 32 05 00 00       	call   3862 <open>
    3330:	89 04 24             	mov    %eax,(%esp)
    3333:	e8 12 05 00 00       	call   384a <close>
    3338:	e8 e5 04 00 00       	call   3822 <exit>
    333d:	50                   	push   %eax
    333e:	50                   	push   %eax
    333f:	68 56 4c 00 00       	push   $0x4c56
    3344:	ff 35 6c 5d 00 00    	pushl  0x5d6c
    334a:	e8 61 06 00 00       	call   39b0 <printf>
    334f:	e8 ce 04 00 00       	call   3822 <exit>
    3354:	52                   	push   %edx
    3355:	52                   	push   %edx
    3356:	68 3d 4c 00 00       	push   $0x4c3d
    335b:	ff 35 6c 5d 00 00    	pushl  0x5d6c
    3361:	e8 4a 06 00 00       	call   39b0 <printf>
    3366:	e8 b7 04 00 00       	call   3822 <exit>
    336b:	90                   	nop
    336c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003370 <fsfull>:
    3370:	55                   	push   %ebp
    3371:	89 e5                	mov    %esp,%ebp
    3373:	57                   	push   %edi
    3374:	56                   	push   %esi
    3375:	53                   	push   %ebx
    3376:	31 db                	xor    %ebx,%ebx
    3378:	83 ec 54             	sub    $0x54,%esp
    337b:	68 6b 4c 00 00       	push   $0x4c6b
    3380:	6a 01                	push   $0x1
    3382:	e8 29 06 00 00       	call   39b0 <printf>
    3387:	83 c4 10             	add    $0x10,%esp
    338a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3390:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    3395:	b9 cd cc cc cc       	mov    $0xcccccccd,%ecx
    339a:	83 ec 04             	sub    $0x4,%esp
    339d:	f7 e3                	mul    %ebx
    339f:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    33a3:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    33a7:	c1 ea 06             	shr    $0x6,%edx
    33aa:	8d 42 30             	lea    0x30(%edx),%eax
    33ad:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
    33b3:	88 45 a9             	mov    %al,-0x57(%ebp)
    33b6:	89 d8                	mov    %ebx,%eax
    33b8:	29 d0                	sub    %edx,%eax
    33ba:	89 c2                	mov    %eax,%edx
    33bc:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    33c1:	f7 e2                	mul    %edx
    33c3:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    33c8:	c1 ea 05             	shr    $0x5,%edx
    33cb:	83 c2 30             	add    $0x30,%edx
    33ce:	88 55 aa             	mov    %dl,-0x56(%ebp)
    33d1:	f7 e3                	mul    %ebx
    33d3:	89 d8                	mov    %ebx,%eax
    33d5:	c1 ea 05             	shr    $0x5,%edx
    33d8:	6b d2 64             	imul   $0x64,%edx,%edx
    33db:	29 d0                	sub    %edx,%eax
    33dd:	f7 e1                	mul    %ecx
    33df:	89 d8                	mov    %ebx,%eax
    33e1:	c1 ea 03             	shr    $0x3,%edx
    33e4:	83 c2 30             	add    $0x30,%edx
    33e7:	88 55 ab             	mov    %dl,-0x55(%ebp)
    33ea:	f7 e1                	mul    %ecx
    33ec:	89 d9                	mov    %ebx,%ecx
    33ee:	c1 ea 03             	shr    $0x3,%edx
    33f1:	8d 04 92             	lea    (%edx,%edx,4),%eax
    33f4:	01 c0                	add    %eax,%eax
    33f6:	29 c1                	sub    %eax,%ecx
    33f8:	89 c8                	mov    %ecx,%eax
    33fa:	83 c0 30             	add    $0x30,%eax
    33fd:	88 45 ac             	mov    %al,-0x54(%ebp)
    3400:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3403:	50                   	push   %eax
    3404:	68 78 4c 00 00       	push   $0x4c78
    3409:	6a 01                	push   $0x1
    340b:	e8 a0 05 00 00       	call   39b0 <printf>
    3410:	58                   	pop    %eax
    3411:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3414:	5a                   	pop    %edx
    3415:	68 02 02 00 00       	push   $0x202
    341a:	50                   	push   %eax
    341b:	e8 42 04 00 00       	call   3862 <open>
    3420:	83 c4 10             	add    $0x10,%esp
    3423:	85 c0                	test   %eax,%eax
    3425:	89 c7                	mov    %eax,%edi
    3427:	78 57                	js     3480 <fsfull+0x110>
    3429:	31 f6                	xor    %esi,%esi
    342b:	eb 05                	jmp    3432 <fsfull+0xc2>
    342d:	8d 76 00             	lea    0x0(%esi),%esi
    3430:	01 c6                	add    %eax,%esi
    3432:	83 ec 04             	sub    $0x4,%esp
    3435:	68 00 02 00 00       	push   $0x200
    343a:	68 60 85 00 00       	push   $0x8560
    343f:	57                   	push   %edi
    3440:	e8 fd 03 00 00       	call   3842 <write>
    3445:	83 c4 10             	add    $0x10,%esp
    3448:	3d ff 01 00 00       	cmp    $0x1ff,%eax
    344d:	7f e1                	jg     3430 <fsfull+0xc0>
    344f:	83 ec 04             	sub    $0x4,%esp
    3452:	56                   	push   %esi
    3453:	68 94 4c 00 00       	push   $0x4c94
    3458:	6a 01                	push   $0x1
    345a:	e8 51 05 00 00       	call   39b0 <printf>
    345f:	89 3c 24             	mov    %edi,(%esp)
    3462:	e8 e3 03 00 00       	call   384a <close>
    3467:	83 c4 10             	add    $0x10,%esp
    346a:	85 f6                	test   %esi,%esi
    346c:	74 28                	je     3496 <fsfull+0x126>
    346e:	83 c3 01             	add    $0x1,%ebx
    3471:	e9 1a ff ff ff       	jmp    3390 <fsfull+0x20>
    3476:	8d 76 00             	lea    0x0(%esi),%esi
    3479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    3480:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3483:	83 ec 04             	sub    $0x4,%esp
    3486:	50                   	push   %eax
    3487:	68 84 4c 00 00       	push   $0x4c84
    348c:	6a 01                	push   $0x1
    348e:	e8 1d 05 00 00       	call   39b0 <printf>
    3493:	83 c4 10             	add    $0x10,%esp
    3496:	bf d3 4d 62 10       	mov    $0x10624dd3,%edi
    349b:	be 1f 85 eb 51       	mov    $0x51eb851f,%esi
    34a0:	89 d8                	mov    %ebx,%eax
    34a2:	b9 cd cc cc cc       	mov    $0xcccccccd,%ecx
    34a7:	83 ec 0c             	sub    $0xc,%esp
    34aa:	f7 e7                	mul    %edi
    34ac:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    34b0:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    34b4:	c1 ea 06             	shr    $0x6,%edx
    34b7:	8d 42 30             	lea    0x30(%edx),%eax
    34ba:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
    34c0:	88 45 a9             	mov    %al,-0x57(%ebp)
    34c3:	89 d8                	mov    %ebx,%eax
    34c5:	29 d0                	sub    %edx,%eax
    34c7:	f7 e6                	mul    %esi
    34c9:	89 d8                	mov    %ebx,%eax
    34cb:	c1 ea 05             	shr    $0x5,%edx
    34ce:	83 c2 30             	add    $0x30,%edx
    34d1:	88 55 aa             	mov    %dl,-0x56(%ebp)
    34d4:	f7 e6                	mul    %esi
    34d6:	89 d8                	mov    %ebx,%eax
    34d8:	c1 ea 05             	shr    $0x5,%edx
    34db:	6b d2 64             	imul   $0x64,%edx,%edx
    34de:	29 d0                	sub    %edx,%eax
    34e0:	f7 e1                	mul    %ecx
    34e2:	89 d8                	mov    %ebx,%eax
    34e4:	c1 ea 03             	shr    $0x3,%edx
    34e7:	83 c2 30             	add    $0x30,%edx
    34ea:	88 55 ab             	mov    %dl,-0x55(%ebp)
    34ed:	f7 e1                	mul    %ecx
    34ef:	89 d9                	mov    %ebx,%ecx
    34f1:	83 eb 01             	sub    $0x1,%ebx
    34f4:	c1 ea 03             	shr    $0x3,%edx
    34f7:	8d 04 92             	lea    (%edx,%edx,4),%eax
    34fa:	01 c0                	add    %eax,%eax
    34fc:	29 c1                	sub    %eax,%ecx
    34fe:	89 c8                	mov    %ecx,%eax
    3500:	83 c0 30             	add    $0x30,%eax
    3503:	88 45 ac             	mov    %al,-0x54(%ebp)
    3506:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3509:	50                   	push   %eax
    350a:	e8 63 03 00 00       	call   3872 <unlink>
    350f:	83 c4 10             	add    $0x10,%esp
    3512:	83 fb ff             	cmp    $0xffffffff,%ebx
    3515:	75 89                	jne    34a0 <fsfull+0x130>
    3517:	83 ec 08             	sub    $0x8,%esp
    351a:	68 a4 4c 00 00       	push   $0x4ca4
    351f:	6a 01                	push   $0x1
    3521:	e8 8a 04 00 00       	call   39b0 <printf>
    3526:	83 c4 10             	add    $0x10,%esp
    3529:	8d 65 f4             	lea    -0xc(%ebp),%esp
    352c:	5b                   	pop    %ebx
    352d:	5e                   	pop    %esi
    352e:	5f                   	pop    %edi
    352f:	5d                   	pop    %ebp
    3530:	c3                   	ret    
    3531:	eb 0d                	jmp    3540 <uio>
    3533:	90                   	nop
    3534:	90                   	nop
    3535:	90                   	nop
    3536:	90                   	nop
    3537:	90                   	nop
    3538:	90                   	nop
    3539:	90                   	nop
    353a:	90                   	nop
    353b:	90                   	nop
    353c:	90                   	nop
    353d:	90                   	nop
    353e:	90                   	nop
    353f:	90                   	nop

00003540 <uio>:
    3540:	55                   	push   %ebp
    3541:	89 e5                	mov    %esp,%ebp
    3543:	83 ec 10             	sub    $0x10,%esp
    3546:	68 ba 4c 00 00       	push   $0x4cba
    354b:	6a 01                	push   $0x1
    354d:	e8 5e 04 00 00       	call   39b0 <printf>
    3552:	e8 c3 02 00 00       	call   381a <fork>
    3557:	83 c4 10             	add    $0x10,%esp
    355a:	85 c0                	test   %eax,%eax
    355c:	74 1b                	je     3579 <uio+0x39>
    355e:	78 3d                	js     359d <uio+0x5d>
    3560:	e8 c5 02 00 00       	call   382a <wait>
    3565:	83 ec 08             	sub    $0x8,%esp
    3568:	68 c4 4c 00 00       	push   $0x4cc4
    356d:	6a 01                	push   $0x1
    356f:	e8 3c 04 00 00       	call   39b0 <printf>
    3574:	83 c4 10             	add    $0x10,%esp
    3577:	c9                   	leave  
    3578:	c3                   	ret    
    3579:	b8 09 00 00 00       	mov    $0x9,%eax
    357e:	ba 70 00 00 00       	mov    $0x70,%edx
    3583:	ee                   	out    %al,(%dx)
    3584:	ba 71 00 00 00       	mov    $0x71,%edx
    3589:	ec                   	in     (%dx),%al
    358a:	52                   	push   %edx
    358b:	52                   	push   %edx
    358c:	68 2c 54 00 00       	push   $0x542c
    3591:	6a 01                	push   $0x1
    3593:	e8 18 04 00 00       	call   39b0 <printf>
    3598:	e8 85 02 00 00       	call   3822 <exit>
    359d:	50                   	push   %eax
    359e:	50                   	push   %eax
    359f:	68 49 4c 00 00       	push   $0x4c49
    35a4:	6a 01                	push   $0x1
    35a6:	e8 05 04 00 00       	call   39b0 <printf>
    35ab:	e8 72 02 00 00       	call   3822 <exit>

000035b0 <rand>:
    35b0:	69 05 68 5d 00 00 0d 	imul   $0x19660d,0x5d68,%eax
    35b7:	66 19 00 
    35ba:	55                   	push   %ebp
    35bb:	89 e5                	mov    %esp,%ebp
    35bd:	5d                   	pop    %ebp
    35be:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
    35c3:	a3 68 5d 00 00       	mov    %eax,0x5d68
    35c8:	c3                   	ret    
    35c9:	66 90                	xchg   %ax,%ax
    35cb:	66 90                	xchg   %ax,%ax
    35cd:	66 90                	xchg   %ax,%ax
    35cf:	90                   	nop

000035d0 <strcpy>:
    35d0:	55                   	push   %ebp
    35d1:	89 e5                	mov    %esp,%ebp
    35d3:	53                   	push   %ebx
    35d4:	8b 45 08             	mov    0x8(%ebp),%eax
    35d7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    35da:	89 c2                	mov    %eax,%edx
    35dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    35e0:	83 c1 01             	add    $0x1,%ecx
    35e3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    35e7:	83 c2 01             	add    $0x1,%edx
    35ea:	84 db                	test   %bl,%bl
    35ec:	88 5a ff             	mov    %bl,-0x1(%edx)
    35ef:	75 ef                	jne    35e0 <strcpy+0x10>
    35f1:	5b                   	pop    %ebx
    35f2:	5d                   	pop    %ebp
    35f3:	c3                   	ret    
    35f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    35fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00003600 <strcmp>:
    3600:	55                   	push   %ebp
    3601:	89 e5                	mov    %esp,%ebp
    3603:	53                   	push   %ebx
    3604:	8b 55 08             	mov    0x8(%ebp),%edx
    3607:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    360a:	0f b6 02             	movzbl (%edx),%eax
    360d:	0f b6 19             	movzbl (%ecx),%ebx
    3610:	84 c0                	test   %al,%al
    3612:	75 1c                	jne    3630 <strcmp+0x30>
    3614:	eb 2a                	jmp    3640 <strcmp+0x40>
    3616:	8d 76 00             	lea    0x0(%esi),%esi
    3619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    3620:	83 c2 01             	add    $0x1,%edx
    3623:	0f b6 02             	movzbl (%edx),%eax
    3626:	83 c1 01             	add    $0x1,%ecx
    3629:	0f b6 19             	movzbl (%ecx),%ebx
    362c:	84 c0                	test   %al,%al
    362e:	74 10                	je     3640 <strcmp+0x40>
    3630:	38 d8                	cmp    %bl,%al
    3632:	74 ec                	je     3620 <strcmp+0x20>
    3634:	29 d8                	sub    %ebx,%eax
    3636:	5b                   	pop    %ebx
    3637:	5d                   	pop    %ebp
    3638:	c3                   	ret    
    3639:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3640:	31 c0                	xor    %eax,%eax
    3642:	29 d8                	sub    %ebx,%eax
    3644:	5b                   	pop    %ebx
    3645:	5d                   	pop    %ebp
    3646:	c3                   	ret    
    3647:	89 f6                	mov    %esi,%esi
    3649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003650 <strlen>:
    3650:	55                   	push   %ebp
    3651:	89 e5                	mov    %esp,%ebp
    3653:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3656:	80 39 00             	cmpb   $0x0,(%ecx)
    3659:	74 15                	je     3670 <strlen+0x20>
    365b:	31 d2                	xor    %edx,%edx
    365d:	8d 76 00             	lea    0x0(%esi),%esi
    3660:	83 c2 01             	add    $0x1,%edx
    3663:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    3667:	89 d0                	mov    %edx,%eax
    3669:	75 f5                	jne    3660 <strlen+0x10>
    366b:	5d                   	pop    %ebp
    366c:	c3                   	ret    
    366d:	8d 76 00             	lea    0x0(%esi),%esi
    3670:	31 c0                	xor    %eax,%eax
    3672:	5d                   	pop    %ebp
    3673:	c3                   	ret    
    3674:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    367a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00003680 <memset>:
    3680:	55                   	push   %ebp
    3681:	89 e5                	mov    %esp,%ebp
    3683:	57                   	push   %edi
    3684:	8b 55 08             	mov    0x8(%ebp),%edx
    3687:	8b 4d 10             	mov    0x10(%ebp),%ecx
    368a:	8b 45 0c             	mov    0xc(%ebp),%eax
    368d:	89 d7                	mov    %edx,%edi
    368f:	fc                   	cld    
    3690:	f3 aa                	rep stos %al,%es:(%edi)
    3692:	89 d0                	mov    %edx,%eax
    3694:	5f                   	pop    %edi
    3695:	5d                   	pop    %ebp
    3696:	c3                   	ret    
    3697:	89 f6                	mov    %esi,%esi
    3699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000036a0 <strchr>:
    36a0:	55                   	push   %ebp
    36a1:	89 e5                	mov    %esp,%ebp
    36a3:	53                   	push   %ebx
    36a4:	8b 45 08             	mov    0x8(%ebp),%eax
    36a7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    36aa:	0f b6 10             	movzbl (%eax),%edx
    36ad:	84 d2                	test   %dl,%dl
    36af:	74 1d                	je     36ce <strchr+0x2e>
    36b1:	38 d3                	cmp    %dl,%bl
    36b3:	89 d9                	mov    %ebx,%ecx
    36b5:	75 0d                	jne    36c4 <strchr+0x24>
    36b7:	eb 17                	jmp    36d0 <strchr+0x30>
    36b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    36c0:	38 ca                	cmp    %cl,%dl
    36c2:	74 0c                	je     36d0 <strchr+0x30>
    36c4:	83 c0 01             	add    $0x1,%eax
    36c7:	0f b6 10             	movzbl (%eax),%edx
    36ca:	84 d2                	test   %dl,%dl
    36cc:	75 f2                	jne    36c0 <strchr+0x20>
    36ce:	31 c0                	xor    %eax,%eax
    36d0:	5b                   	pop    %ebx
    36d1:	5d                   	pop    %ebp
    36d2:	c3                   	ret    
    36d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    36d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000036e0 <gets>:
    36e0:	55                   	push   %ebp
    36e1:	89 e5                	mov    %esp,%ebp
    36e3:	57                   	push   %edi
    36e4:	56                   	push   %esi
    36e5:	53                   	push   %ebx
    36e6:	31 f6                	xor    %esi,%esi
    36e8:	89 f3                	mov    %esi,%ebx
    36ea:	83 ec 1c             	sub    $0x1c,%esp
    36ed:	8b 7d 08             	mov    0x8(%ebp),%edi
    36f0:	eb 2f                	jmp    3721 <gets+0x41>
    36f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    36f8:	8d 45 e7             	lea    -0x19(%ebp),%eax
    36fb:	83 ec 04             	sub    $0x4,%esp
    36fe:	6a 01                	push   $0x1
    3700:	50                   	push   %eax
    3701:	6a 00                	push   $0x0
    3703:	e8 32 01 00 00       	call   383a <read>
    3708:	83 c4 10             	add    $0x10,%esp
    370b:	85 c0                	test   %eax,%eax
    370d:	7e 1c                	jle    372b <gets+0x4b>
    370f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    3713:	83 c7 01             	add    $0x1,%edi
    3716:	88 47 ff             	mov    %al,-0x1(%edi)
    3719:	3c 0a                	cmp    $0xa,%al
    371b:	74 23                	je     3740 <gets+0x60>
    371d:	3c 0d                	cmp    $0xd,%al
    371f:	74 1f                	je     3740 <gets+0x60>
    3721:	83 c3 01             	add    $0x1,%ebx
    3724:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    3727:	89 fe                	mov    %edi,%esi
    3729:	7c cd                	jl     36f8 <gets+0x18>
    372b:	89 f3                	mov    %esi,%ebx
    372d:	8b 45 08             	mov    0x8(%ebp),%eax
    3730:	c6 03 00             	movb   $0x0,(%ebx)
    3733:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3736:	5b                   	pop    %ebx
    3737:	5e                   	pop    %esi
    3738:	5f                   	pop    %edi
    3739:	5d                   	pop    %ebp
    373a:	c3                   	ret    
    373b:	90                   	nop
    373c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3740:	8b 75 08             	mov    0x8(%ebp),%esi
    3743:	8b 45 08             	mov    0x8(%ebp),%eax
    3746:	01 de                	add    %ebx,%esi
    3748:	89 f3                	mov    %esi,%ebx
    374a:	c6 03 00             	movb   $0x0,(%ebx)
    374d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3750:	5b                   	pop    %ebx
    3751:	5e                   	pop    %esi
    3752:	5f                   	pop    %edi
    3753:	5d                   	pop    %ebp
    3754:	c3                   	ret    
    3755:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003760 <stat>:
    3760:	55                   	push   %ebp
    3761:	89 e5                	mov    %esp,%ebp
    3763:	56                   	push   %esi
    3764:	53                   	push   %ebx
    3765:	83 ec 08             	sub    $0x8,%esp
    3768:	6a 00                	push   $0x0
    376a:	ff 75 08             	pushl  0x8(%ebp)
    376d:	e8 f0 00 00 00       	call   3862 <open>
    3772:	83 c4 10             	add    $0x10,%esp
    3775:	85 c0                	test   %eax,%eax
    3777:	78 27                	js     37a0 <stat+0x40>
    3779:	83 ec 08             	sub    $0x8,%esp
    377c:	ff 75 0c             	pushl  0xc(%ebp)
    377f:	89 c3                	mov    %eax,%ebx
    3781:	50                   	push   %eax
    3782:	e8 f3 00 00 00       	call   387a <fstat>
    3787:	89 1c 24             	mov    %ebx,(%esp)
    378a:	89 c6                	mov    %eax,%esi
    378c:	e8 b9 00 00 00       	call   384a <close>
    3791:	83 c4 10             	add    $0x10,%esp
    3794:	8d 65 f8             	lea    -0x8(%ebp),%esp
    3797:	89 f0                	mov    %esi,%eax
    3799:	5b                   	pop    %ebx
    379a:	5e                   	pop    %esi
    379b:	5d                   	pop    %ebp
    379c:	c3                   	ret    
    379d:	8d 76 00             	lea    0x0(%esi),%esi
    37a0:	be ff ff ff ff       	mov    $0xffffffff,%esi
    37a5:	eb ed                	jmp    3794 <stat+0x34>
    37a7:	89 f6                	mov    %esi,%esi
    37a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000037b0 <atoi>:
    37b0:	55                   	push   %ebp
    37b1:	89 e5                	mov    %esp,%ebp
    37b3:	53                   	push   %ebx
    37b4:	8b 4d 08             	mov    0x8(%ebp),%ecx
    37b7:	0f be 11             	movsbl (%ecx),%edx
    37ba:	8d 42 d0             	lea    -0x30(%edx),%eax
    37bd:	3c 09                	cmp    $0x9,%al
    37bf:	b8 00 00 00 00       	mov    $0x0,%eax
    37c4:	77 1f                	ja     37e5 <atoi+0x35>
    37c6:	8d 76 00             	lea    0x0(%esi),%esi
    37c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    37d0:	8d 04 80             	lea    (%eax,%eax,4),%eax
    37d3:	83 c1 01             	add    $0x1,%ecx
    37d6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
    37da:	0f be 11             	movsbl (%ecx),%edx
    37dd:	8d 5a d0             	lea    -0x30(%edx),%ebx
    37e0:	80 fb 09             	cmp    $0x9,%bl
    37e3:	76 eb                	jbe    37d0 <atoi+0x20>
    37e5:	5b                   	pop    %ebx
    37e6:	5d                   	pop    %ebp
    37e7:	c3                   	ret    
    37e8:	90                   	nop
    37e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000037f0 <memmove>:
    37f0:	55                   	push   %ebp
    37f1:	89 e5                	mov    %esp,%ebp
    37f3:	56                   	push   %esi
    37f4:	53                   	push   %ebx
    37f5:	8b 5d 10             	mov    0x10(%ebp),%ebx
    37f8:	8b 45 08             	mov    0x8(%ebp),%eax
    37fb:	8b 75 0c             	mov    0xc(%ebp),%esi
    37fe:	85 db                	test   %ebx,%ebx
    3800:	7e 14                	jle    3816 <memmove+0x26>
    3802:	31 d2                	xor    %edx,%edx
    3804:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3808:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    380c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    380f:	83 c2 01             	add    $0x1,%edx
    3812:	39 d3                	cmp    %edx,%ebx
    3814:	75 f2                	jne    3808 <memmove+0x18>
    3816:	5b                   	pop    %ebx
    3817:	5e                   	pop    %esi
    3818:	5d                   	pop    %ebp
    3819:	c3                   	ret    

0000381a <fork>:
    381a:	b8 01 00 00 00       	mov    $0x1,%eax
    381f:	cd 40                	int    $0x40
    3821:	c3                   	ret    

00003822 <exit>:
    3822:	b8 02 00 00 00       	mov    $0x2,%eax
    3827:	cd 40                	int    $0x40
    3829:	c3                   	ret    

0000382a <wait>:
    382a:	b8 03 00 00 00       	mov    $0x3,%eax
    382f:	cd 40                	int    $0x40
    3831:	c3                   	ret    

00003832 <pipe>:
    3832:	b8 04 00 00 00       	mov    $0x4,%eax
    3837:	cd 40                	int    $0x40
    3839:	c3                   	ret    

0000383a <read>:
    383a:	b8 05 00 00 00       	mov    $0x5,%eax
    383f:	cd 40                	int    $0x40
    3841:	c3                   	ret    

00003842 <write>:
    3842:	b8 10 00 00 00       	mov    $0x10,%eax
    3847:	cd 40                	int    $0x40
    3849:	c3                   	ret    

0000384a <close>:
    384a:	b8 15 00 00 00       	mov    $0x15,%eax
    384f:	cd 40                	int    $0x40
    3851:	c3                   	ret    

00003852 <kill>:
    3852:	b8 06 00 00 00       	mov    $0x6,%eax
    3857:	cd 40                	int    $0x40
    3859:	c3                   	ret    

0000385a <exec>:
    385a:	b8 07 00 00 00       	mov    $0x7,%eax
    385f:	cd 40                	int    $0x40
    3861:	c3                   	ret    

00003862 <open>:
    3862:	b8 0f 00 00 00       	mov    $0xf,%eax
    3867:	cd 40                	int    $0x40
    3869:	c3                   	ret    

0000386a <mknod>:
    386a:	b8 11 00 00 00       	mov    $0x11,%eax
    386f:	cd 40                	int    $0x40
    3871:	c3                   	ret    

00003872 <unlink>:
    3872:	b8 12 00 00 00       	mov    $0x12,%eax
    3877:	cd 40                	int    $0x40
    3879:	c3                   	ret    

0000387a <fstat>:
    387a:	b8 08 00 00 00       	mov    $0x8,%eax
    387f:	cd 40                	int    $0x40
    3881:	c3                   	ret    

00003882 <link>:
    3882:	b8 13 00 00 00       	mov    $0x13,%eax
    3887:	cd 40                	int    $0x40
    3889:	c3                   	ret    

0000388a <mkdir>:
    388a:	b8 14 00 00 00       	mov    $0x14,%eax
    388f:	cd 40                	int    $0x40
    3891:	c3                   	ret    

00003892 <chdir>:
    3892:	b8 09 00 00 00       	mov    $0x9,%eax
    3897:	cd 40                	int    $0x40
    3899:	c3                   	ret    

0000389a <dup>:
    389a:	b8 0a 00 00 00       	mov    $0xa,%eax
    389f:	cd 40                	int    $0x40
    38a1:	c3                   	ret    

000038a2 <getpid>:
    38a2:	b8 0b 00 00 00       	mov    $0xb,%eax
    38a7:	cd 40                	int    $0x40
    38a9:	c3                   	ret    

000038aa <sbrk>:
    38aa:	b8 0c 00 00 00       	mov    $0xc,%eax
    38af:	cd 40                	int    $0x40
    38b1:	c3                   	ret    

000038b2 <sleep>:
    38b2:	b8 0d 00 00 00       	mov    $0xd,%eax
    38b7:	cd 40                	int    $0x40
    38b9:	c3                   	ret    

000038ba <uptime>:
    38ba:	b8 0e 00 00 00       	mov    $0xe,%eax
    38bf:	cd 40                	int    $0x40
    38c1:	c3                   	ret    

000038c2 <kthread_create>:
    38c2:	b8 16 00 00 00       	mov    $0x16,%eax
    38c7:	cd 40                	int    $0x40
    38c9:	c3                   	ret    

000038ca <kthread_id>:
    38ca:	b8 17 00 00 00       	mov    $0x17,%eax
    38cf:	cd 40                	int    $0x40
    38d1:	c3                   	ret    

000038d2 <kthread_exit>:
    38d2:	b8 18 00 00 00       	mov    $0x18,%eax
    38d7:	cd 40                	int    $0x40
    38d9:	c3                   	ret    

000038da <kthread_join>:
    38da:	b8 19 00 00 00       	mov    $0x19,%eax
    38df:	cd 40                	int    $0x40
    38e1:	c3                   	ret    

000038e2 <kthread_mutex_alloc>:
    38e2:	b8 1a 00 00 00       	mov    $0x1a,%eax
    38e7:	cd 40                	int    $0x40
    38e9:	c3                   	ret    

000038ea <kthread_mutex_dealloc>:
    38ea:	b8 1b 00 00 00       	mov    $0x1b,%eax
    38ef:	cd 40                	int    $0x40
    38f1:	c3                   	ret    

000038f2 <kthread_mutex_lock>:
    38f2:	b8 1c 00 00 00       	mov    $0x1c,%eax
    38f7:	cd 40                	int    $0x40
    38f9:	c3                   	ret    

000038fa <kthread_mutex_unlock>:
    38fa:	b8 1d 00 00 00       	mov    $0x1d,%eax
    38ff:	cd 40                	int    $0x40
    3901:	c3                   	ret    

00003902 <procdump>:
    3902:	b8 1e 00 00 00       	mov    $0x1e,%eax
    3907:	cd 40                	int    $0x40
    3909:	c3                   	ret    
    390a:	66 90                	xchg   %ax,%ax
    390c:	66 90                	xchg   %ax,%ax
    390e:	66 90                	xchg   %ax,%ax

00003910 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    3910:	55                   	push   %ebp
    3911:	89 e5                	mov    %esp,%ebp
    3913:	57                   	push   %edi
    3914:	56                   	push   %esi
    3915:	53                   	push   %ebx
    3916:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    3919:	85 d2                	test   %edx,%edx
{
    391b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
    391e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
    3920:	79 76                	jns    3998 <printint+0x88>
    3922:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    3926:	74 70                	je     3998 <printint+0x88>
    x = -xx;
    3928:	f7 d8                	neg    %eax
    neg = 1;
    392a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    3931:	31 f6                	xor    %esi,%esi
    3933:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    3936:	eb 0a                	jmp    3942 <printint+0x32>
    3938:	90                   	nop
    3939:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
    3940:	89 fe                	mov    %edi,%esi
    3942:	31 d2                	xor    %edx,%edx
    3944:	8d 7e 01             	lea    0x1(%esi),%edi
    3947:	f7 f1                	div    %ecx
    3949:	0f b6 92 84 54 00 00 	movzbl 0x5484(%edx),%edx
  }while((x /= base) != 0);
    3950:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
    3952:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
    3955:	75 e9                	jne    3940 <printint+0x30>
  if(neg)
    3957:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    395a:	85 c0                	test   %eax,%eax
    395c:	74 08                	je     3966 <printint+0x56>
    buf[i++] = '-';
    395e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    3963:	8d 7e 02             	lea    0x2(%esi),%edi
    3966:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    396a:	8b 7d c0             	mov    -0x40(%ebp),%edi
    396d:	8d 76 00             	lea    0x0(%esi),%esi
    3970:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
    3973:	83 ec 04             	sub    $0x4,%esp
    3976:	83 ee 01             	sub    $0x1,%esi
    3979:	6a 01                	push   $0x1
    397b:	53                   	push   %ebx
    397c:	57                   	push   %edi
    397d:	88 45 d7             	mov    %al,-0x29(%ebp)
    3980:	e8 bd fe ff ff       	call   3842 <write>

  while(--i >= 0)
    3985:	83 c4 10             	add    $0x10,%esp
    3988:	39 de                	cmp    %ebx,%esi
    398a:	75 e4                	jne    3970 <printint+0x60>
    putc(fd, buf[i]);
}
    398c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    398f:	5b                   	pop    %ebx
    3990:	5e                   	pop    %esi
    3991:	5f                   	pop    %edi
    3992:	5d                   	pop    %ebp
    3993:	c3                   	ret    
    3994:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    3998:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    399f:	eb 90                	jmp    3931 <printint+0x21>
    39a1:	eb 0d                	jmp    39b0 <printf>
    39a3:	90                   	nop
    39a4:	90                   	nop
    39a5:	90                   	nop
    39a6:	90                   	nop
    39a7:	90                   	nop
    39a8:	90                   	nop
    39a9:	90                   	nop
    39aa:	90                   	nop
    39ab:	90                   	nop
    39ac:	90                   	nop
    39ad:	90                   	nop
    39ae:	90                   	nop
    39af:	90                   	nop

000039b0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    39b0:	55                   	push   %ebp
    39b1:	89 e5                	mov    %esp,%ebp
    39b3:	57                   	push   %edi
    39b4:	56                   	push   %esi
    39b5:	53                   	push   %ebx
    39b6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    39b9:	8b 75 0c             	mov    0xc(%ebp),%esi
    39bc:	0f b6 1e             	movzbl (%esi),%ebx
    39bf:	84 db                	test   %bl,%bl
    39c1:	0f 84 b3 00 00 00    	je     3a7a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
    39c7:	8d 45 10             	lea    0x10(%ebp),%eax
    39ca:	83 c6 01             	add    $0x1,%esi
  state = 0;
    39cd:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
    39cf:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    39d2:	eb 2f                	jmp    3a03 <printf+0x53>
    39d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    39d8:	83 f8 25             	cmp    $0x25,%eax
    39db:	0f 84 a7 00 00 00    	je     3a88 <printf+0xd8>
  write(fd, &c, 1);
    39e1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    39e4:	83 ec 04             	sub    $0x4,%esp
    39e7:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    39ea:	6a 01                	push   $0x1
    39ec:	50                   	push   %eax
    39ed:	ff 75 08             	pushl  0x8(%ebp)
    39f0:	e8 4d fe ff ff       	call   3842 <write>
    39f5:	83 c4 10             	add    $0x10,%esp
    39f8:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
    39fb:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    39ff:	84 db                	test   %bl,%bl
    3a01:	74 77                	je     3a7a <printf+0xca>
    if(state == 0){
    3a03:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
    3a05:	0f be cb             	movsbl %bl,%ecx
    3a08:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    3a0b:	74 cb                	je     39d8 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    3a0d:	83 ff 25             	cmp    $0x25,%edi
    3a10:	75 e6                	jne    39f8 <printf+0x48>
      if(c == 'd'){
    3a12:	83 f8 64             	cmp    $0x64,%eax
    3a15:	0f 84 05 01 00 00    	je     3b20 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    3a1b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    3a21:	83 f9 70             	cmp    $0x70,%ecx
    3a24:	74 72                	je     3a98 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    3a26:	83 f8 73             	cmp    $0x73,%eax
    3a29:	0f 84 99 00 00 00    	je     3ac8 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    3a2f:	83 f8 63             	cmp    $0x63,%eax
    3a32:	0f 84 08 01 00 00    	je     3b40 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    3a38:	83 f8 25             	cmp    $0x25,%eax
    3a3b:	0f 84 ef 00 00 00    	je     3b30 <printf+0x180>
  write(fd, &c, 1);
    3a41:	8d 45 e7             	lea    -0x19(%ebp),%eax
    3a44:	83 ec 04             	sub    $0x4,%esp
    3a47:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    3a4b:	6a 01                	push   $0x1
    3a4d:	50                   	push   %eax
    3a4e:	ff 75 08             	pushl  0x8(%ebp)
    3a51:	e8 ec fd ff ff       	call   3842 <write>
    3a56:	83 c4 0c             	add    $0xc,%esp
    3a59:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    3a5c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    3a5f:	6a 01                	push   $0x1
    3a61:	50                   	push   %eax
    3a62:	ff 75 08             	pushl  0x8(%ebp)
    3a65:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    3a68:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
    3a6a:	e8 d3 fd ff ff       	call   3842 <write>
  for(i = 0; fmt[i]; i++){
    3a6f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
    3a73:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    3a76:	84 db                	test   %bl,%bl
    3a78:	75 89                	jne    3a03 <printf+0x53>
    }
  }
}
    3a7a:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3a7d:	5b                   	pop    %ebx
    3a7e:	5e                   	pop    %esi
    3a7f:	5f                   	pop    %edi
    3a80:	5d                   	pop    %ebp
    3a81:	c3                   	ret    
    3a82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
    3a88:	bf 25 00 00 00       	mov    $0x25,%edi
    3a8d:	e9 66 ff ff ff       	jmp    39f8 <printf+0x48>
    3a92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
    3a98:	83 ec 0c             	sub    $0xc,%esp
    3a9b:	b9 10 00 00 00       	mov    $0x10,%ecx
    3aa0:	6a 00                	push   $0x0
    3aa2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
    3aa5:	8b 45 08             	mov    0x8(%ebp),%eax
    3aa8:	8b 17                	mov    (%edi),%edx
    3aaa:	e8 61 fe ff ff       	call   3910 <printint>
        ap++;
    3aaf:	89 f8                	mov    %edi,%eax
    3ab1:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3ab4:	31 ff                	xor    %edi,%edi
        ap++;
    3ab6:	83 c0 04             	add    $0x4,%eax
    3ab9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    3abc:	e9 37 ff ff ff       	jmp    39f8 <printf+0x48>
    3ac1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    3ac8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    3acb:	8b 08                	mov    (%eax),%ecx
        ap++;
    3acd:	83 c0 04             	add    $0x4,%eax
    3ad0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
    3ad3:	85 c9                	test   %ecx,%ecx
    3ad5:	0f 84 8e 00 00 00    	je     3b69 <printf+0x1b9>
        while(*s != 0){
    3adb:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
    3ade:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
    3ae0:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
    3ae2:	84 c0                	test   %al,%al
    3ae4:	0f 84 0e ff ff ff    	je     39f8 <printf+0x48>
    3aea:	89 75 d0             	mov    %esi,-0x30(%ebp)
    3aed:	89 de                	mov    %ebx,%esi
    3aef:	8b 5d 08             	mov    0x8(%ebp),%ebx
    3af2:	8d 7d e3             	lea    -0x1d(%ebp),%edi
    3af5:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    3af8:	83 ec 04             	sub    $0x4,%esp
          s++;
    3afb:	83 c6 01             	add    $0x1,%esi
    3afe:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
    3b01:	6a 01                	push   $0x1
    3b03:	57                   	push   %edi
    3b04:	53                   	push   %ebx
    3b05:	e8 38 fd ff ff       	call   3842 <write>
        while(*s != 0){
    3b0a:	0f b6 06             	movzbl (%esi),%eax
    3b0d:	83 c4 10             	add    $0x10,%esp
    3b10:	84 c0                	test   %al,%al
    3b12:	75 e4                	jne    3af8 <printf+0x148>
    3b14:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
    3b17:	31 ff                	xor    %edi,%edi
    3b19:	e9 da fe ff ff       	jmp    39f8 <printf+0x48>
    3b1e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
    3b20:	83 ec 0c             	sub    $0xc,%esp
    3b23:	b9 0a 00 00 00       	mov    $0xa,%ecx
    3b28:	6a 01                	push   $0x1
    3b2a:	e9 73 ff ff ff       	jmp    3aa2 <printf+0xf2>
    3b2f:	90                   	nop
  write(fd, &c, 1);
    3b30:	83 ec 04             	sub    $0x4,%esp
    3b33:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    3b36:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    3b39:	6a 01                	push   $0x1
    3b3b:	e9 21 ff ff ff       	jmp    3a61 <printf+0xb1>
        putc(fd, *ap);
    3b40:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
    3b43:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    3b46:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
    3b48:	6a 01                	push   $0x1
        ap++;
    3b4a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
    3b4d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
    3b50:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    3b53:	50                   	push   %eax
    3b54:	ff 75 08             	pushl  0x8(%ebp)
    3b57:	e8 e6 fc ff ff       	call   3842 <write>
        ap++;
    3b5c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
    3b5f:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3b62:	31 ff                	xor    %edi,%edi
    3b64:	e9 8f fe ff ff       	jmp    39f8 <printf+0x48>
          s = "(null)";
    3b69:	bb 7c 54 00 00       	mov    $0x547c,%ebx
        while(*s != 0){
    3b6e:	b8 28 00 00 00       	mov    $0x28,%eax
    3b73:	e9 72 ff ff ff       	jmp    3aea <printf+0x13a>
    3b78:	66 90                	xchg   %ax,%ax
    3b7a:	66 90                	xchg   %ax,%ax
    3b7c:	66 90                	xchg   %ax,%ax
    3b7e:	66 90                	xchg   %ax,%ax

00003b80 <free>:
    3b80:	55                   	push   %ebp
    3b81:	a1 20 5e 00 00       	mov    0x5e20,%eax
    3b86:	89 e5                	mov    %esp,%ebp
    3b88:	57                   	push   %edi
    3b89:	56                   	push   %esi
    3b8a:	53                   	push   %ebx
    3b8b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    3b8e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    3b91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3b98:	39 c8                	cmp    %ecx,%eax
    3b9a:	8b 10                	mov    (%eax),%edx
    3b9c:	73 32                	jae    3bd0 <free+0x50>
    3b9e:	39 d1                	cmp    %edx,%ecx
    3ba0:	72 04                	jb     3ba6 <free+0x26>
    3ba2:	39 d0                	cmp    %edx,%eax
    3ba4:	72 32                	jb     3bd8 <free+0x58>
    3ba6:	8b 73 fc             	mov    -0x4(%ebx),%esi
    3ba9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    3bac:	39 fa                	cmp    %edi,%edx
    3bae:	74 30                	je     3be0 <free+0x60>
    3bb0:	89 53 f8             	mov    %edx,-0x8(%ebx)
    3bb3:	8b 50 04             	mov    0x4(%eax),%edx
    3bb6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    3bb9:	39 f1                	cmp    %esi,%ecx
    3bbb:	74 3a                	je     3bf7 <free+0x77>
    3bbd:	89 08                	mov    %ecx,(%eax)
    3bbf:	a3 20 5e 00 00       	mov    %eax,0x5e20
    3bc4:	5b                   	pop    %ebx
    3bc5:	5e                   	pop    %esi
    3bc6:	5f                   	pop    %edi
    3bc7:	5d                   	pop    %ebp
    3bc8:	c3                   	ret    
    3bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3bd0:	39 d0                	cmp    %edx,%eax
    3bd2:	72 04                	jb     3bd8 <free+0x58>
    3bd4:	39 d1                	cmp    %edx,%ecx
    3bd6:	72 ce                	jb     3ba6 <free+0x26>
    3bd8:	89 d0                	mov    %edx,%eax
    3bda:	eb bc                	jmp    3b98 <free+0x18>
    3bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3be0:	03 72 04             	add    0x4(%edx),%esi
    3be3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    3be6:	8b 10                	mov    (%eax),%edx
    3be8:	8b 12                	mov    (%edx),%edx
    3bea:	89 53 f8             	mov    %edx,-0x8(%ebx)
    3bed:	8b 50 04             	mov    0x4(%eax),%edx
    3bf0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    3bf3:	39 f1                	cmp    %esi,%ecx
    3bf5:	75 c6                	jne    3bbd <free+0x3d>
    3bf7:	03 53 fc             	add    -0x4(%ebx),%edx
    3bfa:	a3 20 5e 00 00       	mov    %eax,0x5e20
    3bff:	89 50 04             	mov    %edx,0x4(%eax)
    3c02:	8b 53 f8             	mov    -0x8(%ebx),%edx
    3c05:	89 10                	mov    %edx,(%eax)
    3c07:	5b                   	pop    %ebx
    3c08:	5e                   	pop    %esi
    3c09:	5f                   	pop    %edi
    3c0a:	5d                   	pop    %ebp
    3c0b:	c3                   	ret    
    3c0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003c10 <malloc>:
    3c10:	55                   	push   %ebp
    3c11:	89 e5                	mov    %esp,%ebp
    3c13:	57                   	push   %edi
    3c14:	56                   	push   %esi
    3c15:	53                   	push   %ebx
    3c16:	83 ec 0c             	sub    $0xc,%esp
    3c19:	8b 45 08             	mov    0x8(%ebp),%eax
    3c1c:	8b 15 20 5e 00 00    	mov    0x5e20,%edx
    3c22:	8d 78 07             	lea    0x7(%eax),%edi
    3c25:	c1 ef 03             	shr    $0x3,%edi
    3c28:	83 c7 01             	add    $0x1,%edi
    3c2b:	85 d2                	test   %edx,%edx
    3c2d:	0f 84 9d 00 00 00    	je     3cd0 <malloc+0xc0>
    3c33:	8b 02                	mov    (%edx),%eax
    3c35:	8b 48 04             	mov    0x4(%eax),%ecx
    3c38:	39 cf                	cmp    %ecx,%edi
    3c3a:	76 6c                	jbe    3ca8 <malloc+0x98>
    3c3c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    3c42:	bb 00 10 00 00       	mov    $0x1000,%ebx
    3c47:	0f 43 df             	cmovae %edi,%ebx
    3c4a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    3c51:	eb 0e                	jmp    3c61 <malloc+0x51>
    3c53:	90                   	nop
    3c54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3c58:	8b 02                	mov    (%edx),%eax
    3c5a:	8b 48 04             	mov    0x4(%eax),%ecx
    3c5d:	39 f9                	cmp    %edi,%ecx
    3c5f:	73 47                	jae    3ca8 <malloc+0x98>
    3c61:	39 05 20 5e 00 00    	cmp    %eax,0x5e20
    3c67:	89 c2                	mov    %eax,%edx
    3c69:	75 ed                	jne    3c58 <malloc+0x48>
    3c6b:	83 ec 0c             	sub    $0xc,%esp
    3c6e:	56                   	push   %esi
    3c6f:	e8 36 fc ff ff       	call   38aa <sbrk>
    3c74:	83 c4 10             	add    $0x10,%esp
    3c77:	83 f8 ff             	cmp    $0xffffffff,%eax
    3c7a:	74 1c                	je     3c98 <malloc+0x88>
    3c7c:	89 58 04             	mov    %ebx,0x4(%eax)
    3c7f:	83 ec 0c             	sub    $0xc,%esp
    3c82:	83 c0 08             	add    $0x8,%eax
    3c85:	50                   	push   %eax
    3c86:	e8 f5 fe ff ff       	call   3b80 <free>
    3c8b:	8b 15 20 5e 00 00    	mov    0x5e20,%edx
    3c91:	83 c4 10             	add    $0x10,%esp
    3c94:	85 d2                	test   %edx,%edx
    3c96:	75 c0                	jne    3c58 <malloc+0x48>
    3c98:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3c9b:	31 c0                	xor    %eax,%eax
    3c9d:	5b                   	pop    %ebx
    3c9e:	5e                   	pop    %esi
    3c9f:	5f                   	pop    %edi
    3ca0:	5d                   	pop    %ebp
    3ca1:	c3                   	ret    
    3ca2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3ca8:	39 cf                	cmp    %ecx,%edi
    3caa:	74 54                	je     3d00 <malloc+0xf0>
    3cac:	29 f9                	sub    %edi,%ecx
    3cae:	89 48 04             	mov    %ecx,0x4(%eax)
    3cb1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
    3cb4:	89 78 04             	mov    %edi,0x4(%eax)
    3cb7:	89 15 20 5e 00 00    	mov    %edx,0x5e20
    3cbd:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3cc0:	83 c0 08             	add    $0x8,%eax
    3cc3:	5b                   	pop    %ebx
    3cc4:	5e                   	pop    %esi
    3cc5:	5f                   	pop    %edi
    3cc6:	5d                   	pop    %ebp
    3cc7:	c3                   	ret    
    3cc8:	90                   	nop
    3cc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3cd0:	c7 05 20 5e 00 00 24 	movl   $0x5e24,0x5e20
    3cd7:	5e 00 00 
    3cda:	c7 05 24 5e 00 00 24 	movl   $0x5e24,0x5e24
    3ce1:	5e 00 00 
    3ce4:	b8 24 5e 00 00       	mov    $0x5e24,%eax
    3ce9:	c7 05 28 5e 00 00 00 	movl   $0x0,0x5e28
    3cf0:	00 00 00 
    3cf3:	e9 44 ff ff ff       	jmp    3c3c <malloc+0x2c>
    3cf8:	90                   	nop
    3cf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3d00:	8b 08                	mov    (%eax),%ecx
    3d02:	89 0a                	mov    %ecx,(%edx)
    3d04:	eb b1                	jmp    3cb7 <malloc+0xa7>
