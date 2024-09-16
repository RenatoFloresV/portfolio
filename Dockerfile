# Utiliza una imagen base de CentOS
FROM centos:7

# Establece el directorio de trabajo
WORKDIR /app

# Copia el código fuente de tu aplicación
COPY . .

# Define el argumento API_KEY que se pasará durante la construcción
ARG API_KEY

# Establece la variable de entorno con el valor de API_KEY
ENV API_KEY=${API_KEY}

# Exponer el puerto para la aplicación web
EXPOSE 8080

# Usa un servidor ligero (Nginx) para servir la aplicación Flutter
FROM nginx:alpine
COPY --from=0 /app/build/web /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]