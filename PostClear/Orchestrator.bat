schtasks /delete /tn "Microsoft\Windows\UpdateOrchestrator\Report policies" /f
schtasks /delete /tn "Microsoft\Windows\UpdateOrchestrator\Schedule Scan" /f
schtasks /delete /tn "Microsoft\Windows\UpdateOrchestrator\Schedule Scan Static Task" /f
schtasks /delete /tn "Microsoft\Windows\UpdateOrchestrator\Schedule Work" /f
schtasks /delete /tn Microsoft\Windows\UpdateOrchestrator\UpdateModelTask /f
schtasks /delete /tn Microsoft\Windows\UpdateOrchestrator\USO_UxBroker /f
