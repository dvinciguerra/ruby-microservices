
# Ruby Microservices


## Using the services

### Auth

#### POST /v1/auth

Command:

```
curl -XPOST "http://localhost:3001/v1/auth" -d $'{ \
  "email": "eminetto@gmail.com", \
  "password": "1234567" \
}'
```

Result Example:

```json
{
  "token": "Authorization:eyJhbGciOiJIUzI1NiJ9.eyJpZCI6IjFiYmFlY2Q3LTBhOWUtNGY1NS1iMjVjLTYyMTc0ODYxNWZiZSIsImVtYWlsIjoiZGV2QGV4YW1wbGUub3JnIiwicGFzc3dvcmQiOiJ0ZXN0In0.6nYYTW_vsd6CbPttyEXqlz1kdCAiceqUy3j4RvtNQI4"
}
```

### Services

#### POST /v1/services

Command:

```
curl -XPOST "http://localhost:3002/v1/services" \
  -H 'Authorization:eyJhbGciOiJIUzI1NiJ9.eyJpZCI6IjFiYmFlY2Q3LTBhOWUtNGY1NS1iMjVjLTYyMTc0ODYxNWZiZSIsImVtYWlsIjoiZGV2QGV4YW1wbGUub3JnIiwicGFzc3dvcmQiOiJ0ZXN0In0.6nYYTW_vsd6CbPttyEXqlz1kdCAiceqUy3j4RvtNQI4' \
  -d $'{ \
		"type": "compute", \
		"size":"micro 2x", \
		"preferences":{ \
			"storage":{ \
				"type":"ssd", \
				"size":"512G" \
			} \
		} \
	}'
```

Result Example:

```json
{
	"type":"compute",
	"size":"micro 2x",
	"preferences": {
		"storage": {
			"type":"ssd",
			"size":"512G"
		}
	}
}
```

