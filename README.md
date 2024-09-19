# Conduit App with Terraform and Ansible

> **React / Vite + SWC / Express.js / Sequelize / PostgreSQL codebase containing real world examples (CRUD, auth, advanced patterns, etc) that adheres to the [RealWorld](https://realworld.io/) spec and API, with added Terraform and Ansible deployment.**

This project extends the original Conduit App by adding infrastructure-as-code (Terraform) and configuration management (Ansible) capabilities for easy deployment to AWS EC2.

## Project Structure

```
conduit-app/
├── ansible/
│   ├── templates/
│   │   ├── conduit-app.service.j2
│   │   └── nginx.conf.j2
│   ├── vars/
│   │   ├── env_dev.yml
│   │   ├── main.yml
│   │   └── vault.yml
│   ├── inventory.ini
│   └── main.yml
├── backend/
├── frontend/
├── terraform/
│   ├── .terraform/
│   ├── .terraform.lock.hcl
│   ├── main.tf
│   ├── provider.tf
│   ├── setup.sh
│   ├── variables.tf
│   └── vpc.tf
├── .gitignore
├── CODE_OF_CONDUCT.md
├── LICENSE
├── logo.png
├── package-lock.json
├── package.json
├── README.md
└── vitest.config.js
```

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- AWS account and configured AWS CLI
- All prerequisites from the original Conduit app (Node.js, NPM, SQL database)

## Deployment

### 1. Terraform Setup

1. Navigate to the `terraform` directory:
   ```
   cd terraform
   ```

2. Initialize Terraform:
   ```
   terraform init
   ```

3. Review and apply the Terraform configuration:
   ```
   terraform plan
   terraform apply
   ```

This will create an EC2 instance on AWS and generate an Ansible inventory file.

### 2. Ansible Deployment

After Terraform has provisioned the EC2 instance, Ansible will automatically run to configure the server and deploy the application.

If you need to run Ansible manually:

1. Navigate to the `ansible` directory:
   ```
   cd ~/conduit-app/ansible
   ```

2. Run the Ansible playbook:
   ```
   ansible-playbook -i inventory.ini main.yml -e 'env=dev' --ask-vault-pass -v
   ```

## Original Conduit App Setup

### For local development and more details about the Conduit app itself, please refer to the [original README](#original-readme).
---

<a name="original-readme"></a>

## Original README Content

## Getting Started

These instructions will help you install and run the project on your local machine for development and testing.

### Prerequisites

Before you run the project, make sure that you have the following tools and software installed on your computer:

- Text editor/IDE (e.g., VS Code, Sublime Text, Atom)
- [Git](https://git-scm.com/downloads)
- [Node.js](https://nodejs.org/en/download/) `v18.11.0+`
- [NPM](https://www.npmjs.com/) (usually included with Node.js)
- SQL database

### Installation

To install the project on your computer, follow these steps:

1. Clone the repository to your local machine.

   ```bash
   git clone https://github.com/TonyMckes/conduit-app
   ```

2. Navigate to the project directory.

   ```bash
   cd conduit-app
   ```

3. Install project dependencies by running the command:

   ```bash
   npm install
   ```

### Configuration

1. Create a `.env` file in the root directory of the project
2. Add the required environment variables as specified in the [`.env.example`](backend/.env.example) file
3. (Optional) update the Sequelize configuration parameters in the [`config.js`](backend/config/config.js) file
4. If you are **not** using PostgreSQL, you may also have to install the driver for your database:

   <details>
   <summary>Use one of the following commands to install:</summary><br/>

   > Note: `-w backend` option is used to install it in the backend [`package.json`](backend/package.json).

   ```bash
   npm install -w backend pg pg-hstore  # Postgres (already installed)
   npm install -w backend mysql2
   npm install -w backend mariadb
   npm install -w backend sqlite3
   npm install -w backend tedious       # Microsoft SQL Server
   npm install -w backend oracledb      # Oracle Database
   ```

   > :information_source: Visit [Sequelize - Installing](https://sequelize.org/docs/v6/getting-started/#installing) for more infomation.

   ***

   </details>

5. Create database specified by configuration by executing

   > :warning: Please, make sure you have already created a superuser for your database.

   ```bash
   npm run sqlz -- db:create
   ```

   > :information_source: The command `npm run sqlz` is an alias for `npx -w backend sequelize-cli`.  
   > Execute `npm run sqlz -- --help` to see more of `sequelize-cli` commands availables.

6. Optionally you can run the following command to populate your database with some dummy data:

   ```bash
   npm run sqlz -- db:seed:all
   ```

### Usage

#### Development Server

To run the project, follow these steps:

1. Start the development server by executing the command:

   ```bash
   npm run dev
   ```

2. Open a web browser and navigate to:
   - Home page should be available at [`http://localhost:3000/`](http://localhost:3000).
   - API endpoints should be available at [`http://localhost:3001/api`](http://localhost:3001/api).

#### Running Tests

To run tests, simply run the following command:

```bash
npm run test
```

#### Production

The following command will build the production version of the app:

```bash
npm run start
```

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [RealWorld](https://realworld.io/)
- [RealWorld (GitHub)](https://github.com/gothinkster/realworld)
- [CodebaseShow](https://codebase.show/)
- [How to write a Good readme](https://bulldogjob.com/news/449-how-to-write-a-good-readme-for-your-github-project)
