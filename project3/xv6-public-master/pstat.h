#ifndef _PSTAT_H_
#define _PSTAT_H_

#define NTICKS 500
#define NSCHEDSTATS 1500

struct sched_stat_t
{
  int start_tick;
  int duration;
  int priority;
};

#endif
