import { Text } from 'react-native';
import globalLanguage from '@/globals/Language';

const translations = {
    en: {
      welcome: "Welcome back 👋",
      credentials: "Please enter your email & password to log in.",
      hello: "Hello, how are you?",
      hellothere: "Hello and Welcome 👋",
      orcontinuewith: "or continue with",
      signup: "Sign up",
      signin: "Sign in",
      login: "Log in",
      email: "Email Address",
      password: "Password",
      rememberme: "Remember me",
      forgotpassword : "Forgot password",
      donthaveaccount: "Don’t have an account?",
      alreadyhaveaccount: "Already have an account?",
      pleaseentercredentials: "Please enter your email & password to create an account.",
      publicagreement : "Public Agreement, Terms, & Privacy Policy.",
      iagreeto: "I agree to ",
      continue: "Continue",
      AIAssistants:"Prodigies Assistants",
      
      // More translations...
    },
    es: {
      welcome: "Bienvenido de nuevo 👋",
      credentials: "Por favor, introduce tu correo electrónico y contraseña para iniciar sesión.",
      hello: "Hola, ¿cómo estás?",
      hellothere: "Hola y Bienvenido 👋",
      orcontinuewith: "o continúa con",
      signup: "Registrar Cuenta",
      signin: "Iniciar sesión",
      login: "Iniciar sesión",
      email: "Correo electrónico",
      password: "Contraseña",
      rememberme: "Recuérdame",
      forgotpassword : "Olvidé mi contraseña",
      donthaveaccount: "¿No tienes una cuenta?",
      alreadyhaveaccount: "¿Ya tienes una cuenta?",
      pleaseentercredentials: "Por favor, introduce tu correo electrónico y contraseña para crear una cuenta.",
      publicagreement: "Acuerdo Público, Términos y Política de Privacidad.",
      iagreeto: "Estoy de acuerdo con ",
      continue: "Continuar",
      AIAssistants:"Asistentes Prodigios",
    },
    fr: {
      welcome: "Bienvenue",
      hello: "Bonjour, comment ça va?",
      // More translations...
    },
    // Add more languages here...
  };


  const Translate = (text) => {
    return translations[globalLanguage]?.[text] || translations[globalLanguage]?.[text] || text;
  };

export default Translate;