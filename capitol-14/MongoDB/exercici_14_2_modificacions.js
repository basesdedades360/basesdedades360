// ============================================================
//  CAPITOL 14 - Exercicis resolts - Bloc 2
//  Modificacions sobre la base de dades 'institut'
//
//  Aquests exercicis MODIFIQUEN dades. Si vols repetir-los des
//  d'un estat net, torna a executar load("01_institut_mongodb.js").
// ============================================================

db = db.getSiblingDB("institut");

// ------------------------------------------------------------
//  Exercici 6
//  Apujar un 3% el salari de tots els professors del departament 5.
// ------------------------------------------------------------
db.professor.updateMany(
    { id_dept: 5 },
    { $mul: { salari: 1.03 } }
);

// Comprovacio
db.professor.find(
    { id_dept: 5 },
    { _id: 0, nom: 1, cognoms: 1, salari: 1 }
);

// ------------------------------------------------------------
//  Exercici 7
//  Eliminar el camp 'telefon' de tots els alumnes que el tinguin a null.
// ------------------------------------------------------------
db.alumne.updateMany(
    { telefon: null },
    { $unset: { telefon: "" } }
);

// Comprovacio: cap document hauria de tenir telefon = null
db.alumne.countDocuments({ telefon: null });

// ------------------------------------------------------------
//  Exercici 8
//  Marcar com a aprovades (nota 5.00) totes les matricules amb
//  nota null de l'alumne 7 (en Nil).
// ------------------------------------------------------------
db.matricula.updateMany(
    { id_alumne: 7, nota_final: null },
    { $set: { nota_final: 5.00 } }
);

// Comprovacio
db.matricula.find({ id_alumne: 7 });

// ------------------------------------------------------------
//  Exercici 9
//  Eliminar totes les matricules de tercera convocatoria.
// ------------------------------------------------------------
db.matricula.deleteMany({ convocatoria: 3 });
