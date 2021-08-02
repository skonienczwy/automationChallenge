FROM nginx:1.21.1



ENTRYPOINT ["/bin/sh", "/usr/local/bin/add_var_environments.sh"]
# EXPOSE PORTS
EXPOSE 80
EXPOSE 443
# RUN COMMAND
CMD ["/bin/sh", "-c", "nginx -g 'daemon off;'; nginx -s reload;"]
