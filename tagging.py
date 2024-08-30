import subprocess
import sys
from semver import VersionInfo

def get_latest_tag():
    try:
        return subprocess.check_output(['git', 'describe', '--tags', '--abbrev=0']).decode().strip()
    except subprocess.CalledProcessError:
        return '0.0.0'  # If no tags exist, start from 0.0.0

def bump_version(current_version, bump_type):
    v = VersionInfo.parse(current_version)
    if bump_type == 'major':
        return str(v.bump_major())
    elif bump_type == 'minor':
        return str(v.bump_minor())
    elif bump_type == 'patch':
        return str(v.bump_patch())
    else:
        raise ValueError("Invalid bump type. Use 'major', 'minor', or 'patch'.")

def tag_docker_image(image_name, version):
    subprocess.run(['docker', 'tag', f'{image_name}:latest', f'{image_name}:{version}'], check=True)
    print(f"Tagged Docker image: {image_name}:{version}")

def push_docker_image(image_name, version):
    subprocess.run(['docker', 'push', f'{image_name}:{version}'], check=True)
    print(f"Pushed Docker image: {image_name}:{version}")

def main(image_name, bump_type):
    current_version = get_latest_tag()
    new_version = bump_version(current_version, bump_type)
    
    tag_docker_image(image_name, new_version)
    push_docker_image(image_name, new_version)
    
    # Also tag and push as 'latest'
    tag_docker_image(image_name, 'latest')
    push_docker_image(image_name, 'latest')
    
    print(f"Successfully updated {image_name} to version {new_version}")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python script.py <image_name> <bump_type>")
        sys.exit(1)
    
    image_name = sys.argv[1]
    bump_type = sys.argv[2]
    main(image_name, bump_type)
