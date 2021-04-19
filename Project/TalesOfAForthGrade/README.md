

# Tales of a forth grade API documentation

## Auth Module

### Url: `/auth`

### Student

`POST /auth/student`

`Authorization: None`

#### Request Body

||DataType|Requested|
|----------------|-------------------------------|-----------------------------|
|CNP|`string`            |yes            |
|password|`string`            |yes           |

#### Example Request Body
```json
{
	"CNP": "1234567890123",
	"password": "user"
}
```

#### Response Body

||DataType|
|----------------|-------------------------------|
|token|`string`            |
|expires|`Date`            |

#### Example Response Body
```json
{
	"token": "very.long.string.with.student.permission",
	"expires": "2015-03-25T12:00:00Z"
}
```

#### Possible Errors

`401 Unauthorized` with message `CNP or Password invalid`


### Professor

`POST /auth/professor`

`Authorization: None`

#### Request Body

||DataType|Requested|
|----------------|-------------------------------|-----------------------------|
|username|`string`            |yes            |
|password|`string`            |yes           |

#### Example Request Body
```json
{
	"username": "ion.popescu",
	"password": "user"
}
```

#### Response Body

||DataType|
|----------------|-------------------------------|
|token|`string`            |
|expires|`Date`            |

#### Example Response Body
```json
{
	"token": "very.long.string.with.professor.permission",
	"expires": "2015-03-25T12:00:00Z"
}
```

#### Possible Errors

`401 Unauthorized` with message `Username or Password invalid`


## Professor Module

### Url: `/professor`

#### Get Professor by Id

`GET /professor/{id}`

`Authorization: Bearer {token} w/ Roles = <Admin, Professor>`

#### Request Query

`id = professorId`

#### Response

||DataType|
|----------------|-------------------------------|
|id|`string`            |
|lastName|`string`            |
|firstName|`string`            |
|subject|`string`            |

#### Response Body Example

```json
{
  "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
  "lastName": "string",
  "firstName": "string",
  "subject": "3fa85f64-5717-4562-b3fc-2c963f66afa6"
}
```

#### Create Professor

`Post /professor`

`Authorization: Bearer {token} w/ Roles = <Admin>`

#### Request Body

||DataType|Requested|
|----------------|-------------------------------|-----------------------------|
|lastName|`string`            |yes            |
|firstName|`string`            |yes           |
|subject|`string`            |yes           |

#### Request Body Example

```json
{
  "lastName": "string",
  "firstName": "string",
  "subject": "string"
}
```

#### Response

||DataType|
|----------------|-------------------------------|
|id|`string`            |
|lastName|`string`            |
|firstName|`string`            |
|subject|`string`            |

#### Response Body Example

```json
{
  "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
  "lastName": "string",
  "firstName": "string",
  "subject": "3fa85f64-5717-4562-b3fc-2c963f66afa6"
}
```

### Student Profile

#### Get Student Profile

`GET /profile`

`Authorization: Bearer {token} w/ Roles = <Student>`

#### Response Body

||DataType|
|----------------|-------------------------------|
|id|`string`            |
|lastName|`string`            |
|firstName|`string`            |
|grades|`Array<Grade>`            |
|absences|`Array<Absence>`|

#### Response Example

```json
{
  "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
  "lastName": "string",
  "firstName": "string"
  "grades": []
  "absences": []
}
```



