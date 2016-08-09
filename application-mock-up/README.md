# Web ACME Application Mock-Up

This is just a background mock up application to simulate the acme web upload application for students file of a Singapure university

# Build a Docker image container 
```
docker build -t="traqy/acme-mock-up-app" .
```

# Run the mock up application container
```
docker rm acme-mock-up-app
docker run -it -P --privileged=true -v /Users/traqy/github/test-teralytics-docker-wp-nginx/volume-data/upload:/var/www/upload --name=acme-mock-up-app traqy/acme-mock-up-app  /root/scripts/apps.sh
```

# Inspect application activity logs
```
docker exec -it acme-mock-up-app tail -f /var/log/apps.log
```