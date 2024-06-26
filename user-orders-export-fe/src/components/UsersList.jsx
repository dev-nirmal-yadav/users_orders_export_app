import React, { useState, useEffect } from 'react';
import axios from 'axios';
import './UsersList.css';
import { createConsumer } from "@rails/actioncable";

const UsersList = () => {
  const [users, setUsers] = useState([]);
  const [message, setMessage] = useState('');
  const BASE_URL = 'http://localhost:3000'

  useEffect(() => {
    axios.get(`${BASE_URL}/api/users`)
      .then(response => {
        setUsers(response.data);
      })
      .catch(error => {
        console.error('Error fetching users: ', error);
      });

    // Initialize Action Cable connection
    const cable = createConsumer('ws://localhost:3000/cable');
    const subscription = cable.subscriptions.create('CsvGenerationChannel', {
      connected() {
        console.log('Connected to Action Cable');
      },
      disconnected() {
        console.log('Disconnected from Action Cable');
      },
      received(data) {
        setMessage(data.message);
        if (data.message.includes('is ready') && data.username) {
          console.log(data.username)
          window.location.href = `http://localhost:3000/api/users/${data.username}/download_csv`;
        }
      }
    });

    return () => {
      subscription.unsubscribe();
    };
  }, []);

  const handleDownload = (userId) => {
    axios.get(`${BASE_URL}/api/users/${userId}/generate_orders_csv`)
      .then(response => {
        setMessage(response.data.message);
      })
      .catch(error => {
        console.error('Error starting CSV generation: ', error);
      });
  };

  return (
    <div className="user-list-container">
      <h1>Users List</h1>
      <p>{message}</p>
      <table className="user-table">
        <thead>
          <tr>
            <th>Username</th>
            <th>Email</th>
            <th>Download (csv)</th>
          </tr>
        </thead>
        <tbody>
          {users.map(user => (
            <tr key={user.id}>
              <td>{user.username}</td>
              <td>{user.email}</td>
              <td><button onClick={() => handleDownload(user.id, user.username)}>Download</button></td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default UsersList;