#FROM node:alpine
FROM rqi14/perplexica-app:slim

ARG NEXT_PUBLIC_WS_URL=ws://perp-backend.docker.lan:3001
ARG NEXT_PUBLIC_API_URL=http://perp-backend.docker.lan:3001/api
ENV NEXT_PUBLIC_WS_URL=${NEXT_PUBLIC_WS_URL}
ENV NEXT_PUBLIC_API_URL=${NEXT_PUBLIC_API_URL}

WORKDIR /home/perplexica

COPY ui /home/perplexica/

RUN find /home/perplexica/.next/static/chunks -type f -name '*.js' -exec sed -i 's|__NEXT_PUBLIC_WS_URL__|'"${NEXT_PUBLIC_WS_URL}"'|g; s|__NEXT_PUBLIC_API_URL__|'"${NEXT_PUBLIC_API_URL}"'|g' {} +
RUN yarn install
RUN yarn build

CMD ["yarn", "start"]
