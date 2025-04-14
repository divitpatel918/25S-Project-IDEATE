import logging
logger = logging.getLogger(__name__)
import streamlit as st
import requests
from modules.nav import SideBarLinks

SideBarLinks()

member_id = st.text_input("Enter Member Id to view Projects:")
submitted = st.button("Submit Member Id")

if submitted:
 if member_id:
    response = requests.get(f"http://api:4000/m/projects/{member_id}").json()
    if response.status_code == 200:
        st.dataframe(response)
    else:
        st.write("Could not connect to the API, or projects for given member id not found.")
else:
    st.write("Please enter a Member Id.")