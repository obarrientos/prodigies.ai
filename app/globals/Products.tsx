import { Category } from "@/interfaces/Category";

export const Products: Category[] = [
    {
        category: 'Management',
        items: [
            { name: 'Ochoa', description: 'Secretary', image: require('../assets/ochoa.png'), onPressPath: './Content' },
            { name: 'Socrates', description: 'Project Manager', image: require('../assets/socrates.png'), onPressPath: './Content' },
            
            
            // { name: 'Montessori', description: 'Innovative Learning Strategies', image: require('../assets/montessori.png'), onPressPath: './Content' },
            // { name: 'Ada', description: 'Cybersecurity Awareness', image: require('../assets/ada.png'), onPressPath: './Content' },
            // { name: 'Chinua', description: 'History Guide', image: require('../assets/chinua.png'), onPressPath: './Content' },
            // { name: 'Tagore', description: 'Language Tutor', image: require('../assets/tagore.png'), onPressPath: './Content' },
            // { name: 'Torvalds', description: 'Coding Mentor', image: require('../assets/torvalds.png'), onPressPath: './Content' },
        ],
    },
    {
        category: 'Communication',
        items: [
            { name: 'Hemingway', description: 'Copywriter', image: require('../assets/hemingway.png'), onPressPath: './Content' },
            { name: 'Babel', description: 'Translator', image: require('../assets/babel.png'), onPressPath: './Content' },
    
            // { name: 'Solon', description: 'Legal Guidance', image: require('../assets/solon.png'), onPressPath: './Content' },
            // { name: 'Demosthenes', description: 'Public Speaking Coach', image: require('../assets/demosthenes.png'), onPressPath: './Content' },
        ],
    },
    {
        category: 'Sales',
        items: [
            // { name: 'Li', description: 'Accounts Receivable Clerk', image: require('../assets/li.png'), onPressPath: './Content' },
            { name: 'Plato', description: 'Accounts Receivables', image: require('../assets/plato.png'), onPressPath: './Content' },
            // { name: 'Erik', description: 'Visual Assistant', image: require('../assets/erik.png'), onPressPath: './Content' },
            { name: 'Hippocrates', description: 'Customer Service', image: require('../assets/hippocrates.png'), onPressPath: './Content' },
            // { name: 'Freud', description: 'Mental Wellness and Mindfulness', image: require('../assets/freud.png'), onPressPath: './Content' },
            // { name: 'Garvin', description: 'Chef Assistant', image: require('../assets/garvin.png'), onPressPath: './Content' },
            // { name: 'Li', description: 'Fitness Coach', image: require('../assets/li.png'), onPressPath: './Content' },
        ],
    },    
    {
        category: 'Financial',
        items: [
            { name: 'Chase', description: 'Accountant Assistant', image: require('../assets/hamilton.png'), onPressPath: './Content' },
            { name: 'Smith', description: 'Financial Analyst', image: require('../assets/smith.png'), onPressPath: './Content' },            
            // { name: 'Smith', description: 'Finance Advisor', image: require('../assets/smith.png'), onPressPath: './Content' },
            // { name: 'Hamilton', description: 'Debt Management', image: require('../assets/hamilton.png'), onPressPath: './Content' },
            // { name: 'Graham', description: 'Retirement Planning', image: require('../assets/graham.png'), onPressPath: './Content' },
            // { name: 'Franklin', description: 'Budgeting and Expense Tracking', image: require('../assets/franklin.png'), onPressPath: './Content' },
            // { name: 'Keynes', description: 'Savings Optimization', image: require('../assets/keynes.png'), onPressPath: './Content' },
        ],
    },
    {
        category: 'Technology',
        items: [
            // { name: 'Braile', description: 'Assistive Reading', image: require('../assets/braille.png'), onPressPath: './Content' },
            // { name: 'Erik', description: 'Visual Context', image: require('../assets/erik.png'), onPressPath: './Content' },
            // { name: 'Hippocrates', description: 'Personal Health and Wellness', image: require('../assets/hippocrates.png'), onPressPath: './Content' },
            // { name: 'Freud', description: 'Mental Wellness and Mindfulness', image: require('../assets/freud.png'), onPressPath: './Content' },
            { name: 'Garvin', description: 'IT Support', image: require('../assets/garvin.png'), onPressPath: './Content' },
            // { name: 'Li', description: 'Fitness Coach', image: require('../assets/li.png'), onPressPath: './Content' },
            { name: 'Curie', description: 'Data Research', image: require('../assets/curie.png'), onPressPath: './Content' },
        ],
    },        
    
    {
        category: 'Supply Chain',
        items: [
            { name: 'Bell', description: 'Inventory Manager', image: require('../assets/bell.png'), onPressPath: './Content' },
            // { name: 'Li', description: 'Inventory Manager', image: require('../assets/li.png'), onPressPath: './Content' },
            // { name: 'Erik', description: 'Visual Assistant', image: require('../assets/erik.png'), onPressPath: './Content' },
            { name: 'Branson', description: 'Accounts Payables', image: require('../assets/branson.png'), onPressPath: './Content' },   
            // { name: 'Hippocrates', description: 'Accounts Payables Clerk', image: require('../assets/hippocrates.png'), onPressPath: './Content' },
            // { name: 'Freud', description: 'Mental Wellness and Mindfulness', image: require('../assets/freud.png'), onPressPath: './Content' },
            // { name: 'Garvin', description: 'Chef Assistant', image: require('../assets/garvin.png'), onPressPath: './Content' },
            // { name: 'Li', description: 'Fitness Coach', image: require('../assets/li.png'), onPressPath: './Content' },
        ],
    },       
    {
        category: 'Marketing',
        items: [
           
            // { name: 'Turing', description: 'Document Analysis', image: require('../assets/turing.png'), onPressPath: './Content' },
            // { name: 'Curie', description: 'Data Research', image: require('../assets/curie.png'), onPressPath: './Content' },
            // { name: 'Ogilvy', description: 'Sales Optimization and CRM Management', image: require('../assets/ogilvy.png'), onPressPath: './Content' },
            // { name: 'Branson', description: 'Feedback Analysis and Response', image: require('../assets/branson.png'), onPressPath: './Content' },
            { name: 'Warhol', description: 'Social Media Expert', image: require('../assets/warhol.png'), onPressPath: './Content' },
            { name: 'Bernbach', description: 'Marketing Assistant', image: require('../assets/bernbach.png'), onPressPath: './Content' },
        ],
    },    

    {
        category: 'Bussiness Analyst',
        items: [
            { name: 'Turing', description: 'Bussiness Analyst', image: require('../assets/turing.png'), onPressPath: './Content' },            
            { name: 'Edison', description: 'Problem Solver', image: require('../assets/edison.png'), onPressPath: './Content' },
        //     { name: 'Ogilvy', description: 'Sales Optimization and CRM Management', image: require('../assets/ogilvy.png'), onPressPath: './Content' },

        //     { name: 'Warhol', description: 'Social Media Management and Strategy', image: require('../assets/warhol.png'), onPressPath: './Content' },
        //     { name: 'Bernbach', description: 'Marketing Strategy and Planning', image: require('../assets/bernbach.png'), onPressPath: './Content' },
        ],
    },
    {
        category: 'Legal',
        items: [
            { name: 'Solon', description: 'Legal Advisor', image: require('../assets/solon.png'), onPressPath: './Content' },
            { name: 'Helen', description: 'Contract Manager', image: require('../assets/helen.png'), onPressPath: './Content' },            
            
        ],
    },
    {
        category: 'Human Resources',
        items: [
            { name: 'Carnegie', description: 'HR Manager', image: require('../assets/carnegie.png'), onPressPath: './Content' },
            { name: 'Marco Polo', description: 'Event Planner', image: require('../assets/marcopolo.png'), onPressPath: './Content' },            
            

        ],
    },    
 
    {
        category: 'Accesibility',
        items: [
            { name: 'Braile', description: 'Assistive Reading', image: require('../assets/braille.png'), onPressPath: './Content' },
            { name: 'Erik', description: 'Visual Assistant', image: require('../assets/erik.png'), onPressPath: './Content' },
            // { name: 'Hippocrates', description: 'Personal Health and Wellness', image: require('../assets/hippocrates.png'), onPressPath: './Content' },
            // { name: 'Freud', description: 'Mental Wellness and Mindfulness', image: require('../assets/freud.png'), onPressPath: './Content' },
            // { name: 'Garvin', description: 'Chef Assistant', image: require('../assets/garvin.png'), onPressPath: './Content' },
            
        ],
    },    

];