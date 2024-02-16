import React, { useState,useEffect } from 'react';
import { StyleSheet, View, Text, TouchableOpacity} from "react-native";
import { useNavigation } from 'expo-router';
import { Padding, Border, FontSize, Color, FontFamily } from "@/globals/Styles";
import {Chat, Categories} from '@/assets/icons';
import { useRouter } from 'expo-router';
const NavigationBar = ({selected,screen}) => {
    const router = useRouter();
    const navigation = useNavigation();
    
    return (
        <View style={styles.bottomNavigationBar}>
            
            <TouchableOpacity style={styles.navButton} onPress={() => selected('chats')}>
                <Chat isActive={screen === 'chats'} />
                <Text style={[styles.navLabel, screen === 'chats' ? styles.navLabelActive : null]}>Chats</Text>
            </TouchableOpacity>

            <TouchableOpacity style={styles.navButtonActive} onPress={() => selected('aiAssistants')}>
                <Categories isActive={screen === 'aiAssistants'} />
                <Text style={[styles.navLabel, screen === 'aiAssistants' ? styles.navLabelActive : null]}>AI Assistants</Text>
            </TouchableOpacity>

        </View>
    );
};
const styles = StyleSheet.create({

    bottomNavigationBar: {
        flexDirection: "row",
        backgroundColor: Color.white,
        shadowColor: Color.transparentBlack,
        height: 80,
        // alignItems: "center",
        justifyContent: "space-around",
        paddingTop:Padding.p_8xs,
        
    },
    navButton: {
        alignItems: "center",
    },
    navButtonActive: {
        alignItems: "center",
    },
    navLabel: {
        top:2,
        fontFamily: FontFamily.h6Medium,
        color: Color.greyscale500,
        fontSize: FontSize.bodySmallRegular_size,
    },
    navLabelActive: {
        top:2,
        fontFamily: FontFamily.h6Bold,
        color: Color.primaryColor,
        fontSize: FontSize.bodySmallRegular_size,
    },
});

export default NavigationBar;