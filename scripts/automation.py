
import argparse
import subprocess
import sys


def run_ps(command: str):

    full_cmd = ["powershell.exe", "-Command", command]
    print("+", " ".join(full_cmd))

    proc = subprocess.run(
        full_cmd,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        text=True
    )

    print(proc.stdout)

    if proc.returncode != 0:
        print(f" ERROR running command: {command}", file=sys.stderr)
        sys.exit(proc.returncode)


def dataset_exists(project_id: str, dataset_id: str) -> bool:

    target = f"{project_id}:{dataset_id}"
    cmd = ["powershell.exe", "-Command", f"bq show --format=none {target}"]
    check = subprocess.run(
        cmd,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True
    )
    return check.returncode == 0


def create_dataset(project_id: str,
                   dataset_id: str,
                   location: str,
                   default_table_expiration_ms: int = None,
                   default_partition_expiration_ms: int = None,
                   default_view_expiration_ms: int = None,
                   description: str = None,
                   labels: dict = None):


    target = f"{project_id}:{dataset_id}"
    print(f"\n Checking dataset: {target}")

    if dataset_exists(project_id, dataset_id):
        print(" Dataset already exists. Skipping creation.")
        return

    print(f" Creating dataset: {target}")

    mk_parts = [f"bq --location={location} mk --dataset"]


    if description:
        mk_parts.append(f'--description "{description}"')


    if default_table_expiration_ms is not None:
        mk_parts.append(f"--default_table_expiration {default_table_expiration_ms}")
    if default_partition_expiration_ms is not None:
        mk_parts.append(f"--default_partition_expiration {default_partition_expiration_ms}")
    if default_view_expiration_ms is not None:
        mk_parts.append(f"--default_view_expiration {default_view_expiration_ms}")


    if labels:
        label_str = ",".join([f"{k}={v}" for k, v in labels.items()])
        mk_parts.append(f"--label {label_str}")

    mk_parts.append(target)
    run_ps(" ".join(mk_parts))

    print(f" Dataset created successfully: {target}")
    print(f" Location: {location}")
    if any(x is not None for x in [default_table_expiration_ms, default_partition_expiration_ms, default_view_expiration_ms]):
        print(" Default expirations applied (ms): "
              f"table={default_table_expiration_ms}, "
              f"partition={default_partition_expiration_ms}, "
              f"view={default_view_expiration_ms}")


def main():
    parser = argparse.ArgumentParser(description="BigQuery Dataset Automation Script")
    parser.add_argument("--project", required=True, help="GCP Project ID")
    parser.add_argument("--dataset", required=True, help="BigQuery Dataset ID (no project prefix)")
    parser.add_argument("--location", default="asia-south1", help="Dataset location (e.g., asia-south1, us, eu)")
    parser.add_argument("--description", default=None, help="Dataset description")
    parser.add_argument("--labels", nargs="*", help="Labels as key=value pairs (space-separated). Example: env=dev team=data")
    parser.add_argument("--default_table_expiration_ms", type=int, default=None,
                        help="Default table expiration in milliseconds (optional)")
    parser.add_argument("--default_partition_expiration_ms", type=int, default=None,
                        help="Default partition expiration in milliseconds (optional)")
    parser.add_argument("--default_view_expiration_ms", type=int, default=None,
                        help="Default view expiration in milliseconds (optional)")
    args = parser.parse_args()


    labels_dict = None
    if args.labels:
        labels_dict = {}
        for kv in args.labels:
            if "=" not in kv:
                print(f" Invalid label format '{kv}'. Expected key=value.", file=sys.stderr)
                sys.exit(2)
            k, v = kv.split("=", 1)
            labels_dict[k] = v

    print("\n Setting active project")
    run_ps(f"gcloud config set project {args.project}")

    print("\n Enabling BigQuery API")
    run_ps(f"gcloud services enable bigquery.googleapis.com --project {args.project}")

    print("\n Processing BigQuery dataset")
    create_dataset(
        project_id=args.project,
        dataset_id=args.dataset,
        location=args.location,
        default_table_expiration_ms=args.default_table_expiration_ms,
        default_partition_expiration_ms=args.default_partition_expiration_ms,
        default_view_expiration_ms=args.default_view_expiration_ms,
        description=args.description,
        labels=labels_dict
    )

    print("\n DONE — BigQuery dataset automation complete!")
    print(f"Dataset: {args.project}:{args.dataset}")
    print(f"Location: {args.location}\n")


if __name__ == "__main__":
    main()