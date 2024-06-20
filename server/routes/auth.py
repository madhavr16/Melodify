from database import get_db
from fastapi import APIRouter, Depends, HTTPException
import bcrypt
import uuid
from models.user import User
from pydantic_schemas.user_create import UserCreate
from pydantic_schemas.user_login import UserLogin
from sqlalchemy.orm import Session


router = APIRouter()

@router.post('/signup', status_code=201)

def signup_user(user: UserCreate, db: Session = Depends(get_db)):
    # extract the data from the request
    print(user.name)
    print(user.email)
    print(user.password)
    # check if the user already exists
    user_db = db.query(User).filter(User.email == user.email).first()

    if user_db:
        raise HTTPException(status_code=400, detail="User already exists")
    
    hashed_pw = bcrypt.hashpw(user.password.encode(), bcrypt.gensalt())

    user_db = User(id = str(uuid.uuid4()), name = user.name, email = user.email, password = hashed_pw)
    # if not, create the user
    db.add(user_db)
    db.commit()
    db.refresh(user_db)

    return user_db

@router.post('/login')

def login_user(user: UserLogin, db: Session = Depends(get_db)):
    # check if the user with same email exists
    user_db = db.query(User).filter(User.email == user.email).first()

    if not user_db:
        raise HTTPException(status_code=400, detail="Invalid credentials")
    
    # password matching or not
    is_match = bcrypt.checkpw(user.password.encode(), user_db.password)

    if not is_match:
        raise HTTPException(status_code=400, detail="Incorrect Password")
    
    return user_db