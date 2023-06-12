MVC




Goes from client to router then gord to controller
after controller is goes to model and the model retruved from the database then back to the controller and foes to the views and spits out the action


Rails magic,

Securely storing imforamtuion

we scant store plaintext password in the db

one  of the ways to do this is to use b crypt

User Schema

Columnn | data type | details |

id

username

| column name  | data type   |  details |
|---|---|---|
|  id |   |   |
|   username|   |   |
|   password_digest|   |   |
|   session_token|   |   |

Relevant routes for sign up

hwo do we sugbn up a uawe

pass params (username,passwoers) thought a form
create a new instanc eofa user
try to save the user in the satabase
- user needs password_digest and session_token


we are going to use resource :session , only new create


how do we long a suer

a user is logged in if
user.session_token == session[:session_token]


cookies stores the session token on the browser so the server knows who it is


