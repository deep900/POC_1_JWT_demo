# POC_1_JWT_demo

How to build this POC.

set the micro gateway runtime in the system environment variables and make it available globally.

Settings in API _Definitions.

Import the Open API 3.0.1 yaml file in the API definitions folder. Make the changes as per the file available in that folder.

Run the CarRental APP in a docker container and map the IP address(Docker container IP) in the api definitions file. 

Now go to the root folder and open a command window.

run the command "micro-gw" build POC_1_JWT_Demo" (Ensure you have the api_definitions file before running).

Docker image:

After executing the above command the docker image will be listed.

Run the docker image.

docker run -p 9090:9090 <image_name>

How to hit the API:
Step 1: Run  the WSO2 API Manager and then hit the below URL:
https://localhost:9443/devportal/apis/588d0894-f4e8-43fb-b08c-5d4da5212c6c/test

Now click on "Get Test Key" and copy the JWT token from the application.

Step 2:
Run the CarRental APP in a docker container in port 8080 and then check if the CarRental APP is working properly by hitting the command.

curl http://localhost:8080/getCars
Response:
[{"name":"Honda","price":300000.25,"category":"Sedan"},{"name":"Kia","price":100400.25,"category":"Mini"},{"name":"Hundai","price":400400.25,"category":"Sedan"}]

Step 3: 
Now hit the micro-gateway proxy API by using the below command.
curl -X GET http://localhost:9090/carrental/v1/getCars -H "accept:application/json" -H "Authorization:Bearer eyJ4NXQiOiJNell4TW1Ga09HWXdNV0kwWldObU5EY3hOR1l3WW1NNFpUQTNNV0kyTkRBelpHUXpOR00wWkdSbE5qSmtPREZrWkRSaU9URmtNV0ZoTXpVMlpHVmxOZyIsImtpZCI6Ik16WXhNbUZrT0dZd01XSTBaV05tTkRjeE5HWXdZbU00WlRBM01XSTJOREF6WkdRek5HTTBaR1JsTmpKa09ERmtaRFJpT1RGa01XRmhNelUyWkdWbE5nX1JTMjU2IiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiJhZG1pbiIsImF1dCI6IkFQUExJQ0FUSU9OIiwiYXVkIjoiWHZWWExYdXduWWxEVEJtR3Z1Rlo3V215NUdVYSIsIm5iZiI6MTYzMDA2Nzk1OSwiYXpwIjoiWHZWWExYdXduWWxEVEJtR3Z1Rlo3V215NUdVYSIsInNjb3BlIjoiZGVmYXVsdCIsImlzcyI6Imh0dHBzOlwvXC9sb2NhbGhvc3Q6OTQ0M1wvb2F1dGgyXC90b2tlbiIsImV4cCI6MTYzMDA3MTU1OSwiaWF0IjoxNjMwMDY3OTU5LCJqdGkiOiI5YTNlOGU1Ni0zMWNkLTQ2NjQtODRmNy03ZDk1M2Y5YjEzYWQifQ.c0OV-VeeukfX8MMvvyIfScSStnm7ZRE8Mq3pCw5kbFwc3ORgxRgzeF-OM27sOV7XFgX-o0wMmLXBp2DU9neUPHr3zAc_Gt78aT6rEe9dY_0LOPDfUtxNYrhy-a1d4OVoepkYT1sekzadDb1nUNfufTUV38b98DH0m1P3K1jIDKgX2i8vlkmOUmcog7tYAi8QhiDxjsm4Gr9OkNU435DnJaNTkrbOydgKT3oq5VmV9wlqkWwAL_4jB2iy8UDMi6Zq-5Nu2eHba-GS2frOvBirhFyDTf7YAsA1y9OoDKERGO_dgeLNRn5e8r3DuBqk2ncdo_BwAYqQAaG8yudcLuV7SA"
Response:
[{"name":"Honda","price":300000.25,"category":"Sedan"},{"name":"Kia","price":100400.25,"category":"Mini"},{"name":"Hundai","price":400400.25,"category":"Sedan"}]