// ============================================================
//  CAPITOL 14 - Exercicis resolts - Bloc 3
//  Consultes amb operadors avancats
// ============================================================

db = db.getSiblingDB("institut");

// ------------------------------------------------------------
//  Exercici 10
//  Professors amb salari >= 2700 i del departament 1 o 5.
// ------------------------------------------------------------
db.professor.find({
    salari: { $gte: 2700 },
    id_dept: { $in: [1, 5] }
});

// ------------------------------------------------------------
//  Exercici 11
//  Moduls amb un codi que comenci per 'INF'.
// ------------------------------------------------------------
db.modul.find({ codi: { $regex: /^INF/ } });

// ------------------------------------------------------------
//  Exercici 12
//  Alumnes amb un telefon registrat que comenca pel prefix '610'.
// ------------------------------------------------------------
db.alumne.find({
    telefon: { $regex: /^610/ }
});

// ------------------------------------------------------------
//  Exercici 13
//  Matricules suspeses (nota < 5) en convocatoria 1.
// ------------------------------------------------------------
db.matricula.find({
    nota_final: { $lt: 5 },
    convocatoria: 1
});
