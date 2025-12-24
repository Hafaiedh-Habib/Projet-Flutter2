from fastapi import FastAPI, Depends, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy.orm import Session
from typing import List
from database import engine, get_db
from models import Base, Person, PersonCreate, PersonResponse, User, UserCreate, UserLogin, UserResponse

Base.metadata.create_all(bind=engine)

app = FastAPI(title="Contact API")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.post("/personnes", response_model=PersonResponse)
def create_person(person: PersonCreate, db: Session = Depends(get_db)):
    db_person = db.query(Person).filter(Person.telephone == person.telephone).first()
    if db_person:
        raise HTTPException(status_code=400, detail="Ce numéro de téléphone existe déjà")
    
    db_person = Person(
        nom=person.nom,
        prenom=person.prenom,
        telephone=person.telephone
    )
    db.add(db_person)
    db.commit()
    db.refresh(db_person)
    return db_person


@app.get("/personnes", response_model=List[PersonResponse])
def get_persons(db: Session = Depends(get_db)):
    persons = db.query(Person).all()
    return persons

@app.get("/personnes/search/{query}", response_model=List[PersonResponse])
def search_persons(query: str, db: Session = Depends(get_db)):
    query_lower = query.lower()
    persons = db.query(Person).filter(
        (Person.nom.ilike(f"%{query_lower}%")) |
        (Person.prenom.ilike(f"%{query_lower}%")) |
        (Person.telephone.ilike(f"%{query_lower}%"))
    ).all()
    return persons

@app.get("/personnes/{person_id}", response_model=PersonResponse)
def get_person(person_id: int, db: Session = Depends(get_db)):
    person = db.query(Person).filter(Person.id == person_id).first()
    if person is None:
        raise HTTPException(status_code=404, detail="Personne non trouvée")
    return person

@app.delete("/personnes/{person_id}")
def delete_person(person_id: int, db: Session = Depends(get_db)):
    person = db.query(Person).filter(Person.id == person_id).first()
    if person is None:
        raise HTTPException(status_code=404, detail="Personne non trouvée")
    
    db.delete(person)
    db.commit()
    return {"message": "Personne supprimée avec succès"}

@app.put("/personnes/{person_id}", response_model=PersonResponse)
def update_person(person_id: int, person: PersonCreate, db: Session = Depends(get_db)):
    db_person = db.query(Person).filter(Person.id == person_id).first()
    if db_person is None:
        raise HTTPException(status_code=404, detail="Personne non trouvée")
    
    # Vérifier si le nouveau numéro existe déjà pour une autre personne
    existing = db.query(Person).filter(
        Person.telephone == person.telephone,
        Person.id != person_id
    ).first()
    if existing:
        raise HTTPException(status_code=400, detail="Ce numéro de téléphone existe déjà")
    
    db_person.nom = person.nom
    db_person.prenom = person.prenom
    db_person.telephone = person.telephone
    
    db.commit()
    db.refresh(db_person)
    return db_person



@app.post("/auth/register", response_model=UserResponse)
def register_user(user: UserCreate, db: Session = Depends(get_db)):
    db_user = db.query(User).filter(User.numero == user.numero).first()
    if db_user:
        raise HTTPException(status_code=400, detail="Ce numéro existe déjà")
    
    db_user = User(
        nom=user.nom.lower(),
        prenom=user.prenom.lower(),
        numero=user.numero,
        mot_de_passe=user.mot_de_passe
    )
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user

@app.post("/auth/login", response_model=UserResponse)
def login_user(credentials: UserLogin, db: Session = Depends(get_db)):
    user = db.query(User).filter(
        User.numero == credentials.numero,
        User.mot_de_passe == credentials.mot_de_passe
    ).first()
    
    if user is None:
        raise HTTPException(status_code=401, detail="Numéro ou mot de passe incorrect")
    
    return user




if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)