use std::fs::File;
use std::io::{BufRead, BufReader, Seek, SeekFrom};

fn main() -> std::io::Result<()> {
    let mut input = BufReader::new(File::open("input.txt")?);

    let mut dial: i32 = 50;
    let mut zeroes: u32 = 0;
    
    for line in (&mut input).lines().map(|l| l.unwrap()).filter(|l| l != "") {
        match line.chars().next().unwrap() {
            'L' => dial = (dial - &line[1..].parse().unwrap()).rem_euclid(100),
            'R' => dial = (dial + &line[1..].parse().unwrap()).rem_euclid(100),
            _ => unreachable!(),
        }

        if dial == 0 {
            zeroes += 1;
        }
    }
    
    println!("part 1: {}", zeroes);


    input.seek(SeekFrom::Start(0))?;
    dial = 50;
    zeroes = 0;

    for line in input.lines().map(|l| l.unwrap()).filter(|l| l != "") {
        let distance: i32 = line[1..].parse().unwrap();
        
        for _ in 0..distance {
            match line.chars().next().unwrap() {
                'L' => dial = (dial - 1).rem_euclid(100),
                'R' => dial = (dial + 1).rem_euclid(100),
                _ => unreachable!(),
            }

            if dial == 0 {
                zeroes += 1;
            }
        }
    }

    println!("part 2: {}", zeroes);

    Ok(())
}