
# cronjob.yaml:
        # apiVersion: batch/v1
        # kind: CronJob
        # metadata:
        # name: example-cronjob
        # spec:
        # schedule: "*/5 * * * *"  # This defines the cron schedule (every 5 minutes in this case)
        # jobTemplate:
        #     spec:
        #     template:
        #         spec:
        #         containers:
        #         - name: example
        #             image: busybox
        #             args:
        #             - /bin/sh
        #             - -c
        #             - date; echo Hello from Kubernetes CronJob
        #         restartPolicy: OnFailure  # Job will restart only if it fails
        # successfulJobsHistoryLimit: 3  # Limits the number of successful jobs to keep
        # failedJobsHistoryLimit: 1  # Limits the number of failed jobs to keep


  kubectl apply -f cronjob.yaml