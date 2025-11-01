# 1️⃣ Find and store pods not on the latest revision
OUTDATED_PODS=$(kubectl -n database get pod -l app=dragonfly \
  -o jsonpath='{range .items[*]}{.metadata.name}{" "}{.metadata.labels.controller-revision-hash}{"\n"}{end}' | \
  awk -v rev=$(kubectl -n database get sts dragonfly -o jsonpath='{.status.updateRevision}') '$2 != rev {print $1}')

echo "Outdated pods: $OUTDATED_PODS"

# 2️⃣ Reboot them one at a time, waiting for each to become Ready
for pod in $OUTDATED_PODS; do
  echo "Restarting $pod..."
  kubectl -n database delete pod "$pod" --wait=false
  kubectl -n database wait --for=condition=ready pod/"$pod" --timeout=10m
done
