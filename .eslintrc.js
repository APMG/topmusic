module.exports = {
  "env": {
    "browser": true,
    "commonjs": true,
    "es6": true
  },
  "extends": "eslint:recommended",
  "globals": {
    "define": true // Allows using requirejs 'define' without linting errors
  },
  "parserOptions": {
    "sourceType": "module"
  },
  "rules": {
    "indent": [
      "warn",
      2
    ],
    "linebreak-style": [
      "error",
      "unix"
    ],
    "no-unused-vars": [
      "warn", {
        "args": "all",
        "argsIgnorePattern": "^(require)$",
        "vars": "all",
        "varsIgnorePattern": "^[$]$"
      }
    ],
    "quotes": [
      "error",
      "single"
    ],
    "semi": [
      "error",
      "always"
    ]
  }
};
