# Conduit App with Terraform, Ansible, and GitHub Actions

**React / Vite + SWC / Express.js / Sequelize / PostgreSQL codebase containing real-world examples (CRUD, auth, advanced patterns, etc) that adhere to the RealWorld spec and API, with added Terraform and Ansible deployment, now automated with GitHub Actions.**

This project extends the original Conduit App by adding infrastructure-as-code (Terraform), configuration management (Ansible) capabilities for easy deployment to AWS EC2, and GitHub Actions for automated workflow.

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
├── .github/
│   └── workflows/
│       └── deploy.yml
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

* GitHub account with Actions enabled
* AWS account with configured IAM user for programmatic access
* All prerequisites from the original Conduit app (Node.js, NPM, SQL database)

## Deployment

The deployment process is now fully automated using GitHub Actions. The workflow is triggered manually ("workflow_dispatch") and performs the following steps:

1. Checks out the repository
2. Sets up Terraform
3. Configures AWS CLI with secrets
4. Updates the Terraform backend configuration
5. Sets up SSH for Ansible
6. Initializes and validates Terraform
7. Applies Terraform changes to create/update infrastructure
8. Runs Ansible playbook to deploy the application
9. Uploads the Terraform lock file to S3

### GitHub Secrets

To run the workflow, you need to set up the following secrets in your GitHub repository:

- `AWS_ACCESS_KEY_ID`: Your AWS access key ID
- `AWS_SECRET_ACCESS_KEY`: Your AWS secret access key
- `AWS_REGION`: The AWS region to deploy to
- `BUCKET_NAME`: The name of your S3 bucket for Terraform state
- `STATE_KEY`: The key for your Terraform state file in the S3 bucket
- `EC2_PRIVATE_KEY`: The private key for SSH access to EC2 instances
- `ANSIBLE_VAULT_PASSWORD`: The password to decrypt Ansible vault files

### Running the Workflow

To deploy the application:

1. Go to the "Actions" tab in your GitHub repository
2. Select the "Create infra and deploy app" workflow
3. Click "Run workflow"
4. Monitor the workflow progress and check for any errors

## Manual Steps (if needed)

While the GitHub Actions workflow automates the entire process, you can still perform manual steps if necessary:

### Terraform Setup

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

### Ansible Deployment

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
