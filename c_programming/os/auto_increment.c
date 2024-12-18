/// with auto incremnt arival time fcfs
#include <stdio.h>

struct Process
{
    int id;
    int bt;  // Burst time
    int at;  // Arrival time
    int wt;  // Waiting time
    int tat; // Turnaround time
};

void sortByArrival(struct Process p[], int n)
{
    struct Process temp;
    for (int i = 0; i < n - 1; i++)
    {
        for (int j = i + 1; j < n; j++)
        {
            if (p[i].at > p[j].at)
            {
                temp = p[i];
                p[i] = p[j];
                p[j] = temp;
            }
        }
    }
}

int main()
{
    int n, avwt = 0, avtat = 0, initialArrival = 0;
    printf("Enter the total number of processes: ");
    scanf("%d", &n);

    struct Process p[n];

    printf("\nEnter the burst time for each process:\n");
    for (int i = 0; i < n; i++)
    {
        p[i].id = i + 1;
        p[i].at = initialArrival + i * 2;

        printf("Process [%d]:\n", p[i].id);
        printf("Burst time: ");
        scanf("%d", &p[i].bt);

        printf("Arrival time = %d\n", p[i].at);
    }

    sortByArrival(p, n);

    p[0].wt = 0; // Waiting time for first process is 0

    // Calculating waiting time
    for (int i = 1; i < n; i++)
    {
        int service_time = 0;
        for (int j = 0; j < i; j++)
        {
            service_time += p[j].bt;
        }
        p[i].wt = service_time - p[i].at;
        if (p[i].wt < 0)
        {
            p[i].wt = 0;
        }
    }

    printf("\nProcess\tArrival Time\tBurst Time\tWaiting Time\tTurnaround Time");
    for (int i = 0; i < n; i++)
    {
        p[i].tat = p[i].bt + p[i].wt; // Turnaround time = Burst time + Waiting time
        avwt += p[i].wt;
        avtat += p[i].tat;
        printf("\nP[%d]\t\t%d\t\t%d\t\t%d\t\t%d", p[i].id, p[i].at, p[i].bt, p[i].wt, p[i].tat);
    }

    avwt /= n;
    avtat /= n;
    printf("\n\nAverage waiting time = %d", avwt);
    printf("Average turnaround time = %d\n", avtat);

    return 0;
}