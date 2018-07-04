#!/usr/bin/env bash

ACT_GATEWAY_URL=${ACT_GATEWAY_URL:-http://localhost:8080}
ACT_IDM_URL=${ACT_IDM_URL:-http://localhost:8081/auth/realms/springboot/protocol/openid-connect/token}
ACT_IDM_BASE_URL=$(echo $ACT_IDM_URL | cut -d / -f 1,2,3)
ACT_IDM_PATH=${ACT_IDM_URL/${ACT_IDM_BASE_URL}/}
ACT_IDM_CLIENT_ID=${ACT_IDM_CLIENT_ID:-activiti}

echo ACT_GATEWAY_URL=${ACT_GATEWAY_URL}
echo ACT_IDM_URL=${ACT_IDM_URL}
echo ACT_IDM_CLIENT_ID=${ACT_IDM_CLIENT_ID}
echo ACT_IDM_BASE_URL=${ACT_IDM_BASE_URL}
echo ACT_IDM_PATH=${ACT_IDM_PATH}

sed -e "s@http://activiti-cloud-sso-idm-kub:30080@${ACT_GATEWAY_URL}@g" \
    -e "s@http://activiti-cloud-sso-idm-kub:30081@${ACT_IDM_BASE_URL}@g" \
    -e "s@/auth/realms/springboot/protocol/openid-connect/token@${ACT_IDM_PATH}@g" \
    -e "s@activiti@${ACT_IDM_CLIENT_ID}@g" \
    -i dist/app.config.json

if [ "$BASEHREF" = "/" ]; then
  http-server  -p 3000 dist
else
   mkdir public
   mv dist public/ui
   cd public
   http-server -c-1 -p 3000 ./
fi
