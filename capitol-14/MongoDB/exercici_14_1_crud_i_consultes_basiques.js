// ============================================================
//  CAPITOL 14 - Exercicis resolts - Bloc 1
//  CRUD i consultes basiques sobre la base de dades 'institut'
//
//  Requisits previs:
//    1. Tenir 'mongosh' instal-lat.
//    2. Haver carregat la BD amb: load("01_institut_mongodb.js")
// ============================================================

db = db.getSiblingDB("institut");

// ------------------------------------------------------------
//  Exercici 1
//  Inserir un nou departament d'Educacio Fisica amb id 8.
// ------------------------------------------------------------
db.departament.insertOne({
    _id: 8,
    nom_dept: "Educacio Fisica",
    edifici: "Edifici E"
});

// ------------------------------------------------------------
//  Exercici 2
//  Llistar els alumnes nascuts l'any 2005 (nomes nom i cognoms).
// ------------------------------------------------------------
db.alumne.find(
    {
        data_naix: {
            $gte: ISODate("2005-01-01"),
            $lt:  ISODate("2006-01-01")
        }
    },
    { _id: 0, nom: 1, cognoms: 1 }
);

// ------------------------------------------------------------
//  Exercici 3
//  Comptar els professors inactius.
// ------------------------------------------------------------
db.professor.countDocuments({ actiu: false });
// 2

// ------------------------------------------------------------
//  Exercici 4
//  Moduls del primer curs ordenats per hores descendents.
// ------------------------------------------------------------
db.modul.find(
    { curs: 1 },
    { _id: 0, codi: 1, nom_modul: 1, hores: 1 }
).sort({ hores: -1 });

// ------------------------------------------------------------
//  Exercici 5
//  Els 3 alumnes amb el correu mes curt.
// ------------------------------------------------------------
db.alumne.aggregate([
    { $project: {
        _id: 0,
        nom: 1,
        cognoms: 1,
        email: 1,
        longitud: { $strLenCP: "$email" }
    } },
    { $sort: { longitud: 1 } },
    { $limit: 3 }
]);
