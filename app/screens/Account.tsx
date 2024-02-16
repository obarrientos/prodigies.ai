import React, { useEffect } from 'react';
import { StyleSheet, Text, ScrollView, View , TouchableOpacity} from "react-native";
import { Color, FontSize, Padding } from "@/globals/Styles";
import { useNavigation } from 'expo-router';
import { Formik } from 'formik';
import * as Yup from 'yup';
import { useRouter } from 'expo-router';
import ButtonCmp from "@/components/Button";
import TextInputCmp from "@/components/TextField";
import PhoneInputCmp from "@/components/Phone";
import ListCmp from "@/components/List";
import DatePickerCmp from "@/components/DatePicker";
import TranslateCmp from "@/services/Translate";
import { AntDesign } from '@expo/vector-icons'; // Assuming you use this somewhere

const validationSchema = Yup.object().shape({
  name: Yup.string().required('Full Name is required'),
  phone: Yup.string().required('Phone Number is required'),
  gender: Yup.string().required('Gender is required'),
  dob: Yup.date().required('Date of Birth is required'),
});

const Account = () => {
  const router = useRouter();
  const navigation = useNavigation();
  const [nameValue, setNameValue] = React.useState('');
  const [phoneValue, setPhoneValue] = React.useState('');
  const [genderValue, setGenderValue] = React.useState('');
  const [dateValue, setDOBValue] = React.useState(new Date());

  useEffect(() => {
    navigation.setOptions({
        headerShown: true,
        title: TranslateCmp("AIAssistants"),
        headerBackVisible: false,
        headerLeft: () => (
          <TouchableOpacity
              style={styles.settingsButton}
              onPress={() => router.back()}
          >
              <AntDesign name="arrowleft" size={24} color={Color.primaryColor} />
          </TouchableOpacity>
      ),
        headerRight: () => (
            <TouchableOpacity
                style={styles.settingsButton}
                onPress={() => router.replace('../screens/Menu')}
            >
                <AntDesign name="setting" size={24} color={Color.primaryColor} />
            </TouchableOpacity>
        ),
        
    });
}, [navigation]); 
  return (
    <ScrollView style={styles.container}>
      <Formik
        initialValues={{
          name: '',
          phone: '',
          gender: '',
          dob: new Date(),
        }}
        validationSchema={validationSchema}
        onSubmit={(values) => {
          // Handle form submission
          console.log(values);
          // Navigate to the next screen or perform other actions
          // navigation.navigate("@/screens/Index");
          router.replace(require('@/screens/Index'));
        }}
      >
        {({ handleChange, handleBlur, handleSubmit, values, errors }) => (
          <>
            <Text style={styles.Title}>Complete your profile</Text>
            <Text style={styles.SubTitle}>{`Please enter your profile. Don't worry, only you can see your personal data. No one else will be able to see it. Or you can skip it for now.`}</Text>
            <TextInputCmp label="Full Name" value={nameValue} onChange={setNameValue} />
            <PhoneInputCmp label="Phone Number" value={phoneValue} onChange={setPhoneValue} />
            <ListCmp label="Gender" value={genderValue} onChange={setGenderValue} />
            <DatePickerCmp label="Date of Birth" value={dateValue} onChange={setDOBValue} />
            <View style={styles.buttonPosition}><ButtonCmp label="Continue" onPress="../../screens/auth/ProfileScreen" disabled={false} /></View>
            <View style={styles.deathSpace}></View>
          </>
        )}
      </Formik>
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    flexDirection: 'column', // This is actually the default and can be omitted
    // alignItems: "flex-start", // To align items horizontally in the center
    //justifyContent: 'center', // To align items vertically in the center
    flex: 1, // Optional, for the container to take the full height of the screen
    backgroundColor: Color.othersWhite,
    padding: Padding.p_base
  },


  Title: {
    fontSize: FontSize.h3Bold_size,
    height: 60,
  },
  SubTitle: {
    fontSize: FontSize.bodyLargeSemibold_size,
    height: 100,

  },

  buttonPosition: {
    top: 30,
    height: 100
  },
  deathSpace: {
    height: 100,
    position: "relative",
    top: 20,
  },
  settingsButton: {
    marginRight: Padding.p_base,
    width: 24,
    height: 24,        
},
});

export default Account;
