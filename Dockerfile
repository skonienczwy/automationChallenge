FROM nginx:1.21.1

ADD $PWD/config/default.conf /etc/nginx/conf.d/default.conf


ADD $PWD/config/*.key /etc/ssl/private/
ADD $PWD/config/*.crt /etc/ssl/certs/


# ENTRYPOINT
COPY $PWD/config/add_var_environments.sh /usr/local/bin
RUN chmod +x /usr/local/bin/add_var_environments.sh
ENTRYPOINT ["/bin/sh", "/usr/local/bin/add_var_environments.sh"]
# EXPOSE PORTS
EXPOSE 80
EXPOSE 443
# RUN COMMAND
CMD ["/bin/sh", "-c", "nginx -g 'daemon off;'; nginx -s reload;"]
