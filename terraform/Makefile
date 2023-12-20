default:

control-plan:
	sh ./scripts/k3s_control_plan.sh
	sh ./scripts/cleanup.sh

control-apply:
	sh ./scripts/k3s_control_apply.sh
	sh ./scripts/cleanup.sh

control-destroy:
	sh ./scripts/k3s_control_destroy.sh
	sh ./scripts/cleanup.sh

worker-plan:
	sh ./scripts/k3s_worker_plan.sh
	sh ./scripts/cleanup.sh

worker-apply:
	sh ./scripts/k3s_worker_apply.sh
	sh ./scripts/cleanup.sh

worker-destroy:
	sh ./scripts/k3s_worker_destroy.sh
	sh ./scripts/cleanup.sh


clean:
	sh ./scripts/cleanup.sh