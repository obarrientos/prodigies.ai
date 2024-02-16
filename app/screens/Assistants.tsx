import React, { useState, useEffect, useRef } from 'react';
import { View, Text, Image, StyleSheet, Pressable, FlatList, Animated } from 'react-native';
import NavigationBar from '@/components/NavigationBar';
import { FontFamily, FontSize, Color, Padding, Border } from "@/globals/Styles";
import { Products } from '@/globals/Products';
import { getRandomText, getRandomDate } from '@/utils/helpers';
import { useNavigation, useRouter } from 'expo-router';
import TranslateCmp from "@/services/Translate";
import { AntDesign } from '@expo/vector-icons';
import {Item} from '@/interfaces/Category';

const Assistants = () => {
    const router = useRouter();
    const navigation = useNavigation();
    const [activeButton, setActiveButton] = useState<'chats' | 'aiAssistants'>('chats'); // 'chats' or 'aiAssistants'
    const opacity = useRef(new Animated.Value(1)).current; // useRef to persist the value without re-initializing on re-renders

    useEffect(() => {
        navigation.setOptions({
            headerShown: true,
            title: TranslateCmp("AIAssistants"),
            headerBackVisible: false,
            headerRight: () => (
                <Pressable
                    style={styles.settingsButton}
                    onPress={() => router.push('../screens/Menu')}
                >
                    <AntDesign name="setting" size={24} color={Color.primaryColor} />
                </Pressable>
            ),
        });
    }, [navigation]);

    const renderItem = ({ item }: { item: Item }) => (
        <Pressable style={styles.itemContainer} onPress={() => {}}>
            <Image style={styles.imageIcon} resizeMode="cover" source={item.image} />
            <View style={styles.itemContent}>
                <Text style={styles.itemTitle}>{item.name}</Text>
                <Text numberOfLines={2} ellipsizeMode="tail" style={styles.itemDescription}>{getRandomText()}</Text>
                <Text style={styles.itemDate}>{getRandomDate()}</Text>
            </View>

            <AntDesign name="arrowright" size={24} color={Color.primaryColor} />
        </Pressable>
    );

    const allItems = Products.reduce<Item[]>((accumulator, category) => {
        return accumulator.concat(category.items);
      }, []);

    const handlePress = (buttonName: 'chats' | 'aiAssistants') => {
        Animated.timing(opacity, {
            toValue: 0,
            duration: 500,
            useNativeDriver: true,
        }).start(() => {
            setActiveButton(buttonName);
            router.replace(buttonName === 'chats' ? '../screens/Index' : '../screens/Chats');
            Animated.timing(opacity, {
                toValue: 1,
                duration: 500,
                useNativeDriver: true,
            }).start();
        });
    };

    return (
        <Animated.View style={{ flex: 1, opacity: opacity }}>
            <FlatList
                data={allItems}
                renderItem={renderItem}
                keyExtractor={(item, index) => index.toString()}
            />
            <NavigationBar selected={() => handlePress(activeButton)} screen={activeButton} />
        </Animated.View>
    );
};
const styles = StyleSheet.create({
    itemContainer: {
        flexDirection: "row",
        alignItems: "center",
        borderRadius: 14,
        backgroundColor: "#fafafa",
        padding: 5,
        marginVertical: 6,
        marginHorizontal: 24,
    },
    imageIcon: {
        width: 43,
        height: 40,
        borderRadius: 100,
    },
    itemContent: {
        flex: 1,
        marginLeft: 10,
    },
    itemTitle: {
        fontSize: 18,
        fontFamily: FontFamily.h4Bold,
        color: Color.greyscale900,
    },
    itemDescription: {
        fontSize: FontSize.bodyMediumRegular_size,
        fontFamily: FontFamily.bodyMediumRegular,
        color: Color.greyscale900,
        paddingRight: 5, // Add some padding to accommodate ellipsis
    },
    itemDate: {
        fontSize: 10,
        fontFamily: FontFamily.bodyMediumRegular,
        color: Color.greyscale900,
        marginTop: 6,
    },
    arrowIcon: {
        width: 24,
        height: 24,
    },
    settingsButton: {
        marginRight: Padding.p_base,
        width: 24,
        height: 24,        
    },
});

export default Assistants;
