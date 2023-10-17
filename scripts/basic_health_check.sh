#!/bin/bash
for i in `seq 1 10`;
do
  HTTP_CODE=`curl --write-out '%{http_code}' -o /dev/null -m 10 -q -s http://localhost:8080/login`
  if [ "$HTTP_CODE" == "200" ] || [ "$HTTP_CODE" == "302" ]; then
    echo "Successfully accessed application root page with HTTP Code $HTTP_CODE."
    exit 0;
  fi
  echo "Attempt to curl endpoint returned HTTP Code $HTTP_CODE. Backing off and retrying."
  sleep 10
done
echo "Application did not come up after expected time. Failing."
exit 1
