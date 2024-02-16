import { SplashScreen, Redirect } from 'expo-router';
import { auth } from '@/services/Firebase';
import { useFonts } from 'expo-font';
import { useCallback } from 'react';



export default function Page() {
  // SplashScreen.preventAutoHideAsync();
  const [fontsLoaded, fontError] = useFonts({
    // 'Urbanist-Light': require('./assets/fonts/Urbanist-Light.ttf'),
    'Urbanist-Medium': require('./assets/fonts/Urbanist-Medium.ttf'),    
    'RoadRage-Regular' : require('@/assets/fonts/RoadRage-Regular.ttf'),
    'Urbanist-Regular' : require('@/assets/fonts/Urbanist-Regular.ttf'),
    'Urbanist-SemiBold': require('@/assets/fonts/Urbanist-SemiBold.ttf'),
    'Urbanist-Bold'    : require('@/assets/fonts/Urbanist-Bold.ttf'),
  });
    
  const onLayoutRootView = useCallback(async () => {
    if (fontsLoaded || fontError) {
      await SplashScreen.hideAsync();
    }
  }, [fontsLoaded,fontError]);

  if (!fontsLoaded && !fontError) {
    return null;
  }

  if (auth) {
    return <Redirect href="./auth/Welcome" />;
  } else{
    return <Redirect href="./auth/SignIn" />;
  }

}