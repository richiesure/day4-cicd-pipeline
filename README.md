# Day 4: CI/CD Pipeline with GitHub Actions

## Project Description
Automated CI/CD pipeline using GitHub Actions to build Docker images and deploy to AWS ECS on every git push.

## What Was Built
- **GitHub Actions Workflow**: Automated pipeline triggered on push to main
- **Build Stage**: Builds Docker image from source code
- **Push Stage**: Pushes image to AWS ECR with git commit SHA tag
- **Deploy Stage**: Updates ECS service with new container image
- **Zero Downtime**: ECS rolling deployment ensures continuous availability

## Architecture
```
Git Push → GitHub Actions → Build Docker → Push to ECR → Deploy to ECS
```

## Pipeline Stages

### 1. Source (GitHub)
- Triggered automatically on push to main branch
- Can also be triggered manually via workflow_dispatch

### 2. Build
- Checks out code from repository
- Builds Docker image using Dockerfile
- Tags with git commit SHA and 'latest'

### 3. Push to ECR
- Authenticates to AWS ECR
- Pushes Docker image to repository
- Both SHA and latest tags pushed

### 4. Deploy to ECS
- Downloads current ECS task definition
- Updates with new image tag
- Deploys to ECS cluster
- Waits for service stability

## Key Features
- ✅ Fully automated (no manual steps)
- ✅ Triggered by git push
- ✅ Zero downtime deployments
- ✅ Version tracking (git SHA)
- ✅ Rollback capability
- ✅ Build logs in GitHub Actions

## GitHub Actions Workflow

Location: `.github/workflows/deploy.yml` (in day3-docker-ecs-deployment repo)

**Secrets Required:**
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`

## Usage

### Trigger Deployment
```bash
# Make any code change
vim app/server.js

# Commit and push
git add .
git commit -m "Update application"
git push origin main

# Pipeline automatically triggers!
```

### View Pipeline Status
- GitHub: https://github.com/richiesure/day3-docker-ecs-deployment/actions
- Check deployment logs in real-time

### Manual Trigger
1. Go to Actions tab in GitHub
2. Select "CI/CD Pipeline" workflow
3. Click "Run workflow" button

## Rollback

If deployment fails or has issues:
```bash
# Find previous working image
aws ecr describe-images --repository-name devops-day3-app --region eu-west-2

# Update ECS service to previous image SHA
aws ecs update-service \
  --cluster devops-day3-cluster \
  --service devops-day3-service \
  --task-definition devops-day3-app:PREVIOUS_REVISION \
  --region eu-west-2
```

## Comparison: GitHub Actions vs AWS CodePipeline

| Feature | GitHub Actions | AWS CodePipeline |
|---------|---------------|------------------|
| Cost | Free (2000 min/month) | Pay per pipeline run |
| Setup | Simple YAML file | Complex IAM + multiple services |
| Account Limits | Generous free tier | New accounts restricted |
| Visibility | Built into GitHub | Separate AWS Console |
| Secrets | GitHub Secrets | AWS Secrets Manager |

## Real-World Improvements

For production,  I will add:
1. **Unit Tests**: Run tests before build
2. **Security Scanning**: Scan Docker images for vulnerabilities
3. **Staging Environment**: Deploy to staging first
4. **Approval Gates**: Manual approval before production
5. **Notifications**: Slack/email on success/failure
6. **Performance Tests**: Load test after deployment
7. **Automated Rollback**: Rollback on health check failures

## Learning Objectives
✅ Understand CI/CD principles
✅ Implement automated deployments
✅ Integrate Git with cloud infrastructure
✅ Practice DevOps workflow
✅ Handle deployment failures

<img width="1915" height="1011" alt="image" src="https://github.com/user-attachments/assets/9240aca4-8ece-4d12-a026-45178f868e8c" />
<img width="1879" height="945" alt="image" src="https://github.com/user-attachments/assets/dafe5fb4-a4b5-4f85-b79f-f35ed8ea8555" />
<img width="1901" height="988" alt="image" src="https://github.com/user-attachments/assets/e309a8c3-aee4-409e-9318-cba019a6299d" />




---

**Author:** IAMEFEMENA (Richiesure)

**Note:** I Initially attempted AWS CodePipeline/CodeBuild but encountered account limits. GitHub Actions proved to be a superior alternative with no restrictions and easier setup.
