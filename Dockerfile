FROM node:carbon

WORKDIR /home/node/app


COPY . .
RUN [ "sh", "-c","echo BASEHREF1=$BASEHREF"]
ENV BASEHREF=${BASEHREF:-/}
RUN [ "sh", "-c","echo BASEHREF2=$BASEHREF"]

RUN [ "sh", "-c","npm install && npm run build -- --base-href $BASEHREF --deploy-url $BASEHREF && rm -rf node_modules" ]
RUN chmod +x cmd.sh

RUN npm install -g http-server

EXPOSE 3000

CMD ["/home/node/app/cmd.sh"]
