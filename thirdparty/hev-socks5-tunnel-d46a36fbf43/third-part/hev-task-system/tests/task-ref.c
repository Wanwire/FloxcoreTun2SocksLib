/*
 ============================================================================
 Name        : task-ref.c
 Author      : Heiher <r@hev.cc>
 Copyright   : Copyright (c) 2018 everyone.
 Description : Task Reference Test
 ============================================================================
 */

#include <assert.h>

#include <hev-task.h>

int
main (int argc, char *argv[])
{
    HevTask *task;

    task = hev_task_new (-1);
    assert (task);
    assert (hev_task_ref (task) == task);

    hev_task_unref (task);
    hev_task_unref (task);

    return 0;
}
