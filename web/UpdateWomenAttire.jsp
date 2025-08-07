<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Men's Attire</title>
    <link href="https://fonts.googleapis.com/css2?family=Raleway:wght@400;500;700&family=Poppins:wght@400;600&display=swap" rel="stylesheet">

    <style>
        /* Same styles as before */
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(45deg, #FF6F61, #f5f7fa);
            height: 100vh;
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
            background-size: 400% 400%;
            animation: gradientBackground 10s ease infinite;
        }

        @keyframes gradientBackground {
            0% {
                background-position: 0% 50%;
            }
            50% {
                background-position: 100% 50%;
            }
            100% {
                background-position: 0% 50%;
            }
        }

        .container {
            width: 100%;
            max-width: 600px;
            background: #fff;
            padding: 20px 30px;
            border-radius: 15px;
            box-shadow: 0 15px 45px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease-in-out;
            position: relative;
            box-sizing: border-box;
        }

        .container:hover {
            transform: scale(1.05);
        }

        h1 {
            font-size: 22px;
            font-weight: 700;
            color: #333;
            text-align: center;
            margin-bottom: 20px;
            word-wrap: break-word;
            white-space: normal;
        }

        form {
            margin-top: 20px;
        }

        label {
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 8px;
            display: block;
            color: #444;
        }

        input, select, textarea {
            width: 100%;
            padding: 12px;
            margin-bottom: 15px;
            border: 2px solid #ddd;
            border-radius: 10px;
            font-size: 14px;
            background-color: #f9f9f9;
            box-sizing: border-box;
            transition: border-color 0.3s ease;
        }

        input:focus, select:focus, textarea:focus {
            border-color: #FF6F61;
            outline: none;
        }

        input[type="file"] {
            border: none;
            padding: 10px;
            background-color: #f0f0f0;
        }

        button {
            width: 100%;
            padding: 12px;
            background: #FF6F61;
            border: none;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 600;
            color: white;
            cursor: pointer;
            transition: background 0.3s, transform 0.3s;
        }

        button:hover {
            background: #e05b4f;
            transform: translateY(-3px);
        }

        .form-footer {
            font-size: 13px;
            color: #777;
            text-align: center;
            margin-top: 20px;
        }

        .form-footer a {
            color: #FF6F61;
            text-decoration: none;
        }

        .form-footer a:hover {
            text-decoration: underline;
        }

        .input-group {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            justify-content: space-between;
        }

        .input-group div {
            width: 48%;
        }

        @media screen and (max-width: 768px) {
            .container {
                padding: 15px;
            }

            .input-group div {
                width: 100%;
            }

            h1 {
                font-size: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Update Attire</h1>
        <form id="attireForm" action="updateWomenServlet" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
            <div class="input-group">
                <div>
                    <label for="id">Attire ID:</label>
                    <input type="number" id="id" name="id" required placeholder="Enter attire id">
                </div>
                <div>
                    <label for="name">Attire Name:</label>
                    <input type="text" id="name" name="name" required placeholder="Enter attire name">
                </div>
                <div>
                    <label for="price">Price (₹):</label>
                    <input type="number" id="price" name="price" step="0.01" min="0" required placeholder="Enter price">
                </div>
            </div>

            <div class="input-group">
                <div>
                    <label for="description">Description:</label>
                    <textarea id="description" name="description" rows="3" required placeholder="Enter attire description"></textarea>
                </div>
                <div>
                    <label for="category">Category:</label>
                    <select id="category" name="category" required onchange="updateSubcategories(this.value)">
                        <option value="" disabled selected>Select a category</option>
                        <option value="2">Women's</option>
                    </select>
                </div>
            </div>

            <div class="input-group">
                <div>
                    <label for="subcategory_id">Subcategory:</label>
                    <select id="subcategory_id" name="subcategory_id" required>
                        <option value="" disabled selected>Select a subcategory</option>
                    </select>
                </div>
                <div>
                    <label for="status">Status:</label>
                    <select id="status" name="status" required>
                        <option value="" disabled selected>Select status</option>
                        <option value="Available">Available</option>
                        <option value="Not Available">Not Available</option>
                    </select>
                </div>
            </div>

            <div class="input-group">
                <div>
                    <label for="size">Size:</label>
                    <select id="size" name="size" required>
                        <option value="" disabled selected>Select Your Size</option>
                        <option value="S">S</option>
                        <option value="M">M</option>
                        <option value="L">L</option>
                        <option value="XL">XL</option>
                        <option value="Free">Free</option>
                    </select>
                </div>
                <div>
                    <label for="duration">Duration (days):</label>
                    <input type="number" id="duration" name="duration" min="1" required placeholder="Enter rental duration">
                </div>
            </div>

            <div class="input-group">
                <div>
                    <label for="deposit">Deposit (₹):</label>
                    <input type="number" id="deposit" name="deposit" step="0.01" min="0" required placeholder="Enter deposit amount">
                </div>
                <div style="width: 100%;"><label for="img">Upload Image:</label><input type="file" id="img" name="img" accept="image/*" required></div>
            </div>

            <button type="submit">Update Attire</button>
        </form>
        <div class="form-footer">
            <p>Need help? <a href="contact.jsp">Contact Support</a></p>
        </div>
    </div>

    <script>
        function validateForm() {
            const fileInput = document.getElementById("img");
            const file = fileInput.files[0];
            if (file && file.size > 5 * 1024 * 1024) {
                alert("File size must not exceed 5MB.");
                return false;
            }
            return true;
        }

        function updateSubcategories(category) {
            const subcategorySelect = document.getElementById('subcategory_id');
            subcategorySelect.innerHTML = '<option value="" disabled selected>Select a subcategory</option>';

            let subcategories = [];

            // Men’s subcategories
            if (category === '2') {
                subcategories = [
                    { id: 1, name: 'Lehenga' },
                    { id: 2, name: 'Gowns' },
                    { id: 3, name: 'Anarkalis' },
                    { id: 4, name: 'Indowestern' },
                    { id: 5, name: 'Navaratri Dresses' },
                    { id: 6, name: 'Sarees' },
                    { id: 7, name: 'Blouses' },
                    { id: 8, name: 'Jewelry' }
                ];
            }

            // Populate the subcategory dropdown
            subcategories.forEach(subcategory => {
                const option = document.createElement('option');
                option.value = subcategory.id;  // Subcategory ID
                option.text = subcategory.name; // Subcategory Name
                subcategorySelect.appendChild(option);
            });
        }
    </script>
</body>
</html>
