import React, { useEffect } from 'react';
import { ScrollView, Text, StyleSheet, Image, View ,TouchableOpacity} from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import { useNavigation, useRouter } from 'expo-router';
import { AntDesign } from '@expo/vector-icons'; // Assuming you use this somewhere
import { FontFamily, FontSize, Color, Padding, Border } from "@/globals/Styles";


const AutoLayoutVertical = () => {
    const navigation = useNavigation();
    const router = useRouter();
    useEffect(() => {
        navigation.setOptions({
            headerShown: true,
            title: 'User Account',
        });
    }, [navigation]);

    return (
        <ScrollView style={styles.container}>

                <TouchableOpacity style={styles.row} onPress={() => {}}> 
                    <Image style={styles.avatar} source={require("@/assets/Iconly/Regular/Outline/Avatar.png")} />
                    <View style={styles.userInfo}>
                        <Text style={styles.username}>Design Picko</Text>
                        <Text style={styles.email}>hello@designpicko.com</Text>
                    </View>
                </TouchableOpacity>
                <LinearGradient
                    style={styles.upgradeSection}
                    colors={["#7e92f8", "#6972f0"]}
                >
                    <TouchableOpacity style={styles.row} onPress={() => { }}> 
                        <Image style={styles.groupIcon} source={require("@/assets/Iconly/Regular/Outline/Group.png")} />
                        <View style={styles.upgradeInfo}>
                            <Text style={styles.upgradeText}>Upgrade to PRO!</Text>
                            <Text style={styles.benefitText}>Enjoy all benefits without restrictions</Text>
                        </View>
                    </TouchableOpacity>
                </LinearGradient>

                <TouchableOpacity style={styles.row} onPress={() => { router.push('../screens/Account') }}> 
                    <Image style={styles.sectionIcon} source={require("@/assets/Iconly/Regular/Outline/Profile.png")} />
                    <Text style={styles.sectionTitle}>Personal Info</Text>
                    <Text style={styles.sectionDescription}></Text>
                    <AntDesign name="right" size={24} color="black" />
                </TouchableOpacity>
                <TouchableOpacity style={styles.row} onPress={() => { }}> 
                    <Image style={styles.sectionIcon} source={require("@/assets/Iconly/Regular/Outline/ShieldDone.png")} />
                    <Text style={styles.sectionTitle}>Security</Text>
                    <Text style={styles.sectionDescription}></Text>
                    <AntDesign name="right" size={24} color="black" />
                </TouchableOpacity>
                <TouchableOpacity style={styles.row} onPress={() => { }}> 
                    <Image style={styles.sectionIcon} source={require("@/assets/Iconly/Regular/Outline/Document.png")} />
                    <Text style={styles.sectionTitle}>Language</Text>
                    <Text style={styles.sectionDescription}>English (US)</Text>
                    <AntDesign name="right" size={24} color="black" />
                </TouchableOpacity>    
                <TouchableOpacity style={styles.row} onPress={() => { }}> 
                    <Image style={styles.sectionIcon} source={require("@/assets/Iconly/Regular/Outline/Show.png")} />
                    <Text style={styles.sectionTitle}>Dark Mode</Text>   
             
                </TouchableOpacity>                              
                <View style={styles.elementssectionDividerDark}>
                    <View style={styles.iconlyregularoutlinearrow} />
                    <Text style={styles.title}>About</Text>
                    <Image style={styles.darkfalseComponentdividerIcon} resizeMode="cover" source={require("@/assets/Iconly/Regular/Outline/Divider.png")} />
                </View>
                <TouchableOpacity style={styles.row} onPress={() => { }}> 
                    <Image style={styles.sectionIcon} source={require("@/assets/Iconly/Regular/Outline/Paper.png")} />
                    <Text style={styles.sectionTitle}>Help Center</Text>
                    <AntDesign name="right" size={24} color="black" />
                </TouchableOpacity>           
                <TouchableOpacity style={styles.row} onPress={() => { }}> 
                    <Image style={styles.sectionIcon} source={require("@/assets/Iconly/Regular/Outline/Lock.png")} />
                    <Text style={styles.sectionTitle}>Privacy Policy</Text>
                    <AntDesign name="right" size={24} color="black" />
                </TouchableOpacity>     
                <TouchableOpacity style={styles.row} onPress={() => { }}> 
                    <Image style={styles.sectionIcon} source={require("@/assets/Iconly/Regular/Outline/InfoSquare.png")} />
                    <Text style={styles.sectionTitle}>About ProdigiesAI</Text>
                    <AntDesign name="right" size={24} color="black" />
                </TouchableOpacity>               
                <TouchableOpacity style={styles.row} onPress={() => { }}> 
                    <Image style={styles.sectionIcon} source={require("@/assets/Iconly/Regular/Outline/Logout.png")} />
                    <Text style={styles.sectionTitle}>Logout</Text>
                </TouchableOpacity>                                                
            <View style={styles.deathSpace}></View>
        </ScrollView>
    );
};

const styles = StyleSheet.create({
    container: {
      flex: 1,
      paddingHorizontal: Padding.p_base, // Use global padding
      backgroundColor: Color.othersWhite, // Use global color
    },
    settingsText: {
      fontSize: FontSize.h4Bold_size, // Use global font size
      fontWeight: "bold",
      flex: 1,
    },
    icon: {
      width: 28,
      height: 28,
    },
    row: {
      flexDirection: "row",
      alignItems: "center",
      paddingVertical: 15, // Use global padding

    },
    avatar: {
      width: 80,
      height: 80,
      borderRadius: Border.br_81xl, // Use global border radius
    },
    userInfo: {
      marginLeft: Padding.p_base, // Use global padding
      flex: 1,
    },
    username: {
      fontSize: FontSize.h5Bold_size, // Use global font size
      fontWeight: "bold", // Assume you meant to use the font weight here
      color: Color.greyscale900, // Use global color
    },
    email: {
      fontSize: FontSize.bodyMediumRegular_size, // Use global font size
      color: Color.greyscale700, // Use global color
    },
    upgradeSection: {
      marginTop: Padding.p_5xs, // Use global padding
      borderRadius: Border.br_base, // Use global border radius
      overflow: "hidden",
    },
    groupIcon: {
      width: 83,
      height: 80,
    },
    upgradeInfo: {
      marginLeft: Padding.p_base, // Use global padding
      flex: 1,
    },
    upgradeText: {
      fontSize: FontSize.h5Bold_size, // Use global font size
      fontWeight: "bold",
      color: Color.white, // Use global color
    },
    benefitText: {
      marginTop: Padding.p_5xs, // Use global padding
      fontSize: FontSize.bodySmallRegular_size, // Use global font size
      color: Color.colorWhitesmoke_100, // Use global color
    },
    elementsSettings: {
      flexDirection: 'row',
      alignItems: 'center',
      paddingVertical: Padding.p_base, // Use global padding
      borderBottomColor: Color.primaryMain100, // Use global color
      height: 60,
    },
    sectionIcon: {
      width: 24,
      height: 24,
      marginRight: Padding.p_base, // Use global padding
    },
    sectionTitle: {
      fontSize: FontSize.bodyLargeSemibold_size, // Use global font size
      fontWeight: 'bold',
      flex: 1,
      color: Color.greyscale700
    },
    sectionDescription: {
      marginRight: Padding.p_base, // Use global padding
      fontSize: FontSize.bodyLargeRegular_size, // Use global font size
    },
    iconlyregularoutlinearrow: {
      width: 24,
      height: 24,
      display: "none"
    },
    title: {
      fontSize: FontSize.bodyMediumRegular_size, // Use global font size
      color: Color.greyscale500, // Use global color
      marginLeft: Padding.p_base, // Use global padding
    },
    darkfalseComponentdividerIcon: {
      maxWidth: "100%",
      overflow: "hidden",
      maxHeight: "100%",
      marginLeft: Padding.p_base, // Use global padding
      flex: 1
    },
    elementssectionDividerDark: {
      width: "100%",
      flexDirection: "row",
      alignItems: "center",
      flex: 1,
      top: 20,
      marginBottom: 30,
    },
    deathSpace: {
        height: 100,
        position: "relative",
        top: 20,
      },

  });
  

export default AutoLayoutVertical;
