
import React, { useState, useEffect } from 'react';
import { useFonts } from 'expo-font';
import { Redirect } from 'expo-router';
import { initializeAppSettings } from '@/services/Locales';
import { getAuth,onAuthStateChanged,User} from '@/services/Firebase';

export default function Page() {
  const [currentUser, setCurrentUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true); // Add a loading stat    
  
  initializeAppSettings();


  useEffect(() => {
    const auth = getAuth(); // Invoking the getter from your Firebase bootstrapping.
    const unsubscribe = onAuthStateChanged(auth, (user) => {
      setCurrentUser(user);
      setLoading(false);
    });

    return () => unsubscribe();
  }, []);

  const [fontsLoaded] = useFonts({
    'Urbanist-Medium': require('./assets/fonts/Urbanist-Medium.ttf'),
    'RoadRage-Regular': require('@/assets/fonts/RoadRage-Regular.ttf'),
    'Urbanist-Regular': require('@/assets/fonts/Urbanist-Regular.ttf'),
    'Urbanist-SemiBold': require('@/assets/fonts/Urbanist-SemiBold.ttf'),
    'Urbanist-Bold': require('@/assets/fonts/Urbanist-Bold.ttf'),
  });

  if (!fontsLoaded) {
    return null; // Or a loading indicator
  }
  // console.log(auth);
  
  if (loading) {
    return null; // Or a loading indicator
  }

  if (currentUser) {
    return <Redirect href="/screens/Index" />; 
  } else {
    return <Redirect href="/auth/Welcome" />; 
  }


}