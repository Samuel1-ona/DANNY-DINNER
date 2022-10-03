# DANNY-DINER
8 WEEK SQL CHALLENGE

          Introduction ---------------------------------------------------------------------------------------------------------------------------------------------
 
 Danny seriously loves Japanese food so in the beginning of 2021, he decides to embark upon a risky venture and opens up a cute little restaurant that sells his 3 favourite foods: sushi, curry and ramen.

Danny’s Diner is in need of your assistance to help the restaurant stay afloat - the restaurant has captured some very basic data from their few months of operation but have no idea how to use their data to help them run the business.


         Problem Statement --------------------------------------------------------------------------------------------------------------------------------------------        
 Danny wants to use the data to answer a few simple questions about his customers, especially about their visiting patterns, how much money they’ve spent and also which menu items are their favourite. Having this deeper connection with his customers will help him deliver a better and more personalised experience for his loyal customers.

He plans on using these insights to help him decide whether he should expand the existing customer loyalty program - additionally he needs help to generate some basic datasets so his team can easily inspect the data without needing to use SQL.

Danny has provided you with a sample of his overall customer data due to privacy issues - but he hopes that these examples are enough for you to write fully functioning SQL queries to help him answer his questions!

Danny has shared with you 3 key datasets for this case study:

#sales
#menu
#members


      Table 1: sales ---------------------------------------------------------------------------------------------------------------------------------------------------
      
 The sales table captures all (customer_id) level purchases with an corresponding (order_date) and (product_id) information for when and what menu items were ordered. 
 
     Table 2: menu ----------------------------------------------------------------------------------------------------------------------------------------------------
     
 The menu table maps the (product_id) to the actual (product_name) and (price) of each menu item.
 
     Table 3: members
     
 The final members table captures the (join_date) when a (customer_id) joined the beta version of the Danny’s Diner loyalty program.    
 
                                                                Case Study Questions
                                                                
                                                                
  Each of the following case study questions can be answered using a single SQL statement:

#.What is the total amount each customer spent at the restaurant?

#.How many days has each customer visited the restaurant?

#.What was the first item from the menu purchased by each customer?

#.What is the most purchased item on the menu and how many times was it purchased by all customers?

#.Which item was the most popular for each customer?

#.Which item was purchased first by the customer after they became a member?

#.Which item was purchased just before the customer became a member?

#.What is the total items and amount spent for each member before they became a member?

#.If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?

#.In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?          

                                                               Official Solutions  
                                                               
  The following topics relevant to the Danny’s Diner case study are covered lots of depth in the Serious SQL course:

1.Common Table Expressions
2.Group By Aggregates
3.Window Functions for ranking
4.Table Joins         


                                                               INSIGHT 
                                                               
     #.What is the total amount each customer spent at the restaurant?


![TOTAL SALES FOR EACH CUSTOMER](https://user-images.githubusercontent.com/68438893/193555023-39aa0a10-c033-405c-8d3e-8d2bbd822069.png)



#.How many days has each customer visited the restaurant?

![VISITED](https://user-images.githubusercontent.com/68438893/193555863-7ca79877-7d82-4b15-8d04-e49fd7d57a7b.png)


#.What was the first item from the menu purchased by each customer?

![FIRST ITEM](https://user-images.githubusercontent.com/68438893/193556757-d10e4f27-ba86-46d6-9fd6-9593b36bccc5.png)


#.What is the most purchased item on the menu and how many times was it purchased by all customers?

![MOST PURCHASED](https://user-images.githubusercontent.com/68438893/193557430-cec2eabc-933a-4154-8b43-bdbd5b5efcc5.png)


#.Which item was the most popular for each customer?

![MOST POPULAR](https://user-images.githubusercontent.com/68438893/193558136-44ab43ee-f4c2-4774-834d-a24325526c87.png)


#.Which item was purchased first by the customer after they became a member?

![ORDER ITEM AFTER JOINING](https://user-images.githubusercontent.com/68438893/193558793-fb564f13-7f4c-4c52-892b-9113ea6f7b93.png)


#.Which item was purchased just before the customer became a member?
![BEFORE JOINING](https://user-images.githubusercontent.com/68438893/193559405-f42e5f3a-ee2a-4a43-9a75-c7c024c223d2.png)


#.What is the total items and amount spent for each member before they became a member?

![TOTAL ITEM AND AMOUNT SPENT](https://user-images.githubusercontent.com/68438893/193559993-3bcbc81e-bdbf-4cfd-abae-990e965832a7.png)


#.If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?

![TOTAL POINT](https://user-images.githubusercontent.com/68438893/193560469-6f5d154e-3e72-4f69-85fd-92724925b1af.png)

