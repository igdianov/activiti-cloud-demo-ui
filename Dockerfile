FROM node:carbon

WORKDIR /home/node/app


COPY . .
ENV BASE-HREF "/"

RUN npm install && npm run build --base-href $BASE-HREF && rm -rf node_modules
RUN chmod +x cmd.sh

RUN npm install -g http-server

EXPOSE 3000

CMD ["/home/node/app/cmd.sh"]
