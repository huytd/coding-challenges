use std::fs::File;
use std::io::Read;

fn print_lines(line: usize, buffer: [u8; 16]) {
    let offset = line * 16;
    print!("{:08x}: ", offset);

    for chunk in buffer.chunks(2) {
        for byte in chunk {
            print!("{:02x}", byte);
        }
        print!(" ");
    }

    print!(" ");

    for b in buffer.iter() {
        if *b >= 32 && *b <= 126 {
            print!("{}", *b as char);
        } else {
            print!(".");
        }
    }

    println!();
}

fn main() {
    let args = std::env::args().collect::<Vec<String>>();
    let file_name = args[1].to_string();

    let mut file = File::open(&file_name).expect("Unable to open file");
    let mut buffer = [0; 16];

    let mut line = 0;
    while let Ok(n) = file.read(&mut buffer) {
        if n == 0 {
            break;
        }
        print_lines(line, buffer);
        line += 1;
    }
}
