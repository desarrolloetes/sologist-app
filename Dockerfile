
# 1. For build React app
FROM node:alpine AS development


ENV appDir /var/www/app

# Se define como variable de ambiente que corra como productivo
ENV NODE_ENV=production

# Se define como variable de ambiente que el pool de hilos de libuv sea 50
ENV UV_THREADPOOL_SIZE=50

# Set working directory
WORKDIR ${appDir}

# Se crea el directorio antes definido
RUN mkdir -p $appDir

# Se empaqueta el código fuente
ADD . $appDir

ENV REACT_APP_COMPANY_ID 1
ENV REACT_APP_API_URL https://cartones-api.azurewebsites.net/api/
ENV REACT_APP_COMPANY_NAME Sologist
ENV REACT_APP_COMPANY_POWERED powered by Sologist
# local runtime configs
ENV NODE_ENV=development
ENV PORT=3007

EXPOSE 3007

# Se instalan dependencias especificadas en package.json
RUN npm install --legacy--peer-deps --verbose&& \ 
    npm run build



# Crear usuario
RUN adduser -D dockeruser

# Asignar permisos
RUN chown -R dockeruser /var/www/app

# Se define el usuario a ejecutar
USER dockeruser

# Se inicia aplicacion
ENTRYPOINT ["npm"]
CMD ["start"]

