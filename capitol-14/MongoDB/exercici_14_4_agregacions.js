// ============================================================
//  CAPITOL 14 - Exercicis resolts - Bloc 4
//  Framework d'agregacio
//
//  El framework d'agregacio de MongoDB es l'equivalent del
//  SELECT ... GROUP BY ... JOIN ... HAVING del mon SQL.
// ============================================================

db = db.getSiblingDB("institut");

// ------------------------------------------------------------
//  Exercici 14
//  Comptar quants professors hi ha per departament,
//  ordenat de mes a menys.
// ------------------------------------------------------------
db.professor.aggregate([
    { $group: { _id: "$id_dept", total: { $sum: 1 } } },
    { $sort: { total: -1 } }
]);

// ------------------------------------------------------------
//  Exercici 15
//  Nota mitjana de l'alumne 1 (en Marc).
// ------------------------------------------------------------
db.matricula.aggregate([
    { $match: { id_alumne: 1, nota_final: { $ne: null } } },
    { $group: { _id: "$id_alumne", mitjana: { $avg: "$nota_final" } } }
]);

// ------------------------------------------------------------
//  Exercici 16
//  Nom complet i departament de cada professor ($lookup = JOIN).
// ------------------------------------------------------------
db.professor.aggregate([
    { $lookup: {
        from: "departament",
        localField: "id_dept",
        foreignField: "_id",
        as: "dept"
    } },
    { $unwind: "$dept" },
    { $project: {
        _id: 0,
        nom: 1,
        cognoms: 1,
        departament: "$dept.nom_dept"
    } }
]);

// ------------------------------------------------------------
//  Exercici 17
//  Quants moduls te assignats cada professor?
// ------------------------------------------------------------
db.modul.aggregate([
    { $match: { id_prof: { $ne: null } } },
    { $group: { _id: "$id_prof", moduls: { $sum: 1 } } },
    { $lookup: {
        from: "professor",
        localField: "_id",
        foreignField: "_id",
        as: "prof"
    } },
    { $unwind: "$prof" },
    { $project: {
        _id: 0,
        nom: "$prof.nom",
        cognoms: "$prof.cognoms",
        moduls: 1
    } },
    { $sort: { moduls: -1 } }
]);

// ------------------------------------------------------------
//  Exercici 18
//  Alumnes sense matricula (LEFT JOIN ... WHERE x IS NULL).
// ------------------------------------------------------------
db.alumne.aggregate([
    { $lookup: {
        from: "matricula",
        localField: "_id",
        foreignField: "id_alumne",
        as: "ms"
    } },
    { $match: { ms: { $size: 0 } } },
    { $project: { _id: 0, nom: 1, cognoms: 1 } }
]);
// Quim Font Soler i Adriana Roca Garcia

// ------------------------------------------------------------
//  Exercici 19
//  Per a cada departament, salari mitja i maxim
//  dels seus professors actius.
// ------------------------------------------------------------
db.professor.aggregate([
    { $match: { actiu: true } },
    { $group: {
        _id: "$id_dept",
        mitjana: { $avg: "$salari" },
        maxim:   { $max: "$salari" },
        nombre:  { $sum: 1 }
    } },
    { $lookup: {
        from: "departament",
        localField: "_id",
        foreignField: "_id",
        as: "d"
    } },
    { $unwind: "$d" },
    { $project: {
        _id: 0,
        departament: "$d.nom_dept",
        mitjana: { $round: ["$mitjana", 2] },
        maxim: 1,
        nombre: 1
    } },
    { $sort: { mitjana: -1 } }
]);

// ------------------------------------------------------------
//  Exercici 20
//  Modul amb millor nota mitjana de tota la base de dades.
// ------------------------------------------------------------
db.matricula.aggregate([
    { $match: { nota_final: { $ne: null } } },
    { $group: { _id: "$id_modul", mitjana: { $avg: "$nota_final" } } },
    { $sort: { mitjana: -1 } },
    { $limit: 1 },
    { $lookup: {
        from: "modul",
        localField: "_id",
        foreignField: "_id",
        as: "m"
    } },
    { $unwind: "$m" },
    { $project: {
        _id: 0,
        codi: "$m.codi",
        nom_modul: "$m.nom_modul",
        mitjana: { $round: ["$mitjana", 2] }
    } }
]);
