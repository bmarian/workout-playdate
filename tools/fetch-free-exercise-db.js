import { readFileSync, writeFileSync, existsSync, rmSync } from "node:fs";

function getFileLocation() {
  return process.cwd() + "/source/data/free-exercise-db.json";
}

function checkFileIntegrity() {
  const path = getFileLocation();
  const exists = existsSync(path);
  if (!exists) return { error: "File does not exist!" };

  const fileConent = readFileSync(path);
  const exercises = JSON.parse(fileConent);
  if (Array.isArray(exercises))
    return { error: "Outdated file format" };

  return {};
}

function deleteOldFile() {
  const path = getFileLocation();
  const exists = existsSync(path);
  if (!exists) return;

  rmSync(path);
}

async function fetchExercises() {
  const sourceUrl =
    "https://raw.githubusercontent.com/yuhonas/free-exercise-db/main/dist/exercises.json";
  const response = await fetch(sourceUrl);
  if (!response.ok) {
    console.error("Could not download exercises");
    return;
  }

  const exercises = await response.json();
  const formattedExercises = exercises.reduce((acc, ex) => {
    const { images, id, ...data } = ex;
    return { ...acc, [id]: data };
  }, {});

  return formattedExercises;
}

async function downloadFile() {
  const exercises = await fetchExercises();
  const path = getFileLocation();

  writeFileSync(path, JSON.stringify(exercises));
}

async function main() {
  const integrity = checkFileIntegrity();
  if (integrity.error) {
    console.error(integrity.error);
  }

  console.log("-- Old file will be deleted --");
  deleteOldFile();

  console.log("-- Downloading new file --");
  await downloadFile();
  console.log("-- File downloaded --");
}

main();
