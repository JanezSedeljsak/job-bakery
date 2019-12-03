#!/usr/bin/env node

const {
  resolve
} = require('path')

const fs = require('fs')

const {
  promisify
} = require('util')

const readFile = promisify(fs.readFile)

const conceptsFile = resolve(__dirname, 'data', 'concepts')
const languageFeaturesFile = resolve(__dirname, 'data', 'language-features')

const getRandomLine = filename => readFile(filename)
  .then(buffer => buffer.toString())
  .then(file => file.split('\n'))
  .then(lines => lines[Math.floor(Math.random() * (lines.length - 1))])

const concept = getRandomLine(conceptsFile)
const feature = getRandomLine(languageFeaturesFile)

Promise.all([concept, feature])
  .then(([concept, feature]) =>
    console.log(`let's replace all our ${concept} with ${feature}`))
